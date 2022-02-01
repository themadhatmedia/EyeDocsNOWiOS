//
//  JobPostImageArray.swift
//  Nokri
//
//  Created by Furqan Nadeem on 17/06/2020.
//  Copyright © 2020 Furqan Nadeem. All rights reserved.
//

import Foundation

struct JobPostImageArray {
    
    var key : Int!
    var value : String!
    var fieldName : String!
    
    
    init () {
        
    }
    
    
    init(fromDictionary dictionary: [String:Any]){
        key = dictionary["key"] as? Int
        value = dictionary["value"] as? String
        fieldName = dictionary["fieldname"] as? String
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
//        if imgId != nil{
//            dictionary["key"] = imgId
//        }
//        if thumb != nil{
//            dictionary["value"] = thumb
//        }
        return dictionary
    }
    
}
