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
    
    
    //MARK: - Constructors
    override func initEvent() {
        setupView()
        setupLayout()
        setupViewModel()
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
        
        kfImageView.imageUrlString = viewModel.imageUrl
        
        nameLabel.text = viewModel.name ?? "***"
        
        let dateText = viewModel.date?.dateString
        dateLabel.text = dateText ?? "****-**-**"
        
        summaryLabel.text = viewModel.summary ?? "*****"
        
    }
    
    private func setupView() {
        
        isUserInteractionEnabled = false
        backgroundColor = .clear
        
        let container = RoundShadowContainerView()
        container.radius = 8
        container.isShadow = true
        
        addSubview(container)
        container.edgesToSuperview(insets: .init(top: 8, left: 8, bottom: 8, right: 8))
        
        container.addSubview(backView)
        backView.edgesToSuperview()
        backView.backgroundColor = .neutral100
        
        kfImageView.imageRatio = 0.5
        
        nameLabel.font = .title_m
        nameLabel.numberOfLines = 0
        nameLabel.setContentHuggingPriority(.init(1000), for: .horizontal)
        
        dateLabel.font = .text_m
        dateLabel.numberOfLines = 0
        dateLabel.setContentHuggingPriority(.init(750), for: .horizontal)
        
        summaryLabel.font = .text_s
        summaryLabel.numberOfLines = 1
        summaryLabel.lineBreakMode = .byTruncatingTail
        
        backView.addSubview(kfImageView)
        backView.addSubview(nameLabel)
        backView.addSubview(dateLabel)
        backView.addSubview(summaryLabel)
        
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
            "H:|-(16)-[name]-(8)-[date]-(>=16)-|": .alignAllCenterY,
            "H:|-(16)-[sum]-(16)-|": nil,
            "V:|-(0)-[image]-(12)-[name(20)]-(6)-[sum(15)]-(8)-|": nil
        ]
        
        let constraints = constraintsArrayVFL(vfls, views: views)
        NSLayoutConstraint.activate(constraints)
        
        
    }
    
}
