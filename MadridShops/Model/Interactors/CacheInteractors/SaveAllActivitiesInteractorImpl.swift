//  SaveAllActivitiesInteractorImpl.swift
//  MadridShops
//
//  Created by Carlos on 01/10/17.
//  Copyright © 2017 THO. All rights reserved.

import CoreData

class SaveAllActivitiesInteractorImpl: SaveAllActivitiesInteractor {
    func execute(activities: Activities, context: NSManagedObjectContext, onSuccess: (Activities) -> Void, onError: errorClosure) {
        
        for i in 0..<activities.count() {
            let activity = activities.get(index: i)
            let _ = mapActivityIntoActivityCD(context: context, activity: activity)
        }
        
        do {
            try context.save()
            onSuccess(activities)
        } catch {
            // onError(nil)
        }
    }
    
    func execute(activities: Activities, context: NSManagedObjectContext, onSuccess: (Activities) -> Void) {
        execute(activities: activities, context: context, onSuccess: onSuccess, onError: nil)
    }

}
