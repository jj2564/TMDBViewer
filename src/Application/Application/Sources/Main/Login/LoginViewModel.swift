//
//  LoginViewModel.swift
//  Application
//
//  Created by Irving Huang on 2023/8/22.
//

import Foundation
import KeychainAccess

import Infrastructure_Hosting
import TMDB_Movies_Core

class LoginViewModel: BaseViewModel {
    
    
    //MARK: - Fields
    private let moviesContext: MoviesContext? = HostContext.current.getService()
    
    
    //MARK: - Constructors
    required init() {
        super.init()
        
    }
    
    
    //MARK: - Properties
    public lazy var authRepository: AuthRepository? = moviesContext?.authRepository
    
    public var accessTokenPass: (() -> Void)?
    
    public var accessTokenFail: (() -> Void)?
    
    
    //MARK: - Methods
    public func setAccessToken(_ accessToken: String) {
        
        checkAuth(token: accessToken) { [weak self] success in
            
            guard let `self` = self else { return }
            
            if success {
                self.setTokenToKeychain(accessToken)
                self.accessTokenPass?()
            } else {
                self.accessTokenFail?()
            }
            
        }
            
        
    }
    
    private func setTokenToKeychain(_ accessToken: String) {
        let keychain = Keychain(service: "com.example.irving")
        keychain["UKnowWho"] = accessToken
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
    
    
    
}
