//  ActivitiesVC+CollectionVC.swift
//  MadridShops

import UIKit

extension ActivitiesViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return fetchedResultsController.sections?.count ?? 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionInfo = fetchedResultsController.sections![section]
        return sectionInfo.numberOfObjects
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ActivityCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ActivityCell", for: indexPath) as! ActivityCell
        
        let activityCD: ActivityCD = fetchedResultsController.object(at: indexPath)
        cell.refresh(activity: mapActivityCDIntoActivity(activityCD: activityCD))
        
        return cell
    }
    
}
