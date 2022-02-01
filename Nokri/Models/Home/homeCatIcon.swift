//
//  homeCatIcon.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 7/28/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import Foundation

struct homeCatIcon{
    
    var count : String!
    var img : String!
    var jobCategory : Int!
    var name : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        count = dictionary["count"] as? String
        img = dictionary["img"] as? String
        jobCategory = dictionary["job_category"] as? Int
        name = dictionary["name"] as? String
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if count != nil{
            dictionary["count"] = count
        }
        if img != nil{
            dictionary["img"] = img
        }
        if jobCategory != nil{
            dictionary["job_category"] = jobCategory
        }
        if name != nil{
            dictionary["name"] = name
        }
        return dictionary
    }
    
}
