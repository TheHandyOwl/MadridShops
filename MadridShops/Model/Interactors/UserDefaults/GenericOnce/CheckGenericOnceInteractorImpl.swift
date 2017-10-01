//  CheckGenericOnceInteractorImpl.swift
//  MadridShops
//
//  Created by Carlos on 01/10/17.
//  Copyright © 2017 THO. All rights reserved.

import Foundation

class CheckGenericOnceInteractorImpl: CheckGenericOnceInteractor {
    func execute(item: String) -> Bool {
        let defaults = UserDefaults.standard
        if let _ = defaults.string(forKey: item) {
            return true
        } else {
            return false
        }
    }    
}
