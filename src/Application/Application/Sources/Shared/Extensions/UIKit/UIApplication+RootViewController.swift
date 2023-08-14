//
//  UIApplication+RootViewController.swift
//  Application
//
//  Created by IrvingHuang on 2021/12/28.
//

import UIKit

extension UIApplication {
    
    /// 目前顯示的UIViewController
    static var rootViewController: UIViewController? {
        get {
            return UIApplication.keyWindow?.rootViewController
        }
        
        set {
            UIApplication.keyWindow?.rootViewController = newValue
        }
    }
    
    static var topViewController: UIViewController? {
        if var topController = UIApplication.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
                return topController
            }
        }
        return UIApplication.rootViewController
    }
    
}
