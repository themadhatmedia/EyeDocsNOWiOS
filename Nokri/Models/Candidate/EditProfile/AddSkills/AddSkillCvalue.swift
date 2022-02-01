//
//  AddSkillCvalue.swift
//  Nokri
//
//  Created by Furqan Nadeem on 11/20/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import Foundation

struct AddSkillCvalue{
    
    var selected : Bool!
    var value : String!
   
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        selected = dictionary["selected"] as? Bool
        value = dictionary["value"] as? String
       
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if selected != nil{
            dictionary["selected"] = selected
        }
        if value != nil{
            dictionary["value"] = value
        }
       
        return dictionary
    }
    
}
