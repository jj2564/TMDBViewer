//
//  FavoriteListViewController.swift
//  Application
//
//  Created by Irving Huang on 2023/8/20.
//

import UIKit

class FavoriteListViewController: BaseViewController {
    
    
    //MARK: - Fields
    private lazy var favorView = FavoriteListView(viewModel: viewModel)
    private let sort = SYBarButton(type: .sort)
    
    
    //MARK: - Constructors
    override func loadView() {
        super.loadView()
        
        title = "我的收藏"
        setupView()
        
        setupNavigationItem()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchAll()
    }
    
    
    //MARK: - Properties
    public let viewModel = FavoriteListViewModel()
    
    
    //MARK: - Methods
    private func setupView() {
        view.addSubview(favorView)
        favorView.edgesToSuperview()
    }
    
    private func setupNavigationItem() {
        
        
        sort.onPressed = { [unowned self] _ in
            showSortOption()
        }
        
        navigationItem.rightBarButtonItems = [sort]
        
    }
    
    private func showSortOption() {
        
        let list = MovieCardSortStyle.allCases
        
        let alert = UIAlertController(title: "請選擇排序方式", message: nil, preferredStyle: .actionSheet)
        
        if let popoverController = alert.popoverPresentationController {
            popoverController.sourceView = self.view
            popoverController.barButtonItem = sort
            popoverController.permittedArrowDirections = .up
        }
        
        for sort in list {
            let action = UIAlertAction(title: sort.rawValue, style: .default) { [unowned self] _ in
                viewModel.sortBy = sort
                viewModel.updateSort()
            }
            
            if sort == viewModel.sortBy {
                action.setValue(UIColor.primary60, forKey: "titleTextColor")
            } else {
                action.setValue(UIColor.secondary10, forKey: "titleTextColor")
            }
            alert.addAction(action)
        }
        
        let defaultCancel = UIAlertAction(title: "取消", style: .cancel)
        defaultCancel.setValue(UIColor.error10, forKey: "titleTextColor")
        alert.addAction(defaultCancel)
        
        present(alert, animated: true)
    }

}
