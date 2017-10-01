//  MapActivities.swift
//  MadridShops
//
//  Created by Carlos on 01/10/17.
//  Copyright © 2017 THO. All rights reserved.

import Foundation
import CoreData

func mapActivityCDIntoActivity(activityCD: ActivityCD) -> Activity {
    let activity = Activity(name: activityCD.name!)
    
    activity.address = activityCD.address ?? ""
    activity.image = activityCD.image ?? ""
    activity.logo = activityCD.logo ?? ""
    activity.latitude = activityCD.latitude
    activity.longitude = activityCD.longitude
    
    activity.description_cl = activityCD.description_cl ?? ""
    activity.description_cn = activityCD.description_cn ?? ""
    activity.description_en = activityCD.description_en ?? ""
    activity.description_es = activityCD.description_es ?? ""
    activity.description_jp = activityCD.description_jp ?? ""
    activity.description_mx = activityCD.description_mx ?? ""
    
    activity.opening_hours_cl = activityCD.opening_hours_cl ?? ""
    activity.opening_hours_cn = activityCD.opening_hours_cn ?? ""
    activity.opening_hours_en = activityCD.opening_hours_en ?? ""
    activity.opening_hours_es = activityCD.opening_hours_es ?? ""
    activity.opening_hours_jp = activityCD.opening_hours_jp ?? ""
    activity.opening_hours_mx = activityCD.opening_hours_mx ?? ""
    
    activity.cachedMap = activityCD.cachedMap ?? nil
    
    return activity
}

func mapActivityIntoActivityCD(context: NSManagedObjectContext , activity: Activity) -> ActivityCD {
    let activityCD = ActivityCD(context: context)
    
    activityCD.name = activity.name
    activityCD.address = activity.address
    activityCD.image = activity.image
    activityCD.logo = activity.logo
    activityCD.latitude = activity.latitude ?? 0.0
    activityCD.longitude = activity.longitude ?? 0.0
    
    activityCD.description_cl = activity.description_cl
    activityCD.description_cn = activity.description_cn
    activityCD.description_en = activity.description_en
    activityCD.description_es = activity.description_es
    activityCD.description_jp = activity.description_jp
    activityCD.description_mx = activity.description_mx
    
    activityCD.opening_hours_cl = activity.opening_hours_cl
    activityCD.opening_hours_cn = activity.opening_hours_cn
    activityCD.opening_hours_en = activity.opening_hours_en
    activityCD.opening_hours_es = activity.opening_hours_es
    activityCD.opening_hours_jp = activity.opening_hours_jp
    activityCD.opening_hours_mx = activity.opening_hours_mx
    
    activityCD.cachedMap = activity.cachedMap ?? nil
    
    return activityCD
}
