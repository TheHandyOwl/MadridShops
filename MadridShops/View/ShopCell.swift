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
        self.shop = shop
        
        self.label.text = shop.name
        self.shop?.logo.loadImage(into: imageView)
        // Probar con true y false
        // Tiene que ver con los límites
        imageView.clipsToBounds = true
        UIView.animate(withDuration: 1.0) {
            self.imageView.layer.cornerRadius = 30
        }
        
    }
    
}
