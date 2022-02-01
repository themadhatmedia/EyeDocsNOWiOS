//
//  PrivacySaplash.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 10/8/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import Foundation

struct PrivacySaplash{
    
    var privacySec : Bool!
    var privactTitle : String!
    var url : String!
    
    
    init(fromDictionary dictionary: [String:Any]){
        privacySec = dictionary["privacy_section"] as? Bool
        privactTitle = dictionary["privacy_title"] as? String
        url = dictionary["url"] as? String
    
    }
    
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if privacySec != nil{
            dictionary["privacy_section"] = privacySec
        }
        if privactTitle != nil{
            dictionary["privacy_title"] = privactTitle
        }
        if url != nil{
            dictionary["url"] = url
        }
     
        
        return dictionary
    }
}
