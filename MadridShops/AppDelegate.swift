//  AppDelegate.swift
//  MadridShops
//
//  Created by Carlos on 01/10/17.
//  Copyright © 2017 THO. All rights reserved.

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var cds = CoreDataStack()
    var context: NSManagedObjectContext?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        self.context = cds.createContainer(dbName: "MadridShops").viewContext
        
        // Para pasar el contexto
        let nav = self.window?.rootViewController as! UINavigationController
        let mainVC = nav.topViewController as! MainViewController
        //mainVC no tiene context
        //Lo tenemos que traer aquí
        mainVC.context = self.context
        
        /*
         //ERROR: siempre creamos objetos en el contexto
         //let shop = ShopCD()
         let shop = ShopCD(context: self.context!)
         shop.name = "Test"
         self.cds.saveContext(context: self.context!)
         */
        
        
        return true
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        guard let context = self.context else {return}
        self.cds.saveContext(context: context)
    }
    
}

