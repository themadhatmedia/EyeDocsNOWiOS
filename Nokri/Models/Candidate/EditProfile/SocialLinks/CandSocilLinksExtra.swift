//
//  CandSocilLinksExtra.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 7/14/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import Foundation

struct CandSocilLinksExtra{
    
    var btnTxt : String!
    var fbTxt : String!
    var gTxt : String!
    var lkTxt : String!
    var pageTitle : String!
    var twTxt : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        btnTxt = dictionary["btn_txt"] as? String
        fbTxt = dictionary["fb_txt"] as? String
        gTxt = dictionary["g+_txt"] as? String
        lkTxt = dictionary["lk_txt"] as? String
        pageTitle = dictionary["page_title"] as? String
        twTxt = dictionary["tw_txt"] as? String
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
        if fbTxt != nil{
            dictionary["fb_txt"] = fbTxt
        }
        if gTxt != nil{
            dictionary["g+_txt"] = gTxt
        }
        if lkTxt != nil{
            dictionary["lk_txt"] = lkTxt
        }
        if pageTitle != nil{
            dictionary["page_title"] = pageTitle
        }
        if twTxt != nil{
            dictionary["tw_txt"] = twTxt
        }
        return dictionary
    }
    
}
