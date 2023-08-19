//
//  MovieDetailViewController.swift
//  Application
//
//  Created by Irving Huang on 2023/8/19.
//

import UIKit
import TMDB_Movies_Core

class MovieDetailViewController: BaseViewController {
    
    
    //MARK: - Fields
    private lazy var detailView = MovieDetailView(viewModel: viewModel)
    private let viewModel = MovieDetailViewModel()
    
    
    //MARK: - Constructors
    override func loadView() {
        super.loadView()
        setupView()
        setupNavigation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    //MARK: - Properties
    public var movie: Movie? {
        set {
            viewModel.movie = newValue
            viewModel.loadMoviewDetail()
        }
        get { viewModel.movie }
    }
    
    
    //MARK: - Methods
    private func setupView() {
        
        edgesForExtendedLayout = .all
        
        view.addSubview(detailView)
        detailView.edgesToSuperview()
        
        
        let statusBarHeight = (UIApplication.keyWindow?.safeAreaInsets.top ?? 0) + (navigationController?.navigationBar.frame.height ?? 0)
        detailView.statusBarHeight = statusBarHeight
        
        detailView.navigationStyleChangeAlpha = { [unowned self] alpha in
            self.navigationController?.setNormalStyle(alpha: alpha)
            self.navigationItem.title = self.movie?.originalTitle
        }
        
        detailView.navigationStyleChangeTransparent = { [unowned self] in
            self.navigationController?.setTransparentStyle()
            self.navigationItem.title = nil
        }
        
    }
    
    private func setupNavigation() {
        
        // make transparent
        isTransparent = true
        
        let arrowButton = UIButton()
        arrowButton.translatesAutoresizingMaskIntoConstraints = false
        arrowButton.setImage(Asset.arrowLeftShadow.image, for: .normal)
        arrowButton.width(23)
        arrowButton.height(29)
        arrowButton.addTarget(self, action: #selector(popViewController), for: .touchUpInside)
        let back = UIBarButtonItem(customView: arrowButton)
        
        self.navigationItem.leftBarButtonItems = [back]
        self.navigationItem.leftItemsSupplementBackButton = false
        
    }
    
    @objc private func popViewController() {
        self.navigationController?.popViewController(animated: true)
    }
    
}
