//  SetExecutedOnceInteractorImpl.swift
//  MadridShops

import Foundation

class SetExecutedOnceInteractorImpl: SetExecutedOnceInteractor {
    func execute(item: String) {
    
        let defaults = UserDefaults.standard
        
        defaults.set("SAVED", forKey: item)
        
        // Primero que nada le damos a sincronizar y luego llenamos código arriba
        // Sería true o false, y deberíamos controlarlo
        defaults.synchronize()
        
        
        
    }
}
