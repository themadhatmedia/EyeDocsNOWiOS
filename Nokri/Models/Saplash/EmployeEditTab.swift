//
//  EmployeEditTab.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 5/9/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import Foundation

struct EmployeEditTab{
    
    var info : String!
    var loc : String!
    var social : String!
    var special : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        info = dictionary["info"] as? String
        loc = dictionary["loc"] as? String
        social = dictionary["social"] as? String
        special = dictionary["special"] as? String
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if info != nil{
            dictionary["info"] = info
        }
        if loc != nil{
            dictionary["loc"] = loc
        }
        if social != nil{
            dictionary["social"] = social
        }
        if special != nil{
            dictionary["special"] = special
        }
        return dictionary
    }
    
}
