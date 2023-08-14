//
//  UIView+RemoveSubviews.swift
//  Application
//
//  Created by Irving Huang on 2022/4/7.
//

import UIKit

extension UIView {
    
    func removeAllSubviews() {
        
        guard subviews.count > 0 else { return }
        
        for view in subviews {
            view.removeFromSuperview()
        }
        
    }
}
