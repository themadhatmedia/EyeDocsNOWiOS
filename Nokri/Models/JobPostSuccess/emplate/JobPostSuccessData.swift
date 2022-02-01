//
//  JobPostSuccessData.swift
//  Nokri
//
//  Created by apple on 9/18/19.
//  Copyright © 2019 Furqan Nadeem. All rights reserved.
//

import Foundation
struct JobPostSuccessData{
    
    var already : String!
    var btn : String!
    var forgot : String!
    var forgotPlaceholder : String!
    var logo : String!
    var signin : String!
    
    init(fromDictionary dictionary: [String:Any]){
        already = dictionary["already"] as? String
        btn = dictionary["submit_text"] as? String
        forgot = dictionary["heading"] as? String
        forgotPlaceholder = dictionary["email_placeholder"] as? String
        logo = dictionary["logo"] as? String
        signin = dictionary["signin"] as? String
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
