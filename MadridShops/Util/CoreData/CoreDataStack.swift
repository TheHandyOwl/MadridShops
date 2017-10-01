//  CoreDataStack.swift
//  CoreDataHelloWorld
//
//  Created by Carlos on 01/10/17.
//  Copyright © 2017 THO. All rights reserved.

import CoreData

public class CoreDataStack {
    
    // MARK: - Core Data stack
    
    /*
 lazy var persistentContainer: NSPersistentContainer = {
 let container = NSPersistentContainer(name: "CoreDataHelloWorld")
 container.loadPersistentStores(completionHandler: { (storeDescription, error) in
 print(" 💾 \( storeDescription.description)")
 if let error = error as NSError? {
 fatalError("Unresolved error \(error), \(error.userInfo)")
 }
 })
 return container
 }()
 */
    
    public func createContainer(dbName: String) -> NSPersistentContainer {
        let container = NSPersistentContainer(name: dbName)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            print(" 💾 \( storeDescription.description)")
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }
    
    // MARK: - Core Data Saving support

    /*
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
     */
    public func saveContext (context: NSManagedObjectContext) {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}
