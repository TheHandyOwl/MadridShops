//  SetExecutedOnceInteractorImpl.swift
//  MadridShops

import Foundation

class SetExecutedOnceInteractorImpl: SetExecutedOnceInteractor {
    func execute() {
        let defaults = UserDefaults.standard
        
        defaults.set("SAVED", forKey: "once")
        
        // Primero que nada le damos a sincronizar y luego llenamos código arriba
        // Sería true o false, y deberíamos controlarlo
        defaults.synchronize()
        
        
        
    }
}
