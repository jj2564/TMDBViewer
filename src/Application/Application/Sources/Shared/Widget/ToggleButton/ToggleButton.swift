//
//  ToggleButton.swift
//  Application
//
//  Created by Irving Huang on 2023/8/19.
//

import UIKit
import TinyConstraints

class ToggleButton: UIButton {
    
    
    //MARK: - Fields
    
    
    //MARK: - Constructors
    required init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Properties
    override var isSelected: Bool {
        didSet { updateTintColor() }
    }
    
    public var selectedColor: UIColor = .primary60 {
        didSet { updateTintColor() }
    }
    public var normalColor: UIColor = .primary99 {
        didSet { updateTintColor() }
    }
    
    public var normalTextColor: UIColor = .secondary10 {
        didSet { setTitleColor(normalTextColor, for: .selected) }
    }
    
    public var selectedTextColor: UIColor = .neutral100 {
        didSet { setTitleColor(selectedTextColor, for: .selected) }
    }
    
    public var normalImage: UIImage? = nil {
        didSet { setImage(normalImage, for: .normal)  }
    }
    
    public var selectedImage: UIImage? = nil {
        didSet { setImage(selectedImage, for: .selected) }
    }
    
    
    //MARK: - Methods
    private func setupView() {
        
        setTitleColor(normalTextColor, for: .normal)
        setTitleColor(selectedTextColor, for: .selected)
        
        backgroundColor = .clear
    }
    
    private func updateTintColor() {
        tintColor = isSelected ? selectedColor : normalColor
    }
    
}
