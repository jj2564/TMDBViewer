//
//  BaseNavigationController.swift
//  Application
//
//  Created by IrvingHuang on 2021/11/19.
//

import Foundation
import UIKit

class BaseNavigationController: UINavigationController {
    
    
    //MARK: - Fields
    private var barTintColor: UIColor = .neutral100
    private var textTintColor: UIColor = .secondary10
    
    
    //MARK: - Constructors
    override func loadView() {
        super.loadView()
        setNormalAppearance(alpha: 1)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return isBarDark ? .darkContent : .lightContent
    }
    
    
    //MARK: - Properties
    public var isDarkMode: Bool = true {
        didSet {
            barTintColor = isDarkMode ? .primary30 : .neutral100
            textTintColor = isDarkMode ? .neutral100 : .secondary10
            setupStyle()
        }
    }
    
    public var isBarDark: Bool = true {
        didSet { setNeedsStatusBarAppearanceUpdate() }
    }
    
    
    //MARK: - Methods
    private func updateTintColor() {
        barTintColor = isDarkMode ? .primary30 : .neutral100
        textTintColor = isDarkMode ? .white : .secondary10
    }
    
    private func setupStyle() {
        let navAppear = UINavigationBarAppearance()
        configureAppearance(navAppear)
        applyAppearance(navAppear)
    }
    
    private func configureAppearance(_ appearance: UINavigationBarAppearance) {
        appearance.configureWithTransparentBackground()
        appearance.shadowImage = UIImage()
        appearance.backgroundColor = barTintColor.withAlphaComponent(1)
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: textTintColor]
    }
    
    private func applyAppearance(_ appearance: UINavigationBarAppearance) {
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
        navigationBar.tintColor = textTintColor
        isBarDark = false
    }
    
    public func setTransparentAppearance(alpha: CGFloat = 0) {
        let navAppear = UINavigationBarAppearance()
        configureAppearance(navAppear)
        navAppear.backgroundColor = barTintColor.withAlphaComponent(alpha)
        applyAppearance(navAppear)
    }
    
    public func setNormalAppearance(alpha: CGFloat = 1) {
        let navAppear = UINavigationBarAppearance()
        configureAppearance(navAppear)
        navAppear.backgroundColor = barTintColor.withAlphaComponent(alpha)
        navAppear.titleTextAttributes = [NSAttributedString.Key.foregroundColor: textTintColor.withAlphaComponent(alpha)]
        applyAppearance(navAppear)
    }
    
}
