//
//  CandLocationExtra.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 7/15/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import Foundation

struct CandLocationExtra{
    
    var btnTxt : String!
    var cityTxt : String!
    var countryTxt : String!
    var pageTitle : String!
    var stateTxt : String!
    var townTxt : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        btnTxt = dictionary["btn_txt"] as? String
        cityTxt = dictionary["city_txt"] as? String
        countryTxt = dictionary["country_txt"] as? String
        pageTitle = dictionary["page_title"] as? String
        stateTxt = dictionary["state_txt"] as? String
        townTxt = dictionary["town_txt"] as? String
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if btnTxt != nil{
            dictionary["btn_txt"] = btnTxt
        }
        if cityTxt != nil{
            dictionary["city_txt"] = cityTxt
        }
        if countryTxt != nil{
            dictionary["country_txt"] = countryTxt
        }
        if pageTitle != nil{
            dictionary["page_title"] = pageTitle
        }
        if stateTxt != nil{
            dictionary["state_txt"] = stateTxt
        }
        if townTxt != nil{
            dictionary["town_txt"] = townTxt
        }
        return dictionary
    }
    
}
