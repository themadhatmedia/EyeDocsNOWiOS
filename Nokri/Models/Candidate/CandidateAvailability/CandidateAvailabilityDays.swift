//
//  CandidateAvailabilityDays.swift
//  Nokri
//
//  Created by Apple on 15/12/2020.
//  Copyright © 2020 Furqan Nadeem. All rights reserved.
//

import Foundation
struct  CandidateAvailabilityDays {
    var dayName: String!
    var startTime: String!
    var EndTime: String!
    var closedDay: Bool!
    var dayKey: String!
    
    init(fromDictionary dictionary: [String:Any]){
        dayName = dictionary["day_name"] as? String
        startTime = dictionary["start_time"] as? String
        EndTime = dictionary["end_time"] as? String
        closedDay = dictionary["closed"] as? Bool
        dayKey = dictionary["day_key"] as? String

    }
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if dayName != nil {
            dictionary["day_name"] = dayName
        }
        if startTime != nil {
            dictionary["start_time"] = startTime
        }
        if EndTime != nil {
            dictionary["end_time"] = EndTime
        }
        if closedDay != nil {
            dictionary["closed"] = closedDay
        }
        if dayKey != nil {
            dictionary["day_key"] = dayKey
        }
        
        return dictionary
    }
    
    
    
}
