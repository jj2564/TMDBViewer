//
//  ToggleLayoutButton.swift
//  Application
//
//  Created by Irving Huang on 2023/8/25.
//

import UIKit
import TinyConstraints

class ToggleLayoutButton: ToggleButton {
    
    
    //MARK: - Fields
    private lazy var height = height(40)
    private lazy var width = width(40)
    
    
    //MARK: - Constructors
    required init() {
        super.init()
        setupView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Properties
    public var viewModel = ToggleLayoutButtonViewModel() {
        didSet { setupViewModel() }
    }
    
    
    //MARK: - Methods
    public func setupViewModel() {
        
        viewModel.updateLayout = { [weak self] isBlock in
            self?.isSelected = isBlock
        }
        
        isSelected = viewModel.isBlock
    }
    
    private func setupView() {
        
        let isList = Asset.iconList.image
        let isBlock = Asset.iconBlock.image
        
        normalImage = isList
        selectedImage = isBlock
        
        normalColor = .secondary10
        selectedColor = .secondary10
        
        self.height.constant = 40
        self.width.constant = 40
        
        addTarget(self, action: #selector(didTappedLayoutButton(_:)), for: .touchUpInside)
    }
    
    @objc private func didTappedLayoutButton(_ sender: UIButton) {
        
        isSelected = !isSelected
        viewModel.setBlock(isBlock: isSelected)
        
    }
    
}

