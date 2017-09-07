//
//  Shops.swift
//  MadridShops
//
//  Created by Carlos on 7/9/17.
//  Copyright © 2017 THO. All rights reserved.
//

import Foundation

public protocol ShopsProtocol {
    func count() -> Int
    func add(shop: Shop)
    func get(index: Int) -> Shop
}

public class Shops: ShopsProtocol {
    
    private var shopList: [Shop]?
    
    public init(){
        self.shopList = []
    }
    
    public func count() -> Int {
        return (shopList?.count)!
    }
    
    public func add(shop: Shop) {
        shopList?.append(shop)
    }
    
    public func get(index: Int) -> Shop {
        return (shopList?[index])!
    }
    
}
