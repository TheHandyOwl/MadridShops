//  Activity.swift
//  MadridShops

import Foundation

public class Activity {
    // Add more things to improve the note
    var name: String
    var description: String = ""
    var latitude: Float? = nil
    var longitude: Float? = nil
    var image: String = ""
    var logo: String = ""
    var openingHours: String = ""
    var address: String = ""
    
    public init (name: String){
        self.name = name
    }
    
}
