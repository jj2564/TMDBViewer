//
//  KFImageContainerView.swift
//  Application
//
//  Created by Irving Huang on 2023/8/19.
//

import UIKit
import Kingfisher

class KFImageContainerView: UIView {
    
    
    //MARK: - Fields
    private let nodataImageView = UIImageView()
    private let imageView = UIImageView()
    
    private lazy var imageHeightConstraint = imageView.heightToWidth(of: imageView, multiplier: imageRatio)
    
    
    //MARK: - Constructors
    required init() {
        super.init(frame: .zero)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Properties
    public var imageUrlString: String? = nil {
        didSet { loadImage() }
    }
    
    public var imageRatio: Double = 0.67 {
        didSet { changeImageMultiplier() }
    }
    
    
    //MARK: - Methods
    public func prepareForReuse() {
        imageView.image = nil
        imageView.isHidden = true
        nodataImageView.isHidden = false
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
                ]) { [weak self] _ in
                    self?.imageView.isHidden = false
                    self?.nodataImageView.isHidden = true
                }
            
        }
        
    }
    
    private func changeImageMultiplier() {
        imageHeightConstraint.isActive = false
        imageHeightConstraint = imageView.heightToWidth(of: imageView, multiplier: imageRatio)
    }
    
}
