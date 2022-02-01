//
//  JobPostCustomeValues.swift
//  Nokri
//
//  Created by apple on 7/24/19.
//  Copyright © 2019 Furqan Nadeem. All rights reserved.
//

import Foundation
struct JobPostCustomeValues{
    
    var value : String!
    var selected : Bool!
    var name : String!
    var valueInt : Int!
    var selectedText : String!
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        value = dictionary["value"] as? String
        selected = dictionary["selected"] as? Bool
        //selectedText = dictionary["selected"] as? Bool
        name = dictionary["name"] as? String
        valueInt = dictionary["value"] as? Int
     
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if value != nil{
            dictionary["value"] = value
        }
        if valueInt != nil{
            dictionary["value"] = dictionary
        }
        if selected != nil{
            dictionary["selected"] = selected
        }
        if name != nil{
            dictionary["name"] = name
        }
      
        return dictionary
    }
    
}
