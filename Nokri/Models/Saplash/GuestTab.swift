//
//  GuestTab.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 5/9/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import Foundation

struct GuestTab{
    
    var candDp : String!
    var exit : String!
    var explore : String!
    var faq : String!
    var guset : String!
    var home : String!
    var signin : String!
    var signup : String!
    var templates : String!
    var canSearch : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        candDp = dictionary["cand_dp"] as? String
        exit = dictionary["exit"] as? String
        explore = dictionary["explore"] as? String
        faq = dictionary["faq"] as? String
        guset = dictionary["guset"] as? String
        home = dictionary["home"] as? String
        signin = dictionary["signin"] as? String
        signup = dictionary["signup"] as? String
        templates = dictionary["templates"] as? String
        canSearch = dictionary["cand_search"] as? String
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if candDp != nil{
            dictionary["cand_dp"] = candDp
        }
        if exit != nil{
            dictionary["exit"] = exit
        }
        if explore != nil{
            dictionary["explore"] = explore
        }
        if faq != nil{
            dictionary["faq"] = faq
        }
        if guset != nil{
            dictionary["guset"] = guset
        }
        if home != nil{
            dictionary["home"] = home
        }
        if signin != nil{
            dictionary["signin"] = signin
        }
        if signup != nil{
            dictionary["signup"] = signup
        }
        if templates != nil{
            dictionary["templates"] = templates
        }
        if canSearch != nil{
            dictionary["cand_search"] = templates
        }
        return dictionary
    }
    
}
