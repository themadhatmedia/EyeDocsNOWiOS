//
//  candPortfolioRootPost.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 7/18/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import Foundation

struct candPortfolioRootPost{
    
    var data : String!
    var message : String!
    var success : Bool!
    
    var name : String!
    var type : String!
    var temp_name : String!
    var error : String!
    var size : String!
    
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        data = dictionary["data"] as? String
        message = dictionary["message"] as? String
        success = dictionary["success"] as? Bool
        name = dictionary["name"] as? String
        type = dictionary["type"] as? String
        size = dictionary["size"] as? String
        error = dictionary["error"] as? String
        temp_name = dictionary["temp_name"] as? String
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if data != nil{
            dictionary["data"] = data
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
