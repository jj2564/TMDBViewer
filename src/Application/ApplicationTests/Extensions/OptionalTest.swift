//
//  OptionalTest.swift
//  ApplicationTests
//
//  Created by Irving Huang on 2023/8/26.
//

import XCTest
@testable import Application

class OptionalExtensionsTests: XCTestCase {
    
    func testIsNil() {

        let nilOptionalValue: Int? = nil
        XCTAssertTrue(nilOptionalValue.isNil)
        
        let nonNilOptionalValue: Int? = 5
        XCTAssertFalse(nonNilOptionalValue.isNil)
        
        let nilOptionalStringValue: String? = nil
        XCTAssertTrue(nilOptionalStringValue.isNil)
        
        let nonNilOptionalStringValue: String? = "Test"
        XCTAssertFalse(nonNilOptionalStringValue.isNil)
        
    }
}
