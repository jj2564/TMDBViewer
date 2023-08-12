//
//  Dictionary+Data.swift
//  Infrastructure.SuperAgent.Core
//
//  Created by IrvingHuang on 2022/1/19.
//

import Foundation

public extension Decodable {
    
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Self.self, from: data)
    }
    
    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    func clone() -> Self? {
        
        let dictionary = self.convertToDictionary()
        guard let data = dictionary.data else { return nil }
        return try? Self(data: data)

    }
    
    private func convertToDictionary() -> JSONDictionary {
        
        var dictionary = JSONDictionary()
        let mirror = Mirror(reflecting: self)
        
        for child in mirror.children {
            guard let key = child.label else { continue }
            
            if let list = child.value as? [Decodable] {

                let newList = list.map { $0.convertToDictionary() }
                dictionary[key] = newList
            } else if let date = child.value as? Date {
                let dateString = ios8061formatter.string(from: date)
                dictionary[key] = dateString
            } else {
                dictionary[key] = child.value
            }
            
        }
        
        return dictionary
        
    }
    
}

public extension Encodable {
    
    func convertTo<T: Decodable>() -> T? {
        
        guard let date = try? jsonData(encodable: self) else { return nil }
        guard let reuslt = try? T(data: date) else { return nil }
        return reuslt
    }
    
}

public extension Dictionary {
    
    var data: Data? {
        try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
    }
    
}

public extension Array {
    
    var data: Data? {
        try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
    }
}

public extension Data {
    
    var dictionary: JSONDictionary? {
        try? JSONSerialization.jsonObject(with: self, options: .mutableContainers) as? Dictionary
    }
    
    var string: String? {
        String(data: self, encoding: .utf8)
    }
    
    func prettyPrintedJSONString() -> String {
        guard let jsonObject = try? JSONSerialization.jsonObject(with: self, options: []),
              let jsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: [.prettyPrinted]),
              let prettyJSONString = String(data: jsonData, encoding: .utf8)
        else {
            return "PrintedJSONString Failed (Failed to read JSON Object.)"
        }
        return prettyJSONString
    }
    
}

public extension String {
    
    var dictionary: JSONDictionary? {
        guard let data = self.data(using: .utf8) else { return nil }
        return try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? JSONDictionary
    }
    
}

