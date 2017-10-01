//  ActivitiesDetailViewController.swift
//  MadridShops
//
//  Created by Carlos on 01/10/17.
//  Copyright © 2017 THO. All rights reserved.

import UIKit

class ActivitiesDetailViewController: UIViewController {
    
    var activity: Activity!
    var myLanguage : String!
    
    @IBOutlet weak var activityDetailDescription: UITextView!
    @IBOutlet weak var activityOpeningHours: UITextView!
    @IBOutlet weak var activityImage: UIImageView!
    
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        // Translated items
        self.myLanguage = GetLanguageInteractorImpl().execute()
        var descriptionTranslated = ""
        var openingHoursTranslated = ""
        switch myLanguage {
        case "cl":
            descriptionTranslated = self.activity.description_cl
            openingHoursTranslated = self.activity.opening_hours_cl
        case "cn":
            descriptionTranslated = self.activity.description_cn
            openingHoursTranslated = self.activity.opening_hours_cn
        case "en":
            descriptionTranslated = self.activity.description_en
            openingHoursTranslated = self.activity.opening_hours_en
        case "es":
            descriptionTranslated = self.activity.description_es
            openingHoursTranslated = self.activity.opening_hours_es
        case "jp":
            descriptionTranslated = self.activity.description_jp
            openingHoursTranslated = self.activity.opening_hours_jp
        case "mx":
            descriptionTranslated = self.activity.description_mx
            openingHoursTranslated = self.activity.opening_hours_mx
        default:
            descriptionTranslated = self.activity.description_en
            openingHoursTranslated = self.activity.opening_hours_en
        }
        
        // Absolute items
        self.title = self.activity.name
        self.activityDetailDescription.text = """
        ℹ️
        \(descriptionTranslated)
        """
        self.activityOpeningHours.text = """
        🕑
        \(openingHoursTranslated)
        """
        self.activity.image.loadImage(into: activityImage)
        
    }
    
    
    // MARK: - Setting Up Interface
    func setupUI(){
        activityDetailDescription.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        activityDetailDescription.layer.borderWidth = 2
        activityDetailDescription.layer.cornerRadius = 5
        
        activityOpeningHours.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        activityOpeningHours.layer.borderWidth = 2
        activityOpeningHours.layer.cornerRadius = 5
    }
    
}
