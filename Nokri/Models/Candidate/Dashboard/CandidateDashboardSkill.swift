//
//  CandidateDashboardSkill.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 6/19/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import Foundation

struct CandidateDashboardSkill{
    
    var key : Int!
    var value : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        key = dictionary["key"] as? Int
        value = dictionary["value"] as? String
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if key != nil{
            dictionary["key"] = key
        }
        if value != nil{
            dictionary["value"] = value
        }
        return dictionary
    }
    
}
