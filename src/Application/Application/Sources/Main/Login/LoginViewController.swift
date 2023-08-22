//
//  LoginViewController.swift
//  Application
//
//  Created by Irving Huang on 2023/8/22.
//

import UIKit

class LoginViewController: BaseViewController {
    
    
    //MARK: - Fields
    private lazy var loginView = LoginView(viewModel: viewModel)
    private let viewModel = LoginViewModel()
    
    
    //MARK: - Constructors
    override func loadView() {
        super.loadView()
        
        setupView()
        setupViewModel()
    }
    
    
    //MARK: - Properties
    
    
    //MARK: - Methods
    private func setupView() {
        
        view.addSubview(loginView)
        loginView.edgesToSuperview()
        
    }
    
    private func setupViewModel() {
        
        viewModel.accessTokenPass = { [weak self] in
            self?.rootToMainPage()
        }
        
        viewModel.accessTokenFail = { [weak self] in
            showToaster("Token驗證失敗")
            self?.loginView.clearTextField()
        }
        
    }
    
    private func rootToMainPage() {
        
        let vc = NowPlayingViewController()
        UIApplication.rootViewController = BaseNavigationController(rootViewController: vc)
        
    }
}
