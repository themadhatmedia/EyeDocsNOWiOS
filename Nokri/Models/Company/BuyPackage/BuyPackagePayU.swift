//
//  BuyPackagePayU.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 6/11/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import Foundation

struct BuyPackagePayU{
    
    var marchantKey : String!
    var mode : String!
    var salt : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        marchantKey = dictionary["marchant_key"] as? String
        mode = dictionary["mode"] as? String
        salt = dictionary["salt"] as? String
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if marchantKey != nil{
            dictionary["marchant_key"] = marchantKey
        }
        if mode != nil{
            dictionary["mode"] = mode
        }
        if salt != nil{
            dictionary["salt"] = salt
        }
        return dictionary
    }
    
}
