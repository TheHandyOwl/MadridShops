//  ActivitiesViewController.swift
//  MadridShops

import UIKit
import CoreData
import CoreLocation
import MapKit

class ActivitiesViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    var context: NSManagedObjectContext!
    var activities: Activities?
    
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var activitiesCollectionView: UICollectionView!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.delegate = self
        self.locationManager.startUpdatingLocation()
        
        self.map.delegate = self
        
        self.activitiesCollectionView.delegate = self
        self.activitiesCollectionView.dataSource = self
        
        let madridLocation = CLLocation(latitude: 40.416646, longitude: -3.703818)
        //self.map.setCenter(madridLocation.coordinate, animated: true)
        let region = MKCoordinateRegion(center: madridLocation.coordinate, span: MKCoordinateSpanMake(0.1, 0.1))
        self.map.setRegion(region, animated: true)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowActivityDetailSegue" {
            let vc = segue.destination as! ActivitiesDetailViewController
            let activityCD: ActivityCD = sender as! ActivityCD
            //vc.activity = sender as! Activity
            vc.activity = mapActivityCDIntoActivity(activityCD: activityCD)
            
        }
    }
    
    // MARK: - Fetched results controller
    
    var _fetchedResultsController: NSFetchedResultsController<ActivityCD>? = nil
    
    var fetchedResultsController: NSFetchedResultsController<ActivityCD> {
        
        if _fetchedResultsController != nil {
            return _fetchedResultsController!
        }
        
        let fetchRequest: NSFetchRequest<ActivityCD> = ActivityCD.fetchRequest()
        
        fetchRequest.fetchBatchSize = 20
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        _fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.context!, sectionNameKeyPath: nil, cacheName: "ActivitiesCacheFile")
        
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
        
        if let activities = fetchedResultsController.fetchedObjects {
            for activity in activities {
                let activityLocation = CLLocation(latitude: Double(activity.latitude), longitude: Double(activity.longitude))
                print("La latitud es: \((activity.latitude)) y longitud \((activity.longitude))")
                let activityPin = MapPin(coordinate: activityLocation.coordinate, title: activity.name!, subtitle: activity.address!)
                print("activityPin: \(activityPin)")
                self.map.addAnnotation(activityPin)
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

