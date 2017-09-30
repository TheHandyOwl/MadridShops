//  JsonParser.swift
//  MadridShops

import Foundation

func parseShops(data: Data) -> Shops {
    
    let shops = Shops()
    
    do {
        
        let jsonObject = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! Dictionary<String, Any>
        let result = jsonObject["result"] as! [Dictionary<String, Any>]
        
        for shopJson in result {
            let shop = Shop(name: shopJson["name"]! as! String)
            shop.address = shopJson["address"]! as! String
            shop.logo = shopJson["logo_img"]! as! String
            shop.image = shopJson["img"]! as! String
            shop.latitude = Float(shopJson["gps_lat"]! as! String)
            shop.longitude = Float(shopJson["gps_lon"]! as! String)
            
            shop.description_cl = shopJson["description_cl"]! as! String
            shop.description_cn = shopJson["description_cn"]! as! String
            shop.description_en = shopJson["description_en"]! as! String
            shop.description_es = shopJson["description_es"]! as! String
            shop.description_jp = shopJson["description_jp"]! as! String
            shop.description_mx = shopJson["description_mx"]! as! String
            
            shop.opening_hours_cl = shopJson["opening_hours_cl"]! as! String
            shop.opening_hours_cn = shopJson["opening_hours_cn"]! as! String
            shop.opening_hours_en = shopJson["opening_hours_en"]! as! String
            shop.opening_hours_es = shopJson["opening_hours_es"]! as! String
            shop.opening_hours_jp = shopJson["opening_hours_jp"]! as! String
            shop.opening_hours_mx = shopJson["opening_hours_mx"]! as! String
            
            shops.add(shop: shop)
        }
        
    } catch {
        print("Error parsing JSON")
    }
    
    return shops
}

func parseActivities(data: Data) -> Activities {
    
    let activities = Activities()
    
    do {
        
        let jsonObject = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! Dictionary<String, Any>
        let result = jsonObject["result"] as! [Dictionary<String, Any>]
        
        for activityJson in result {
            let activity = Activity(name: activityJson["name"]! as! String)
            activity.address = activityJson["address"]! as! String
            activity.logo = activityJson["logo_img"]! as! String
            activity.image = activityJson["img"]! as! String
            activity.latitude = Float(activityJson["gps_lat"]! as! String)
            activity.longitude = Float(activityJson["gps_lon"]! as! String)
            
            activity.description_cl = activityJson["description_cl"]! as! String
            activity.description_cn = activityJson["description_cn"]! as! String
            activity.description_en = activityJson["description_en"]! as! String
            activity.description_es = activityJson["description_es"]! as! String
            activity.description_jp = activityJson["description_jp"]! as! String
            activity.description_mx = activityJson["description_mx"]! as! String
            
            activity.opening_hours_cl = activityJson["opening_hours_cl"]! as! String
            activity.opening_hours_cn = activityJson["opening_hours_cn"]! as! String
            activity.opening_hours_en = activityJson["opening_hours_en"]! as! String
            activity.opening_hours_es = activityJson["opening_hours_es"]! as! String
            activity.opening_hours_jp = activityJson["opening_hours_jp"]! as! String
            activity.opening_hours_mx = activityJson["opening_hours_mx"]! as! String
            
            activities.add(activity: activity)
        }
        
    } catch {
        print("Error parsing JSON")
    }
    
    return activities
}
