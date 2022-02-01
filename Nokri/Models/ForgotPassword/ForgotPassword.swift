//
//  ForgotPassword.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 5/7/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import Foundation
struct ForgotPassword{
    
    var already : String!
    var btn : String!
    var forgot : String!
    var forgotPlaceholder : String!
    var logo : String!
    var signin : String!
    var token : String!
    var api_birbase_key : String!
   
    init(fromDictionary dictionary: [String:Any]){
        already = dictionary["already"] as? String
        btn = dictionary["submit_text"] as? String
        forgot = dictionary["heading"] as? String
        forgotPlaceholder = dictionary["email_placeholder"] as? String
        logo = dictionary["logo"] as? String
        signin = dictionary["signin"] as? String
        token = dictionary["token"] as? String
        api_birbase_key = dictionary["api_birbase_key"] as? String
    }
   
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if already != nil{
            dictionary["already"] = already
        }
        if btn != nil{
            dictionary["submit_text"] = btn
        }
        if forgot != nil{
            dictionary["heading"] = forgot
        }
        if forgotPlaceholder != nil{
            dictionary["email_placeholder"] = forgotPlaceholder
        }
        if logo != nil{
            dictionary["logo"] = logo
        }
        if signin != nil{
            dictionary["signin"] = signin
        }
        return dictionary
    }
    
}
