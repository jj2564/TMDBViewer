//
//  UserDefaultsSettingService.swift
//  TMDB.User.Accesses
//
//  Created by Irving Huang on 2023/8/21.
//

import Foundation

import Infrastructure_DataStorage

import TMDB_User_Core

public class UserDefaultsSettingService: SettingService {
    
    
    //MARK: - Constructor
    public init() { }
    
    
    //MARK: - Method
    public func set(key: String, value: String) throws {
        UserDefaults.setValue(in: value, key: key)
    }
    
    public func get(key: String) throws -> String? {
        UserDefaults.getValue(for: key)
    }
    
}
