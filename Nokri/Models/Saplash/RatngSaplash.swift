//
//  RatngSaplash.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 10/8/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import Foundation

struct RatngSaplash{
    
    var ratingSec : Bool!
    var ratingText : String!
    var app_id : String!
  
    
    init(fromDictionary dictionary: [String:Any]){
        ratingSec = dictionary["rating_section"] as? Bool
        ratingText = dictionary["rating_txt"] as? String
        app_id = dictionary["app_id_ios"] as? String
    }
    
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if ratingSec != nil{
            dictionary["rating_section"] = ratingSec
        }
        if ratingText != nil{
            dictionary["rating_txt"] = ratingText
        }
        if app_id != nil{
            dictionary["app_id_ios"] = app_id
        }
     

        return dictionary
    }
}
