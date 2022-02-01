//
//  CandidateAvailabilityRoot.swift
//  Nokri
//
//  Created by Apple on 14/12/2020.
//  Copyright © 2020 Furqan Nadeem. All rights reserved.
//

import Foundation
struct CandidateAvailabilityRoot{
    
    var data : CandidateAvailabilityDataClass!
//    var extra : [AdvanceSearchExtra]!
    var success : Bool!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        if let dataData = dictionary["data"] as? [String:Any]{
            data = CandidateAvailabilityDataClass(fromDictionary: dataData)
        }
//        extra = [AdvanceSearchExtra]()
//        if let extraArray = dictionary["extra"] as? [[String:Any]]{
//            for dic in extraArray{
//                let value = AdvanceSearchExtra(fromDictionary: dic)
//                extra.append(value)
//            }
//        }
        //data = CandidateAvailabilityDataClass["data"]
        success = dictionary["success"] as? Bool
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if data != nil{
           // dictionary["data"] = data.toDictionary()
        }
//        if extra != nil{
//            var dictionaryElements = [[String:Any]]()
//            for extraElement in extra {
//                dictionaryElements.append(extraElement.toDictionary())
//            }
//            dictionary["extra"] = dictionaryElements
//        }
        if success != nil{
            dictionary["success"] = success
        }
        return dictionary
    }
    
}
