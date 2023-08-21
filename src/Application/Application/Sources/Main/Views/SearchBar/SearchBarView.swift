//
//  SearchBarView.swift
//  Application
//
//  Created by Irving Huang on 2023/8/20.
//

import UIKit
import TinyConstraints

class SearchBarView: UIView {
    
    
    //MARK: - Fields
    private let barHeight: CGFloat = 44
    private let barRadius: CGFloat = 4
    private lazy var image = createImageView()
    
    
    //MARK: - Constructors
    required init(text: String) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        setupStyle()
        setupLayout()
        searchTextField.placeholder = text
        searchTextField.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Properties
    public lazy var searchTextField = ClearButtonTextField()
    public var searchPressed: (() -> Void)?
    
    
    //MARK: - Methods
    private func setupStyle() {
        backgroundColor = .neutral99
        height(barHeight)
        radius = barRadius
    }
    
    private func setupLayout() {
        
        addSubview(image)
        addSubview(searchTextField)
        searchTextField.returnKeyType = .search
        
        image.leadingToSuperview(offset: 12)
        image.centerYToSuperview()
        image.setContentHuggingPriority(.init(1000), for: .horizontal)
        
        searchTextField.leftToRight(of: image, offset: 14)
        searchTextField.trailingToSuperview(offset: 20)
        searchTextField.centerYToSuperview()
        
    }
    
}

extension SearchBarView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField.text == "" {
            
            return false
            
        } else {
            
            textField.resignFirstResponder()
            searchPressed?()
            return true
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) { }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}


extension SearchBarView {
    
    private func createImageView() -> UIImageView {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(systemName: "magnifyingglass", withConfiguration: UIImage.SymbolConfiguration(pointSize: 16, weight: .medium))
        img.tintColor = .secondary10
        return img
    }
    
}
