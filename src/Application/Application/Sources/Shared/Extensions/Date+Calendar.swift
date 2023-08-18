//
//  Date+Calendar.swift
//  Application
//
//  Created by Irving Huang on 2022/12/20.
//

import Foundation


import UIKit

public extension Date {
    
    
    //MARK: - Properties
    var day: Int { getValue(by: .day).day ?? 0 }
    var month: Int { getValue(by: .month).month ?? 0 }
    var year: Int { getValue(by: .year).year ?? 0 }
    var hour: Int { getValue(by: .hour).hour ?? 0 }
    var minute: Int { getValue(by: .minute).minute ?? 0 }
    
    var dateToMonth: Date? {
        let calendar = Calendar.current
        let date = calendar.date(from: calendar.dateComponents([.year, .month], from: self) )
        return date
    }
    
    private func getValue(by component: Calendar.Component) -> DateComponents {
        let calendar = Calendar.current
        return calendar.dateComponents([component], from: self)
    }
    
    
    //MARK: - Get String
    var dayString: String {
        let month = String(format: "%02d", month)
        let day = String(format: "%02d", day)
        return  "\(month)/\(day)"
    }
    
    var monthString: String {
        let month = String(format: "%02d", month)
        return  "\(year)/\(month)"
    }
    
    var dateString: String {
        let month = String(format: "%02d", month)
        let day = String(format: "%02d", day)
        return  "\(year)/\(month)/\(day)"
    }
    
    var timeString: String {
        let hour = String(format: "%02d", hour)
        let minute = String(format: "%02d", minute)
        return "\(hour):\(minute)"
    }
    
    var dateToTimeString: String {
        return dateString + " " + timeString
    }
    
    var dateStringToServer: String {
        dateString.replacingOccurrences(of: "/", with: "-")
    }
    
    var timeStringToServer: String {
        dateStringToServer + "T" + timeString + ":00Z"
    }
    
    
    //MARK: - Add Time
    var tomorrowDate: Date? {
        addDay(1)
    }
    
    func addHourMinuteByDate(_ date: Date) -> Date? {
        let hour = date.hour
        let minute = date.minute
        return self.addHour(hour)?.addMinute(minute)
    }
    
    func addMinute(_ count: Int) -> Date? {
        Calendar.current.date(byAdding: .minute, value: count, to: self)
    }
    
    func addHour(_ count: Int) -> Date? {
        Calendar.current.date(byAdding: .hour, value: count, to: self)
    }
    
    func addDay(_ count: Int) -> Date? {
        Calendar.current.date(byAdding: .day, value: count, to: self)
    }
    
    func addMonth(_ count: Int) -> Date? {
        Calendar.current.date(byAdding: .month, value: count, to: self)
    }
    
    func addYear(_ count: Int) -> Date? {
        Calendar.current.date(byAdding: .year, value: count, to: self)
    }
    
    
    //MARK: - Methods
    var previousMonthDate: Date? { addMonth(-1) }
    var nextMonthDate: Date? { addMonth(1) }
    
    func mounthDayCount() -> Int {
        if let range = Calendar.current.range(of: .day, in: .month, for: self) {
            return range.count
        }
        return 0
    }
    
    func monthStartWeekday() -> Int {
        let calendar = Calendar.current
        var components = calendar.dateComponents([
            .year, .month, .day], from: self)
        components.day = 1
        
        guard
            let start = calendar.date(from: components),
            let count = calendar.ordinality(of: .weekday, in: .weekOfMonth, for: start)
        else { return 1 }
        
        return count - 1
    }
    
    func setDate(year: Int? = nil, month: Int? = nil, day: Int? = nil) -> Date {
        let calendar = Calendar.current
        var components = calendar.dateComponents([
            .year, .month, .day], from: self)
        
        if let year = year {
            components.year = year
        }
        if let month = month {
            components.month = month
        }
        if let day = day {
            components.day = day
        }
        return calendar.date(from: components) ?? self
    }
    
    func isSameDay(date: Date) -> Bool {
        day == date.day && month == date.month && year == date.year
    }
    
    func isSameMonth(date: Date) -> Bool {
        month == date.month && year == date.year
    }
    
    func isSameYear(date: Date) -> Bool {
        year == date.year
    }

}
