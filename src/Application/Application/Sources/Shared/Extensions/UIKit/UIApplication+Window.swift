//
//  UIApplication+Window.swift
//  Application
//
//  Created by IrvingHuang on 2022/2/23.
//

import UIKit

extension UIApplication {
    
    static var keyWindow: UIWindow? {
        UIApplication.shared.windows.filter {$0.isKeyWindow}.first
    }
}
