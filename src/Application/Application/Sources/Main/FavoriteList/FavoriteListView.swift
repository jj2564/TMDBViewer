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
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    
    private var rowCount: Int { viewModel.perRowCount }
    
    
    
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
        
        updateCollectionLayout()
        collectionView.reloadData()
        nodataView.isHidden = (viewModel.movieViewModelList.count > 0)
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
    
    // TODO: - 精細計算圖片跟高度
    private func updateCollectionLayout() {
        collectionView.collectionViewLayout.updateLayout(rowCount: rowCount)
    }
    
}


extension FavoriteListView: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.showList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if let vm = viewModel.showList[safe: indexPath.row] {
            let cell = collectionView.dequeueCell(MovieCardCollectionCell.self, indexPath: indexPath)
            
            cell.viewModel = vm
            vm.fetchData()
            return cell
        }

        return UICollectionViewCell()
    }

}

extension FavoriteListView: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = indexPath.row
        if let vm = viewModel.showList[safe: index] {
            let vc = MovieDetailViewController()
            vc.movie = vm.movie
            parentViewController?.pushViewController(vc)
        }
        
    }
    
}
