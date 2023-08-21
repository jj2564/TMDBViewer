//
//  ClearButtonTextField.swift
//  Application
//
//  Created by Irving Huang on 2023/8/20.
//

import UIKit
import TinyConstraints

class ClearButtonTextField: UITextField {
    
    
    //MARK: - Fields
    private let buttonHeight: CGFloat = 17
    
    
    //MARK: - Constructors
    required init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        setupStyle()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Properties
    public lazy var clearButton = createClearBtn()
    
    public override var placeholder: String? {
        didSet {
            updatePlaceholder()
        }
    }
    
    
    //MARK: - Methods
    private func setupStyle() {
        textColor = .primary40
        rightView = clearButton
        clearButtonMode = .never
        rightViewMode = .whileEditing
    }
    
    private func updatePlaceholder() {
        guard let text = placeholder else { return }
        attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: UIColor.primary40, NSAttributedString.Key.font: UIFont.text_m_bold])
    }
    
    private func setupLayout() {
        clearButton.centerYToSuperview()
        clearButton.rightToSuperview()
    }
    
}

extension ClearButtonTextField {
    
    private func createClearBtn() -> UIButton {
        let clearBtn = UIButton()
        clearBtn.translatesAutoresizingMaskIntoConstraints = false
        clearBtn.height(buttonHeight)
        clearBtn.width(buttonHeight)
        clearBtn.layer.cornerRadius = buttonHeight / 2
        clearBtn.backgroundColor = UIColor.neutral60
        //image
        let image = UIImage(systemName: "xmark", withConfiguration: UIImage.SymbolConfiguration(pointSize: 8, weight: .medium))
        clearBtn.setImage(image, for: .normal)
        clearBtn.tintColor = .neutral100
        clearBtn.addTarget(self, action: #selector(clearClicked), for: .touchUpInside)
        addSubview(clearBtn)
        return clearBtn
    }
    
    @objc private func clearClicked(sender: UIButton) {
        text = nil
        sendActions(for: .editingChanged)
    }
    
}
