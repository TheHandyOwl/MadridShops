//  MapPin.swift
//  MadridShops

import Foundation
import MapKit

class MapPin: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }
    
    convenience init(coordinate: CLLocationCoordinate2D) {
        self.init(coordinate: coordinate, title: "", subtitle: "")
    }
}
