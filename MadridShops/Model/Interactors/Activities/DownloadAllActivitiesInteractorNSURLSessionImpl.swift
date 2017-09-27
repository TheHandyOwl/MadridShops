//  DownloadAllActivitiesInteractorNSURLSessionImpl.swift
//  MadridShops

import Foundation

class DownloadAllActivitiesInteractorNSURLSessionImpl: DownloadAllActivitiesInteractor {
    func execute(onSuccess: @escaping (Activities) -> Void, onError: errorClosure) {
        let urlString = "https://madrid-shops.com/json_new/getActivities.php"
        
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
                        let activities = parseActivities(data: data!)
                        onSuccess(activities)
                    } else {
                        if let myError = onError{
                            myError(error!)
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    func execute(onSuccess: @escaping (Activities) -> Void) {
        execute(onSuccess: onSuccess, onError: nil)
    }
    
    
}
