//  SaveAllShopsInteractorImpl.swift
//  MadridShops

import CoreData

class SaveAllShopsInteractorImpl: SaveAllShopsInteractor {
    func execute(shops: Shops, context: NSManagedObjectContext, onSuccess: @escaping (Shops) -> Void, onError: errorClosure) {
        
        // Este no conforma el protocolo Sequence
        /*
        for shop in shops {
        }
         */
        
        for i in 0..<shops.count() {
            let shop = shops.get(index: i)
            
            // mapping shop into ShopCD
            let shopCD = ShopCD(context: context)
            shopCD.name = shop.name
            shopCD.address = shop.address
            shopCD.image = shop.image
            shopCD.logo = shop.logo
            //shopCD.latitude = shop.latitude!
            //shopCD.longitude = shop.longitude!
            shopCD.description_en = shop.description
            shopCD.openingHours = shop.openingHours
        }
        
        do {
            try context.save()
            onSuccess(shops)
        } catch {
            //onError(nil)
        }
        
    }
    
    func execute(shops: Shops, context: NSManagedObjectContext, onSuccess: @escaping (Shops) -> Void) {
        execute(shops: shops, context: context, onSuccess: onSuccess, onError: nil)
    }
    
    
}
