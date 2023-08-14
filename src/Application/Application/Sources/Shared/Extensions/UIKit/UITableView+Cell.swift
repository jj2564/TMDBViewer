//
//  UITableView+Cell.swift
//  Application
//
//  Created by IrvingHuang on 2021/12/9.
//
import Foundation
import UIKit

extension UITableView {
    
    /// 註冊各類型UITableViewCell
    /// ```
    /// How to use：
    /// tableView.registerCell(UITableViewCell.self)
    /// ```
    /// - Parameters:
    ///   - t: Cell Type
    func registerCell<T: UITableViewCell>(_ t: T.Type) {
        register(t, forCellReuseIdentifier: String(describing: t))
    }
    
    /// 取得各類型UITableViewCell
    /// ```
    /// How to use：
    /// tableView.dequeueCell(UITableViewCell.self, indexPath: indexPath)
    /// ```
    /// - Parameters:
    ///   - t: Cell Type
    /// - Returns: UITableViewCell
    func dequeueCell<T: UITableViewCell>(_ t: T.Type) -> T {
        let identifier = String(describing: t)
        
        guard let type = self.dequeueReusableCell(withIdentifier: identifier) as? T else {
            fatalError("TableView dequeueReusableCell 👉🏻 \(identifier) not found.")
        }
        
        return type
    }
    
    /// 取得各類型UITableViewCell
    /// ```
    /// How to use：
    /// tableView.dequeueCell(UITableViewCell.self, indexPath: indexPath)
    /// ```
    /// - Parameters:
    ///   - t: Cell Type
    ///   - indexPath: IndexPath
    /// - Returns: UITableViewCell
    func dequeueCell<T: UITableViewCell>(_ t: T.Type, indexPath: IndexPath) -> T {
        let identifier = String(describing: t)
        
        guard let type = self.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? T else {
            fatalError("TableView dequeueReusableCell 👉🏻 \(identifier) not found.")
        }
        
        return type
    }
    
}
