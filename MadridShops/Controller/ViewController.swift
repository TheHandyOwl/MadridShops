//  ViewController.swift
//  MadridShops
//
//  Created by Carlos on 01/10/17.
//  Copyright © 2017 THO. All rights reserved.

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.delegate = self
        self.locationManager.startUpdatingLocation()
        
        self.map.delegate = self
        
        self.shopsCollectionView.delegate = self
        self.shopsCollectionView.dataSource = self
        
        let madridLocation = CLLocation(latitude: 40.416775, longitude: -3.703790)
        //self.map.setCenter(madridLocation.coordinate, animated: true)
        let region = MKCoordinateRegion(center: madridLocation.coordinate, span: MKCoordinateSpanMake(0.01, 0.01))
        self.map.setRegion(region, animated: true)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowShopDetailSegue" {
            let vc = segue.destination as! ShopDetailViewController
            let shopCD: ShopCD = sender as! ShopCD
            //vc.shop = sender as! Shop
            vc.shop = mapShopCDIntoShop(shopCD: shopCD)
            
        }
    }
    
    
    // MARK: - CLLocationManager Delegate
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        self.map.setCenter(location.coordinate, animated: true)
    }
    
    
    // MARK: - MKMapViewDelegate Delegate
    // Tells the delegate that the map view is about to start rendering some of its tiles
    func mapViewWillStartRenderingMap(_ mapView: MKMapView) {
        //print("Start rendering")
    }
    
    func mapViewDidFinishRenderingMap(_ mapView: MKMapView, fullyRendered: Bool) {
        //print("Finish rendering")
        
        /*
         let km0 = MapPin(coordinate: CLLocationCoordinate2D(latitude: 40.416676, longitude: -3.703878))
         km0.title = "Punto kilométrico 0"
         km0.subtitle = "El centro de España"
         
         self.map.addAnnotation(km0)
         */
        
        if let shops = shopFetchedResultsController(context: context).fetchedObjects {
            for shop in shops {
                let shopLocation = CLLocation(latitude: Double(shop.latitude), longitude: Double(shop.longitude))
                //print("Latitude: \((activity.latitude)) - Longitude \((activity.longitude))")
                let shopPin = MapPin(coordinate: shopLocation.coordinate, title: shop.name!, subtitle: shop.address!)
                self.map.addAnnotation(shopPin)
            }
        }
        
    }
    
    // Tells the delegate that the specified map view is about to retrieve some map data
    func mapViewWillStartLoadingMap(_ mapView: MKMapView) {
        //print("Start loading")
    }
    
    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
        //print("Finish loading")
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
