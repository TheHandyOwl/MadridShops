//  ViewController+CollectionViewController.swift
//  MadridShops

import UIKit

extension ViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Como es opcional podemos ir a las bravas
        // return (self.shops?.count())!
        // O nos decantamos por hacer el unwrap
        if let shops = self.shops {
            return shops.count()
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //var cell: ShopCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShopCell", for: indexPath)
        let cell: ShopCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShopCell", for: indexPath) as! ShopCell
        
        // Buscamos la shop
        let shop: Shop = (self.shops?.get(index: indexPath.row))!
        
        // Y se la cascamos a la celda
        cell.refresh(shop: shop)
        
        return cell
    }
    
    
}
