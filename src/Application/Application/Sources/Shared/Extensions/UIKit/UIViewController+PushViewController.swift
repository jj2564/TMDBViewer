//
//  UIViewController+PushViewController.swift
//  Application
//
//  Created by Irving Huang on 2021/11/12.
//

import UIKit

extension UIViewController {
    
    
    //MARK: - Properties
    
    
    //MARK: - Methods
    func pushViewController(_ vc: UIViewController, animated: Bool = true) {
        navigationController?.pushWithoutCount(0, vc: vc, animated: animated)
    }
    
    func pushViewControllerWithoutSelf(_ vc: UIViewController, animated: Bool = true) {
        navigationController?.pushWithoutCount(1, vc: vc, animated: animated)
    }
    
    public func presentModallyWithNavigation(_ vc: UIViewController, style: UIModalPresentationStyle = .automatic ) {
        let nav = BaseNavigationController(rootViewController: vc)
        
        if let vc = vc as? BaseViewController {
            vc.isCloseButton = true
        }
        
        nav.modalPresentationStyle = style
        nav.setNormalStyle(alpha: 1)
        present(nav, animated: true, completion: nil)
    }
    
}

