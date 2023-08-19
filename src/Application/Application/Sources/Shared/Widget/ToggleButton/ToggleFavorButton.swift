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
    
    
    //MARK: - Methods
    private func setupView() {
        
        let noFavor = UIImage(systemName: "heart", withConfiguration: UIImage.SymbolConfiguration(pointSize: 42, weight: .bold))
        let isFavor = UIImage(systemName: "heart.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 42, weight: .bold))
        
        normalImage = noFavor
        selectedImage = isFavor
        
        normalColor = .secondary10
        selectedColor = .error80
        
        height(50)
        width(60)
    }
    
}
