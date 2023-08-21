//
//  SearchMovieViewController.swift
//  Application
//
//  Created by Irving Huang on 2023/8/20.
//

import UIKit
import TinyConstraints

class SearchMovieViewController: BaseViewController {
    
    
    //MARK: - Fields
    private lazy var searchView = SearchMovieView(viewModel: viewModel)
    private let viewModel = SearchMovieViewModel()
    
    
    //MARK: - Constructors
    override func loadView() {
        super.loadView()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        searchView.startSearchField()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
        searchView.endEditing(true)
    }
    
    
    //MARK: - Properties
    
    
    //MARK: - Methods
    private func setupView() {
        view.addSubview(searchView)
        searchView.edgesToSuperview(excluding: .bottom, usingSafeArea: true)
        searchView.bottomToSuperview()
    }
    
}
