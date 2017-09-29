//
//  SetLanguageInteractorImpl.swift
//  MadridShops
//
//  Created by Carlos on 29/9/17.
//  Copyright © 2017 THO. All rights reserved.
//

import Foundation

class SetLanguageInteractorImpl: SetLanguageInteractor {
    func execute(language: String){
        let defaults = UserDefaults.standard
        defaults.set(language.lowercased(), forKey: "language")
        defaults.synchronize()
        print("Get: \(language)")
    }
}
