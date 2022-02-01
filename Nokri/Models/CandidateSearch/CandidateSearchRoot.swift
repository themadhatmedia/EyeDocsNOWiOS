//
//  CandidateSearchRoot.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 7/9/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import Foundation

struct CandidateSearchRoot{
    
    var data : CandidateSearchData!
    var extra : [CandidateSearchExtra]!
    var success : Bool!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        if let dataData = dictionary["data"] as? [String:Any]{
            data = CandidateSearchData(fromDictionary: dataData)
        }
        extra = [CandidateSearchExtra]()
        if let extraArray = dictionary["extra"] as? [[String:Any]]{
            for dic in extraArray{
                let value = CandidateSearchExtra(fromDictionary: dic)
                extra.append(value)
            }
        }
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
        if extra != nil{
            var dictionaryElements = [[String:Any]]()
            for extraElement in extra {
                dictionaryElements.append(extraElement.toDictionary())
            }
            dictionary["extra"] = dictionaryElements
        }
        if success != nil{
            dictionary["success"] = success
        }
        return dictionary
    }
    
}
