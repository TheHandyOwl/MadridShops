//  ActivitiesVC+CollectionVC.swift
//  MadridShops
//
//  Created by Carlos on 01/10/17.
//  Copyright © 2017 THO. All rights reserved.

import UIKit

extension ActivitiesViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return activityFetchedResultsController(context: context).sections?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionInfo = activityFetchedResultsController(context: context).sections![section]
        return sectionInfo.numberOfObjects
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ActivityCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ActivityCell", for: indexPath) as! ActivityCell
        
        let activityCD: ActivityCD = activityFetchedResultsController(context: context).object(at: indexPath)
        cell.refresh(activity: mapActivityCDIntoActivity(activityCD: activityCD))
        cell.backgroundColor = #colorLiteral(red: 0.7529411765, green: 0.8745098039, blue: 0.9882352941, alpha: 1)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let activity : ActivityCD = activityFetchedResultsController(context: context).object(at: indexPath)
        self.performSegue(withIdentifier: "ShowActivityDetailSegue", sender: activity)
        
    }
    
}
