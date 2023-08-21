//
//  UserDefaults+Manager.swift
//  Infrastructure.DataStorage
//
//  Created by Irving Huang on 2023/8/21.
//

import Foundation


public protocol UserDefaultsKeys {
    /// 實作時回傳 String(reflecting: self)
    var description: String { get }
}

public extension UserDefaultsKeys {
    
    var description: String {
        String(reflecting: self)
    }
    
}

public extension UserDefaults {
    
    //set
    static func setValue(in value: Any?, key: UserDefaultsKeys) {
        setValue(in: value, key: key.description)
    }
    
    static func setValue(in value: Any?, key: String) {
        UserDefaults.standard.set(value, forKey: key)
    }
    
    //get
    static func getValue(for key: UserDefaultsKeys) -> Any? {
        getValue(for: key.description)
    }
    
    static func getValue(for key: String) -> Any? {
        let value = UserDefaults.standard.value(forKey: key)
        return value
    }

    //get generic
    static func getValue<T>(for key: UserDefaultsKeys) -> T? {
        let value: T? = getValue(for:key.description)
        return value
    }
    
    static func getValue<T>(for key: String) -> T? {
        let data = UserDefaults.standard.value(forKey: key)
        return data as? T
    }
    
    //remove
    static func removeValue(for key: UserDefaultsKeys) {
        removeValue(for: key.description)
    }
    
    static func removeValue(for key: String) {
        UserDefaults.standard.removeObject(forKey: key)
    }
    
}
