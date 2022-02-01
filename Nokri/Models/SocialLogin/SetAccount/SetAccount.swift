//
//  SetAccount.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 5/8/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import Foundation

struct SetAccount{
    
    var btnCand : String!
    var btnEmp : String!
    var continueField : String!
    var desc : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        btnCand = dictionary["btn_cand"] as? String
        btnEmp = dictionary["btn_emp"] as? String
        continueField = dictionary["continue"] as? String
        desc = dictionary["desc"] as? String
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if btnCand != nil{
            dictionary["btn_cand"] = btnCand
        }
        if btnEmp != nil{
            dictionary["btn_emp"] = btnEmp
        }
        if continueField != nil{
            dictionary["continue"] = continueField
        }
        if desc != nil{
            dictionary["desc"] = desc
        }
        return dictionary
    }
    
}
