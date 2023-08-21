//
//  KFImageContainerView.swift
//  Application
//
//  Created by Irving Huang on 2023/8/19.
//

import UIKit
import Kingfisher

class KFImageContainerView: BaseView<KFImageContainerViewModel> {
    
    
    //MARK: - Fields
    private let nodataImageView = UIImageView()
    private let imageView = UIImageView()
    
    private lazy var imageHeightConstraint = imageView.heightToWidth(of: imageView, multiplier: imageRatio)
    
    
    //MARK: - Constructors
    override func initEvent() {
        setupView()
    }
    
    override func updateView() {
        loadImage()
    }
    
    
    //MARK: - Properties
    public var imageUrlString: String? {
        set {
            viewModel.imageUrlString = newValue
            loadImage()
        }
        get { viewModel.imageUrlString }
    }
    
    public var movieId: Int? {
        set { viewModel.movieId = newValue }
        get { viewModel.movieId }
    }
    
    public var imageRatio: Double = 0.67 {
        didSet { changeImageMultiplier() }
    }
    
    
    //MARK: - Methods
    public func prepareForReuse() {
        imageView.image = nil
        imageView.isHidden = true
        nodataImageView.isHidden = false
        movieId = nil
    }
    
    private func setupView() {
        
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        
        nodataImageView.translatesAutoresizingMaskIntoConstraints = false
        nodataImageView.contentMode = .center
        nodataImageView.image = Asset.nodata.image.resized(to: .init(width: 50, height: 50))
        nodataImageView.height(50)
        nodataImageView.width(50)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        changeImageMultiplier()
        
        addSubview(nodataImageView)
        addSubview(imageView)
        
        imageView.edgesToSuperview()
        nodataImageView.centerInSuperview()
        
    }
    
    private func loadImage() {
        
        if let imageUrlString, let url = URL(string: imageUrlString) {
            
            imageView.kf.setImage(
                with: url,
                options: [
                    .transition(.fade(1.0)),
                    .cacheOriginalImage
                ]) { [weak self] result in
                    switch result {
                    case .success(_):
                        self?.imageView.isHidden = false
                        self?.nodataImageView.isHidden = true
                    case .failure(_):
                        self?.imageView.isHidden = true
                        self?.nodataImageView.isHidden = false
                    }
                }
            
        }
        
    }
    
    private func changeImageMultiplier() {
        imageHeightConstraint.isActive = false
        imageHeightConstraint = imageView.heightToWidth(of: imageView, multiplier: imageRatio)
    }
    
}
