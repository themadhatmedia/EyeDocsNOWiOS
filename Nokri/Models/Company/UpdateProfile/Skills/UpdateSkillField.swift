//
//  UpdateSkillField.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 5/15/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import Foundation

struct UpdateSkillField{
    
    var column : Int!
    var fieldTypeName : String!
    var fieldname : String!
    var isRequired : Bool!
    var key : String!
    var vaalue : [UpdateSkillValue]!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        column = dictionary["column"] as? Int
        fieldTypeName = dictionary["field_type_name"] as? String
        fieldname = dictionary["fieldname"] as? String
        isRequired = dictionary["is_required"] as? Bool
        key = dictionary["key"] as? String
        vaalue = [UpdateSkillValue]()
        if let valueArray = dictionary["value"] as? [[String:Any]]{
            for dic in valueArray{
                let value = UpdateSkillValue(fromDictionary: dic)
                vaalue.append(value)
            }
        }
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if column != nil{
            dictionary["column"] = column
        }
        if fieldTypeName != nil{
            dictionary["field_type_name"] = fieldTypeName
        }
        if fieldname != nil{
            dictionary["fieldname"] = fieldname
        }
        if isRequired != nil{
            dictionary["is_required"] = isRequired
        }
        if key != nil{
            dictionary["key"] = key
        }
        if vaalue != nil{
            var dictionaryElements = [[String:Any]]()
            for valueElement in vaalue {
                dictionaryElements.append(valueElement.toDictionary())
            }
            dictionary["value"] = dictionaryElements
        }
        return dictionary
    }
    
}
