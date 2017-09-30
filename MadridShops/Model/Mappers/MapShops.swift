//  MapShops.swift
//  MadridShops

import Foundation
import CoreData

func mapShopCDIntoShop(shopCD: ShopCD) -> Shop {
    let shop = Shop(name: shopCD.name!)
    
    shop.address = shopCD.address ?? ""
    shop.image = shopCD.image ?? ""
    shop.logo = shopCD.logo ?? ""
    
    shop.latitude = shopCD.latitude
    shop.longitude = shopCD.longitude
    
    shop.description_cl = shopCD.description_cl ?? ""
    shop.description_cn = shopCD.description_cn ?? ""
    shop.description_en = shopCD.description_en ?? ""
    shop.description_es = shopCD.description_es ?? ""
    shop.description_jp = shopCD.description_jp ?? ""
    shop.description_mx = shopCD.description_mx ?? ""
    
    shop.opening_hours_cl = shopCD.opening_hours_cl ?? ""
    shop.opening_hours_cn = shopCD.opening_hours_cn ?? ""
    shop.opening_hours_en = shopCD.opening_hours_en ?? ""
    shop.opening_hours_es = shopCD.opening_hours_es ?? ""
    shop.opening_hours_jp = shopCD.opening_hours_jp ?? ""
    shop.opening_hours_mx = shopCD.opening_hours_mx ?? ""
    
    return shop
}

func mapShopIntoShopCD(context: NSManagedObjectContext , shop: Shop) -> ShopCD {
    // mapping shop into ShopCD
    let shopCD = ShopCD(context: context)
    
    shopCD.name = shop.name
    shopCD.address = shop.address
    shopCD.image = shop.image
    shopCD.logo = shop.logo
    shopCD.latitude = shop.latitude ?? 0.0
    shopCD.longitude = shop.longitude ?? 0.0
    
    shopCD.description_cl = shop.description_cl
    shopCD.description_cn = shop.description_cn
    shopCD.description_en = shop.description_en
    shopCD.description_es = shop.description_es
    shopCD.description_jp = shop.description_jp
    shopCD.description_mx = shop.description_mx
    
    shopCD.opening_hours_cl = shop.opening_hours_cl
    shopCD.opening_hours_cn = shop.opening_hours_cn
    shopCD.opening_hours_en = shop.opening_hours_en
    shopCD.opening_hours_es = shop.opening_hours_es
    shopCD.opening_hours_jp = shop.opening_hours_jp
    shopCD.opening_hours_mx = shop.opening_hours_mx

    return shopCD
}
