//
//  AsyncHelper.swift
//  Application
//
//  Created by Irving Huang on 2023/8/15.
//

import Foundation
import Infrastructure_HttpClient


class AsyncHelper {
    
    func sync<T: Any>(action: @escaping (() throws ->T?)) -> T? {
        
        var result: T? = nil
        var actionError: Error? = nil
        
        do {
            result = try action()
        } catch let error {
            actionError = error
        }
        
        logError(actionError) { err in
            print(err)
        }
        
        return result
    }
    
    
    func excute<T: Any>(action: @escaping (() throws ->T?), completion: @escaping ((T?) throws ->Void) ) {
        excute(action: action, completion: completion) { error in
            print(error)
        }
    }
    
    
    func excute<T: Any>(action: @escaping (() throws ->T), completion: @escaping ((T) throws ->Void), error: @escaping ((Error)->Void) ) {
        
        let queue = DispatchQueue(label: "com.sinyi.superagent.asynchelper", qos: .userInteractive)
        
        var result: T? = nil
        var actionError: Error? = nil
        
        let workItem = DispatchWorkItem {
            
            do {
                result = try action()
            } catch let error {
                actionError = error
            }
            
            DispatchQueue.main.async {
                self.logError(actionError, error: error)
            }
        }
        
        queue.async(execute: workItem)
        
        workItem.notify(queue: DispatchQueue.main) {
            
            if let result = result {
                do {
                    try completion(result)
                } catch let error {
                    actionError = error
                }
            }
            
            self.logError(actionError, error: error)
        }
        
    }
    
    private func logError(_ actionError: Error?, error: @escaping ((Error)->Void) ) {
        
        if let actionError = actionError {
            error(actionError)
            print(actionError)
        }

        if let netError = actionError as? HttpError {
            switch netError {
            case .networkError(let message):
                if message.count > 0 {
                    print(message)
                }
            }
        }
        
    }
    
}
