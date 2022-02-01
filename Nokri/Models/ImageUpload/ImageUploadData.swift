//
//  ImageUploadData.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 9/28/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import Foundation

struct ImageUploadData{
    
    var image : String!
  
    init(fromDictionary dictionary: [String:Any]){
        image = dictionary["logo_img"] as? String
     
    }
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if image != nil{
            dictionary["logo_img"] = image
        }
        return dictionary
    }
    
}
