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


public let refreshDay: Int = 1

let ios8061formatter = ISO8601DateFormatter()

public let headers: HttpHeaders = [
    "Content-Type": "application/json",
    "cache-control": "no-cache"
]


// MARK: - Helper functions for creating encoders and decoders
public func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    return decoder
}

public func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    encoder.dateEncodingStrategy = .iso8601
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

