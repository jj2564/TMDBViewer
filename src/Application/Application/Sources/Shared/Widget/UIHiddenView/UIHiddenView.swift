//
//  UIHiddenView.swift
//  Application
//
//  Created by Irving Huang on 2022/6/1.
//

import UIKit
import TinyConstraints

class UIHiddenView: UIView {
    
    
    //MARK: - Fields
    private lazy var heightZero = height(0, isActive: false)
    private lazy var widthZero = width(0, priority: .defaultHigh, isActive: false)
    
    
    //MARK: - Constructors
    required init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Properties
    override var isHidden: Bool  {
        get { super.isHidden }
        set {
            super.isHidden = newValue
            hiddenChanged()
        }
    }
    
    public var hideVertical: Bool = true {
        didSet { hiddenChanged() }
    }
    
    public var hideHorizontal: Bool = true {
        didSet { hiddenChanged() }
    }
    
    
    //MARK: - Methods
    public func addSubview(_ view: UIView, insets: UIEdgeInsets) {
        addSubview(view)
        view.edgesToSuperview(insets: insets)
        fixSubviewsConstraints(multiplier: 0.9)
    }
    
    private func hiddenChanged() {
        heightZero.isActive = (isHidden && hideVertical)
        widthZero.isActive = (isHidden && hideHorizontal)
    }
    
}
