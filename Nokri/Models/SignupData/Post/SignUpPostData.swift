//
//  SignUpPostData.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 5/10/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import Foundation

struct SignUpPostData{
    
    var autoLogin : Bool!
    var profileData : SignUpPostProfileData!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        autoLogin = dictionary["auto_login"] as? Bool
        if let profileDataData = dictionary["profile_data"] as? [String:Any]{
            profileData = SignUpPostProfileData(fromDictionary: profileDataData)
        }
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if autoLogin != nil{
            dictionary["auto_login"] = autoLogin
        }
        if profileData != nil{
            dictionary["profile_data"] = profileData.toDictionary()
        }
        return dictionary
    }
    
}
