//
//  ShopFetchedResultsController.swift
//  MadridShops
//
//  Created by Carlos on 28/9/17.
//  Copyright © 2017 THO. All rights reserved.
//

import Foundation
import CoreData

// MARK: - Fetched results controller

public var _shopFetchedResultsController: NSFetchedResultsController<ShopCD>? = nil

public func shopFetchedResultsController(context: NSManagedObjectContext) -> NSFetchedResultsController<ShopCD> {
    
    if _shopFetchedResultsController != nil {
        return _shopFetchedResultsController!
    }
    
    let fetchRequest: NSFetchRequest<ShopCD> = ShopCD.fetchRequest()
    
    fetchRequest.fetchBatchSize = 20
    fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
    
    _shopFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: "ShopsCacheFile")
    
    do {
        try _shopFetchedResultsController!.performFetch()
    } catch {
        let nserror = error as NSError
        fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
    }
    
    return _shopFetchedResultsController!
}
