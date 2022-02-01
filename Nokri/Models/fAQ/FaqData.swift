//
//  FaqData.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 6/7/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import Foundation

struct FaqData{
    
    var descriptionField : String!
    var title : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        descriptionField = dictionary["Description"] as? String
        title = dictionary["title"] as? String
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if descriptionField != nil{
            dictionary["Description"] = descriptionField
        }
        if title != nil{
            dictionary["title"] = title
        }
        return dictionary
    }
    
}
