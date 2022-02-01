//
//  AddEmailTempRoot.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 5/23/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import Foundation

struct AddEmailTempRoot{
    
    var data : [AddEmailTempData]!
    var extras : [AddEmailTempExtra]!
    var message : String!
    var success : Bool!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        data = [AddEmailTempData]()
        if let dataArray = dictionary["data"] as? [[String:Any]]{
            for dic in dataArray{
                let value = AddEmailTempData(fromDictionary: dic)
                data.append(value)
            }
        }
        extras = [AddEmailTempExtra]()
        if let extrasArray = dictionary["extras"] as? [[String:Any]]{
            for dic in extrasArray{
                let value = AddEmailTempExtra(fromDictionary: dic)
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
