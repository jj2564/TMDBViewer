//
//  NowPlayingView.swift
//  Application
//
//  Created by Irving Huang on 2023/8/15.
//

import UIKit
import TinyConstraints
import TMDB_Movies_Core

class NowPlayingView: BaseView<NowPlayingViewModel> {
    
    
    //MARK: - Fields
    private let tableView = UITableView()
    
    private var isLoadingMore = false
    
    
    //MARK: - Constructors
    override func initEvent() {
        backgroundColor = .neutral95
        setupTableView()
    }
    
    
    //MARK: - Properties
    
    
    //MARK: - Methods
    override func updateView() {
        
        isLoadingMore = false
        tableView.reloadData()
        nodataView.isHidden = (viewModel.movieList.count > 0)
        
    }
    
    private func loadMoreDataIfNeeded(from indexPath: IndexPath) {
        let threshold = 5
        if indexPath.row >= viewModel.movieList.count - threshold && !isLoadingMore {
            isLoadingMore = true
            viewModel.loadMore()
        }
    }
    
    private func setupTableView() {
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.estimatedRowHeight = 300
        tableView.rowHeight = UITableView.automaticDimension
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.registerCell(UITableViewCell.self)
        tableView.registerCell(MovieCardCell.self)
        
        addSubview(tableView)
        tableView.edgesToSuperview()
    }
    
}

extension NowPlayingView: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.movieList.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        loadMoreDataIfNeeded(from: indexPath)
        
        if let movie = viewModel.movieList[safe: indexPath.row] {
            let cell = tableView.dequeueCell(MovieCardCell.self, indexPath: indexPath)
            
            let cardViewModel = MovieCardViewModel()
            cardViewModel.movie = movie
            cell.viewModel = cardViewModel
            
            return cell
        }
        
        return tableView.dequeueCell(UITableViewCell.self)
    }
    
}


extension NowPlayingView: UITableViewDelegate {
    
}
