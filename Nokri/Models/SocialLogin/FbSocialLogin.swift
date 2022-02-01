//
//  FbSocialLogin.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 5/8/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import Foundation

struct FbSocialLogin{
    
    var acountType : String!
    var displayName : String!
    var id : Int!
    var phone : String!
    var profileImg : String!
    var userEmail : String!
 
    init(fromDictionary dictionary: [String:Any]){
        acountType = dictionary["acount_type"] as? String
        displayName = dictionary["display_name"] as? String
        id = dictionary["id"] as? Int
        phone = dictionary["phone"] as? String
        profileImg = dictionary["profile_img"] as? String
        userEmail = dictionary["user_email"] as? String
    }
   
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if acountType != nil{
            dictionary["acount_type"] = acountType
        }
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
        return dictionary
    }
    
}
