//
//  SearchMovieView.swift
//  Application
//
//  Created by Irving Huang on 2023/8/20.
//

import UIKit
import TinyConstraints

class SearchMovieView: BaseView<SearchMovieViewModel> {
    
    
    //MARK: - Fields
    private lazy var searchView = createSearchView()
    private lazy var searchBar = createSearchBar()
    private lazy var tableView = createTableView()
    
    
    //MARK: - Constructors
    override func initEvent() {
        backgroundColor = .neutral95
        setupViews()
    }
    
    override func updateView() {
        
        tableView.reloadData()
        nodataView.isHidden = (viewModel.movieList.count > 0)
    }
    
    
    //MARK: - Properties
    
    
    //MARK: - Methods
    
    public func startSearchField() {
        searchBar.searchTextField.becomeFirstResponder()
    }
    
    
    private func setupViews() {
        
        addSubview(searchView)
        addSubview(tableView)
        
        searchView.edgesToSuperview(excluding: .bottom)
        tableView.edgesToSuperview(excluding: .top)
        
        searchView.bottomToTop(of: tableView)
        
        nodataView.isHidden = false
    }
    
}


extension SearchMovieView: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
        guard let textField = textField as? ClearButtonTextField else { return }
        
        if let text = textField.text, text == "" {
            
            textField.rightViewMode = .unlessEditing
            
        } else if let _ = textField.text {
            
            let clearButton = textField.clearButton
            textField.rightView = clearButton
            textField.rightViewMode = .whileEditing
            
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text else { return false }
        if text != "" {
            viewModel.search(by: text)
        }
        return true
    }
    
}

extension SearchMovieView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
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


extension SearchMovieView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let index = indexPath.row
        if let movie = viewModel.movieList[safe: index] {
            let vc = MovieDetailViewController()
            vc.movie = movie
            parentViewController?.pushViewController(vc)
        }
        
    }
    
}

extension SearchMovieView {
    
    private func createSearchView() -> UIView {
        
        let v = quickView()
        
        v.backgroundColor = .neutral100
        v.addSubview(searchBar)
        searchBar.edgesToSuperview(excluding: .right, insets: .init(top: 8, left: 16, bottom: 8, right: 0))
        
        let cancel = createCancelButton()
        
        v.addSubview(cancel)
        cancel.edgesToSuperview(excluding: .left, insets: .init(top: 8, left: 0, bottom: 8, right: 8))
        
        searchBar.rightToLeft(of: cancel)
        
        return v
        
    }
    
    private func createSearchBar() -> SearchBarView {
        
        let placeholder = "查詢"
        let bar = SearchBarView(text: placeholder)
        bar.searchTextField.placeholder = placeholder
        
        bar.searchTextField.rightViewMode = .always
        bar.searchTextField.textColor = .neutral40
        bar.searchTextField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.neutral60, NSAttributedString.Key.font: UIFont.text_m])
        
        bar.searchTextField.delegate = self
        
        return bar
        
    }
    
    private func createCancelButton() -> UIButton {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .neutral100
        btn.setTitle("取消", for: .normal)
        btn.setTitleColor(.secondary10, for: .normal)
        btn.titleLabel?.font = .title_m
        btn.width(56)
        btn.addTarget(self, action: #selector(cancelButtonPressed), for: .touchUpInside)
        return btn
    }
    
    @objc private func cancelButtonPressed() {
        parentViewController?.navigationController?.popViewController(animated: true)
    }
    
    private func createTableView() -> UITableView {
        
        let tableView = UITableView()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 300
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        
        tableView.registerCell(UITableViewCell.self)
        tableView.registerCell(MovieCardCell.self)
        
        return tableView
        
    }
    
}
