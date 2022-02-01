//
//  EducationRoot.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 8/6/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import Foundation

struct EducationRoot{
    
    var data : EducationData!
    var pageTitle : String!
    var success : Bool!
   
    init(fromDictionary dictionary: [String:Any]){
        if let dataData = dictionary["data"] as? [String:Any]{
            data = EducationData(fromDictionary: dataData)
        }
        pageTitle = dictionary["page_title"] as? String
        success = dictionary["success"] as? Bool
    }
    
}
