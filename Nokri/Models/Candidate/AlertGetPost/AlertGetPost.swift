//
//  AlertGetPost.swift
//  Nokri
//
//  Created by Apple on 13/10/2020.
//  Copyright © 2020 Furqan Nadeem. All rights reserved.
//

import Foundation

struct AlertGetPost{
    
    var data : AlertGetPostData!
    var message : String!
    var success : Bool!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        if let dataData = dictionary["data"] as? [String:Any]{
            data = AlertGetPostData(fromDictionary: dataData)
        }
        message = dictionary["message"] as? String
        success = dictionary["success"] as? Bool
    }
    
}
