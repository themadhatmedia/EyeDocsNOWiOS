//
//  CandLocationValue.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 7/15/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import Foundation

struct CandLocationValue{
    
    var hasChild : Bool!
    var key : Int!
    var value : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        hasChild = dictionary["has_child"] as? Bool
        key = dictionary["key"] as? Int
        value = dictionary["value"] as? String
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if hasChild != nil{
            dictionary["has_child"] = hasChild
        }
        if key != nil{
            dictionary["key"] = key
        }
        if value != nil{
            dictionary["value"] = value
        }
        return dictionary
    }
    
}
