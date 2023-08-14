//
//  UISegmentedControl+Apperance.swift
//  Application
//
//  Created by Irving Huang on 2022/5/11.
//

import UIKit

extension UISegmentedControl {
    
    func setStyle(tintColor: UIColor = .primary40) {
        if #available(iOS 13.0, *) {
            self.layer.borderColor = tintColor.cgColor
            self.layer.borderWidth = 1.0
            
            var renderer = UIGraphicsImageRenderer(size: CGSize(width: 100.0, height: 32.0))
            
            // 選到時的背景色
            var image = renderer.image { context in
                tintColor.setFill()
                context.fill(context.format.bounds)
            }
            self.setBackgroundImage(image, for: .selected, barMetrics: .default)
            
            // 選到時的字體顏色
            var attrs = [
                NSAttributedString.Key.foregroundColor: UIColor.neutral100,
                NSAttributedString.Key.font: UIFont.title_m
            ]
            self.setTitleTextAttributes(attrs, for: .selected)
            
            // 未選到時的背景色
            image = renderer.image { context in
                UIColor.white.setFill()
                context.fill(context.format.bounds)
            }
            self.setBackgroundImage(image, for: .normal, barMetrics: .default)
            
            // 未選到時的字體顏色
            attrs = [
                .foregroundColor: tintColor,
                .font: UIFont.title_m
            ]
            self.setTitleTextAttributes(attrs, for: .normal)
            
            // 設定中間分隔線顏色
            renderer = UIGraphicsImageRenderer(size: CGSize(width: 1.0, height: 32.0))
            image = renderer.image { context in
                tintColor.setFill()
                context.fill(context.format.bounds)
            }
            
            self.setDividerImage(image,
                                 forLeftSegmentState: .normal,
                                 rightSegmentState: .normal,
                                 barMetrics: .default)
        } else {
            self.layer.cornerRadius = 4.0
            self.clipsToBounds = true
            
            self.tintColor = tintColor
            self.backgroundColor = .neutral100
            
            let attrs = [NSAttributedString.Key.font: UIFont.title_m]
            self.setTitleTextAttributes(attrs, for: .normal)
        }
    }
}
