//
//  GetLanguageInteractorImpl.swift
//  MadridShops
//
//  Created by Carlos on 29/9/17.
//  Copyright © 2017 THO. All rights reserved.
//

import Foundation

class GetLanguageInteractorImpl: GetLanguageInteractor {
    func execute() -> String {
        let defaults = UserDefaults.standard
        if let language = defaults.string(forKey: "language")?.lowercased() {
            print("Get: \(language)")
            return language
        } else {
            let defaultLanguage = "en".lowercased()
            print("Get: \(defaultLanguage)")
            SetLanguageInteractorImpl().execute(language: defaultLanguage)
            return defaultLanguage
        }
    }
}
