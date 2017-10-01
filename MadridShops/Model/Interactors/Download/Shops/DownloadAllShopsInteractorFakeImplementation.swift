//  DownloadAllShopsInteractorFakeImplementation.swift
//  MadridShops
//
//  Created by Carlos on 01/10/17.
//  Copyright © 2017 THO. All rights reserved.

import Foundation

class DownloadAllShopsInteractorFakeImplementation: DownloadAllShopsInteractor {
    func execute(onSuccess: @escaping (Shops) -> Void) {
        execute(onSuccess: onSuccess, onError: nil)
    }
    
    func execute(onSuccess: @escaping (Shops) -> Void, onError: errorClosure = nil) {
        // We do not download anything. We fake it
        let shops = Shops()
        
        for i in 0...10 {
            let shop = Shop(name:"Shop number \( i )")
            shop.address = "Address \( 1 )"
            shops.add(shop: shop)
        }
        
        OperationQueue.main.addOperation {
            onSuccess(shops)
        }
    }
}
