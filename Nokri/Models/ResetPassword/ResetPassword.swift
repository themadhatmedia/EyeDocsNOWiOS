//
//  ResetPassword.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 5/15/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import Foundation

struct ResetPassword{
    
    var cancel : String!
    var confirmPassword : String!
    var logo : String!
    var newPassword : String!
    var ok : String!
    var oldPassword : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        cancel = dictionary["cancel"] as? String
        confirmPassword = dictionary["confirm_password"] as? String
        logo = dictionary["logo"] as? String
        newPassword = dictionary["new_password"] as? String
        ok = dictionary["ok"] as? String
        oldPassword = dictionary["old_password"] as? String
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if cancel != nil{
            dictionary["cancel"] = cancel
        }
        if confirmPassword != nil{
            dictionary["confirm_password"] = confirmPassword
        }
        if logo != nil{
            dictionary["logo"] = logo
        }
        if newPassword != nil{
            dictionary["new_password"] = newPassword
        }
        if ok != nil{
            dictionary["ok"] = ok
        }
        if oldPassword != nil{
            dictionary["old_password"] = oldPassword
        }
        return dictionary
    }
    
}
