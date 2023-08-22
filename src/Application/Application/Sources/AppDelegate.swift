//
//  AppDelegate.swift
//  Application
//
//  Created by Irving Huang on 2023/1/11.
//

import UIKit
import IQKeyboardManagerSwift

import Infrastructure_Core

import Infrastructure_Hosting
import Infrastructure_HttpClient

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        initalHosting()
        setupWithCore()
        setupIQKeyboard()
        setupRootViewController()
        
        return true
    }
    
    func initalHosting() {
        ContextFactoryRegister().initialHosting()
    }
    
    private func setupRootViewController() {
        
        let rootVC = RootViewController()
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = BaseNavigationController(rootViewController:  rootVC)
        window.makeKeyAndVisible()
        
        self.window = window
        
    }

    private func setupWithCore() {
        
        if InfrastructureCoreContext.shared.mode == .DEV {
            print("Irving| Is Develop Mode.")
        }
        
        let serviceUrl = InfrastructureCoreContext.shared.serviceUrl
        
        let httpClient: HttpClient? = HostContext.current.getService()
        httpClient?.setServiceUrl(serviceUrl)
        
        
    }
    
    private func setupIQKeyboard() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.layoutIfNeededOnUpdate = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        IQKeyboardManager.shared.shouldShowToolbarPlaceholder = false
    }

}

