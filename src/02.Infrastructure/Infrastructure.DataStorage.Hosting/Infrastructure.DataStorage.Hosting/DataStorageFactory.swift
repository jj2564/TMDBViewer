//
//  DataStorageFactory.swift
//  Infrastructure.DataStorage.Hosting
//
//  Created by Irving Huang on 2022/6/22.
//

import Foundation
import Infrastructure_Hosting
import Infrastructure_DataStorage
import Infrastructure_DataStorage_RealmSwift

public class DataStorageFactory: ServiceFactory {
    

    //MARK: - Constructors
    public init() { }

    
    //MARK: - Methods
    public func getService<T>(provider: ServiceProvider) -> T? {
        
        // chekc
        guard DataStorage.self is T.Type else { return nil }
        
        // create
        let realm = RealmDataStorageProvider()
        
        let storage = DataStorage(dataStorageProvider: realm)
        
        return storage as? T
    }
    
}
