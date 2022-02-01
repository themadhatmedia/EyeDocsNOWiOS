//
//  EmailData.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 8/13/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import Foundation

struct EmailData{
    
    var key : String!
    var value : String!
    
    init(fromDictionary dictionary: [String:Any]){
        key = dictionary["key"] as? String
        value = dictionary["value"] as? String
    }
    
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if key != nil{
            dictionary["key"] = key
        }
        if value != nil{
            dictionary["value"] = value
        }
        return dictionary
    }
    
}
