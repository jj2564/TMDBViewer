//
//  FavoriteListViewController.swift
//  Application
//
//  Created by Irving Huang on 2023/8/20.
//

import Foundation

class FavoriteListViewController: BaseViewController {
    
    
    //MARK: - Fields
    private lazy var favorView = FavoriteListView(viewModel: viewModel)
    public let viewModel = FavoriteListViewModel()
    
    
    //MARK: - Constructors
    override func loadView() {
        super.loadView()
        
        title = "我的收藏"
        setupView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchAll()
    }
    
    
    //MARK: - Properties
    
    
    //MARK: - Methods
    private func setupView() {
        view.addSubview(favorView)
        favorView.edgesToSuperview()
    }

}
