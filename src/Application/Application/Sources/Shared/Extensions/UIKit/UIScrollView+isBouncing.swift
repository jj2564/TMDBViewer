//
//  UIScrollView+isBouncing.swift
//  Application
//
//  Created by IrvingHuang on 2022/1/7.
//

import UIKit

extension UIScrollView {
    var isBouncing: Bool {
        var isBouncing = false
        if contentOffset.y >= (contentSize.height - bounds.size.height) {
            // Bottom bounce
            isBouncing = true
        } else if contentOffset.y < contentInset.top {
            // Top bounce
            isBouncing = true
        }
        return isBouncing
    }
}
