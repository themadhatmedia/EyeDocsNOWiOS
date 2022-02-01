//
//  FeedBackForm.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 10/9/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import Foundation

struct FeedBackForm{
    
    var title : String!
    var email : String!
    var message : String!
    var btnSubmit : String!
    var btnCancel : String!
    
    init(fromDictionary dictionary: [String:Any]){
        title = dictionary["title"] as? String
        email = dictionary["email"] as? String
        message = dictionary["message"] as? String
        btnSubmit = dictionary["btn_submit"] as? String
        btnCancel = dictionary["btn_cancel"] as? String
    }
    
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if title != nil{
            dictionary["title"] = title
        }
        if email != nil{
            dictionary["email"] = email
        }
        if message != nil{
            dictionary["message"] = message
        }
        if btnSubmit != nil{
            dictionary["btn_submit"] = btnSubmit
        }
        if btnCancel != nil{
            dictionary["btn_cancel"] = btnCancel
        }
        
        
        return dictionary
    }
}
