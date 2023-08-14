//
//  NSObject+ClassName.swift
//  Infrastructure.Core
//
//  Created by Irving Huang on 2023/3/9.
//

import Foundation

public extension NSObject {
    var className: String {
        String(describing: type(of: self))
    }
}
