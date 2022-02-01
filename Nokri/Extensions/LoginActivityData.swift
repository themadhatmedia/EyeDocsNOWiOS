//
//  LoginActivityData.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 8/28/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import Foundation
struct LoginActivityData{
    
    var logo : String!
    var signin : String!
    var signup : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        logo = dictionary["logo"] as? String
        signin = dictionary["signin"] as? String
        signup = dictionary["signup"] as? String
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if logo != nil{
            dictionary["logo"] = logo
        }
        if signin != nil{
            dictionary["signin"] = signin
        }
        if signup != nil{
            dictionary["signup"] = signup
        }
        return dictionary
    }
    
}
