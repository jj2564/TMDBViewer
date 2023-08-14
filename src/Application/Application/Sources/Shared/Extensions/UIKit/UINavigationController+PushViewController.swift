//
//  UINavigationController+PushViewController.swift
//  Application
//
//  Created by IrvingHuang on 2021/11/12.
//

import UIKit
import Infrastructure_Core

extension UINavigationController {
    
    func pushWithList(vcList: [UIViewController], animated: Bool = false) {
        
        var vcs = viewControllers
        vcs = vcs + vcList
        setViewControllers(vcs, animated: animated)
        
    }
    
    func pushWithoutCount(_ count: Int, vc: UIViewController, animated: Bool = true) {
        var vcs = viewControllers
        for _ in 0 ..< count {
            if vcs.count > 0 {
                vcs.removeLast()
            } else { break }
        }
        vcs.append(vc)
        setViewControllers( vcs, animated: animated)
    }
    
    func pushIfExist(vc: UIViewController, animated: Bool = true, withoutSelf: Bool = true) {
        var vcs = viewControllers
        var isRemove = false
        
        for existVC in vcs {
            
            if existVC.className == vc.className {
                isRemove = true
            }
            
            if isRemove && vcs.count > 0 {
                vcs.removeLast()
            }
        }
        
        if !isRemove {
            if withoutSelf && vcs.count > 0 {
                vcs.removeLast()
            }
        }
        
        vcs.append(vc)
        
        setViewControllers( vcs, animated: animated)
    }
    
    @discardableResult
    func popIfExist(vc: UIViewController, animated: Bool = true, withoutSelf: Bool = true) -> Bool {
        var vcs = viewControllers
        var isExist = false
        
        for existVC in vcs {
            
            if isExist && vcs.count > 0 {
                vcs.removeLast()
            }
            
            if existVC.className == vc.className {
                isExist = true
            }
            
        }
        
        setViewControllers( vcs, animated: animated)
        return isExist
    }
    
    func isExsit(vc: UIViewController) -> Bool {
        let vcs = viewControllers
        
        for existVC in vcs {
            if existVC.className == vc.className {
                return true
            }
        }
        
        return false
    }
    
}
