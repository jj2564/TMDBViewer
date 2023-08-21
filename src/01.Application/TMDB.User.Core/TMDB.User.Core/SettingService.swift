//
//  SettingService.swift
//  TMDB.User.Core
//
//  Created by Irving Huang on 2023/8/21.
//

import Foundation

public protocol SettingService {
    
    func set(key: String, value: String) throws
    
    func get(key: String) throws -> String?
    
}
