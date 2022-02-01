//
//  MenuResume.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 5/9/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import Foundation

struct MenuResume{
    
    var action : String!
    var download : String!
    var linkedin : String!
    var profile : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        action = dictionary["action"] as? String
        download = dictionary["download"] as? String
        linkedin = dictionary["linkedin"] as? String
        profile = dictionary["profile"] as? String
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if action != nil{
            dictionary["action"] = action
        }
        if download != nil{
            dictionary["download"] = download
        }
        if linkedin != nil{
            dictionary["linkedin"] = linkedin
        }
        if profile != nil{
            dictionary["profile"] = profile
        }
        return dictionary
    }
    
}
