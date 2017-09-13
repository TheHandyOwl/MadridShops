//  ShopDetailViewController.swift
//  MadridShops

import UIKit

class ShopDetailViewController: UIViewController {

    var shop: Shop!
    
    @IBOutlet weak var shopDetailDescription: UITextView!
    @IBOutlet weak var shopImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = self.shop.name
        self.shopDetailDescription.text = self.shop.description
        self.shop.image.loadImage(into: shopImage)
    }

}
