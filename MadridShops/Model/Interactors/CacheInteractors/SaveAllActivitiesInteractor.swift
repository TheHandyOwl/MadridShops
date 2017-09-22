//  SaveAllActivitiesInteractor.swift
//  MadridShops

import CoreData

protocol SaveAllActivitiesInteractor {
    func execute(activities: Activities, context: NSManagedObjectContext, onSuccess: (Activities) -> Void, onError: errorClosure)
    func execute(activities: Activities, context: NSManagedObjectContext, onSuccess: (Activities) -> Void)
}
