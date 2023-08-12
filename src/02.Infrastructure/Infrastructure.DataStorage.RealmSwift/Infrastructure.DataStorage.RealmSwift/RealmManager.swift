//
//  RealmManager.swift
//  Infrastructure.DataStorage.Realm
//
//  Created by Irving Huang on 2022/6/22.
//

import Realm
import RealmSwift

class RealmManager {
    
    
    //MARK: - Fields
    private var realm: Realm? {
        try? Realm()
    }
    
    
    //MARK: - Methods
    func objects<T: Object>(_ type: T.Type, predicate: NSPredicate? = nil) -> Results<T>? {
        
        guard let realm = self.realm else { return nil }
        realm.refresh()
        
        let objects = realm.objects(type)
        
        if let predicate = predicate {
            return objects.filter(predicate)
        }
        
        return objects
    }
    
    func object<T: Object>(_ type: T.Type, key: Any) -> T? {
        
        guard let realm = self.realm else { return nil }
        realm.refresh()
        
        let object = realm.object(ofType: type, forPrimaryKey: key)
        
        return object
    }
    
    func add<T: Object>(_ data: T) {
        add([data])
    }
    
    func add<T: Object>(_ datas: [T]) {
        
        guard let realm = self.realm else { return }
        realm.refresh()
        
        if realm.isInWriteTransaction {
            realm.add(datas, update: .all)
        } else {
            try? realm.write {
                realm.add(datas, update: .all)
            }
        }
        
    }
    
    func runTransaction(action: () -> Void) {
        
        guard let realm = self.realm else { return }
        realm.refresh()

        try? realm.write {
            action()
        }
        
    }
    
    func printLocation() {
        print("User Realm User file location: \(realm!.configuration.fileURL!.path)")
    }

    
}
