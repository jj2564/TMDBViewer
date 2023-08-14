//
//  UICollectionView+Cell.swift
//  Application
//
//  Created by IrvingHuang on 2021/12/28.
//

import Foundation
import UIKit

extension UICollectionView {
    
    
    /// 註冊各類型UICollectionViewCell
    /// - Parameters:
    ///   - t: Cell Type
    func registerCell<T: UICollectionViewCell>(_ t: T.Type) {
        register(t, forCellWithReuseIdentifier: String(describing: t))
    }
    
    func registerHeader<T: UICollectionReusableView>(_ t: T.Type) {
        register(
            t,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: String(describing: t)
        )
    }
    
    func registerFooter<T: UICollectionReusableView>(_ t: T.Type) {
        register(
            t,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: String(describing: t)
        )
    }
    
    /// 取得各類型UICollectionViewCell
    /// - Parameters:
    ///   - t: Cell Type
    ///   - indexPath: IndexPath
    /// - Returns: UICollectionViewCell
    func dequeueCell<T: UICollectionViewCell>(_ t: T.Type, indexPath: IndexPath) -> T {
        let identifier = String(describing: t)
        
        guard let type = self.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? T else {
            fatalError("CollectionView dequeueReusableCell 👉🏻 \(identifier) not found.")
        }
        
        return type
    }
    
    func dequeueHeader<T: UICollectionReusableView>(_ t: T.Type, indexPath: IndexPath) -> T {
        let identifier = String(describing: t)
        
        guard let type = self.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: identifier, for: indexPath) as? T else {
            fatalError("CollectionView dequeueReusableHeader 👉🏻 \(identifier) not found.")
        }
        
        return type
    }
    
    func dequeueFooter<T: UICollectionReusableView>(_ t: T.Type, indexPath: IndexPath) -> T {
        let identifier = String(describing: t)
        
        guard let type = self.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: identifier, for: indexPath) as? T else {
            fatalError("CollectionView dequeueReusableFooter 👉🏻 \(identifier) not found.")
        }
        
        return type
    }
    
}
