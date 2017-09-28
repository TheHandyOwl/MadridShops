//
//  RemoveGenericOnceInteractorImpl.swift
//  MadridShops
//
//  Created by Carlos on 28/9/17.
//  Copyright © 2017 THO. All rights reserved.
//

import Foundation

class RemoveGenericOnceInteractorImpl: RemoveGenericOnceInteractor {
    func execute(item: String) {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: item)
    }
}
