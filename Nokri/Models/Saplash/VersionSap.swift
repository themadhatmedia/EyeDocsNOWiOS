//
//  VersionSap.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 10/8/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import Foundation

struct VersionSap{
    
    var versionSec : Bool!
    var versionDet : String!
    
    init(fromDictionary dictionary: [String:Any]){
        versionSec = dictionary["version_section"] as? Bool
        versionDet = dictionary["version_txt"] as? String        
    }
    
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if versionSec != nil{
            dictionary["version_section"] = versionSec
        }
        if versionDet != nil{
            dictionary["version_txt"] = versionDet
        }
        return dictionary
    }
}
