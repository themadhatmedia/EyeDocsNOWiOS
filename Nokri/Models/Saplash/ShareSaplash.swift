//
//  ShareSaplash.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 10/8/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import Foundation

struct ShareSaplash{
    
    var shareSec : Bool!
    var popupTitle : String!
    var subject : String!
    var url : String!
    
    
    init(fromDictionary dictionary: [String:Any]){
        shareSec = dictionary["share_section"] as? Bool
        popupTitle = dictionary["popup_title"] as? String
        subject = dictionary["subject"] as? String
        url = dictionary["url"] as? String
        
    }
    
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if shareSec != nil{
            dictionary["share_section"] = shareSec
        }
        if popupTitle != nil{
            dictionary["popup_title"] = popupTitle
        }
        if subject != nil{
            dictionary["subject"] = subject
        }
        if url != nil{
            dictionary["url"] = url
        }
        
        return dictionary
    }
}
