//  SaveAndExecuteOnceInteractorImpl.swift
//  MadridShops
//
//  Created by Carlos on 01/10/17.
//  Copyright © 2017 THO. All rights reserved.

import Foundation

class SaveAndExecuteOnceInteractorImpl: SaveAndExecuteOnceInteractor {
    func execute(item: String, closure: () -> Void) {
        let defaults = UserDefaults.standard
        defaults.set("SAVED", forKey: item)
        defaults.synchronize()
        closure()
    }
}
