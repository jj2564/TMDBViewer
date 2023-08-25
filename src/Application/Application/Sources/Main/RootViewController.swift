//
//  RootViewController.swift
//  Application
//
//  Created by Irving Huang on 2023/1/11.
//

import UIKit

import KeychainAccess
import TinyConstraints

import Infrastructure_Hosting
import TMDB_Movies_Core

class RootViewController: BaseViewController {


    //MARK: - Fields
    let baseView = BaseView()
    
    private let moviesContext: MoviesContext? = HostContext.current.getService()
    
    
    //MARK: - Constructors
    override func loadView() {
        super.loadView()
        
        view.addSubview(baseView)
        baseView.edgesToSuperview()
        baseView.startLoadinView()
        
        checkKeychain()
    }
    
    
    //MARK: - Properties
    public lazy var authRepository: AuthRepository? = moviesContext?.authRepository
    
    
    //MARK: - Methods
    private func checkKeychain() {
        
        
        let keychain = Keychain(service: "com.example.irving")

        let apiId = keychain["apiId"]
        let sessionId = keychain["sessionId"]

        if let apiId, let sessionId {

            checkSessionId(apiId: apiId, sessionId: sessionId) { [weak self] success in
                guard let `self` = self else { return }

                if success {
                    self.toNowPlaying()
                } else {
                    self.toLogin()
                }
            }

        } else {
            toLogin()
        }
        
        
    }
    
    private func checkAuth(token: String, completion: ((Bool) -> Void)?  = nil) {
        
        AsyncHelper().excute { [unowned self] in
            try authRepository?.authentication(token: token)
        } completion: { result in
            let success = (result == true)
            completion?(success)
        } error: { _ in
            completion?(false)
        }
        
    }
    
    private func checkSessionId(apiId: String, sessionId: String, completion: ((Bool) -> Void)?  = nil) {
        
        AsyncHelper().excute { [unowned self] in
            try authRepository?.authId(apiId: apiId, sessionId: sessionId)
        } completion: { result in
            let success = (result == true)
            completion?(success)
        } error: { _ in
            completion?(false)
        }
        
    }
    
    private func toNowPlaying() {
        
        let vc = NowPlayingViewController()
        UIApplication.rootViewController = BaseNavigationController(rootViewController: vc)
        
    }
    
    private func toLogin() {
        
        let vc = LoginViewController()
        UIApplication.rootViewController = BaseNavigationController(rootViewController: vc)
        
    }
    
}

