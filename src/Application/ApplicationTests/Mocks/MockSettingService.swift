//
//  MockSettingService.swift
//  ApplicationTests
//
//  Created by Irving Huang on 2023/8/26.
//

import Foundation

import TMDB_User_Core

class MockSettingService: SettingService {
    
    var settings: [String: String] = [:]
    
    func set(key: String, value: String) throws {
        settings[key] = value
    }
    
    func get(key: String) throws -> String? {
        return settings[key]
    }
    
}
