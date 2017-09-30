//  Activity.swift
//  MadridShops

import Foundation

public class Activity {
    // Add more things to improve the note
    var name: String
    var latitude: Float? = nil
    var longitude: Float? = nil
    var image: String = ""
    var logo: String = ""
    var address: String = ""
    
    var description_cl: String = ""
    var description_cn: String = ""
    var description_en: String = ""
    var description_es: String = ""
    var description_jp: String = ""
    var description_mx: String = ""
    
    var opening_hours_cl: String = ""
    var opening_hours_cn: String = ""
    var opening_hours_en: String = ""
    var opening_hours_es: String = ""
    var opening_hours_jp: String = ""
    var opening_hours_mx: String = ""
    
    public init (name: String){
        self.name = name
    }
    
}
