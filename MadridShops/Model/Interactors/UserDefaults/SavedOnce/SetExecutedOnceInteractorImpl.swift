//  SetExecutedOnceInteractorImpl.swift
//  MadridShops

import Foundation

class SetExecutedOnceInteractorImpl: SetExecutedOnceInteractor {
    func execute(item: String) {
        let defaults = UserDefaults.standard
        defaults.set("SAVED", forKey: item)
        defaults.synchronize()
    }
}
