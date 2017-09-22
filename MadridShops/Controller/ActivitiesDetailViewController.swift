//  ActivitiesDetailViewController.swift
//  MadridShops

import UIKit

class ActivitiesDetailViewController: UIViewController {
    
    var activity: Activity!

    @IBOutlet weak var activityDetailDescription: UITextView!
    @IBOutlet weak var activityImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = self.activity.name
        self.activityDetailDescription.text = self.activity.name
        //self.activityDetailDescription.text = self.activity.description
        //self.activity.image.loadImage(into: activityImage)

    }

}
