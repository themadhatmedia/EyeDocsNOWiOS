//
//  CandPortfolioRoot.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 7/18/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import Foundation

struct CandPortfolioRoot{
    
    var data : CandPortfolioData!
    var extras : String!
    var success : Bool!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        if let dataData = dictionary["data"] as? [String:Any]{
            data = CandPortfolioData(fromDictionary: dataData)
        }
        extras = dictionary["extras"] as? String
        success = dictionary["success"] as? Bool
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if data != nil{
            dictionary["data"] = data.toDictionary()
        }
        if extras != nil{
            dictionary["extras"] = extras
        }
        if success != nil{
            dictionary["success"] = success
        }
        return dictionary
    }
    

}
