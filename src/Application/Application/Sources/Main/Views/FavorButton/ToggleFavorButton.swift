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
    
    
    //MARK: - Constructors
    required init() {
        super.init()
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        }
        
    }
    
    private func setupView() {
        
        let noFavor = UIImage(systemName: "heart", withConfiguration: UIImage.SymbolConfiguration(pointSize: 42, weight: .regular))
        let isFavor = UIImage(systemName: "heart.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 42, weight: .regular))
        
        normalImage = noFavor
        selectedImage = isFavor
        
        normalColor = .secondary10
        selectedColor = .error80
        
        height(50)
        width(60)
        
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
    
}
