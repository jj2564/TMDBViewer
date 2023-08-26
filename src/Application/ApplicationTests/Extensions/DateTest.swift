//
//  DateTest.swift
//  ApplicationTests
//
//  Created by Irving Huang on 2023/8/26.
//

import XCTest
@testable import Application

class DateExtensionTests: XCTestCase {
    
    var testDate: Date!
    
    override func setUp() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        testDate = dateFormatter.date(from: "2023-05-19 14:30:45")!
    }
    
    func testDayMonthYearProperties() {
        XCTAssertEqual(testDate.day, 19)
        XCTAssertEqual(testDate.month, 5)
        XCTAssertEqual(testDate.year, 2023)
        XCTAssertEqual(testDate.hour, 14)
        XCTAssertEqual(testDate.minute, 30)
    }
    
    func testDateStringFormats() {
        XCTAssertEqual(testDate.dayString, "05/19")
        XCTAssertEqual(testDate.monthString, "2023/05")
        XCTAssertEqual(testDate.dateString, "2023/05/19")
        XCTAssertEqual(testDate.timeString, "14:30")
        XCTAssertEqual(testDate.dateToTimeString, "2023/05/19 14:30")
    }
    
    func testAddTimeFunctions() {
        XCTAssertEqual(testDate.addDay(1)?.day, 20)
        XCTAssertEqual(testDate.addMonth(1)?.month, 6)
        XCTAssertEqual(testDate.addYear(1)?.year, 2024)
        XCTAssertEqual(testDate.addHour(1)?.hour, 15)
        XCTAssertEqual(testDate.addMinute(10)?.minute, 40)
    }
    
    func testOtherDateMethods() {
        XCTAssertTrue(testDate.isSameDay(date: testDate))
        XCTAssertFalse(testDate.isSameDay(date: testDate.addDay(1)!))
        XCTAssertFalse(testDate.isSameMonth(date: testDate.addMonth(1)!))
        XCTAssertTrue(testDate.isSameYear(date: testDate.addMonth(1)!))
        
        XCTAssertNotNil(testDate.dateToMonth)
        
        let startOfMonth = testDate.setDate(day: 1)
        XCTAssertEqual(testDate.mounthDayCount(), 31)
        XCTAssertEqual(startOfMonth.monthStartWeekday(), 1) // 2023/05/01 Monday
        XCTAssertTrue(testDate.isSameDay(date: testDate.setDate(year: 2023)))
        XCTAssertTrue(testDate.isSameMonth(date: testDate.setDate(month: 5)))
        XCTAssertTrue(testDate.isSameYear(date: testDate.setDate(day: 19)))
        
        XCTAssertEqual(testDate.previousMonthDate?.month, 4)
        XCTAssertEqual(testDate.nextMonthDate?.month, 6)
    }
    
    func testTimeIntervalPrint() {
        let futureDate = testDate.addMinute(5)!
        futureDate.printTimeInternal(testDate)
    }
    
}
