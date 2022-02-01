//
//  CandidateScheduledHourData.swift
//  Nokri
//
//  Created by Apple on 21/12/2020.
//  Copyright © 2020 Furqan Nadeem. All rights reserved.
//

import Foundation
struct CandidateScheduledHourData {
    var scheduleHOur: CandidateDaysData!

    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        if let dataData = dictionary["scheduled_hours"] as? [String:Any]{
         scheduleHOur = CandidateDaysData(fromDictionary: dataData)
        }

    }
}
