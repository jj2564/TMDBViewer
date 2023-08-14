//
//  Int+CommaString.swift
//  Application
//
//  Created by Irving Huang on 2023/1/13.
//

import Foundation

extension Int {
    
    var commaString: String {
        
        var result = ""
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        
        if let text = formatter.string(from: NSNumber(value: self)) {
            result = text
        }
        
        return result
    }
    
}

extension Int64 {
    
    var commaString: String {
        
        var result = ""
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        
        if let text = formatter.string(from: NSNumber(value: self)) {
            result = text
        }
        
        return result
    }
    
}
