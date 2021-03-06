//
//  PackageDetailBump.swift
//  Nokri
//
//  Created by Apple on 12/10/2020.
//  Copyright © 2020 Furqan Nadeem. All rights reserved.
//

import Foundation

struct PackageDetailBump{
    
    var name : String!
    var noOfJobs : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        name = dictionary["name"] as? String
        noOfJobs = dictionary["no_of_jobs"] as? String
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if name != nil{
            dictionary["name"] = name
        }
        if noOfJobs != nil{
            dictionary["no_of_jobs"] = noOfJobs
        }
        return dictionary
    }
    
}
