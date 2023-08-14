//
//  Array+SafeIndex.swift
//  Application
//
//  Created by Irving Huang on 2021/11/17.
//

import Foundation

extension Array {
    
    func isIndexAvailable(_ index: Int) -> Bool {
        return indices.contains(index)
    }
    
    /// Array防呆
    subscript(safe index: Int) -> Element? {
        if !indices.contains(index) {
            return nil
        }
        return self[index]
    }
    
}
