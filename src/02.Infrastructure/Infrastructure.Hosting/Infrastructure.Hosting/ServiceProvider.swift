//
//  ServiceProvider.swift
//  Infrastructure.Hosting
//
//  Created by IrvingHuang on 2021/11/15.
//

import Foundation

public protocol ServiceProvider {
    
    
    //MARK: - Methods
    func getService<T>() -> T?
}
