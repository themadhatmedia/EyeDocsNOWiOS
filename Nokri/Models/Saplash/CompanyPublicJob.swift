//
//  CompanyPublicJob.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 5/9/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import Foundation

struct CompnyPublicJob{
    
    var details : String!
    var open : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        details = dictionary["details"] as? String
        open = dictionary["open"] as? String
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if details != nil{
            dictionary["details"] = details
        }
        if open != nil{
            dictionary["open"] = open
        }
        return dictionary
    }
    
}
