//
//  PersonalInfoRoot.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 7/13/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import Foundation

struct PersonalInfoRoot{
    
    var data : [PersonalInfoData]!
    var extras : [PersonalInfoExtra]!
    var message : String!
    var success : Bool!
    var customArr : [JobPostCCustomData]!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        data = [PersonalInfoData]()
        if let dataArray = dictionary["data"] as? [[String:Any]]{
            for dic in dataArray{
                let value = PersonalInfoData(fromDictionary: dic)
                data.append(value)
            }
        }
        extras = [PersonalInfoExtra]()
        if let extrasArray = dictionary["extras"] as? [[String:Any]]{
            for dic in extrasArray{
                let value = PersonalInfoExtra(fromDictionary: dic)
                extras.append(value)
            }
        }
        customArr = [JobPostCCustomData]()
        if let dataArray = dictionary["custom_fields"] as? [[String:Any]]{
            for dic in dataArray{
                let value = JobPostCCustomData(fromDictionary: dic)
                customArr.append(value)
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
            var dictionaryElements = [[String:Any]]()
            for dataElement in data {
                dictionaryElements.append(dataElement.toDictionary())
            }
            dictionary["data"] = dictionaryElements
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
