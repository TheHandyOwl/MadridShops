//  DownloadAllActivitiesFakeInteractorImplementation.swift
//  MadridShops
//
//  Created by Carlos on 01/10/17.
//  Copyright © 2017 THO. All rights reserved.

import Foundation

class DownloadAllActivitiesInteractorFakeImplementation: DownloadAllActivitiesInteractor {
    func execute(onSuccess: @escaping (Activities) -> Void) {
        execute(onSuccess: onSuccess, onError: nil)
    }
    
    func execute(onSuccess: @escaping (Activities) -> Void, onError: errorClosure = nil) {
        // We do not download anything. We fake it
        let activities = Activities()
        
        for i in 0...10 {
            let activity = Activity(name:"Activity number \( i )")
            activity.address = "Address \( i )"
            
            activities.add(activity: activity)            
        }
        
        OperationQueue.main.addOperation {
            onSuccess(activities)
        }
    }
}
