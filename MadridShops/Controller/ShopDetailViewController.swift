//  ShopDetailViewController.swift
//  MadridShops
//
//  Created by Carlos on 01/10/17.
//  Copyright © 2017 THO. All rights reserved.

import UIKit

class ShopDetailViewController: UIViewController {
    
    var shop: Shop!
    var myLanguage : String!
    
    @IBOutlet weak var shopDetailDescription: UITextView!    
    @IBOutlet weak var shopOpeningHours: UITextView!
    @IBOutlet weak var shopImage: UIImageView!
    
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Translated items
        let myLanguage = GetLanguageInteractorImpl().execute()
        var descriptionTranslated = ""
        var openingHoursTranslated = ""
        switch myLanguage {
        case "cl":
            descriptionTranslated = self.shop.description_cl
            openingHoursTranslated = self.shop.opening_hours_cl
        case "cn":
            descriptionTranslated = self.shop.description_cn
            openingHoursTranslated = self.shop.opening_hours_cn
        case "en":
            descriptionTranslated = self.shop.description_en
            openingHoursTranslated = self.shop.opening_hours_en
        case "es":
            descriptionTranslated = self.shop.description_es
            openingHoursTranslated = self.shop.opening_hours_es
        case "jp":
            descriptionTranslated = self.shop.description_jp
            openingHoursTranslated = self.shop.opening_hours_jp
        case "mx":
            descriptionTranslated = self.shop.description_mx
            openingHoursTranslated = self.shop.opening_hours_mx
        default:
            descriptionTranslated = self.shop.description_en
            openingHoursTranslated = self.shop.opening_hours_en
        }
        
        self.title = self.shop.name
        self.shopDetailDescription.text = """
        ℹ️
        \(descriptionTranslated)
        """
        self.shopOpeningHours.text = """
        🕑
        \(openingHoursTranslated)
        """
        self.shop.image.loadImage(into: shopImage)
    }
    
    
    // MARK: - Setting Up Interface
    func setupUI(){
        shopDetailDescription.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        shopDetailDescription.layer.borderWidth = 2
        shopDetailDescription.layer.cornerRadius = 5
        shopDetailDescription.isEditable = false
        
        shopOpeningHours.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        shopOpeningHours.layer.borderWidth = 2
        shopOpeningHours.layer.cornerRadius = 5
        shopOpeningHours.isEditable = false
    }
    
}
