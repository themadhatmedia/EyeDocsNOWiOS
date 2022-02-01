//
//  CandidateDaysData.swift
//  Nokri
//
//  Created by Apple on 21/12/2020.
//  Copyright © 2020 Furqan Nadeem. All rights reserved.
//

import Foundation
struct CandidateDaysData {
    
    var days : [CandidateAvailabilityDays]
    var zones: String!
    var status: String!
    var extra: CandidateAvailabilityExtraData!
    var hourType: String!
    init(fromDictionary dictionary: [String:Any]){
       
        days = [CandidateAvailabilityDays]()
        if let daysArray = dictionary["days"] as? [[String:Any]]{
            for dic in daysArray{
                let value = CandidateAvailabilityDays(fromDictionary: dic)
                days.append(value)
            }
        }
        zones = dictionary["zones"] as? String
        status = dictionary["status"] as? String
        if let extraData = dictionary["extra"] as? [String:Any]{
            extra = CandidateAvailabilityExtraData(fromDictionary: extraData)
        }
        hourType = dictionary["hours_type"] as? String
    }
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if days != nil{
            var dictionaryElements = [[String:Any]]()
            for daysElement in days {
                dictionaryElements.append(daysElement.toDictionary())
            }
            dictionary["days"] = dictionaryElements
        }

        return dictionary

    }
    
}
