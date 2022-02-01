//
//  AdvanceSearchData.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 6/30/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import Foundation

struct AdvanceSearchData{
    
    var searchFields : [AdvanceSearchField]!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        searchFields = [AdvanceSearchField]()
        if let searchFieldsArray = dictionary["search_fields"] as? [[String:Any]]{
            for dic in searchFieldsArray{
                let value = AdvanceSearchField(fromDictionary: dic)
                searchFields.append(value)
            }
        }
    }
    
}
