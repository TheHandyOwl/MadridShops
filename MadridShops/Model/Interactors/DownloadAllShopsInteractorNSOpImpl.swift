//  DownloadAllShopsInteractorNSOpImpl.swift
//  MadridShops

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
                do {
                    let jsonObject = try JSONSerialization.jsonObject(with: data,                                                                   options: JSONSerialization.ReadingOptions.allowFragments) as! Dictionary<String, Any>
                    // result es la clave del json
                    let result = jsonObject["result"] as! [Dictionary<String, Any>]
                    
                    let shops = Shops()
                    
                    for shopJson in result {
                        let shop = Shop(name: shopJson["name"]! as! String)
                        shop.address = shopJson["address"]! as! String
                        
                        shops.add(shop: shop)
                        
                    }
                    
                    OperationQueue.main.addOperation {
                        onSuccess(shops)
                    }
                    
                } catch {
                    
                }
                
            }

        }
 
    }
    
}
