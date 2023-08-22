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
    private let nameLabel = UIPaddingLabel()
    private let dateLabel = UIPaddingLabel()
    private let taglineLabel = UIPaddingLabel()
    private let overviewLabel = UIPaddingLabel()
    private let favorButton = ToggleFavorButton()
    
    
    //MARK: - Constructors
    override func initEvent() {
        setupView()
    }
    
    override func setupViewModel() {
        updateView()
        
        favorButton.viewModel = viewModel.favorButtonViewModel
    }
    
    override func updateView() {
        kfImageView.imageUrlString = viewModel.mainImageUrl
        kfImageView.movieId = viewModel.movie?.id
        
        nameLabel.text = viewModel.titleString
        
        if let date = viewModel.releaseDate, date != .distantPast {
            dateLabel.text = date.dateString
        } else {
            dateLabel.text = "no date info"
        }
        
        taglineLabel.text = viewModel.tagline
        
        overviewLabel.text = viewModel.overview
    }
    
    
    //MARK: - Properties
    
    public var statusBarHeight: CGFloat = 0
    
    public var navigationStyleChangeTransparent: (() -> Void)?
    public var navigationStyleChangeAlpha: ((CGFloat) -> Void)?
    
    
    
    //MARK: - Methods
    private func setupView() {
        
        backgroundColor = .secondary10
        stackView.backgroundColor = .neutral100.withAlphaComponent(0.95)
        
        addSubview(stackView)
        stackView.edgesToSuperview()
        stackView.isUnderEdgeLayout = true
        stackView.scrollView.delegate = self
        
        stackView.addSubviewToStackView(kfImageView)
        
        setupInfoView()
        stackView.addSubviewToStackView(infoView)
        
        taglineLabel.font = .text_m
        taglineLabel.textColor = .neutral80
        taglineLabel.text = "xxxxxxx xxxx xxxxx xxxxx, xxxxxxx xxxx xxxxx."
        taglineLabel.padding = .init(top: 20, left: 16, bottom: 0, right: 16)
        stackView.addSubviewToStackView(taglineLabel)
        
        let titleOverview = UIPaddingLabel()
        titleOverview.font = .title_m
        titleOverview.textColor = .secondary10
        titleOverview.text = "Overview"
        titleOverview.padding = .init(top: 20, left: 16, bottom: 4, right: 16)
        stackView.addSubviewToStackView(titleOverview)
        
        overviewLabel.font = .text_m
        overviewLabel.textColor = .secondary10
        overviewLabel.numberOfLines = 0
        overviewLabel.text = "xxxxxxx xxxx xxxxx xxxxx, xxxxxxx xxxx xxxxx. xxxxxxx xxxx xxxxx."
        overviewLabel.padding = .init(top: 4, left: 16, bottom: 20, right: 16)
        stackView.addSubviewToStackView(overviewLabel)
        
        
        stackView.addGapView(height: 800)

    }
    
    private func setupInfoView() {
        
        infoView.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = .title_xl
        nameLabel.textColor = .secondary10
        nameLabel.numberOfLines = 0
        nameLabel.padding = .init(top: 20, left: 16, bottom: 0, right: 16)
        nameLabel.text = "XXXXXXXXX"
        
        infoView.addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.font = .text_m
        dateLabel.textColor = .secondary10
        dateLabel.padding = .init(top: 4, left: 16, bottom: 6, right: 16)
        dateLabel.text = "XXXX-XX-XX"
        
        infoView.addSubview(favorButton)
        
        let views: ViewsDictionary = [
            "name": nameLabel,
            "date": dateLabel,
            "favor": favorButton
        ]
        
        let vfls: VFLDictionary = [
            "H:|-(0)-[name]-(>=0)-[favor]-(16)-|": nil,
            "H:|-(0)-[date]-(>=0)-[favor]-(16)-|": nil,
            "V:|-(0)-[name]-(0)-[date]-(0)-|": nil,
            "V:|-(20)-[favor]-(20@250)-|": nil
        ]
        
        let constraints = constraintsArrayVFL(vfls, views: views)
        NSLayoutConstraint.activate(constraints)
        
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
