//  DownloadAllShopsInteractorFakeImplementation.swift
//  MadridShops

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
            // Que realmente está ejecutando el bloque que le mandé desde el VC
            /*
             downloadShopsInteractor.execute(onSuccess:
             
             { (shops: Shops) in
                 print(shops.get(index: 0).name)
             })
             */
            // Hemos pasado el bloque, que decibe el shops y entonces lo imprimimos
            
        }
    }
    
    
}
