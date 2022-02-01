//
//  CandidateAvailabilityTimeZones.swift
//  Nokri
//
//  Created by Apple on 14/12/2020.
//  Copyright © 2020 Furqan Nadeem. All rights reserved.
//

import Foundation
struct CandidateAvailabilityTimeZones {
    var key : String!
    var value : String!
    var selcted : Bool!
    var hasChild : Bool!
    
    init(fromDictionary dictionary: [String:Any]){
        key = dictionary["key"] as? String
        value = dictionary["value"] as? String
        selcted = dictionary["selected"] as? Bool
        hasChild = dictionary["hasChild"] as? Bool

    }
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if key != nil {
            dictionary["key"] = key
        }
        if value != nil {
            dictionary["value"] = value
        }
        if hasChild != nil {
            dictionary["hasChild"] = hasChild
        }
        if selcted != nil {
            dictionary["selected"] = selcted
        }
        
        return dictionary
    }
    
}
