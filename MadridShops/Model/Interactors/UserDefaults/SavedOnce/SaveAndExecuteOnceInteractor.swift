//  SaveAndExecuteOnceInteractor.swift
//  MadridShops
//
//  Created by Carlos on 01/10/17.
//  Copyright © 2017 THO. All rights reserved.

import Foundation

protocol SaveAndExecuteOnceInteractor {
    func execute(item: String, closure: () -> Void)
}
