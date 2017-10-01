//  DownloadAllShopsInteractor.swift
//  MadridShops
//
//  Created by Carlos on 01/10/17.
//  Copyright © 2017 THO. All rights reserved.

import Foundation

protocol DownloadAllShopsInteractor {
    func execute(onSuccess: @escaping (Shops) -> Void, onError: errorClosure)
    func execute(onSuccess: @escaping (Shops) -> Void)
}
