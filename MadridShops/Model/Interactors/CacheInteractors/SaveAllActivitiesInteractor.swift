//  SaveAllActivitiesInteractor.swift
//  MadridShops
//
//  Created by Carlos on 01/10/17.
//  Copyright © 2017 THO. All rights reserved.

import CoreData

protocol SaveAllActivitiesInteractor {
    func execute(activities: Activities, context: NSManagedObjectContext, onSuccess: (Activities) -> Void, onError: errorClosure)
    func execute(activities: Activities, context: NSManagedObjectContext, onSuccess: (Activities) -> Void)
}
