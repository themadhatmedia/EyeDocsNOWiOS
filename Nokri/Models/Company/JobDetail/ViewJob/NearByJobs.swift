//
//  NearByJobs.swift
//  Nokri
//
//  Created by Apple on 01/01/2021.
//  Copyright © 2021 Furqan Nadeem. All rights reserved.
//

import Foundation
struct NearByJobs {
    var jobID: Int!
    var jobTitle: String!
    var compName: String!
    var compImage: String!
    var distance: String!
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */

    init(fromDictionary dictionary: [String:Any]){
        jobID = dictionary["job_id"] as? Int
        jobTitle = dictionary["job_title"] as? String
        compName = dictionary["comp_name"] as? String
        compImage = dictionary["comp_img"] as? String
        distance = dictionary["distance"] as? String

    }
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if jobID != nil {
            dictionary["job_id"] = jobID
        }
        if jobTitle != nil {
            dictionary["job_title"] = jobTitle
        }
        if compName != nil {
            dictionary["comp_name"] = compName
        }
        if compImage != nil {
            dictionary["comp_img"] = compImage
        }
        if distance != nil {
            dictionary["distance"] = distance
        }
        return dictionary
    }

}
