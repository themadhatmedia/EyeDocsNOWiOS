//
//  CandidateTab.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 5/9/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import Foundation

struct CandidateTab{
    
    var apllied : String!
    var blog : String!
    var company : String!
    var dashboard : String!
    var edit : String!
    var exit : String!
    var faq : String!
    var home : String!
    var jobs : String!
    var loading : String!
    var logout : String!
    var profile : String!
    var resume : String!
    var saved : String!
    var search : String!
    var canSearch : String!
    var notifyPage : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        apllied = dictionary["apllied"] as? String
        blog = dictionary["blog"] as? String
        company = dictionary["company"] as? String
        dashboard = dictionary["dashboard"] as? String
        edit = dictionary["edit"] as? String
        exit = dictionary["exit"] as? String
        faq = dictionary["faq"] as? String
        home = dictionary["home"] as? String
        jobs = dictionary["jobs"] as? String
        loading = dictionary["loading"] as? String
        logout = dictionary["logout"] as? String
        profile = dictionary["profile"] as? String
        resume = dictionary["resume"] as? String
        saved = dictionary["saved"] as? String
        search = dictionary["search"] as? String
        canSearch = dictionary["cand_search"] as? String
        notifyPage = dictionary["notify_page"] as? String
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if apllied != nil{
            dictionary["apllied"] = apllied
        }
        if blog != nil{
            dictionary["blog"] = blog
        }
        if company != nil{
            dictionary["company"] = company
        }
        if dashboard != nil{
            dictionary["dashboard"] = dashboard
        }
        if edit != nil{
            dictionary["edit"] = edit
        }
        if exit != nil{
            dictionary["exit"] = exit
        }
        if faq != nil{
            dictionary["faq"] = faq
        }
        if home != nil{
            dictionary["home"] = home
        }
        if jobs != nil{
            dictionary["jobs"] = jobs
        }
        if loading != nil{
            dictionary["loading"] = loading
        }
        if logout != nil{
            dictionary["logout"] = logout
        }
        if profile != nil{
            dictionary["profile"] = profile
        }
        if resume != nil{
            dictionary["resume"] = resume
        }
        if saved != nil{
            dictionary["saved"] = saved
        }
        if search != nil{
            dictionary["search"] = search
        }
        if canSearch != nil{
            dictionary["cand_search"] = search
        }
        return dictionary
    }
    
}
