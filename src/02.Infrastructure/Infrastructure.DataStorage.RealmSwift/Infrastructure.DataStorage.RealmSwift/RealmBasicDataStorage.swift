//
//  RealmBasicDataStorage.swift
//  Infrastructure.DataStorage.Realm
//
//  Created by Irving Huang on 2022/6/22.
//

import RealmSwift

class RealmBasicDataStorage: Object {

    @Persisted(primaryKey: true) var key: String!
    @Persisted var data: Data!
    @Persisted var validDate: Date!

    convenience init(key: String, data: Data, validDate: Date) {
        self.init()
        self.key = key
        self.data = data
        self.validDate = validDate
    }

    override static func primaryKey() -> String? {
        "key"
    }

}
