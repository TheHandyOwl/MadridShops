//  CheckAllFilesSavedInteractorImpl.swift
//  MadridShops
//
//  Created by Carlos on 01/10/17.
//  Copyright © 2017 THO. All rights reserved.

import Foundation

class CheckAllFilesSavedInteractorImpl: CheckAllFilesSavedInteractor {
    func execute(fileNames: [String]) -> Bool {
        let defaults = UserDefaults.standard
        var totalFiles = 0
        
        for file in fileNames {
            if let _ = defaults.string(forKey: file) {
                // Already saved
                totalFiles += 1
            } else {
                // Not yet saved
                return false
            }
        }
        
        if fileNames.count == totalFiles {
            return true
        } else {
            return false
        }
    }
}
