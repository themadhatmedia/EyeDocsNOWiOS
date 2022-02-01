//
//  JobPostCustomeExtra.swift
//  Nokri
//
//  Created by apple on 7/24/19.
//  Copyright © 2019 Furqan Nadeem. All rights reserved.
//

import Foundation
struct JobPostCustomeExtra{
    
    var hidePrice : [String]!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        hidePrice = dictionary["hide_price"] as? [String]
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if hidePrice != nil{
            dictionary["hide_price"] = hidePrice
        }
        return dictionary
    }
    
}
