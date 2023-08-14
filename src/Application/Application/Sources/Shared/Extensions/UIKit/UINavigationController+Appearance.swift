//
//  UINavigationController+Appearance.swift
//  Application
//
//  Created by IrvingHuang on 2022/2/22.
//

import Foundation
import UIKit

extension UINavigationController {
    
    private var baseNavigation: BaseNavigationController? {
        guard let navi = self as? BaseNavigationController else {
            return nil
        }
        return navi
    }
    
    public func setPrimaryStyle() {
        baseNavigation?.setNormalAppearance()
    }
    
    public func setTransparentStyle(alpha: CGFloat = 0) {
        baseNavigation?.setTransparentAppearance(alpha: alpha)
    }
    
    public func setNormalStyle(alpha: CGFloat = 1) {
        baseNavigation?.setNormalAppearance(alpha: alpha)
    }
    
}
