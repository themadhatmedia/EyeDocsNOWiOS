//
//  HomeTwoCategory.swift
//  Nokri
//
//  Created by Furqan Nadeem on 17/04/2019.
//  Copyright © 2019 Furqan Nadeem. All rights reserved.
//

import Foundation
struct HomeTwoCategory{
    
    var column : String!
    var fieldTypeName : String!
    var fieldname : String!
    var isRequired : Bool!
    var key : String!
    var value : [HomeCategoryValue]!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        column = dictionary["column"] as? String
        fieldTypeName = dictionary["field_type_name"] as? String
        fieldname = dictionary["fieldname"] as? String
        isRequired = dictionary["is_required"] as? Bool
        key = dictionary["key"] as? String
        value = [HomeCategoryValue]()
        if let valueArray = dictionary["value"] as? [[String:Any]]{
            for dic in valueArray{
                let valuee = HomeCategoryValue(fromDictionary: dic)
                value.append(valuee)
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
        if value != nil{
            var dictionaryElements = [[String:Any]]()
            for valueElement in value {
                dictionaryElements.append(valueElement.toDictionary())
            }
            dictionary["value"] = dictionaryElements
        }
        return dictionary
    }
    
}
