//
//  HttpDefine.swift
//  Infrastructure.HttpClient
//
//  Created by Irving Huang on 2023/8/12.
//

import Foundation
import UIKit

import Infrastructure_Core

public typealias JSONDictionary = [String: Any]

let iso8601Formatter = ISO8601DateFormatter()
let customFormatter = DateFormatter()

public let refreshDay: Int = 1

public let headers: HttpHeaders = [
    "Content-Type": "application/json",
    "cache-control": "no-cache"
]


// MARK: - Helper functions for creating encoders and decoders
public func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    
    decoder.dateDecodingStrategy = .custom { decoder -> Date in
        let container = try decoder.singleValueContainer()
        let dateString = try container.decode(String.self)
        
        if dateString.count == 0 {
            return .distantPast
        } else if let date = iso8601Formatter.date(from: dateString) {
            return date
        } else if let date = customFormatter.date(from: dateString) {
            return date
        } else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Cannot decode date string: \(dateString)")
        }
    }
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    return decoder
}

public func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    
    let iso8601Formatter = ISO8601DateFormatter()
    iso8601Formatter.formatOptions = [.withFullDate]
    
    encoder.dateEncodingStrategy = .custom { date, encoder in
        var container = encoder.singleValueContainer()
        let dateString = iso8601Formatter.string(from: date)
        try container.encode(dateString)
    }
    
    encoder.keyEncodingStrategy = .convertToSnakeCase
    return encoder
}

public func jsonData<T: Encodable>(encodable: T) throws -> Data {
    return try newJSONEncoder().encode(encodable)
}

public func jsonString<T: Encodable>(encodable: T, encoding: String.Encoding = .utf8) throws -> String? {
    return String(data: try jsonData(encodable: encodable), encoding: encoding)
}

public func jsonDictionary<T: Encodable>(encodable: T) throws -> JSONDictionary? {
    let data = try jsonData(encodable: encodable)
    return data.dictionary
}


// MARK: - Get
public func getResponse(_ httpClient: HttpClient?, url: String) throws -> HttpResponse {
    
    let request = HttpRequest(url: url, headers: headers, content: Data())
    let postRespone = try httpClient?.get(request)
    guard let response = postRespone else {
        throw HttpError.networkError("連線錯誤")
    }
    
    return response
}


// MARK: - Post
public func postResponse(_ httpClient: HttpClient?, url: String, encodableItem: Encodable) throws -> HttpResponse {
    
    let data = try jsonData(encodable: encodableItem)
    let response = try postResponse(httpClient, url: url, data: data)
    
    return response
}


public func postResponse(_ httpClient: HttpClient?, url: String, dictionary: JSONDictionary, extraHeaders: [String: String]? = nil) throws -> HttpResponse {
    
    guard let data = dictionary.data else {
        throw "資料輸入錯誤"
    }
    
    let response = try postResponse(httpClient, url: url, data: data, extraHeaders: extraHeaders)
    
    return response
}

public func postResponse(_ httpClient: HttpClient?, url: String, data: Data, extraHeaders: [String: String]? = nil) throws -> HttpResponse {

    var header_input = headers
    
    if let extraHeaders {
        for (key, value) in extraHeaders {
            header_input[key] = value
        }
    }
    
    let request = HttpRequest(url: url, headers: header_input, content: data)
    let postRespone = try httpClient?.post(request)
    guard let response = postRespone else {
        
        throw HttpError.networkError("連線錯誤")
    }
    
    return response
}

