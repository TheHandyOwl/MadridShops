//  DownloadAllShopsInteractorNSOpImpl.swift
//  MadridShops
//
//  Created by Carlos on 01/10/17.
//  Copyright © 2017 THO. All rights reserved.

import Foundation

class DownloadAllShopsInteractorNSOpImpl: DownloadAllShopsInteractor {
    func execute(onSuccess: @escaping (Shops) -> Void) {
        execute(onSuccess: onSuccess, onError: nil)
    }
    
    func execute(onSuccess: @escaping (Shops) -> Void, onError: errorClosure = nil) {
        
        let urlString = "https://madrid-shops.com/json_new/getShops.php"
        
        let queue = OperationQueue()
        queue.addOperation {
            
            if let url = URL(string: urlString), let data = NSData(contentsOf: url) as Data? {
                
                let shops = parseShops(data: data)
                
                OperationQueue.main.addOperation {
                    onSuccess(shops)
                }
            }
        }    
    }
}
