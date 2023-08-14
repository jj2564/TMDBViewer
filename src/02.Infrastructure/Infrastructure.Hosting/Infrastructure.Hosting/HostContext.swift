//
//  HostContext.swift
//  Infrastructure.Hosting
//
//  Created by IrvingHuang on 2021/10/29.
//

import Foundation

public class HostContext: ServiceProvider {
    
    
    //MARK: - Singleton
    public static let current = HostContext()
    
    
    //MARK: - Field
    private var factoryList: [(ServiceFactory, Bool)] = []
    /// single service list
    private var serviceList: [Any] = []
    
    
    //MARK: - Constructors
    private init() { }
    
    
    //MARK: - Properties
    public var factoryCount: Int {
        factoryList.count
    }
    
    
    //MARK: - Methods
    public func registerFactory( factory: ServiceFactory, isSingle: Bool) {
        factoryList.append( (factory, isSingle) )
    }
    
    public func getService<T>() -> T? {
        
        // check
        for service in serviceList {
            guard let result = service as? T else { continue }
            return result
        }

        // get
        for (factory, isSingle) in factoryList {

            guard let service: T = factory.getService(provider: self) else { continue }
            // save
            if isSingle {
                serviceList.append(service)
            }
            return service
        }
        
        // return
        return nil
    }
    
    public func clearAll() {
        factoryList = []
        serviceList = []
    }
    
}
