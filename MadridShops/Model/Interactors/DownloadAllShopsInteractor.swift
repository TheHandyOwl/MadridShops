//  DownloadAllShopsInteractor.swift
//  MadridShops

import Foundation

//typealias errorClosure = ((Error) -> Void)?

protocol DownloadAllShopsInteractor {
    // Esto bloquearía el hilo principal, mejor no usarla
    //func execute() -> Shops
    // Mejor no devolver nada porque el proceso es asíncrono
    //func execute(onSuccess: () -> Void, onError: () -> Void)
    //func execute(onSuccess: (Shops) -> Void, onError: ((Error) -> Void)?)
    //func execute(onSuccess: (Shops) -> Void, onError: errorClosure)
    func execute(onSuccess: @escaping (Shops) -> Void, onError: errorClosure)
    func execute(onSuccess: @escaping (Shops) -> Void)
    
}
