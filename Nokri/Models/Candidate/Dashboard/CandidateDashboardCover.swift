//
//  CandidateDashboardCover.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 6/19/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import Foundation

struct CandidateDashboardCover{
    
    var img : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        img = dictionary["img"] as? String
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if img != nil{
            dictionary["img"] = img
        }
        return dictionary
    }
    
}
