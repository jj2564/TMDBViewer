//
//  UIView+SuperTableView.swift
//  Application
//
//  Created by Irving Huang on 2022/11/23.
//

import UIKit

extension UIView {
    
    /// 於 cell class 中取得 cell 所在的 tableView
    var superTableView: UITableView? {
        return next(UITableView.self)
    }
    
}
