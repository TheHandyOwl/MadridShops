//  String+Image.swift
//  MadridShops

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
}
