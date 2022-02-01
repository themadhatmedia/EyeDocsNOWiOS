//
//  JobPostCCustomData.swift
//  Nokri
//
//  Created by apple on 7/24/19.
//  Copyright © 2019 Furqan Nadeem. All rights reserved.
//

import Foundation
struct JobPostCCustomData{
    
    var fieldName : String!
    var fieldType : String!
    var fieldTypeName : String!
    var fieldVal : String!
    //var value : String!
    var hasCatTemplate : Bool!
    var hasPageNumber : Int!
    var isRequired : Bool!
    var isShow : Bool!
    var mainTitle : String!
    var title : String!
    var value : String!
    var values : [JobPostCustomeValues]!
    //var valueArr :[JobPostCustomeValues]!
    
    init () {
           
       }
    
    init(fromDictionary dictionary: [String:Any]){
        fieldName = dictionary["field_name"] as? String
        fieldType = dictionary["field_type"] as? String
        fieldTypeName = dictionary["field_type_name"] as? String
        fieldVal = dictionary["field_val"] as? String
        //value = dictionary["value"] as? String
        hasCatTemplate = dictionary["has_cat_template"] as? Bool
        hasPageNumber = dictionary["has_page_number"] as? Int
        isRequired = dictionary["is_required"] as? Bool
        isShow = dictionary["is_show"] as? Bool
        mainTitle = dictionary["main_title"] as? String
        title = dictionary["title"] as? String
        value = dictionary["value"] as? String
        values = [JobPostCustomeValues]()
            if let valArray = dictionary["value"] as? [[String:Any]]{
                for dic in valArray{
                    let value = JobPostCustomeValues(fromDictionary: dic)
                    values.append(value)
                }
        }
    }

    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if fieldName != nil{
            dictionary["field_name"] = fieldName
        }
        if fieldType != nil{
            dictionary["field_type"] = fieldType
        }
        if fieldTypeName != nil{
            dictionary["field_type_name"] = fieldTypeName
        }
        if fieldVal != nil{
            dictionary["field_val"] = fieldVal
        }
        if hasCatTemplate != nil{
            dictionary["has_cat_template"] = hasCatTemplate
        }
        if hasPageNumber != nil{
            dictionary["has_page_number"] = hasPageNumber
        }
        if isRequired != nil{
            dictionary["is_required"] = isRequired
        }
        if isShow != nil{
            dictionary["is_show"] = isShow
        }
        if mainTitle != nil{
            dictionary["main_title"] = mainTitle
        }
        if title != nil{
            dictionary["title"] = title
        }
        if values != nil{
            dictionary["values"] = values
        }
        return dictionary
    }
    
}
