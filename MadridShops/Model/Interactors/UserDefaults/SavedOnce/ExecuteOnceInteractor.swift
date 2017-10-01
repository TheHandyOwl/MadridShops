//  ExecuteOnceInteractor.swift
//  MadridShops
//
//  Created by Carlos on 01/10/17.
//  Copyright © 2017 THO. All rights reserved.

import Foundation

protocol ExecuteOnceInteractor {
    func execute(item: String, closure: () -> Void)
}
