//
//  DoubleTest.swift
//  ApplicationTests
//
//  Created by Irving Huang on 2023/8/26.
//
import XCTest

@testable import Application

class DoubleExtensionsTests: XCTestCase {
    
    // MARK: - Tests for stringWithoutZeroFraction
    
    func testStringWithoutZeroFraction_WithFractionalValue() {
        let value: Double = 123.45
        let stringValue = value.stringWithoutZeroFraction
        XCTAssertEqual(stringValue, "123.45")
    }
    
    func testStringWithoutZeroFraction_WithWholeValue() {
        let value: Double = 123.0
        let stringValue = value.stringWithoutZeroFraction
        XCTAssertEqual(stringValue, "123")
    }
    
    func testStringWithoutZeroFraction_WithZero() {
        let value: Double = 0.0
        let stringValue = value.stringWithoutZeroFraction
        XCTAssertEqual(stringValue, "0")
    }
    
    func testRoundToPlaces_WithFractionalValue_RoundingUp() {
        let value: Double = 123.4567
        let roundedValue = value.round(to: 2)
        XCTAssertEqual(roundedValue, 123.46)
    }
    
    func testRoundToPlaces_WithFractionalValue_RoundingDown() {
        let value: Double = 123.453
        let roundedValue = value.round(to: 2)
        XCTAssertEqual(roundedValue, 123.45)
    }
    
    func testRoundToPlaces_WithWholeValue() {
        let value: Double = 123.0
        let roundedValue = value.round(to: 2)
        XCTAssertEqual(roundedValue, 123.0)
    }
    
    func testRoundToPlaces_WithZero() {
        let value: Double = 0.0
        let roundedValue = value.round(to: 2)
        XCTAssertEqual(roundedValue, 0.0)
    }
    
}
