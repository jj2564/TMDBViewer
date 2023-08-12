//
//  AppDelegate.swift
//  Application
//
//  Created by Irving Huang on 2023/1/11.
//

import UIKit

// Infrastructure
import Infrastructure_Core
import Infrastructure_Hosting
import Infrastructure_HttpClient_Hosting
import Infrastructure_DataStorage_Hosting

// Application


@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        setupCore()
        initalHosting()
        setupRootViewController()
        
        return true
    }
    
    private func initalHosting() {
        
        HostContext.current.registerFactory(factory: HttpClientFactory(), isSingle: true)
        HostContext.current.registerFactory(factory: DataStorageFactory(), isSingle: true)
        
    }
    
    private func setupRootViewController() {
        
        let rootVC = ViewController()
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = UINavigationController(rootViewController:  rootVC)
        window.makeKeyAndVisible()
        
        self.window = window
        
    }

    private func setupCore() {
        if InfrastructureCoreContext.shared.mode == .DEV {
            print("Irving| Is Develop Mode.")
        }
    }

}

