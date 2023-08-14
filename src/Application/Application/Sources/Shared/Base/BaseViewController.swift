//
//  BaseViewController.swift
//  Application
//
//  Created by IrvingHuang on 2021/11/19.
//

import UIKit
import TinyConstraints

import Infrastructure_Core


class BaseViewController: UIViewController {
    
    
    //MARK: - Fields
    
    
    //MARK: - Constructors
    required init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .neutral100
        navigationItem.backButtonTitle = ""
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if isTransparent {
            setNavigationTransparent(isOn: true)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if isTransparent {
            setNavigationTransparent(isOn: false)
            navigationController?.setNormalStyle(alpha: 1)
        }
    }
    
    deinit {
        if InfrastructureCoreContext.shared.mode == .DEV {
            print("BaseViewController: \(self) deinit 👍🏻")
        }
    }
    
    
    //MARK: - Properties
    public var isDarkMode: Bool = true {
        didSet { changeDarkMode() }
    }
    
    public var isTransparent: Bool = false
    
    public var isCloseButton: Bool = false {
        didSet { setLeftNaviToClose() }
    }
    
    
    //MARK: - Methods
    public func dismissVC() {
        self.dismiss(animated: true, completion: nil)
    }
    
    public func setNavigationTransparent(isOn: Bool) {

        guard let navigation = self.navigationController as? BaseNavigationController else { return }
        
        if isOn {
            navigation.setTransparentAppearance()
        } else {
            navigation.setNormalAppearance()
        }
        
    }
    
    private func changeDarkMode() {
        guard let navigationController = navigationController as? BaseNavigationController else { return }
        navigationController.isDarkMode = isDarkMode
    }
    
    private func setLeftNaviToClose() {
        
        let close = SYBarButton(type: .xmark)
        close.onPressed = { [unowned self] _ in
            self.dismissVC()
        }
        
        navigationItem.leftBarButtonItems = [close]
        
    }
    
    private func hideNavigationBarLine() {
        let navAppear = UINavigationBarAppearance()
        navAppear.shadowColor = .clear
        navAppear.backgroundColor = .neutral100
        navAppear.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.secondary10]
        self.navigationController?.navigationBar.scrollEdgeAppearance = navAppear
        self.navigationController?.navigationBar.standardAppearance = navAppear
    }
    
    private func showNavigationBarLine() {
        let navAppear = UINavigationBarAppearance()
        navAppear.configureWithDefaultBackground()
        navAppear.backgroundColor = .neutral100
        navAppear.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.secondary10]
        self.navigationController?.navigationBar.standardAppearance = navAppear
        self.navigationController?.navigationBar.scrollEdgeAppearance = navAppear
    }
    
}
