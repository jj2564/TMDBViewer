//
//  BaseView.swift
//  Application
//
//  Created by Irving Huang on 2023/7/13.
//

import UIKit
import TinyConstraints
import Infrastructure_Core

public class BaseView<T: BaseViewModel>: UIView {
    
    
    //MARK: - Fields
    private lazy var loadingView = createLoadingView()
    
    
    //MARK: - Constructors
    public required init(viewModel: T? = nil) {
        
        self.viewModel = viewModel ?? T()
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        
        initEvent()
        setupViewModel()
        setupUpdateEvent()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        if (InfrastructureCoreContext.shared.mode == .DEV) && viewModel.debugMessageEnable {
            print("BaseView: \(self) deinit 👍🏻")
        }
    }
    
    
    //MARK: - Properties
    public typealias ViewModelFactory = () -> T
    
    public var viewModel: T {
        didSet {
            setupViewModel()
            setupUpdateEvent()
        }
    }
    
    
    //MARK: - Methods
    public func initEvent() { }
    
    public func setupViewModel() { }
    
    public func updateView() { }
    
    public func startLoadinView() {
        loadingView.isHidden = false
    }
    
    public func stopLoadingView() {
        loadingView.isHidden = true
    }
    
    
    private func setupUpdateEvent() {
        
        viewModel.updateView = { [weak self] in
            guard let `self` = self else { return }
            self.updateView()
        }
        
        viewModel.startLoadingView = { [weak self] in
            guard let `self` = self else { return }
            self.startLoadinView()
        }
        
        viewModel.stopLoadingView = { [weak self] in
            guard let `self` = self else { return }
            self.stopLoadingView()
        }
        
    }
    
    private func createLoadingView() -> UIView {
        
        let loadingView = LoadingView()
        addSubview(loadingView)
        loadingView.centerInSuperview()
        
        return loadingView
    }
    
}
