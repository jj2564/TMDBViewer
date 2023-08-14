//
//  UIView+ParentViewController.swift
//  Application
//
//  Created by IrvingHuang on 2021/12/17.
//

import Foundation
import UIKit

extension UIView {
    
    // 取得當前的ViewController
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}
