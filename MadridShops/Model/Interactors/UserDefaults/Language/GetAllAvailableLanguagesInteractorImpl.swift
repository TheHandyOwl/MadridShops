//  GetAllAvailableLanguagesInteractorImpl.swift
//  MadridShops
//
//  Created by Carlos on 01/10/17.
//  Copyright © 2017 THO. All rights reserved.


import Foundation

class GetAllAvailableLanguagesInteractorImpl: GetAllAvailableLanguagesInteractor {
    func execute() -> [String] {
        let defaults = UserDefaults.standard
        if let language : [String] = defaults.stringArray(forKey: "languageArray") {
            return language.map { $0.lowercased() }
        } else {
            let defaultLanguage : [String] = ["en".lowercased()]
            SetAllAvailableLanguagesInteractorImpl().execute(languageArray: defaultLanguage)
            return defaultLanguage
        }
    }
}
