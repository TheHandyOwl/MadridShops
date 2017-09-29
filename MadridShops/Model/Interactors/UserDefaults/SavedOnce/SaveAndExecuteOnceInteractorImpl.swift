//  SaveAndExecuteOnceInteractorImpl.swift
//  MadridShops

import Foundation

class SaveAndExecuteOnceInteractorImpl: SaveAndExecuteOnceInteractor {
    func execute(item: String, closure: () -> Void) {
        let defaults = UserDefaults.standard
        defaults.set("SAVED", forKey: item)
        defaults.synchronize()
        closure()
    }
}
