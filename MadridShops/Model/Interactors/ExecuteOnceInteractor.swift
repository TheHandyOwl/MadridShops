//  ExecuteOnceInteractor.swift
//  MadridShops

import Foundation

protocol ExecuteOnceInteractor {
    func execute(item: String, closure: () -> Void)
}


