//
//  TMDB_Movies_HostingTest.swift
//  ApplicationTests
//
//  Created by Irving Huang on 2023/8/13.
//
// 測試是否有成功註冊各種服務

import XCTest

import Infrastructure_Hosting
import Infrastructure_HttpClient
import Infrastructure_DataStorage

import TMDB_Movies_Core


@testable import Application

class ContextFactoryTest: XCTestCase {
    
    var factoryRegister: ContextFactoryRegister!

    
    override func setUp() {
        super.setUp()
        
        HostContext.current.clearAll()
        
        factoryRegister = ContextFactoryRegister()
        factoryRegister.initialHosting()
    }
    
    func testContextFactory() {
    
        let httpClient: HttpClient? = HostContext.current.getService()
        XCTAssertNotNil(httpClient, "Failed to get the HttpClient")
        
        let dataStorage: DataStorage? = HostContext.current.getService()
        XCTAssertNotNil(dataStorage, "Failed to get the DataStorage")
        
        let moviesContext: MoviesContext? = HostContext.current.getService()
        XCTAssertNotNil(moviesContext, "Failed to get the MoviesContext")
        
    }
    
    override func tearDown() {

        super.tearDown()
    }
    
}
