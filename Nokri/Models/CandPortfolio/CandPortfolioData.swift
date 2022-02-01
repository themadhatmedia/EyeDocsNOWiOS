//
//  CandPortfolioData.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 7/18/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import Foundation

struct CandPortfolioData{
    
    var extra : [CanPortfolionExtra]!
    var img : [CanPortfolionExtra]!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        extra = [CanPortfolionExtra]()
        if let extraArray = dictionary["extra"] as? [[String:Any]]{
            for dic in extraArray{
                let value = CanPortfolionExtra(fromDictionary: dic)
                extra.append(value)
            }
        }
        img = [CanPortfolionExtra]()
        if let imgArray = dictionary["img"] as? [[String:Any]]{
            for dic in imgArray{
                let value = CanPortfolionExtra(fromDictionary: dic)
                img.append(value)
            }
        }
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if extra != nil{
            var dictionaryElements = [[String:Any]]()
            for extraElement in extra {
                dictionaryElements.append(extraElement.toDictionary())
            }
            dictionary["extra"] = dictionaryElements
        }
        if img != nil{
            var dictionaryElements = [[String:Any]]()
            for imgElement in img {
                dictionaryElements.append(imgElement.toDictionary())
            }
            dictionary["img"] = dictionaryElements
        }
        return dictionary
    }
    
}
