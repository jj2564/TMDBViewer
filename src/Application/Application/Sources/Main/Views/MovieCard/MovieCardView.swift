//
//  MovieCardView.swift
//  Application
//
//  Created by Irving Huang on 2023/8/16.
//

import UIKit

import TinyConstraints


class MovieCardView: BaseView<MovieCardViewModel> {
    
    
    //MARK: - Fields
    private let backView = quickView()
    private let kfImageView = KFImageContainerView()
    private let nameLabel = quickLabel()
    private let dateLabel = quickLabel()
    private let summaryLabel = quickLabel()
    
    private let favorButton = ToggleFavorButton()
    
    
    //MARK: - Constructors
    override func initEvent() {
        setupView()
        setupLayout()
        setupViewModel()
    }
    
    override func updateView() {
        updateValue()
    }
    
    public func prepareForReuse() {
        kfImageView.prepareForReuse()
        nameLabel.text = nil
        dateLabel.text = nil
        summaryLabel.text = nil
    }
    
    
    //MARK: - Properties
    
    
    //MARK: - Methods
    override func setupViewModel() {
        updateValue()
        
        favorButton.viewModel = viewModel.favorButtonViewModel
    }
    
    private func updateValue() {
        
        kfImageView.imageUrlString = viewModel.imageUrl
        kfImageView.movieId = viewModel.movieId
        
        nameLabel.text = viewModel.name ?? "XXXXXXXXX"
        
        if viewModel.date != .distantPast {
            let dateText = viewModel.date?.dateString
            dateLabel.text = dateText ?? "XXXX-XX-XX"
        } else {
            dateLabel.text = "no date info"
        }
        
        summaryLabel.text = viewModel.summary ?? "xxxxxxx xxxx xxxxx xxxxx, xxxxxxx xxxx xxxxx."
    }
    
    private func setupView() {
        
        backgroundColor = .clear
        
        let container = RoundShadowContainerView()
        container.radius = 8
        container.isShadow = true
        container.tapEnable = false
        
        addSubview(container)
        container.edgesToSuperview(insets: .init(top: 0, left: 0, bottom: 0, right: 0))
        
        container.addSubview(backView)
        backView.edgesToSuperview()
        backView.backgroundColor = .neutral100
        
        kfImageView.imageRatio = 0.5
        
        nameLabel.font = .title_m
        
        dateLabel.font = .text_m
        
        summaryLabel.font = .text_s
        summaryLabel.numberOfLines = 1
        summaryLabel.lineBreakMode = .byTruncatingTail
        
        favorButton.setWhiteAndSmaller()
        
        backView.addSubview(kfImageView)
        backView.addSubview(nameLabel)
        backView.addSubview(dateLabel)
        backView.addSubview(summaryLabel)
        
        backView.addSubview(favorButton)
        
    }
    
    private func setupLayout() {
        
        let views: ViewsDictionary = [
            "image": kfImageView,
            "name": nameLabel,
            "date": dateLabel,
            "sum": summaryLabel
        ]
        
        let vfls: VFLDictionary = [
            "H:|-(0)-[image]-(0)-|": nil,
            "H:|-(16)-[name]-(16)-|": nil,
            "H:|-(16)-[date]-(16)-|": nil,
            "H:|-(16)-[sum]-(16)-|": nil,
            "V:|-(0)-[image]-(12)-[name]-(6)-[date]-(6)-[sum(15)]-(8)-|": nil
        ]
        
        let constraints = constraintsArrayVFL(vfls, views: views)
        NSLayoutConstraint.activate(constraints)
        
        favorButton.topToSuperview(offset: 12)
        favorButton.rightToSuperview(offset: -12)
    }
    
}
