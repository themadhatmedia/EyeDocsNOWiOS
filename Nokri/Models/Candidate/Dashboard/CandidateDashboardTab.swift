//
//  CandidateDashboardTab.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 6/19/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import Foundation
struct CandidateDashboardTab{
    
    var dashboard1 : String!
    var dashboard4 : String!
    var dashboard5 : String!
    var dashboard6 : String!
    var dashboard7 : String!
    var edit : String!
    var fullProfile : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        dashboard1 = dictionary["dashboard1"] as? String
        dashboard4 = dictionary["dashboard4"] as? String
        dashboard5 = dictionary["dashboard5"] as? String
        dashboard6 = dictionary["dashboard6"] as? String
        dashboard7 = dictionary["dashboard7"] as? String
        edit = dictionary["edit"] as? String
        fullProfile = dictionary["full_profile"] as? String
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if dashboard1 != nil{
            dictionary["dashboard1"] = dashboard1
        }
        if dashboard4 != nil{
            dictionary["dashboard4"] = dashboard4
        }
        if dashboard5 != nil{
            dictionary["dashboard5"] = dashboard5
        }
        if dashboard6 != nil{
            dictionary["dashboard6"] = dashboard6
        }
        if dashboard7 != nil{
            dictionary["dashboard7"] = dashboard7
        }
        if edit != nil{
            dictionary["edit"] = edit
        }
        if fullProfile != nil{
            dictionary["full_profile"] = fullProfile
        }
        return dictionary
    }
    
}
