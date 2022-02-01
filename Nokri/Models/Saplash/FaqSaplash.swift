//
//  FaqSaplash.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 10/9/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import Foundation

struct FaqSaplash{
    
    var isfaq : Bool!
  
    init(fromDictionary dictionary: [String:Any]){
        isfaq = dictionary["faq"] as? Bool
       
    }
    
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if isfaq != nil{
            dictionary["faq"] = isfaq
        }
       
        return dictionary
    }
}
