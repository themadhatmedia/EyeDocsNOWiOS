//
//  TermSaplash.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 10/8/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import Foundation

struct TermSaplash{
    
    var termSec : Bool!
    var termTitle : String!
    var url : String!
    
    
    init(fromDictionary dictionary: [String:Any]){
        termSec = dictionary["terms_section"] as? Bool
        termTitle = dictionary["terms_title"] as? String
        url = dictionary["url"] as? String
        
    }
    
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if termSec != nil{
            dictionary["terms_section"] = termSec
        }
        if termTitle != nil{
            dictionary["terms_title"] = termTitle
        }
        if url != nil{
            dictionary["url"] = url
        }
        
        
        return dictionary
    }
}
