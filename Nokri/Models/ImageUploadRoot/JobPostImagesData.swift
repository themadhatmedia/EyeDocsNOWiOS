//
//  JobPostImagesData.swift
//  Nokri
//
//  Created by Furqan Nadeem on 17/06/2020.
//  Copyright © 2020 Furqan Nadeem. All rights reserved.
//

import Foundation

struct JobPostImagesData {
    
    var adImages : [JobPostImageArray]!
   // var images : JobPostImageArray!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        adImages = [JobPostImageArray]()
        if let adImagesArray = dictionary["img"] as? [[String:Any]]{
            for dic in adImagesArray{
                let value = JobPostImageArray(fromDictionary: dic)
                adImages.append(value)
            }
        }

    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if adImages != nil{
            var dictionaryElements = [[String:Any]]()
            for adImagesElement in adImages {
                dictionaryElements.append(adImagesElement.toDictionary())
            }
            dictionary["img"] = dictionaryElements
        }
//        if images != nil{
//            dictionary["img"] = images.toDictionary()
//        }
        return dictionary
    }
    
}
