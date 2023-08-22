//
//  LoginView.swift
//  Application
//
//  Created by Irving Huang on 2023/8/22.
//

import UIKit
import TinyConstraints

class LoginView: BaseView<LoginViewModel> {
    
    
    //MARK: - Fields
    private let textField = UITextField()
    
    
    //MARK: - Constructors
    override func initEvent() {
        setupView()
    }
    
    
    //MARK: - Properties
    
    
    //MARK: - Methods
    public func clearTextField() {
        textField.text = ""
    }
    
    private func setupView() {
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = Asset.logo.image
        
        addSubview(imageView)
        imageView.edgesToSuperview(excluding: .bottom, insets: .init(top: 100, left: 16, bottom: 0, right: 16))
        
        let label = quickLabel()
        label.font = .title_l
        label.textColor = .secondary30
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "請輸入您的 TMDB token，本程式會幫您存入 Keychain 之中，請放心輸入。"
        
        addSubview(label)
        label.leftToSuperview(offset: 20)
        label.rightToSuperview(offset: -20)
        label.topToBottom(of: imageView, offset: 40)
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = UIColor(0x01b4e4)
        
        textField.font = .text_l
        textField.textColor = .neutral100
        textField.autocapitalizationType = .none
        textField.attributedPlaceholder = NSAttributedString(
            string: "請在此輸入Token",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.neutral99]
        )
        
        textField.height(44)
        textField.radius = 22
        
        let left = quickView()
        left.width(16)
        left.height(44)
        textField.leftView = left
        textField.leftViewMode = .always
        
        addSubview(textField)
        textField.centerYToSuperview(priority: .init(750))
        textField.topToBottom(of: label, offset: 30, relation: .equalOrGreater, priority: .init(1000) )
        textField.leftToSuperview(offset: 20)
        textField.rightToSuperview(offset: -20)
        
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("登入", for: .normal)
        button.height(60)
        button.radius = 6
        button.backgroundColor = .secondary80
        button.addTarget(self, action: #selector(didPressedLogin), for: .touchUpInside)
        
        addSubview(button)
        button.edgesToSuperview(excluding: .top, insets: .init(top: 0, left: 16, bottom: 8, right: 16), usingSafeArea: true)
        
    }
    
    @objc private func didPressedLogin() {
        
        if let token = textField.text, token.count > 10 {
            viewModel.setAccessToken(token)
        } else {
            showToaster("請輸入Token~")
        }
        
    }
    
}
