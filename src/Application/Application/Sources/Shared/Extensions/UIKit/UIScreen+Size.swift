//
//  UIScreen+Size.swift
//  Application
//
//  Created by IrvingHuang on 2022/2/7.
//

import Foundation
import UIKit

extension UIScreen {
    static var screenWidth: CGFloat {
        UIScreen.main.bounds.width
    }

    // Screen height.
    static var screenHeight: CGFloat {
        UIScreen.main.bounds.height
    }
}
