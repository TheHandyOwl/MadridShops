//  DownloadAllShopsInteractorNSURLSessionImpl.swift
//  MadridShops
//
//  Created by Carlos on 01/10/17.
//  Copyright © 2017 THO. All rights reserved.

import Foundation

class DownloadAllShopsInteractorNSURLSessionImpl: DownloadAllShopsInteractor {
    func execute(onSuccess: @escaping (Shops) -> Void, onError: errorClosure) {
        let urlString = "https://madrid-shops.com/json_new/getShops.php"
        
        let session = URLSession.shared
        if let url = URL(string: urlString){
            let task = session.dataTask(with: url) { (data: Data?,
                response: URLResponse?,
                error: Error?)
                in
                
                OperationQueue.main.addOperation {
                    assert(Thread.current == Thread.main)
                    
                    if error == nil {
                        // Ok
                        let shops = parseShops(data: data!)
                        onSuccess(shops)
                    } else {
                        //Error
                        if let myError = onError{
                            myError(error!)
                        }
                    }
                }
                
            }
            task.resume()
        }
    }
    
    func execute(onSuccess: @escaping (Shops) -> Void) {
        execute(onSuccess: onSuccess, onError: nil)
    }
    
    
}
