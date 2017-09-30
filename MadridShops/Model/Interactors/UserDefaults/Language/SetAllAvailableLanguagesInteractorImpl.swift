//
//  SetAllAvailableLanguagesInteractorImpl.swift
//  MadridShops
//
//  Created by Carlos on 30/9/17.
//  Copyright © 2017 THO. All rights reserved.
//

import Foundation

class SetAllAvailableLanguagesInteractorImpl: SetAllAvailableLanguagesInteractor {
    func execute(languageArray: [String]){
        let defaults = UserDefaults.standard
        defaults.set(languageArray.map { $0.lowercased() }, forKey: "languageArray")
        defaults.synchronize()
    }
}
