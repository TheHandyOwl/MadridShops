//  String+Image.swift
//  MadridShops
//
//  Created by Carlos on 01/10/17.
//  Copyright © 2017 THO. All rights reserved.

import UIKit
import SDWebImage

extension String {
    func loadImage(into imageView: UIImageView) {
        let queue = OperationQueue()
        
        // The new one using cache and SDWebImage
        queue.addOperation {
            if let url = URL(string: self){
                OperationQueue.main.addOperation {
                    imageView.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "image-not-available"), options: [.continueInBackground, .refreshCached, .highPriority, .retryFailed], completed: nil)
                }
            }
        }
        
        // The old one without cache
        /*
         queue.addOperation {
         if let url = URL(string: self),
         let data = NSData(contentsOf: url),
         let image = UIImage(data: data as Data) {
         
         OperationQueue.main.addOperation {
         imageView.image = image
         }
         
         }
         }
         */
    }
    func downloadImage() -> Data? {
        if let encodedUrl = self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            if let url = URL(string: encodedUrl) {
                if let data = NSData(contentsOf: url) {
                    return data as Data
                } else {
                    print("There was a problem downloading the image url \(self) encoded as \(encodedUrl)")
                }
            }
            else {
                print("There was a problem parsing the image url \(self) encoded as \(encodedUrl)")
            }
        } else {
            print("There was a problem encoding the image url \(self)")
        }
        
        return nil
    }
}
