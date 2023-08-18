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
    }
    
    override func viewDidLoad() {
        viewModel.loadMore()
    }
    
    
    //MARK: - Properties
    
    
    //MARK: - Methods
    private func setupView() {
        view.addSubview(nowPlayingView)
        nowPlayingView.edgesToSuperview()
    }
    
}

