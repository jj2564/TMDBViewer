//
//  FavoriteListView.swift
//  Application
//
//  Created by Irving Huang on 2023/8/20.
//

import UIKit
import TinyConstraints

class FavoriteListView: BaseView<FavoriteListViewModel> {
    
    
    //MARK: - Fields
    private let tableView = UITableView()
    
    
    //MARK: - Constructors
    override func initEvent() {
        backgroundColor = .neutral95
        setupTableView()
    }
    
    
    //MARK: - Properties
    
    
    //MARK: - Methods
    override func updateView() {
        
        tableView.reloadData()
        nodataView.isHidden = (viewModel.movieViewModelList.count > 0)
    }
    
    private func setupTableView() {
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 300
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        
        tableView.registerCell(UITableViewCell.self)
        tableView.registerCell(MovieCardCell.self)
        
        addSubview(tableView)
        tableView.edgesToSuperview()
    }
    
}


extension FavoriteListView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.movieViewModelList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let vm = viewModel.movieViewModelList[safe: indexPath.row] {
            let cell = tableView.dequeueCell(MovieCardCell.self, indexPath: indexPath)
            
            cell.viewModel = vm
            vm.fetchData()
            
            return cell
        }
        
        return tableView.dequeueCell(UITableViewCell.self)
    }
    
}


extension FavoriteListView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let index = indexPath.row
        if let vm = viewModel.movieViewModelList[safe: index] {
            let vc = MovieDetailViewController()
            vc.movie = vm.movie
            parentViewController?.pushViewController(vc)
        }
        
    }
    
}
