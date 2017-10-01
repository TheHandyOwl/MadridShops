//  ActivityCell.swift
//  MadridShops
//
//  Created by Carlos on 01/10/17.
//  Copyright © 2017 THO. All rights reserved.

import UIKit

class ActivityCell: UICollectionViewCell {
    
    var activity: Activity?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    func refresh(activity: Activity) {
        self.activity = activity
        
        self.label.text = activity.name
        self.activity?.logo.loadImage(into: imageView)
        imageView.clipsToBounds = true
        UIView.animate(withDuration: 1.0) {
            self.imageView.layer.cornerRadius = 20
        }
        
    }
    
}
