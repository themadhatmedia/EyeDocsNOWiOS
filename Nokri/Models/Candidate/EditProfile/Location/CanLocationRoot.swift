//
//  CanLocationRoot.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 7/15/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import Foundation

struct CanLocationRoot{
    
    var data : [CandLocationData]!
    var extras : CandLocationExtra!
    var message : String!
    var success : Bool!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        data = [CandLocationData]()
        if let dataArray = dictionary["data"] as? [[String:Any]]{
            for dic in dataArray{
                let value = CandLocationData(fromDictionary: dic)
                data.append(value)
            }
        }
        if let extrasData = dictionary["extras"] as? [String:Any]{
            extras = CandLocationExtra(fromDictionary: extrasData)
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
            dictionary["extras"] = extras.toDictionary()
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
