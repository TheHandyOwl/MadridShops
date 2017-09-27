//
//  CheckAllFilesSavedInteractor.swift
//  MadridShops
//
//  Created by Carlos on 27/9/17.
//  Copyright © 2017 THO. All rights reserved.
//

import Foundation

protocol CheckAllFilesSavedInteractor {
    func execute(fileNames: [String]) -> Bool
}
