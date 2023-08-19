//
//  SrollableStackView+QuickAdd.swift
//  Application
//
//  Created by IrvingHuang on 2021/11/23.
//

import Foundation
import UIKit
import TinyConstraints

extension ScrollableStackView {
    
    @discardableResult
    public func addGapView(height: CGFloat, color: UIColor = .clear) -> UIView {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = color
        v.height(height)
        self.addSubviewToStackView(v)
        return v
    }
    
}

extension UIStackView {
    @discardableResult
    public func addGapView(height: CGFloat, color: UIColor = .clear) -> UIView {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = color
        v.height(height)
        self.addArrangedSubview(v)
        return v
    }
}
