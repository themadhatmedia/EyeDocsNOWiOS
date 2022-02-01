//
//  BuyPackageExtra.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 6/11/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import Foundation

struct BuyPackageExtra{
    
    var pageTitle : String!
    var extraIos : BuyPackageExtraIos!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        pageTitle = dictionary["page_title"] as? String
        if let ios = dictionary["ios"] as? [String:Any]{
            extraIos = BuyPackageExtraIos(fromDictionary: ios)
        }
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if pageTitle != nil{
            dictionary["page_title"] = pageTitle
        }
        if extraIos != nil{
            dictionary["ios"] = extraIos.toDictionary()
        }
        return dictionary
    }
    
}
