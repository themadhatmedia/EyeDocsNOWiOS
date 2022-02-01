//
//  homeData.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 7/28/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import Foundation

struct homeData{
    
    var catIcons : [homeCatIcon]!
    var catsText : String!
    var heading : String!
    var img : String!
    var placehldr : String!
    var tagline : String!
    var jobForm : Bool!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        catIcons = [homeCatIcon]()
        if let catIconsArray = dictionary["cat_icons"] as? [[String:Any]]{
            for dic in catIconsArray{
                let value = homeCatIcon(fromDictionary: dic)
                catIcons.append(value)
            }
        }
        catsText = dictionary["cats_text"] as? String
        heading = dictionary["heading"] as? String
        img = dictionary["img"] as? String
        placehldr = dictionary["placehldr"] as? String
        tagline = dictionary["tagline"] as? String
        jobForm = dictionary["job_form"] as? Bool
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if catIcons != nil{
            var dictionaryElements = [[String:Any]]()
            for catIconsElement in catIcons {
                dictionaryElements.append(catIconsElement.toDictionary())
            }
            dictionary["cat_icons"] = dictionaryElements
        }
        if catsText != nil{
            dictionary["cats_text"] = catsText
        }
        if heading != nil{
            dictionary["heading"] = heading
        }
        if img != nil{
            dictionary["img"] = img
        }
        if placehldr != nil{
            dictionary["placehldr"] = placehldr
        }
        if tagline != nil{
            dictionary["tagline"] = tagline
        }
        return dictionary
    }
    
}
