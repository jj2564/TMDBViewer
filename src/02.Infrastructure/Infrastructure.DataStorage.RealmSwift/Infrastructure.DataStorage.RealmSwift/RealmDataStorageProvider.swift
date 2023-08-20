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
    
    public func delete(by key: String) throws {
        manager.delete(RealmBasicDataStorage.self, key: key)
    }
    
    public func delete(by keys: [String]) throws {
        manager.delete(RealmBasicDataStorage.self, keys: keys)
    }
    
    public func fetchAll(by format: String) throws -> [Data] {
        
        let predicate: NSPredicate = NSPredicate(format: "format = %@", format)
        
        guard let objects = manager.objects(RealmBasicDataStorage.self, predicate: predicate) else {
            return []
        }
        
        var datas: [Data] = []
        
        for object in objects {
            datas.append(object.data)
        }
        
        return datas
    }
    
    public func fetch(by key: String, isValid: Bool) throws -> Data {

        let datas = try fetch(by: [key], isValid: isValid)
        
        guard let data = datas.first else { throw "無資料" }
        
        return data
        
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
        RealmBasicDataStorage(key: data.key, data: data.data, format: data.format, validDate: data.validDate)
    }
    
}

