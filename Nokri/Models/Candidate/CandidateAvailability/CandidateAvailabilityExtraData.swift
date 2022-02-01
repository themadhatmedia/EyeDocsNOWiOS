//
//  CandidateAvailabilityExtraData.swift
//  Nokri
//
//  Created by Apple on 18/12/2020.
//  Copyright © 2020 Furqan Nadeem. All rights reserved.
//

import Foundation
struct CandidateAvailabilityExtraData{
    var candAvailability: String!
    var selectedHours: String!
    var timeZone: String!
    var submit: String!
    var to: String!
    var open: String!
    var selectiveHours: String!
    var notAvailable: String!
    var scheduledHours: String!
    var closed: String!
    init(fromDictionary dictionary: [String:Any]){
        candAvailability = dictionary["cand_availability"] as? String
        selectedHours = dictionary["selected_hours"] as? String
        timeZone = dictionary["time_zone"] as? String
        submit = dictionary["submit"] as? String
        to = dictionary["to"] as? String
        open = dictionary["open"] as? String
        selectiveHours = dictionary["selective_hours"] as? String
        notAvailable = dictionary["not_available"] as? String
        scheduledHours = dictionary["schedule_hours"] as? String
        closed = dictionary["cloes_now"] as? String
    }
    
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        
        if candAvailability != nil{
            dictionary["cand_availability"] = candAvailability
        }
        if selectedHours != nil {
            dictionary["selected_hours"] = selectedHours
        }
        if timeZone != nil {
            dictionary["time_zone"] = timeZone
        }
        if submit != nil {
            dictionary["submit"] = submit
        }
        if to != nil {
            dictionary["to"] = to
        }
        if open != nil {
            dictionary["open"] = open
        }
        if selectiveHours != nil {
            dictionary["selective_hours"] = selectiveHours
        }
        if notAvailable != nil {
            dictionary["not_available"] = notAvailable
        }
        if scheduledHours != nil {
            dictionary["schedule_hours"] = scheduledHours
        }

        return dictionary
        
    }
    
    
    
    
}
