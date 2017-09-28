//  DownloadAllActivitiesInteractor.swift
//  MadridShops

import Foundation

protocol DownloadAllActivitiesInteractor {
    
    // execute: downloads all activities. Return on the main thread
    func execute(onSuccess: @escaping (Activities) -> Void, onError: errorClosure)
    func execute(onSuccess: @escaping (Activities) -> Void)
    
}
