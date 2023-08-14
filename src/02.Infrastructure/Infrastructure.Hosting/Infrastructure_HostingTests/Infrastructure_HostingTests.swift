//
//  Infrastructure_HostingTests.swift
//  Infrastructure_HostingTests
//
//  Created by Irving Huang on 2023/8/13.
//

import XCTest
import Infrastructure_Hosting

class ServiceFactoryMock: ServiceFactory {
    func getService<T>(provider: ServiceProvider) -> T? {
        return DummyService() as? T
    }
}

class AnotherServiceFactoryMock: ServiceFactory {
    func getService<T>(provider: ServiceProvider) -> T? {
        return AnotherDummyService() as? T
    }
}

class DummyService { }

class AnotherDummyService { }

class HostContextTests: XCTestCase {
    
    var hostContext: HostContext!
    
    override func setUp() {
        super.setUp()
        hostContext = HostContext.current
    }
    
    func testRegisterFactory() {
        let initialFactoryCount = hostContext.factoryCount
        hostContext.registerFactory(factory: ServiceFactoryMock(), isSingle: true)
        
        XCTAssertEqual(hostContext.factoryCount, initialFactoryCount + 1, "Factory count did not increase after registering a new factory.")
    }
    
    func testGetService() {
        hostContext.registerFactory(factory: ServiceFactoryMock(), isSingle: true)
        let service: DummyService? = hostContext.getService()
        
        XCTAssertNotNil(service, "Failed to get the registered service.")
    }
    
    func testSingleServiceInstance() {
        hostContext.registerFactory(factory: ServiceFactoryMock(), isSingle: true)
        let service1: DummyService? = hostContext.getService()
        let service2: DummyService? = hostContext.getService()
        
        XCTAssertTrue(service1 === service2, "Different instances were returned for a single instance service.")
    }
    
    func testMultipleServiceFactories() {
        hostContext.registerFactory(factory: ServiceFactoryMock(), isSingle: false)
        hostContext.registerFactory(factory: AnotherServiceFactoryMock(), isSingle: false)
        
        let dummyService: DummyService? = hostContext.getService()
        XCTAssertNotNil(dummyService, "Failed to get the first registered service.")
        
        let anotherDummyService: AnotherDummyService? = hostContext.getService()
        XCTAssertNotNil(anotherDummyService, "Failed to get the second registered service.")
    }
    
    override func tearDown() {

        super.tearDown()
    }
}
