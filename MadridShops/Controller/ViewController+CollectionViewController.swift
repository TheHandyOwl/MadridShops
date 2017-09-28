//  ViewController+CollectionViewController.swift
//  MadridShops

import UIKit

extension ViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return shopFetchedResultsController(context: context).sections?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionInfo = shopFetchedResultsController(context: context).sections![section]
        return sectionInfo.numberOfObjects
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ShopCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShopCell", for: indexPath) as! ShopCell
        
        let shopCD: ShopCD = shopFetchedResultsController(context: context).object(at: indexPath)
        cell.refresh(shop: mapShopCDIntoShop(shopCD: shopCD))
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let shop : ShopCD = shopFetchedResultsController(context: context).object(at: indexPath)
        self.performSegue(withIdentifier: "ShowShopDetailSegue", sender: shop)
    }
    
}
