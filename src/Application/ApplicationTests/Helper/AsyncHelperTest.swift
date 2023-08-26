//
//  AsyncHelperTest.swift
//  ApplicationTests
//
//  Created by Irving Huang on 2023/8/26.
//

import XCTest
import Infrastructure_HttpClient

@testable import Application

class AsyncHelperTests: XCTestCase {
    
    var asyncHelper: AsyncHelper!
    
    override func setUp() {
        super.setUp()
        asyncHelper = AsyncHelper()
    }
    
    func testSyncFunction() {
        let value = "TestValue"
        let result = asyncHelper.sync {
            return value
        }
        XCTAssertEqual(result, value)
    }
    
    func testExecuteFunction() {
        let expectation = self.expectation(description: "Async completion called")
        let value = "TestValue"
        
        asyncHelper.excute(action: {
            return value
        }, completion: { result in
            XCTAssertEqual(result, value)
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testExecuteFunctionWithError() {
        let expectation = self.expectation(description: "Async error called")
        
        asyncHelper.excute(action: {
            throw HttpError.networkError("Error")
        }, completion: { _ in
            XCTFail("Completion should not be called")
        }, error: { error in
            XCTAssertNotNil(error)
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    
    override func tearDown() {
        asyncHelper = nil
        super.tearDown()
    }
    
}
