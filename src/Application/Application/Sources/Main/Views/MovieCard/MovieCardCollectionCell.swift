//
//  MovieCardCollectionCell.swift
//  Application
//
//  Created by Irving Huang on 2023/8/25.
//

import UIKit

class MovieCardCollectionCell: UICollectionViewCell {
    
    
    //MARK: - Fields
    private let cardView = MovieCardView()
    
    
    //MARK: - Constructors
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cardView.prepareForReuse()
    }
    
    
    //MARK: - Properties
    public var viewModel: MovieCardViewModel {
        get { cardView.viewModel }
        set { cardView.viewModel = newValue }
    }
    
    
    //MARK: - Methods
    private func setupViews() {
        
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        contentView.addSubview(cardView)
        
        cardView.edgesToSuperview(insets: .init(top: 0, left: 0, bottom: 0, right: 0))
    }
    
}
