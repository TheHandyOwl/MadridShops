//  ViewController.swift
//  MadridShops

import UIKit
import CoreData
import CoreLocation
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    var context: NSManagedObjectContext!
    var shops: Shops?
    
    @IBOutlet weak var shopsCollectionView: UICollectionView!
    @IBOutlet weak var map: MKMapView!
    
    let locationManager = CLLocationManager()
    let fileToDownloadAndSaveOnce = "ShopsSavedOnce"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.delegate = self
        self.locationManager.startUpdatingLocation()
        
        self.map.delegate = self
        
        ExecuteOnceInteractorImpl().execute(item: self.fileToDownloadAndSaveOnce) {
            initializedData()
        }
        
        // Lo subimos aquí
        self.shopsCollectionView.delegate = self
        self.shopsCollectionView.dataSource = self
        
        // Centrar el mapa
        let madridLocation = CLLocation(latitude: 40.416646, longitude: -3.703818)
        //self.map.setCenter(madridLocation.coordinate, animated: true)
        let region = MKCoordinateRegion(center: madridLocation.coordinate, span: MKCoordinateSpanMake(0.1, 0.1))
        self.map.setRegion(region, animated: true)
        
    }
    
    func initializedData() {
        let downloadShopsInteractor: DownloadAllShopsInteractor = DownloadAllShopsInteractorNSURLSessionImpl()
        
        downloadShopsInteractor.execute { (shops: Shops) in
            print("Name: " + shops.get(index: 0).name)
            self.shops = shops
            
            // Guardamos el contexto
            let cacheInteractor = SaveAllShopsInteractorImpl()
            cacheInteractor.execute(shops: shops, context: self.context, onSuccess: { (shops: Shops) in
                SetExecutedOnceInteractorImpl().execute(item: self.fileToDownloadAndSaveOnce)
                
                self._fetchedResultsController = nil
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
            let vc = segue.destination as! ShopDetailViewController
            let shopCD: ShopCD = sender as! ShopCD
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
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        _fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.context!, sectionNameKeyPath: nil, cacheName: "ShopsCacheFile")
        //aFetchedResultsController.delegate = self
        //_fetchedResultsController = aFetchedResultsController
        
        do {
            try _fetchedResultsController!.performFetch()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        
        return _fetchedResultsController!
    }
    
    
    // MARK: - CLLocationManager Delegate
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        self.map.setCenter(location.coordinate, animated: true)
    }
    
    
    // MARK: - MKMapViewDelegate Delegate
    // Tells the delegate that the map view is about to start rendering some of its tiles
    func mapViewWillStartRenderingMap(_ mapView: MKMapView) {
        print("Start rendering")
    }
    
    func mapViewDidFinishRenderingMap(_ mapView: MKMapView, fullyRendered: Bool) {
        print("Finish rendering")
        
        let km0 = MapPin(coordinate: CLLocationCoordinate2D(latitude: 40.416676, longitude: -3.703878))
        km0.title = "Punto kilométrico 0"
        km0.subtitle = "El centro de España"
        
        self.map.addAnnotation(km0)
        
        if let shops = fetchedResultsController.fetchedObjects {
            for shop in shops {
                let shopLocation = CLLocation(latitude: Double(shop.latitude), longitude: Double(shop.longitude))
                print("La latitud es: \((shop.latitude)) y longitud \((shop.longitude))")
                let shopPin = MapPin(coordinate: shopLocation.coordinate, title: shop.name!, subtitle: shop.address!)
                print("shopPin: \(shopPin)")
                self.map.addAnnotation(shopPin)
            }
        }
        
    }
    
    // Tells the delegate that the specified map view is about to retrieve some map data
    func mapViewWillStartLoadingMap(_ mapView: MKMapView) {
        print("Start loading")
    }
    
    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
        print("Finish loading")
    }
    
    // Pin items
     func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
     // Don't want to show a custom image if the annotation is the user's location.
     guard !(annotation is MKUserLocation) else {
     return nil
     }
     
     // Better to make this class property
     let annotationIdentifier = "AnnotationIdentifier"
     
     var annotationView: MKAnnotationView?
     if let dequeuedAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier) {
     annotationView = dequeuedAnnotationView
     annotationView?.annotation = annotation
     }
     else {
     annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
     annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
     }
     
     if let annotationView = annotationView {
     // Configure your annotation view here
     annotationView.canShowCallout = true
     annotationView.image = UIImage(named: "PinImage")
     }
     
     return annotationView
     }
    
}
