//
//  PackageDetailInfo.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 5/25/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import Foundation

struct PackageDetailInfo{
    
    var details : String!
    var expiry : String!
    var name : String!
    var number : String!
    var featureProfile :String!
    var jobLeft :String!
    
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        details = dictionary["details"] as? String
        expiry = dictionary["expiry"] as? String
        name = dictionary["name"] as? String
        number = dictionary["number"] as? String
        featureProfile = dictionary["feature_profile"] as? String
        jobLeft = dictionary["jobs_left"] as? String
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if details != nil{
            dictionary["details"] = details
        }
        if expiry != nil{
            dictionary["expiry"] = expiry
        }
        if name != nil{
            dictionary["name"] = name
        }
        if number != nil{
            dictionary["number"] = number
        }
        return dictionary
    }
    
}
