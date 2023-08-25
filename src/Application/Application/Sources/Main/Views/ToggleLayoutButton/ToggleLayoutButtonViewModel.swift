//
//  ToggleLayoutButtonViewModel.swift
//  Application
//
//  Created by Irving Huang on 2023/8/25.
//

import Foundation

import Infrastructure_Hosting
import TMDB_User_Core

class ToggleLayoutButtonViewModel: BaseViewModel {
    
    
    //MARK: - Fields
    private let userContext: UserContext? = HostContext.current.getService()
    
    
    //MARK: - Constructors
    required init() {
        super.init()
        
        checkRowCount()
        NotificationCenter.default.addObserver(self, selector: #selector(didUpdateLayout(_:)), name: .DidUpdateLayout, object: nil)
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    //MARK: - Properties
    public lazy var settingService: SettingService? = userContext?.settingService
    
    public var isBlock: Bool = false
    
    public var updateLayout: ((Bool) -> Void)?
    
    public var didUpdateRowCount: ((Int) -> Void)?
    
    public var currentCount: Int { isBlock ? 3 : 1 }
    
    
    //MARK: - Methods
    public func checkRowCount(completion: (() -> Void)?  = nil) {
        
        if let value = try?  settingService?.get(key: "LayoutStyle"), let count = Int(value) {
            isBlock = (count == 3)
            updateLayout?(isBlock)
            completion?()
        }
        
    }
    
    public func setBlock(isBlock: Bool) {
        self.isBlock = isBlock
        sendNotification(isBlock: isBlock)
        updateRowCount()
        didUpdateRowCount?(currentCount)
    }
    
    private func updateRowCount() {
        
        let value = "\(currentCount)"
        print(value)
        
        try? settingService?.set(key: "LayoutStyle", value: value)
        
    }
    
    private func sendNotification(isBlock: Bool) {
        
        let info = [
            "rowCount": currentCount
        ] as [String: Any]
        
        NotificationCenter.default.post(name: .DidUpdateLayout, object: nil, userInfo: info)
    }
    
    @objc private func didUpdateLayout(_ notification: NSNotification) {
        guard
            let userInfo = notification.userInfo,
            let rowCount = userInfo["rowCount"] as? Int
        else { return }
        
        let isBlock = (rowCount == 3)
        
        if self.isBlock == isBlock { return }
        
        setBlock(isBlock: isBlock)
        updateLayout?(isBlock)
    }
    
}



extension Notification.Name {
 
    static let DidUpdateLayout = Notification.Name("DidUpdateLayout")
}
