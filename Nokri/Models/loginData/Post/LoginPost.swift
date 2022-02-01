//
//  LoginPost.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 5/8/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import Foundation

struct LoginPost{
    
    var displayName : String!
    var id : Int!
    var phone : String!
    var profileImg : String!
    var userEmail : String!
    var userType : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        displayName = dictionary["display_name"] as? String
        id = dictionary["id"] as? Int
        phone = dictionary["phone"] as? String
        profileImg = dictionary["profile_img"] as? String
        userEmail = dictionary["user_email"] as? String
        userType = dictionary["user_type"] as? String
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if displayName != nil{
            dictionary["display_name"] = displayName
        }
        if id != nil{
            dictionary["id"] = id
        }
        if phone != nil{
            dictionary["phone"] = phone
        }
        if profileImg != nil{
            dictionary["profile_img"] = profileImg
        }
        if userEmail != nil{
            dictionary["user_email"] = userEmail
        }
        if userType != nil{
            dictionary["user_type"] = userType
        }
        return dictionary
    }
    
}
