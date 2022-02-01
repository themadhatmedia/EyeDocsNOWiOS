//
//  GenericText.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 5/9/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import Foundation

struct GenericTxt{
    
    var btnCancel : String!
    var btnConfirm : String!
    var confirm : String!
    var success : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        btnCancel = dictionary["btn_cancel"] as? String
        btnConfirm = dictionary["btn_confirm"] as? String
        confirm = dictionary["confirm"] as? String
        success = dictionary["success"] as? String
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if btnCancel != nil{
            dictionary["btn_cancel"] = btnCancel
        }
        if btnConfirm != nil{
            dictionary["btn_confirm"] = btnConfirm
        }
        if confirm != nil{
            dictionary["confirm"] = confirm
        }
        if success != nil{
            dictionary["success"] = success
        }
        return dictionary
    }
    
}
