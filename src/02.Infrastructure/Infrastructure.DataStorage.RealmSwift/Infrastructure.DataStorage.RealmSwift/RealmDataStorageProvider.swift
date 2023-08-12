//
//  RealmDataStorageProvider.swift
//  Infrastructure.DataStorage.Realm
//
//  Created by Irving Huang on 2022/6/22.
//

import Foundation

import RealmSwift

import Infrastructure_Core
import Infrastructure_DataStorage

public class RealmDataStorageProvider: DataStorageProvider {
    

    //MARK: - Properties
    private let manager = RealmManager()
    
    
    //MARK: - Constructors
    public init() {
        #if targetEnvironment(simulator)
            manager.printLocation()
        #endif
    }
    
    
    //MARK: - Methods
    public func set(_ data: BasicDataStorage) throws {
        let object = realmBasic(by: data)
        manager.add(object)
    }
    
    public func set(_ datas: [BasicDataStorage]) throws {
        let objects = datas.map { realmBasic(by: $0) }
        manager.add(objects)
    }
    
    public func fetch(by key: String, isValid: Bool) throws -> Data {
        guard let object = manager.object(RealmBasicDataStorage.self, key: key) else {
            throw "無物件"
        }
        
        if object.validDate <= Date(), isValid {
            throw "物件已過時"
        }
        
        return object.data
        
    }
    
    public func fetch(by keys: [String], isValid: Bool) throws -> [Data] {
        
        let predicate: NSPredicate = NSPredicate(format: "key IN %@", keys)
        
        guard var objects = manager.objects(RealmBasicDataStorage.self, predicate: predicate) else {
            return []
        }
        
        if isValid {
            objects = objects.filter("validDate > %@", Date())
        }
        
        var datas: [Data] = []
        
        for object in objects {
            datas.append(object.data)
        }
        
        return datas
    }
    
    private func realmBasic(by data: BasicDataStorage) -> RealmBasicDataStorage {
        RealmBasicDataStorage(key: data.key, data: data.data, validDate: data.validDate)
    }
    
}

