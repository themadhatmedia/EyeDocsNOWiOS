//
//  ImageUploadRoot.swift
//  Nokri
//
//  Created by apple on 1/24/20.
//  Copyright © 2020 Furqan Nadeem. All rights reserved.
//

import Foundation

struct ImageUploadRootMulti{
    
    var data : JobPostImagesData!
    var message : String!
    var success : Bool!
    var extra : Int!
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
       
        extra = dictionary["extras"] as? Int
        if let dataData = dictionary["data"] as? [String:Any]{
            data = JobPostImagesData(fromDictionary: dataData)
        }
        message = dictionary["message"] as? String
        success = dictionary["success"] as? Bool
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if data != nil{
            dictionary["data"] = data
        }
        if message != nil{
            dictionary["message"] = message
        }
        if success != nil{
            dictionary["success"] = success
        }
        if extra != nil{
            dictionary["extras"] = success
        }
        return dictionary
    }
    
}
