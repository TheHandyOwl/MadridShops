//  DownloadAllActivitiesInteractor.swift
//  MadridShops
//
//  Created by Carlos on 01/10/17.
//  Copyright © 2017 THO. All rights reserved.

import Foundation

protocol DownloadAllActivitiesInteractor {
    
    // execute: downloads all activities. Return on the main thread
    func execute(onSuccess: @escaping (Activities) -> Void, onError: errorClosure)
    func execute(onSuccess: @escaping (Activities) -> Void)
    
}
