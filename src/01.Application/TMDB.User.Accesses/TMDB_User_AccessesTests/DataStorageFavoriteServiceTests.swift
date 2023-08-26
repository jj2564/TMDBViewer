//
//  DataStorageFavoriteServiceTests.swift
//  TMDB_User_AccessesTests
//
//  Created by Irving Huang on 2023/8/26.
//

import XCTest
import Infrastructure_DataStorage
import Infrastructure_HttpClient

import TMDB_User_Accesses

class DataStorageFavoriteServiceTests: XCTestCase {
    
    var dataStorage: DataStorage!
    var service: DataStorageFavoriteService!
    
    override func setUp() {
        super.setUp()
        
        let mockProvider = MockDataStorageProvider()
        dataStorage = DataStorage(dataStorageProvider: mockProvider)
        service = DataStorageFavoriteService(dataStorage)
    }
    
    func testAddFavorite() {
        
        let id = "1234"
        let data = "Test Data".data(using: .utf8)
        
        XCTAssertNoThrow(try service.add(by: id, data: data))
        
        let fetchedFavorite = try? service.get(by: id)
        XCTAssertEqual(fetchedFavorite?.id, id)
        XCTAssertEqual(fetchedFavorite?.data, data)
        
    }
    
    func testDeleteFavorite() {
        
        let id = "1234"
        let data = "Test Data".data(using: .utf8)
        
        try? service.add(by: id, data: data)
        XCTAssertNoThrow(try service.delete(by: id))
        
        let fetchedFavorite = try? service.get(by: id)
        XCTAssertNil(fetchedFavorite)
        
    }
    
    func testGetFavorite() {
        
        let id = "1234"
        let data = "Test Data".data(using: .utf8)
        
        try? service.add(by: id, data: data)
        let fetchedFavorite = try? service.get(by: id)
        
        XCTAssertEqual(fetchedFavorite?.id, id)
        XCTAssertEqual(fetchedFavorite?.data, data)
        
    }
    
    func testGetIdList() {
        
        let id1 = "1234"
        let data1 = "Test Data1".data(using: .utf8)
        
        let id2 = "5678"
        let data2 = "Test Data2".data(using: .utf8)
        
        try? service.add(by: id1, data: data1)
        try? service.add(by: id2, data: data2)
        
        let idList = try? service.getIdList()
        
        XCTAssertEqual(idList?.count, 2)
        XCTAssertTrue(idList?.contains { $0.id == id1 } ?? false)
        XCTAssertTrue(idList?.contains { $0.id == id2 } ?? false)
        
    }

    override func tearDown() {
        dataStorage = nil
        service = nil
        
        super.tearDown()
    }
    
}
