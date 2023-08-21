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
            updateTintColor()
            setupStyle()
        }
    }
    
    public var isBarDark: Bool = false {
        didSet { setNeedsStatusBarAppearanceUpdate() }
    }
    
    
    //MARK: - Methods
    private func updateTintColor() {
        barTintColor = isDarkMode ? .secondary10 : .neutral100
        textTintColor = isDarkMode ? .neutral100 : .secondary10
    }
    
    private func setupStyle() {
        setAppearance()
    }
    
    public func setAppearance() {
        let navAppear = UINavigationBarAppearance()
        navAppear.configureWithDefaultBackground()
        navAppear.backgroundColor = barTintColor
        navAppear.titleTextAttributes = [NSAttributedString.Key.foregroundColor: textTintColor]
        navigationBar.standardAppearance = navAppear
        navigationBar.scrollEdgeAppearance = navAppear
        navigationBar.tintColor = textTintColor
        isBarDark = false
    }
    
    public func setTransparentAppearance(alpha: CGFloat = 0) {
        let navAppear = UINavigationBarAppearance()
        navAppear.configureWithTransparentBackground()
        navAppear.shadowImage = UIImage()
        navAppear.backgroundColor = .neutral100.withAlphaComponent(alpha)
        navAppear.titleTextAttributes = [NSAttributedString.Key.foregroundColor: textTintColor]
        navigationBar.standardAppearance = navAppear
        navigationBar.scrollEdgeAppearance = navAppear
        navigationBar.tintColor = .neutral100
        isBarDark = true
    }
    
    public func setNormalAppearance(alpha: CGFloat = 1) {
        let navAppear = UINavigationBarAppearance()
        navAppear.configureWithTransparentBackground()
        navAppear.shadowImage = UIImage()
        navAppear.backgroundColor = .neutral100.withAlphaComponent(alpha)
        let tintColor = UIColor.secondary10.withAlphaComponent(alpha)
        navAppear.titleTextAttributes = [NSAttributedString.Key.foregroundColor: tintColor]
        navigationBar.standardAppearance = navAppear
        navigationBar.scrollEdgeAppearance = navAppear
        navigationBar.tintColor = tintColor
        isBarDark = true
    }
    
}
