//
//  BlogDetailPublish.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 5/27/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import Foundation

struct BlogDetailPublish{
    
    var btn : String!
    var comment : String!
    var email : String!
    var name : String!
    var msg : String!
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        btn = dictionary["btn"] as? String
        comment = dictionary["comment"] as? String
        email = dictionary["email"] as? String
        name = dictionary["name"] as? String
        msg = dictionary["msg"] as? String
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if btn != nil{
            dictionary["btn"] = btn
        }
        if comment != nil{
            dictionary["comment"] = comment
        }
        if email != nil{
            dictionary["email"] = email
        }
        if name != nil{
            dictionary["name"] = name
        }
        if msg != nil{
            dictionary["msg"] = name
        }
        return dictionary
    }
    
}
