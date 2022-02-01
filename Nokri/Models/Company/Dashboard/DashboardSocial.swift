//
//  DashboardSocial.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 5/11/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import Foundation

struct DashboardSocial{
    
    var facebook : String!
    var googlePlus : String!
    var linkedin : String!
    var twitter : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        facebook = dictionary["facebook"] as? String
        googlePlus = dictionary["google_plus"] as? String
        linkedin = dictionary["linkedin"] as? String
        twitter = dictionary["twitter"] as? String
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if facebook != nil{
            dictionary["facebook"] = facebook
        }
        if googlePlus != nil{
            dictionary["google_plus"] = googlePlus
        }
        if linkedin != nil{
            dictionary["linkedin"] = linkedin
        }
        if twitter != nil{
            dictionary["twitter"] = twitter
        }
        return dictionary
    }
    
}
