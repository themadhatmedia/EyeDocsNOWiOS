//
//  AdMob.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 9/17/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import Foundation

struct AdMob{
    
    var show : Bool!
    var type : String!
    var is_show_banner : Bool!
    var position : String!
    var banner_id : String!
    var is_show_initial : Bool!
    var ad_id : String!
    
    init(fromDictionary dictionary: [String:Any]){
        show = dictionary["show"] as? Bool
        type = dictionary["type"] as? String
        is_show_banner = dictionary["is_show_banner"] as? Bool
        position = dictionary["position"] as? String
        banner_id = dictionary["banner_id"] as? String
        is_show_initial = dictionary["is_show_initial"] as? Bool
        ad_id = dictionary["ad_id"] as? String
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if show != nil{
            dictionary["show"] = show
        }
        if type != nil{
            dictionary["type"] = type
        }
        if is_show_banner != nil{
            dictionary["is_show_banner"] = is_show_banner
        }
        if position != nil{
            dictionary["position"] = position
        }
        if banner_id != nil{
            dictionary["banner_id"] = banner_id
        }
        if is_show_initial != nil{
            dictionary["is_show_initial"] = is_show_initial
        }
        if ad_id != nil{
            dictionary["ad_id"] = ad_id
        }
        return dictionary
    }

}
