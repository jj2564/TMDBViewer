//
//  UIResponder+Next.swift
//  Application
//
//  Created by Irving Huang on 2022/11/23.
//

import UIKit

extension UIResponder {
    
    func next<T: UIResponder>(_ type: T.Type) -> T? {
        return next as? T ?? next?.next(type)
    }
}
