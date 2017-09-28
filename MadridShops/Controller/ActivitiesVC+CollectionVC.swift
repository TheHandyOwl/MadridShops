//  ActivitiesVC+CollectionVC.swift
//  MadridShops

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
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let activity : ActivityCD = activityFetchedResultsController(context: context).object(at: indexPath)
        self.performSegue(withIdentifier: "ShowActivityDetailSegue", sender: activity)
        
    }
    
}
