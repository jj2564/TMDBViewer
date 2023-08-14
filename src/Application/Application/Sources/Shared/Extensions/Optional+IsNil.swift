//
//  Optional+IsNil.swift
//  Application
//
//  Created by Irving Huang on 2021/10/25.
//

import Foundation

extension Optional {
    
    
    /// 判斷該型別是否為nil
    var isNil: Bool {
        switch self {
        case .none:
            return true
        case .some:
            return false
        }
    }
    
}
