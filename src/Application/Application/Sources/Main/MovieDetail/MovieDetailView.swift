//
//  MovieDetailView.swift
//  Application
//
//  Created by Irving Huang on 2023/8/19.
//

import UIKit
import TinyConstraints

class MovieDetailView: BaseView<MovieDetailViewModel> {
    
    
    //MARK: - Fields
    private let stackView = ScrollableStackView()
    private let kfImageView = KFImageContainerView()
    
    private let infoView = quickView()
    private let favorButton = ToggleFavorButton()
    
    
    //MARK: - Constructors
    override func initEvent() {
        setupView()
    }
    
    override func setupViewModel() {
        updateView()
    }
    
    override func updateView() {
        kfImageView.imageUrlString = viewModel.mainImageUrl
    }
    
    
    //MARK: - Properties
    
    public var statusBarHeight: CGFloat = 0
    
    public var navigationStyleChangeTransparent: (() -> Void)?
    public var navigationStyleChangeAlpha: ((CGFloat) -> Void)?
    
    
    
    //MARK: - Methods
    private func setupView() {
        
        addSubview(stackView)
        stackView.edgesToSuperview()
        stackView.isUnderEdgeLayout = true
        stackView.scrollView.delegate = self
        
        stackView.addSubviewToStackView(kfImageView)
        stackView.addSubviewToStackView(infoView)
        
        infoView.height(800)
        
        infoView.addSubview(favorButton)
        favorButton.centerInSuperview()
        favorButton.addTarget(self, action: #selector(didTappedFavorButton(_:)), for: .touchUpInside)
    }
    
    @objc private func didTappedFavorButton(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
}


extension MovieDetailView: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        let y = scrollView.contentOffset.y
        let imageHeght = UIScreen.screenWidth * kfImageView.imageRatio
        
        let changeHeight = (imageHeght -  statusBarHeight)
        if y > changeHeight {
            navigationStyleChangeAlpha?(1)
        } else
        if y > 0 {
            let alpha = y / changeHeight
            navigationStyleChangeAlpha?(alpha)
        } else {
            navigationStyleChangeTransparent?()
        }
        
    }
    
}