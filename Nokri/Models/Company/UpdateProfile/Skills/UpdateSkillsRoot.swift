//
//  UpdateSkillsRoot.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 5/15/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//


import Foundation

struct UpdateSkillsRoot{
    
    var data : UpdateSkillsData!
    var extras : [UpdateSkillExtra]!
    var message : String!
    var success : Bool!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        if let dataData = dictionary["data"] as? [String:Any]{
            data = UpdateSkillsData(fromDictionary: dataData)
        }
        extras = [UpdateSkillExtra]()
        if let extrasArray = dictionary["extras"] as? [[String:Any]]{
            for dic in extrasArray{
                let value = UpdateSkillExtra(fromDictionary: dic)
                extras.append(value)
            }
        }
        message = dictionary["message"] as? String
        success = dictionary["success"] as? Bool
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if data != nil{
            dictionary["data"] = data.toDictionary()
        }
        if extras != nil{
            var dictionaryElements = [[String:Any]]()
            for extrasElement in extras {
                dictionaryElements.append(extrasElement.toDictionary())
            }
            dictionary["extras"] = dictionaryElements
        }
        if message != nil{
            dictionary["message"] = message
        }
        if success != nil{
            dictionary["success"] = success
        }
        return dictionary
    }
    
}
