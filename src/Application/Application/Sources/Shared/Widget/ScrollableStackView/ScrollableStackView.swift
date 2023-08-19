//
//  ScrollableStackView.swift
//  Application
//
//  Created by IrvingHuang on 2021/11/19.
//

import Foundation
import UIKit
import TinyConstraints

class ScrollableStackView: UIView {
    
    
    //MARK: - Fields
    private lazy var stackView: UIStackView = createStackView()
    
    
    //MARK: - Constructors
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setupLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Properties
    public lazy var scrollView: UIScrollView = createScrollView()
    
    public var isGroup: Bool = false {
        didSet { updateGroupStyle() }
    }
    
    public var isScrollEnabled: Bool = true {
        didSet {
            scrollView.isScrollEnabled = isScrollEnabled
        }
    }
    
    public var isUnderEdgeLayout: Bool = false {
        didSet {
            scrollView.contentInsetAdjustmentBehavior = isUnderEdgeLayout ? .never : .always
        }
    }
    
    
    //MARK: - Methods
    public func addSubviewToStackView(_ subview: UIView) {
        stackView.addArrangedSubview(subview)
    }
    
    public func insertSubviewToStackView(_ subview: UIView, at index: Int) {
        stackView.insertArrangedSubview(subview, at: index)
    }
    
    public func viewToLast(_ subView: UIView) {
        
        for view in stackView.subviews {
            if view == subView {
                view.removeFromSuperview()
            }
        }
        
        stackView.addArrangedSubview(subView)
        
    }
    
    public func getIndex(_ subView: UIView) -> Int? {
        guard let index = stackView.arrangedSubviews.firstIndex(of: subView) else { return nil }
        return index
    }
    
    public func scrollTo(view: UIView) {
        
        guard let index = getIndex(view) else { return }
        scrollToView(at: index)
        
    }
    
    public func scrollToView(at index: Int, animated: Bool = true) {
        guard index < stackView.arrangedSubviews.count else {
            print("Index out of range")
            return
        }
        
        if let targetView = stackView.arrangedSubviews[safe: index] {
            let targetRect = scrollView.convert(targetView.frame, from: stackView)
            scrollView.scrollRectToVisible(targetRect, animated: animated)
        }
        
    }
    
    
    public func clearAll() {
        for view in stackView.subviews {
            view.removeFromSuperview()
        }
    }
    
    private func setupLayouts() {
        
        addSubview(scrollView)
        scrollView.edgesToSuperview()
        scrollView.alwaysBounceVertical = true
        
        scrollView.addSubview(stackView)
        stackView.edgesToSuperview()
        
        stackView.width(to: scrollView, relation: .equal)
    }
    
    private func updateGroupStyle() {
        stackView.layoutMargins = UIEdgeInsets(top: 16, left: 20, bottom: 16, right: 20)
        stackView.isLayoutMarginsRelativeArrangement = isGroup
    }
    
}


extension ScrollableStackView {
    
    private func createScrollView() -> UIScrollView {
        let scv = UIScrollView()
        scv.translatesAutoresizingMaskIntoConstraints = false
        scv.isPagingEnabled = false
        scv.showsHorizontalScrollIndicator = false
        scv.showsVerticalScrollIndicator = false
        return scv
    }
    
    private func createStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }
    
}


