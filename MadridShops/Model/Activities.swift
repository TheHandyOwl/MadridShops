//  Activities.swift
//  MadridShops
//
//  Created by Carlos on 01/10/17.
//  Copyright © 2017 THO. All rights reserved.

import Foundation

public protocol ActivitiesProtocol {
    func count() -> Int
    func add(activity: Activity)
    func get(index: Int) -> Activity
}

public class Activities: ActivitiesProtocol{
    
    private var activitiesList: [Activity]?
    
    public init() {
        self.activitiesList = []
    }
    
    public func count() -> Int {
        return(activitiesList?.count)!
    }
    
    public func add(activity: Activity) {
        activitiesList?.append(activity)
    }
    
    public func get(index: Int) -> Activity {
        return (activitiesList?[index])!
    }
    
    
}
