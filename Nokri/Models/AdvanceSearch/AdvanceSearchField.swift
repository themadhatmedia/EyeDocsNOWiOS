//
//  AdvanceSearchField.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 6/30/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import Foundation

struct AdvanceSearchField{
    
    var column : String!
    var fieldTypeName : String!
    var fieldname : String!
    var isRequired : Bool!
    var key : String!
    var valueAr : [AdvanceValue]!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        column = dictionary["is_show"] as? String
        fieldTypeName = dictionary["field_type_name"] as? String
        fieldname = dictionary["fieldname"] as? String
        isRequired = dictionary["is_required"] as? Bool
        key = dictionary["key"] as? String
        valueAr = [AdvanceValue]()
        if let valueArray = dictionary["value"] as? [[String:Any]]{
            for dic in valueArray{
             let value = AdvanceValue(fromDictionary: dic)
                
                valueAr.append(value)
            
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
        if valueAr != nil{
            var dictionaryElements = [[String:Any]]()
            for valueElement in valueAr {
                dictionaryElements.append(valueElement.toDictionary())
            }
            dictionary["value"] = dictionaryElements
        }
        return dictionary
    }
    
}
