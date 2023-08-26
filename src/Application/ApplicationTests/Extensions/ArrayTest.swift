//
//  ArrayTest.swift
//  ApplicationTests
//
//  Created by Irving Huang on 2023/8/26.
//

import XCTest
@testable import Application

class ArrayExtensionTests: XCTestCase {

    func testIsIndexAvailable() {
        let sampleArray = ["a", "b", "c"]

        XCTAssertTrue(sampleArray.isIndexAvailable(0))
        XCTAssertTrue(sampleArray.isIndexAvailable(2))
        XCTAssertFalse(sampleArray.isIndexAvailable(3))
        XCTAssertFalse(sampleArray.isIndexAvailable(-1))
    }

    func testSubscriptSafe() {
        let sampleArray = [1, 2, 3, 4]

        XCTAssertEqual(sampleArray[safe: 0], 1)
        XCTAssertEqual(sampleArray[safe: 3], 4)
        XCTAssertNil(sampleArray[safe: 4])
        XCTAssertNil(sampleArray[safe: -1])
    }
}


