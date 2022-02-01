//
//  EmployeTab.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 5/9/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import Foundation

struct EmployeTab{
    
    var blog : String!
    var buyPackage : String!
    var dashboard : String!
    var exit : String!
    var faq : String!
    var followers : String!
    var home : String!
    var jobs : String!
    var logout : String!
    var pkgDetail : String!
    var postJob : String!
    var profile : String!
    var templates : String!
    var canSearch : String!
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        blog = dictionary["blog"] as? String
        buyPackage = dictionary["buy_package"] as? String
        dashboard = dictionary["dashboard"] as? String
        exit = dictionary["exit"] as? String
        faq = dictionary["faq"] as? String
        followers = dictionary["followers"] as? String
        home = dictionary["home"] as? String
        jobs = dictionary["jobs"] as? String
        logout = dictionary["logout"] as? String
        pkgDetail = dictionary["pkg_detail"] as? String
        postJob = dictionary["post_job"] as? String
        profile = dictionary["profile"] as? String
        templates = dictionary["templates"] as? String
        canSearch = dictionary["cand_search"] as? String
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if blog != nil{
            dictionary["blog"] = blog
        }
        if buyPackage != nil{
            dictionary["buy_package"] = buyPackage
        }
        if dashboard != nil{
            dictionary["dashboard"] = dashboard
        }
        if exit != nil{
            dictionary["exit"] = exit
        }
        if faq != nil{
            dictionary["faq"] = faq
        }
        if followers != nil{
            dictionary["followers"] = followers
        }
        if home != nil{
            dictionary["home"] = home
        }
        if jobs != nil{
            dictionary["jobs"] = jobs
        }
        if logout != nil{
            dictionary["logout"] = logout
        }
        if pkgDetail != nil{
            dictionary["pkg_detail"] = pkgDetail
        }
        if postJob != nil{
            dictionary["post_job"] = postJob
        }
        if profile != nil{
            dictionary["profile"] = profile
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
