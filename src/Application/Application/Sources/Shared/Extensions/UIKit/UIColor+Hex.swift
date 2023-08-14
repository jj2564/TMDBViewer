//
//  UIColor+Hex.swift
//  Application
//
//  Created by IrvingHuang on 2021/11/16.
//

import UIKit

extension UIColor {
    
    /// UIColor init
    ///
    /// - Parameter hex: 0x000000 to 0xffffff
    convenience init (_ hex: Int) {
        self.init(hex, alpha: 1.0)
    }
    
    /// UIColor init
    ///
    /// - Parameters:
    ///   - hex: 0x000000 to 0xffffff
    ///   - alpha: range from 0.0 to 1.0
    convenience init (_ hex: Int, alpha: CGFloat = 1.0) {
        self.init(red: CGFloat((hex >> 16) & 0xFF) / 255.0,
                  green:CGFloat((hex >> 8) & 0xFF) / 255.0,
                  blue: CGFloat(hex & 0xFF) / 255.0,
                  alpha: alpha)
    }
}
