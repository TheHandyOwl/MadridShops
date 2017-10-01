//  GetLanguageInteractorImpl.swift
//  MadridShops
//
//  Created by Carlos on 01/10/17.
//  Copyright © 2017 THO. All rights reserved.

import Foundation

class GetLanguageInteractorImpl: GetLanguageInteractor {
    func execute() -> String {
        let defaults = UserDefaults.standard
        if let language = defaults.string(forKey: "language")?.lowercased() {
            return language
        } else {
            let defaultLanguage = "en".lowercased()
            SetLanguageInteractorImpl().execute(language: defaultLanguage)
            return defaultLanguage
        }
    }
}
