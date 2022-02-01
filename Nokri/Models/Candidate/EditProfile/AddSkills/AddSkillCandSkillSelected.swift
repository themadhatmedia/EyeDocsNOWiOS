//
//  AddSkillCandSkillSelected.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 7/14/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import Foundation

struct AddSkillCandSkillSelected{
    
    var key : String!
    var value : Int!
    
    
    var keySkil : Int!
    var valueSkil : String!
    
    init(fromDictionary dictionary: [String:Any]){
        key = dictionary["name"] as? String
        value = dictionary["Percent value"] as? Int
        keySkil = dictionary["key"] as? Int
        valueSkil = dictionary["value"] as? String
    }
 
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if key != nil{
            dictionary["name"] = key
        }
        if value != nil{
            dictionary["Percent value"] = value
        }
        return dictionary
    }
    
}
