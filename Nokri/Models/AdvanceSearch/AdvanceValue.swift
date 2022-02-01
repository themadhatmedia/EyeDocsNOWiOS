//
//  AdvanceValue.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 6/30/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import Foundation

struct AdvanceValue{
    
    var key : Int!
    var selected : String!
    var value : String!
    var hasChild : Bool!
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        key = dictionary["key"] as? Int
        selected = dictionary["selected"] as? String
        value = dictionary["value"] as? String
        hasChild = dictionary["has_child"] as? Bool
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
        if selected != nil{
            dictionary["selected"] = selected
        }
        if value != nil{
            dictionary["value"] = value
        }
        if hasChild != nil{
            dictionary["has_child"] = value
        }
        return dictionary
    }
    
}
