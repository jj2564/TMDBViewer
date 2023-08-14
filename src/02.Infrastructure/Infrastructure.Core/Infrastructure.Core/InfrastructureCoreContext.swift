//
//  InfrastructureCoreContext.swift
//  Infrastructure.Core
//
//  Created by Irving Huang on 2023/8/12.
//

import Foundation

public class InfrastructureCoreContext {
    
    
    public enum Mode: String {
        case PROD
        case DEV
    }
    
    
    //MARK: - Singleton
    public static let shared = InfrastructureCoreContext()
    
    
    //MARK: - Fields
    private let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Plist not found")
        }
        return dict
    }()
    
    
    //MARK: - Constructor
    public init() {
        
        guard let environment = infoDictionary["Environment"] as? String, let mode = Mode(rawValue: environment) else {
            fatalError("Doesn't have Environment")
        }
        self.mode = mode
        
        guard let token = infoDictionary["AccessToken"] as? String else {
            fatalError("Doesn't have TMDB token")
        }
        
        self.accessToken = token
    }
    
    
    //MARK: - Properties
    public var mode: Mode = .PROD
    
    public var accessToken: String = ""
    
    public var serviceUrl: String = "https://api.themoviedb.org/3/"
    
    
}
