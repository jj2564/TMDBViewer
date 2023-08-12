//
//  BasicDataStorage.swift
//  Infrastructure.DataStorage
//
//  Created by Irving Huang on 2022/6/23.
//

import Foundation

public struct BasicDataStorage {
    
    public var key: String
    public var data: Data
    public var validDate: Date
    
    public init(key: String, data: Data, validDate: Date) {
        self.key = key
        self.data = data
        self.validDate = validDate
    }
    
}
