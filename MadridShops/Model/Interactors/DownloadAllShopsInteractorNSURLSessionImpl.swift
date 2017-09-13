//  DownloadAllShopsInteractorNSURLSessionImpl.swift
//  MadridShops

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
                    // Ponemos un punto de interrupción para saber si estamos en el principal o no
                    // Eso o poner un assert
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
