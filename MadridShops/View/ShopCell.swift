//  ShopCell.swift
//  MadridShops

import UIKit

class ShopCell: UICollectionViewCell {
    
    var shop: Shop?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    func refresh(shop: Shop) {
        self.shop = shop
        
        self.label.text = shop.name
        // TODO: imageView        
        
    }
    
}
