//
//  UrlSchemeHelper.swift
//  Application
//
//  Created by Irving Huang on 2023/8/25.
//

import UIKit

enum URLSchemeType: String {
    
    case approved
    
}

class URLSchemeHelper {
    
    
    //MARK: - Singleton
    static let shared = URLSchemeHelper()
    
    //MARK: - Methods
    public func setbyURL(url: URL, completion: (() -> Void)? = nil) {
        
        let host = url.host
        
        guard let type = URLSchemeType(rawValue: host ?? "") else { return }
        
        switch type {
        case .approved:
            NotificationCenter.default.post(name: .DidApprovedRequest, object: nil, userInfo: nil)
        }
        
    }
    
}
