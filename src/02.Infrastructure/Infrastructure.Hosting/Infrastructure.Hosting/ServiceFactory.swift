//
//  ServiceFactory.swift
//  Infrastructure.Hosting
//
//  Created by IrvingHuang on 2021/10/29.
//

import Foundation

public protocol ServiceFactory {
    
    
    //MARK: - Methods
    func getService<T>(provider: ServiceProvider) -> T?
}
