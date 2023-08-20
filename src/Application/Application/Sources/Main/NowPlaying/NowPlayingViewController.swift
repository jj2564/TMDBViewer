//
//  NowPlayingViewController.swift
//  Application
//
//  Created by Irving Huang on 2023/8/15.
//

import UIKit

class NowPlayingViewController: BaseViewController {
    
    
    //MARK: - Fields
    private lazy var nowPlayingView = NowPlayingView(viewModel: viewModel)
    private let viewModel = NowPlayingViewModel()
    
    
    //MARK: - Constructors
    override func loadView() {
        super.loadView()
        
        title = "現正播放中"
        setupView()
        setupNavigationItem()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.loadMore()
    }
    
    
    //MARK: - Properties
    
    
    //MARK: - Methods
    private func setupView() {
        view.addSubview(nowPlayingView)
        nowPlayingView.edgesToSuperview()
    }
    
    private func setupNavigationItem() {
        
        let search = SYBarButton(type: .search)
//        search.onPressed = { [unowned self] _ in
//
//        }
        
        let favor = SYBarButton(type: .favor)
        favor.onPressed = { [unowned self] _ in
            toFavorList()
        }
        
        let setting = SYBarButton(type: .gear)
//        setting.onPressed = {
//
//        }
        
        
        navigationItem.leftBarButtonItems = [search]
        navigationItem.rightBarButtonItems = [setting, favor]
    }
    
    private func toFavorList() {
        let vc = FavoriteListViewController()
        pushViewController(vc)
    }
    
}

