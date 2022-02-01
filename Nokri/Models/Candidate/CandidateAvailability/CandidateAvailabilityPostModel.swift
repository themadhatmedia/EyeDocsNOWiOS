//
//  CandidateAvailabilityPostModel.swift
//  Nokri
//
//  Created by Apple on 16/12/2020.
//  Copyright © 2020 Furqan Nadeem. All rights reserved.
//

import Foundation
struct CandidateAvailabilityPostModel {
    var success: Bool!
    var message: String!
    
    init(fromDictionary dictionary: [String:Any]){
        success = dictionary["success"] as? Bool
        message = dictionary["message"] as? String
       

    }
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if success != nil {
            dictionary["success"] = success
        }
        if message != nil {
            dictionary["message"] = message
        }
     
        
        return dictionary
    }
    
    
    
}
