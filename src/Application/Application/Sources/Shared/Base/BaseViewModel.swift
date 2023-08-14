//
//  BaseViewModel.swift
//  SuperAgent_PROD
//
//  Created by IrvingHuang on 2021/12/17.
//

import Foundation
import Infrastructure_Core

public class BaseViewModel: NSObject {
    
    
    //MARK: - Fields
    
    
    //MARK: - Constructors
    required override init() {
        super.init()
    }
    
    deinit {
        if InfrastructureCoreContext.shared.mode == .DEV && debugMessageEnable {
            print("BaseViewModel: \(self) deinit 👍🏻")
        }
    }
    
    
    //MARK: - Properties
    public var debugMessageEnable = true
    
    public var updateView: (() -> Void)?
    public var startLoadingView: (() -> Void)?
    public var stopLoadingView: (() -> Void)?
    
    
    //MARK: - Methods
    
}
