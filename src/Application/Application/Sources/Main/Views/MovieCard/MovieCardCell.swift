//
//  MovieCardCell.swift
//  Application
//
//  Created by Irving Huang on 2023/8/18.
//

import UIKit

class MovieCardCell: UITableViewCell {
    
    
    //MARK: - Fields
    private let cardView = MovieCardView()
    
    
    //MARK: - Constructors
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
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
        
        cardView.edgesToSuperview(insets: .init(top: 12, left: 16, bottom: 0, right: 16))
    }
    
}
