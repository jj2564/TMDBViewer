//
//  UICollectionViewFlowLayout+UpdateLayout.swift
//  Application
//
//  Created by Irving Huang on 2023/8/25.
//

import UIKit

extension UICollectionViewLayout {
    
    func updateLayout(rowCount: Int) {
        
        guard let layout = self as? UICollectionViewFlowLayout else { return }
        
        let spacing: CGFloat = isIphone ? 8.0 : 12.0
        let width = (UIScreen.main.bounds.width - CGFloat(rowCount + 1) * spacing) / CGFloat(rowCount)
        
        var height: CGFloat
        if isIphone {
            height = (rowCount == 1) ? width * 0.7 : width * 1.1
        } else {
            height = (rowCount == 1) ? width * 0.6 : width * 0.8
        }
        
        layout.itemSize = CGSize(width: width, height: height)
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
    }
    
}
