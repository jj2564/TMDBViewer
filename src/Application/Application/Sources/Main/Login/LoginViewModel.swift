//
//  LoginViewModel.swift
//  Application
//
//  Created by Irving Huang on 2023/8/22.
//

import Foundation
import UIKit
import KeychainAccess

import Infrastructure_Hosting
import Infrastructure_Core
import TMDB_Movies_Core

class LoginViewModel: BaseViewModel {
    
    
    //MARK: - Fields
    private let moviesContext: MoviesContext? = HostContext.current.getService()
    
    private var apiId: String = ""
    private var requestToken: String = ""
    private var sessionId: String = ""
    
    
    //MARK: - Constructors
    required init() {
        super.init()
        
        NotificationCenter.default.addObserver(self, selector: #selector(didApprovedRequest), name: .DidApprovedRequest, object: nil)
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    //MARK: - Properties
    public lazy var authRepository: AuthRepository? = moviesContext?.authRepository
    
    public var accessTokenPass: (() -> Void)?
    
    public var accessTokenFail: (() -> Void)?
    
    
    //MARK: - Methods
    public func setApiID(_ apiId: String) {
        
        self.apiId = apiId
        
        fetchRequestToken(apiId: apiId) { [weak self] success in
            guard let `self` = self else { return }
            
            let urlScheme = InfrastructureCoreContext.shared.urlScheme
            let urlString = "https://www.themoviedb.org/authenticate/" + self.requestToken + "?redirect_to=" + urlScheme + "://approved"
            if let url = URL(string: urlString) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        
    }
    
    @objc private func didApprovedRequest() {
        
        setApiIdToKeychain(apiId)
        
        fetchSessionId(apiId: apiId, requestToken: requestToken) { [weak self] success in
            guard let `self` = self else { return }
            
            if success {
                self.setSessionIdToKeychain(self.sessionId)
                self.accessTokenPass?()
            } else {
                self.accessTokenFail?()
            }
            
        }
        
    }
    
    private func fetchRequestToken(apiId: String, completion: ((Bool) -> Void)?  = nil) {
        
        AsyncHelper().excute { [unowned self] in
            try authRepository?.getRequestToken(apiId: apiId)
        } completion: { result in
            guard let result else { return }
            self.requestToken = result
            completion?(true)
        } error: { _ in
            completion?(false)
        }
        
    }
    
    private func fetchSessionId(apiId: String, requestToken: String, completion: ((Bool) -> Void)?  = nil) {
        
        AsyncHelper().excute { [unowned self] in
            try authRepository?.getSessionId(apiId: apiId, requestToken: requestToken)
        } completion: { result in
            guard let result else { return }
            self.sessionId = result
            completion?(true)
        } error: { _ in
            completion?(false)
        }
        
    }
    
    private func setApiIdToKeychain(_ apiId: String) {
        let keychain = Keychain(service: "com.example.irving")
        keychain["apiId"] = apiId
    }
    
    
    private func setSessionIdToKeychain(_ sessionId: String) {
        let keychain = Keychain(service: "com.example.irving")
        keychain["sessionId"] = sessionId
    }
    
    
}


extension Notification.Name {
 
    static let DidApprovedRequest = Notification.Name("DidApprovedRequest")
}
