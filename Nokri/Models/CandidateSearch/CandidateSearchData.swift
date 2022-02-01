//
//  CandidateSearchData.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 7/9/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import Foundation

struct CandidateSearchData{
    
    var searchFields : [CandidateSearchField]!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        searchFields = [CandidateSearchField]()
        if let searchFieldsArray = dictionary["search_fields"] as? [[String:Any]]{
            for dic in searchFieldsArray{
                let value = CandidateSearchField(fromDictionary: dic)
                searchFields.append(value)
            }
        }
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if searchFields != nil{
            var dictionaryElements = [[String:Any]]()
            for searchFieldsElement in searchFields {
                dictionaryElements.append(searchFieldsElement.toDictionary())
            }
            dictionary["search_fields"] = dictionaryElements
        }
        return dictionary
    }
    
}
