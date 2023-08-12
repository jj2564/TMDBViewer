//
//  CurlHttpClientProvider.swift
//  Infrastructure.HttpClient.Curl
//
//  Created by IrvingHuang on 2022/1/13.
//

import Foundation
import UIKit

import CurlDSL
import Infrastructure_HttpClient

public class CurlHttpClientProvider: HttpClientProvider {
    
    
    //MARK: - Properties
    private var token: String = ""
    
    
    //MARK: - Constructors
    public init() { }
    
    
    //MARK: - Methods
    public func get(_ request: HttpRequest) throws -> HttpResponse {
        try curl(request, method: .get)
    }
    
    public func post(_ request: HttpRequest) throws -> HttpResponse {
        try curl(request, method: .post)
    }
    
    private func curl(_ request: HttpRequest, method: Method) throws -> HttpResponse {
        
        let methodName = method.rawValue
        
        guard let content = String(data: request.content, encoding: .utf8) else {
            throw "Content is not valid."
        }
        
        let headers = request.headers.map {
            "\($0.key): \($0.value)"
        }
        
        var headerCurl = ""
        for head in headers {
            headerCurl = headerCurl + "-H \'" + head + "\'" + "\n"
        }
        
        if token.count > 0 {
            headerCurl = headerCurl + "-H \'Authorization: Bearer " + token + "\'"
        }
        
        let curl = """
        curl -X \(methodName)
        \(request.url)
        \(headerCurl)
        -d \'\(content)\'
        """
        
        var urlRequest = try CURL(curl).buildRequest()
        var data: Data?
        var response: URLResponse?
        var error: Error?

        urlRequest.timeoutInterval = 30
        
        
        var pass = false
        #if targetEnvironment(simulator)
            pass = true
        #endif

        if pass {
            print(curl)
        }

        let dispatchGroup = DispatchGroup()
        let dataTask = URLSession.shared.dataTask(with: urlRequest) {
            data = $0
            response = $1
            error = $2
            
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        dataTask.resume()
        dispatchGroup.wait()
        
        
        guard let data = data, let response = response as? HTTPURLResponse else {
            throw "Data Error"
        }
        
        if let error = error {
            throw HttpError.networkError("\(error)")
        }

        let httpResponse = HttpResponse(content: data, statusCode: response.statusCode)
        
        
        if pass {
            print("Irving| network name: \(request.url)")
            print("Irving| network respone: \(data.prettyPrintedJSONString())")
        }
        
        if response.statusCode == 302 {
            
        }
        
        return httpResponse
        
    }
    
    public func setToken(_ token: String) {
        self.token = token
    }
    
}

enum Method: String {
    case get = "GET"
    case post = "POST"
}
