//
//  PackageDetailResumes.swift
//  Nokri
//
//  Created by Furqan Nadeem on 11/01/2019.
//  Copyright © 2019 Furqan Nadeem. All rights reserved.
//

import Foundation

struct PackageDetailResumes{
    
    var isRequired : Bool!
    var title : String!
    var nos : String!
   
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        isRequired = dictionary["is_req"] as? Bool
        title = dictionary["title"] as? String
        nos = dictionary["nos"] as? String
      
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if isRequired != nil{
            dictionary["is_req"] = isRequired
        }
        if title != nil{
            dictionary["title"] = title
        }
        if nos != nil{
            dictionary["nos"] = nos
        }
        return dictionary
    }
    
}
