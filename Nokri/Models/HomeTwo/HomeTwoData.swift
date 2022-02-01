//
//  HomeTwoData.swift
//  Nokri
//
//  Created by Furqan Nadeem on 17/04/2019.
//  Copyright © 2019 Furqan Nadeem. All rights reserved.
//

import Foundation

struct HomeTwoData{
    
    var btnText : String!
    var catPlc : String!
    var categories : HomeTwoCategory!
    var heading : String!
    var img : String!
    var keyWrdHeadng : String!
    var keyWrdPlc : String!
    var logo : String!
    var radiusText : String!
    var radiusValue : String!
    var tagline : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        btnText = dictionary["btn_text"] as? String
        catPlc = dictionary["cat_plc"] as? String
        if let categoriesData = dictionary["categories"] as? [String:Any]{
            categories = HomeTwoCategory(fromDictionary: categoriesData)
        }
        heading = dictionary["heading"] as? String
        img = dictionary["img"] as? String
        keyWrdHeadng = dictionary["key_wrd_headng"] as? String
        keyWrdPlc = dictionary["key_wrd_plc"] as? String
        logo = dictionary["logo"] as? String
        radiusText = dictionary["radius_text"] as? String
        radiusValue = dictionary["radius_value"] as? String
        tagline = dictionary["tagline"] as? String
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if btnText != nil{
            dictionary["btn_text"] = btnText
        }
        if catPlc != nil{
            dictionary["cat_plc"] = catPlc
        }
        if categories != nil{
            dictionary["categories"] = categories.toDictionary()
        }
        if heading != nil{
            dictionary["heading"] = heading
        }
        if img != nil{
            dictionary["img"] = img
        }
        if keyWrdHeadng != nil{
            dictionary["key_wrd_headng"] = keyWrdHeadng
        }
        if keyWrdPlc != nil{
            dictionary["key_wrd_plc"] = keyWrdPlc
        }
        if logo != nil{
            dictionary["logo"] = logo
        }
        if radiusText != nil{
            dictionary["radius_text"] = radiusText
        }
        if radiusValue != nil{
            dictionary["radius_value"] = radiusValue
        }
        if tagline != nil{
            dictionary["tagline"] = tagline
        }
        return dictionary
    }
    
}
