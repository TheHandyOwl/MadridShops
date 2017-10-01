//  ExecuteOnceInteractorImpl.swift
//  MadridShops
//
//  Created by Carlos on 01/10/17.
//  Copyright © 2017 THO. All rights reserved.

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
