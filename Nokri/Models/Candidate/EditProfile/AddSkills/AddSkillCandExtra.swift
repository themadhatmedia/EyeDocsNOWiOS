//
//  AddSkillCandExtra.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 7/14/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import Foundation

struct AddSkillCandExtra{
    
    var btnName : AddSkillCandBtnName!
    var pageTitle : AddSkillCandBtnName!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        if let btnNameData = dictionary["btn_name"] as? [String:Any]{
            btnName = AddSkillCandBtnName(fromDictionary: btnNameData)
        }
        if let pageTitleData = dictionary["page_title"] as? [String:Any]{
            pageTitle = AddSkillCandBtnName(fromDictionary: pageTitleData)
        }
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if btnName != nil{
            dictionary["btn_name"] = btnName.toDictionary()
        }
        if pageTitle != nil{
            dictionary["page_title"] = pageTitle.toDictionary()
        }
        return dictionary
    }
    
}
