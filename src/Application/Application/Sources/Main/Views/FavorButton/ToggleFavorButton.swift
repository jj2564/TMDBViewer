//
//  ToggleFavorButton.swift
//  Application
//
//  Created by Irving Huang on 2023/8/19.
//

import UIKit
import TinyConstraints

class ToggleFavorButton: ToggleButton {
    
    
    //MARK: - Fields
    private lazy var height = height(50)
    private lazy var width = width(60)
    
    
    //MARK: - Constructors
    required init() {
        super.init()
        setupView()
        
        NotificationCenter.default.addObserver(self, selector: #selector(didUpdateFavor(_:)), name: .DidUpdateFavor, object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    //MARK: - Properties
    public var viewModel = ToggleFavorButtonViewModel() {
        didSet { setupViewModel() }
    }
    
    
    //MARK: - Methods
    public func setupViewModel() {
        
        viewModel.updateFavorite = { [weak self] isFavor in
            self?.isSelected = isFavor
            self?.isEnabled = true
            self?.sendNotification(isFavor: isFavor)
            
        }
        
    }
    
    public func setWhiteAndSmaller() {
        normalColor = .neutral100
        self.height.constant = 30
        self.width.constant = 36
    }
    
    private func sendNotification(isFavor: Bool) {
        
        let info = [
            "movieId": viewModel.movieId ?? 0,
            "isFavor": isFavor
        ] as [String: Any]
        
        
        NotificationCenter.default.post(name: .DidUpdateFavor, object: nil, userInfo: info)
    }
    
    private func setupView() {
        
        let noFavor = UIImage(systemName: "heart", withConfiguration: UIImage.SymbolConfiguration(pointSize: 42, weight: .regular))
        let isFavor = UIImage(systemName: "heart.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 42, weight: .regular))
        
        normalImage = noFavor
        selectedImage = isFavor
        
        normalColor = .secondary10
        selectedColor = .error80
        
        self.height.constant = 50
        self.width.constant = 60
        
        isEnabled = false
        
        addTarget(self, action: #selector(didTappedFavorButton(_:)), for: .touchUpInside)
    }
    
    @objc private func didTappedFavorButton(_ sender: UIButton) {
        
        if isSelected {
            viewModel.deleteFavor()
        } else {
            viewModel.addFavor()
        }
        
    }
    
    @objc private func didUpdateFavor(_ notification: NSNotification) {
        guard
            let userInfo = notification.userInfo,
            let movieId = userInfo["movieId"] as? Int,
            let isFavor = userInfo["isFavor"] as? Bool,
            movieId == viewModel.movieId
        else { return }
        
        isSelected = isFavor
    }
    
    
}


fileprivate extension Notification.Name {
 
    static let DidUpdateFavor = Notification.Name("DidUpdateFavor")
}
