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
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()

    private var rowCount: Int { viewModel.perRowCount }
    
    private var isLoadingMore = false
    
    
    //MARK: - Constructors
    override func initEvent() {
        backgroundColor = .neutral95
        setupCollectionView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateCollectionLayout()
    }
    
    
    //MARK: - Properties
    
    
    //MARK: - Methods
    override func updateView() {
        
        isLoadingMore = false
        updateCollectionLayout()
        collectionView.reloadData()
        nodataView.isHidden = (viewModel.movieList.count > 0)
        
    }
    
    private func loadMoreDataIfNeeded(from indexPath: IndexPath) {
        let threshold = 5
        if indexPath.row >= viewModel.movieList.count - threshold && !isLoadingMore {
            isLoadingMore = true
            viewModel.loadMore()
        }
    }
    
    private func setupCollectionView() {
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.registerCell(UICollectionViewCell.self)
        collectionView.registerCell(MovieCardCollectionCell.self)
        
        addSubview(collectionView)
        collectionView.edgesToSuperview()
    }
    
    
    private func updateCollectionLayout() {
        collectionView.collectionViewLayout.updateLayout(rowCount: rowCount)
    }
    
}

extension NowPlayingView: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.movieList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        loadMoreDataIfNeeded(from: indexPath)

        if let movie = viewModel.movieList[safe: indexPath.row] {
            let cell = collectionView.dequeueCell(MovieCardCollectionCell.self, indexPath: indexPath)
            let cardViewModel = MovieCardViewModel()
            cardViewModel.movie = movie
            cell.viewModel = cardViewModel
            return cell
        }

        return UICollectionViewCell()
    }

}

extension NowPlayingView: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = indexPath.row
        if let movie = viewModel.movieList[safe: index] {
            let vc = MovieDetailViewController()
            vc.movie = movie
            parentViewController?.pushViewController(vc)
        }
    }
}
