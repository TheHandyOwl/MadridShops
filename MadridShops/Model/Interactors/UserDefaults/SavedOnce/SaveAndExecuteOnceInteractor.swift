//  SaveAndExecuteOnceInteractor.swift
//  MadridShops

import Foundation

protocol SaveAndExecuteOnceInteractor {
    func execute(item: String, closure: () -> Void)
}
