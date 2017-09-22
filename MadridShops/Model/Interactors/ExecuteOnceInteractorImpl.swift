//  ExecuteOnceInteractorImpl.swift
//  MadridShops

import Foundation

class ExecuteOnceInteractorImpl: ExecuteOnceInteractor {
    func execute(item: String, closure: () -> Void) {
        let defaults = UserDefaults.standard
        
        if let _ = defaults.string(forKey: item) {
            //already saved
        } else { // first time
            closure()
        }
        
    }
    
}
