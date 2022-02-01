//
//  CandidateAvailabilityDataClass.swift
//  Nokri
//
//  Created by Apple on 14/12/2020.
//  Copyright © 2020 Furqan Nadeem. All rights reserved.
//

import Foundation

struct CandidateAvailabilityDataClass {

    var hoursType: String!
    var zones : [CandidateAvailabilityTimeZones]
    var days : [CandidateAvailabilityDays]
    var extra: CandidateAvailabilityExtraData!
    init(fromDictionary dictionary: [String:Any]){
        hoursType = dictionary["hours_type"] as? String
        zones = [CandidateAvailabilityTimeZones]()
        if let extraArray = dictionary["zones"] as? [[String:Any]]{
            for dic in extraArray{
                let value = CandidateAvailabilityTimeZones(fromDictionary: dic)
                zones.append(value)
            }
        }
        days = [CandidateAvailabilityDays]()
        if let daysArray = dictionary["days"] as? [[String:Any]]{
            for dic in daysArray{
                let value = CandidateAvailabilityDays(fromDictionary: dic)
                days.append(value)
            }
        }
        if let extraData = dictionary["extra"] as? [String:Any]{
            extra = CandidateAvailabilityExtraData(fromDictionary: extraData)
        }

    }
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if hoursType != nil{
            dictionary["hours_type"] = hoursType
        }
        if zones != nil{
            var dictionaryElements = [[String:Any]]()
            for zonesElement in zones {
                dictionaryElements.append(zonesElement.toDictionary())
            }
            dictionary["zones"] = dictionaryElements
        }
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
