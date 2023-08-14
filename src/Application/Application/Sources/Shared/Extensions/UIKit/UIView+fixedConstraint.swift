//
//  UIView+fixedConstraint.swift
//  Application
//
//  Created by Irving Huang on 2022/4/19.
//

import UIKit

extension UIView {
    
    func fixSubviewsConstraints(multiplier: Float = 0.9) {
        
        if multiplier > 1 { return }
        
        for constraint in constraints {
            constraint.priority = .init(rawValue: constraint.priority.rawValue * multiplier)
        }
        
        if subviews.count > 0 {
            for view in subviews {
                view.fixSubviewsConstraints(multiplier: multiplier)
            }
        }
        
    }
    
}
