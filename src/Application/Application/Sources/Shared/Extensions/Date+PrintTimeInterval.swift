//
//  Date+TimeInterval.swift
//  Application
//
//  Created by Irving Huang on 2023/6/28.
//

import Foundation

extension Date {

    func printTimeInternal(_ date: Date, text: String? = nil) {
        let timeInterval = self.timeIntervalSince(date)
        let formattedTimeInterval = String(format: "%.2f", timeInterval)
        let _text = text ?? ""
        print("\(_text)時間差: \(formattedTimeInterval)s")
    }
    
}
