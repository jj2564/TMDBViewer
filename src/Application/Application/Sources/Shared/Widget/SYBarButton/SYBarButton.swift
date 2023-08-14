//
//  SYBarButton.swift
//  Application
//
//  Created by Irving Huang on 2023/8/13.
//

import UIKit

class SYBarButton: UIBarButtonItem {
    
    
    //MARK: - Fields
    private var btn: UIButton?
    
    
    //MARK: - Constructors
    convenience init(type: Type, onPressed: ((_ button: UIButton) -> Swift.Void)? = nil) {
        self.init()
        self.onPressed = onPressed
        buttonType = type
        setup(from: type)
    }
    
    //MARK: - Properties
    public var onPressed: ((_ button: UIButton) -> Swift.Void)?
    
    public private(set) var buttonType: Type!
    
    public override var tintColor: UIColor? {
        didSet {
            btn?.setTitleColor(tintColor, for: .normal)
        }
    }
    
    
    //MARK: - Methods
    private func setup(from type: Type) {
        btn = UIButton(type: .system)
        buttonType = type
        
        btn?.widthAnchor.constraint(equalToConstant: type.size.width).isActive = true
        btn?.heightAnchor.constraint(equalToConstant: type.size.height).isActive = true
        
        switch type {
        case .text(let value):
            btn?.setTitle(value, for: .normal)
            btn?.setTitleColor(.secondary10, for: .normal)
            btn?.titleLabel?.font = (value.count >= 4) ? .title_m : .title_l
        case .textWhite(let value):
            btn?.setTitle(value, for: .normal)
            btn?.setTitleColor(.neutral100, for: .normal)
            btn?.titleLabel?.font = .title_l
        case .textGreen(let value):
            btn?.setTitle(value, for: .normal)
            btn?.setTitleColor(.primary40, for: .normal)
            btn?.titleLabel?.font = .title_m
        default:
            btn?.setImage(type.image, for: .normal)
        }
        
        btn?.addTarget(self, action: #selector(onTouchUpInside(_:)), for: .touchUpInside)
        
        customView = btn
        
    }
    
    @objc private func onTouchUpInside(_ btn: UIButton) {
        onPressed?(btn)
    }
    
    internal func setTextColor(_ color: UIColor) {
        btn?.setTitleColor(color, for: .normal)
    }
    
    
}

extension SYBarButton {
    
    /// SYBarButtonItem 樣式
    enum `Type` {
        
        case xmark
        
        case whiteXmark
        
        case reloadMark
        
        case back
        
        case foward
        
        case image(value: UIImage?)
        
        case text(value: String)
        
        case textWhite(value: String)
        
        case textGreen(value: String)
        
        var size: CGSize {
            switch self {
            case .text(let value):
                let width: CGFloat = (value.count >= 4) ? 70: 50
                return CGSize(width: width, height: 28.0)
            case .textWhite(_):
                return CGSize(width: 50.0, height: 28.0)
            case .textGreen(_):
                return CGSize(width: 50.0, height: 28.0)
            case .back, .foward:
                return CGSize(width: 23, height: 28)
            default:
                return CGSize(width: 28.0, height: 28.0)
            }
        }
        
        var image: UIImage? {
            switch self {
            case .xmark:
                return UIImage(systemName: "xmark", withConfiguration: UIImage.SymbolConfiguration(pointSize: 16, weight: .medium))
            case .whiteXmark:
                return UIImage(systemName: "xmark", withConfiguration: UIImage.SymbolConfiguration(pointSize: 16, weight: .medium))?.withTintColor(.neutral100)
            case .reloadMark:
                return UIImage(systemName: "arrow.counterclockwise", withConfiguration: UIImage.SymbolConfiguration(pointSize: 16, weight: .medium))
            case .back:
                return UIImage(systemName: "chevron.left", withConfiguration: UIImage.SymbolConfiguration(pointSize: 16, weight: .medium))
            case .foward:
                return UIImage(systemName: "chevron.right", withConfiguration: UIImage.SymbolConfiguration(pointSize: 16, weight: .medium))
            case .image(let value):
                return value
            default:
                return nil
            }
        }
    }
    
}
