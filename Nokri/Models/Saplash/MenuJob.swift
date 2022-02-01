//
//  MenuJob.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 5/9/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import Foundation

struct MenuJob{
    
    var company : String!
    var view : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        company = dictionary["company"] as? String
        view = dictionary["view"] as? String
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if company != nil{
            dictionary["company"] = company
        }
        if view != nil{
            dictionary["view"] = view
        }
        return dictionary
    }
    
}
