//
//  LoadingView.swift
//  Application
//
//  Created by Irving Huang on 2023/8/13.
//

import UIKit
import Kingfisher
import TinyConstraints

class LoadingImageView: UIImageView {
    
    required init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
  
        if let path = Bundle.main.path(forResource: "circle_loading", ofType: "gif") {
            let url = URL(fileURLWithPath: path)
            let provider = LocalFileImageDataProvider(fileURL: url)
            kf.setImage(with: provider)
        }
        
        width(38)
        height(38)
        radius = 19
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class LoadingView: UIView {
    
    
    //MARK: - Fields
    private lazy var imageView: UIImageView = LoadingImageView()
    private lazy var titleLabel: UILabel = createLabel()
    
    
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
    public var title: String = "讀取中..." {
        didSet {
            titleLabel.text = title
        }
    }
    
    public var darkMode: Bool = false {
        didSet {
            backgroundColor = darkMode ? .secondary10.withAlphaComponent(0.5) : .clear
            titleLabel.textColor = darkMode ? .neutral100 : .secondary30
        }
    }
    
    
    //MARK: - Methods
    private func setupView() {
        
        radius = 16
        darkMode = false
        
        addSubview(imageView)
        addSubview(titleLabel)
        
        imageView.edgesToSuperview(excluding: .bottom, insets: TinyEdgeInsets(top: 20, left: 29, bottom: 0, right: 29))
        
        titleLabel.topToBottom(of: imageView, offset: 12)
        titleLabel.bottomToSuperview(offset: -10)
        
        titleLabel.centerX(to: imageView)
    }
    
}

extension LoadingView {
    
    private func createLabel() -> UILabel {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.textColor = .secondary30
        v.font = .text_s
        v.text = title
        return v
    }
    
}
