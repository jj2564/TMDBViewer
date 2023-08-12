//
//  AppDelegate.swift
//  Application
//
//  Created by Irving Huang on 2023/1/11.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let rootVC = ViewController()
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = UINavigationController(rootViewController: rootVC)
        window.makeKeyAndVisible()
        window.backgroundColor = .white
        self.window = window
        
        return true
    }
    


}

