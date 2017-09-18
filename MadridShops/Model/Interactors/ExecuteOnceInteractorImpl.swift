//  ExecuteOnceInteractorImpl.swift
//  MadridShops

import Foundation

class ExecuteOnceInteractorImpl: ExecuteOnceInteractor {
    func execute(closure: () -> Void) {
        let defaults = UserDefaults.standard
        
        if let _ = defaults.string(forKey: "once") {
            //already saved
        } else { // first time
            closure()
        }
        
    }
    
}
