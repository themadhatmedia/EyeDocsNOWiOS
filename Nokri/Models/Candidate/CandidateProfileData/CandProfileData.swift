//
//  CandProfileData.swift
//  Nokri
//
//  Created by Apple on 21/12/2020.
//  Copyright © 2020 Furqan Nadeem. All rights reserved.
//

import Foundation
struct CandProfileData {
//    var dataDays: [CandidateAvailabilityDays]
    var data : CandidateBasicProfileInformation!
    var success: Bool!
    var message: String!
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        if let dataData = dictionary["data"] as? [String:Any]{
            data = CandidateBasicProfileInformation(fromDictionary: dataData)
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
        message = dictionary["message"] as? String
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
//        if dataDays != nil{
//           // dictionary["data"] = data.toDictionary()
//        }
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
