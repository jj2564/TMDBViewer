//
//  RoundShadowContainerView.swift
//  Application
//
//  Created by Irving Huang on 2022/7/27.
//

import UIKit

class RoundShadowContainerView: UIView {
    
    
    //MARK: - Fields
    
    
    //MARK: - Constructors
    required init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTappedView))
        addGestureRecognizer(tap)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupShadow()
    }
    
    //MARK: - Properties
    public var didTapped: (() -> Void)?
    
    public var isShadow: Bool = true {
        didSet { shadowToggle() }
    }
    
    
    //MARK: - Methods
    @objc private func didTappedView() {
        didTapped?()
    }
    
    private func setupShadow() {
        
        shadowColor = .secondary10
        shadowOffset = CGSize(width: 0, height: 6)
        shadowToggle()
    }
    
    private func shadowToggle() {
        shadowRadius = isShadow ? 8 : 0
        shadowOpacity = isShadow ? 0.2 : 0
    }
    
}

