//  ViewController.swift
//  MadridShops

import UIKit
import CoreData
import CoreLocation
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var context: NSManagedObjectContext!
    // Lo ponemos opcional porque se queja
    var shops: Shops?

    @IBOutlet weak var shopsCollectionView: UICollectionView!
    @IBOutlet weak var map: MKMapView!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.delegate = self
        self.locationManager.startUpdatingLocation()

        ExecuteOnceInteractorImpl().execute {
            initializedData()

        }

        // Lo subimos aquí
        self.shopsCollectionView.delegate = self
        self.shopsCollectionView.dataSource = self
        
        // Centrar el mapa
        let madridLocation = CLLocation(latitude: 40.416775, longitude: -3.703790)
        self.map.setCenter(madridLocation.coordinate, animated: true)

    }
    
    func initializedData() {
        // Este es el comodín que cambiaremos cuando lo hagamos de verdad
        //let downloadShopsInteractor : DownloadAllShopsInteractor = DownloadAllShopsInteractorFakeImplementation()
        //let downloadShopsInteractor: DownloadAllShopsInteractor = DownloadAllShopsInteractorNSOpImpl()
        let downloadShopsInteractor: DownloadAllShopsInteractor = DownloadAllShopsInteractorNSURLSessionImpl()
        /*
         downloadShopsInteractor.execute(onSuccess: { (shops: Shops) in
         // todo OK
         }) { (error: Error) in
         // error
         }
         
         downloadShopsInteractor.execute(onSuccess: { (shops: Shops) in
         // todo OK
         })
         */
        
        downloadShopsInteractor.execute { (shops: Shops) in
            // todo OK
            print("Name: " + shops.get(index: 0).name)
            self.shops = shops
            
            // Esto se activa aquí para tener alguna tienda
            // Si lo vinculamos antes no tendremos tiendas y no se mostrará nada
            // Con Core Data hemos descargado la info pero no la hemos guardado. Debería ir en el execute?
            //self.shopsCollectionView.delegate = self
            //self.shopsCollectionView.dataSource = self
            
            // Guardamos el contexto
            let cacheInteractor = SaveAllShopsInteractorImpl()
            cacheInteractor.execute(shops: shops, context: self.context, onSuccess: { (shops: Shops) in
                SetExecutedOnceInteractorImpl().execute()
                
                // Bajamos aquí y mostramos aquí
                // Pero finalmente lo subimos arriba y también lo dejamos aquí
                self._fetchedResultsController = nil // Para corregir que está a 0 al arrancar la app
                self.shopsCollectionView.delegate = self
                self.shopsCollectionView.dataSource = self
                self.shopsCollectionView.reloadData()
                
            })
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //let shop = self.shops?.get(index: indexPath.row)
        let shop : ShopCD = self.fetchedResultsController.object(at: indexPath)
        self.performSegue(withIdentifier: "ShowShopDetailSegue", sender: shop)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowShopDetailSegue" {
            let vc = segue.destination as! ShopDetailViewController // Es un IUVC
            // HAcemos casting minuto 90 aprox
            
            // let indexPath = self.shopsCollectionView.indexPathsForSelectedItems![0]
            // let shop = self.shops?.get(index: indexPath.row)
            //vc.shop = shop
            let shopCD: ShopCD = sender as! ShopCD // No sabe de qué tipo es el sender, se lo decimos
            //vc.shop = sender as! Shop
            vc.shop = mapShopCDIntoShop(shopCD: shopCD)
            
        }
    }
    
    // MARK: - Fetched results controller
    
    //var _fetchedResultsController: NSFetchedResultsController<Event>? = nil
    var _fetchedResultsController: NSFetchedResultsController<ShopCD>? = nil
    
    var fetchedResultsController: NSFetchedResultsController<ShopCD> {
        
        if _fetchedResultsController != nil {
            return _fetchedResultsController!
        }
        
        //let fetchRequest: NSFetchRequest<Event> = Event.fetchRequest()
        let fetchRequest: NSFetchRequest<ShopCD> = ShopCD.fetchRequest()

        // Set the batch size to a suitable number.
        fetchRequest.fetchBatchSize = 20
        //fetchRequest.sortDescriptors = [NSSortDescriptor(key: "timestamp", ascending: false)]
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        // Edit the section name key path and cache name if appropriate.
        // nil for section name key path means "no sections".
        // fetchRequest == SELECT * FROM EVENT ORDER BY TIMESTAMP DESC <<<---
        //let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.managedObjectContext!, sectionNameKeyPath: nil, cacheName: "Master")
        //let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.managedObjectContext!, sectionNameKeyPath: nil, cacheName: "ShopsCacheFile")
        _fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.context!, sectionNameKeyPath: nil, cacheName: "ShopsCacheFile")
        //aFetchedResultsController.delegate = self
        //_fetchedResultsController = aFetchedResultsController
        
        do {
            // Aquí se hace la primera consulta
            try _fetchedResultsController!.performFetch()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        
        return _fetchedResultsController!
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Centramos el mapa al movernos
        let location = locations[0]
        self.map.setCenter(location.coordinate, animated: true)
    }
    
}
