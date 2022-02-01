//
//  FeedBackSaplash.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 10/9/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import Foundation

struct FeedBackSaplash{
    
    var data : FeedBackForm!
    var isShow:Bool?
    var title:String?
    var subline:String?
    
    init(fromDictionary dictionary: [String:Any]){
        if let dataData = dictionary["form"] as? [String:Any]{
            data = FeedBackForm(fromDictionary: dataData)
        }
        isShow = dictionary["is_show"] as? Bool
        title = dictionary["title"] as? String
        subline = dictionary["subline"] as? String
       
    }
  
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if data != nil{
            dictionary["form"] = data.toDictionary()
        }
        if isShow != nil{
            dictionary["is_show"] = isShow
        }
        if subline != nil{
            dictionary["title"] = subline
        }
        if title != nil{
            dictionary["subline"] = title
        }
      
        return dictionary
    }
    
}
