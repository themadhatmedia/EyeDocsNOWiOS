//
//  AboutSaplash.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 10/8/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import Foundation

struct AboutSaplash{
    
    var aboutSec : Bool!
    var aboutDet : String!
    var about_title :String!
    
    init(fromDictionary dictionary: [String:Any]){
        aboutSec = dictionary["about_section"] as? Bool
        aboutDet = dictionary["about_details"] as? String
        about_title = dictionary["about_title"] as? String
       
    }
 
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if aboutSec != nil{
            dictionary["about_section"] = aboutSec
        }
        if aboutDet != nil{
            dictionary["about_details"] = aboutDet
        }
        if about_title != nil{
            dictionary["about_title"] = about_title
        }
        return dictionary
    }
}
