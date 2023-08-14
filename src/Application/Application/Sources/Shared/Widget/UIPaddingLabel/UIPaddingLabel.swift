//
//  UIPaddingLabel.swift
//  Application
//
//  Created by IrvingHuang on 2021/10/25.
//

import UIKit

/// 可設定padding的UILabel
@IBDesignable
open class UIPaddingLabel: UILabel {
    
    @IBInspectable
    var topPadding: CGFloat {
        get {
            return padding.top
        }
        set {
            padding.top = newValue
        }
    }
    
    @IBInspectable
    var leftPadding: CGFloat {
        get {
            return padding.left
        }
        set {
            padding.left = newValue
        }
    }
    
    @IBInspectable
    var bottomPadding: CGFloat {
        get {
            return padding.bottom
        }
        set {
            padding.bottom = newValue
        }
    }
    
    @IBInspectable
    var rightPadding: CGFloat {
        get {
            return padding.right
        }
        set {
            padding.right = newValue
        }
    }
    
    var padding: UIEdgeInsets = UIEdgeInsets.zero
    
    open override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }
    
    // Override `intrinsicContentSize` property for Auto layout code
    open override var intrinsicContentSize: CGSize {
        let superContentSize = super.intrinsicContentSize
        let width = superContentSize.width + leftPadding + rightPadding
        let heigth = superContentSize.height + topPadding + bottomPadding
        return CGSize(width: width, height: heigth)
    }
    
    // Override `sizeThatFits(_:)` method for Springs & Struts code
    open override func sizeThatFits(_ size: CGSize) -> CGSize {
        let superSizeThatFits = super.sizeThatFits(size)
        let width = superSizeThatFits.width + leftPadding + rightPadding
        let heigth = superSizeThatFits.height + topPadding + bottomPadding
        return CGSize(width: width, height: heigth)
    }
    
}
