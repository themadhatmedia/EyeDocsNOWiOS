//
//  CandidateDashboardData.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 6/19/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import Foundation

struct CandidateDashboardData{
    
    var extra : [CandidateDashboardExtra]!
    var info : [CandidateDashboardInfo]!
    var profileImg : String!
    var skills : [CandidateDashboardSkill]!
    var social : CandidateDashboardSocial!
    var candCover : CandidateDashboardCover!
    var candDp : String!
    //var extra : candidat!
   // var profile : CandidateDashboardData!
    var socialIcons : CandidateDashboardSocial!
    var tabs : CandidateDashboardTab!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        extra = [CandidateDashboardExtra]()
        if let extraArray = dictionary["extra"] as? [[String:Any]]{
            for dic in extraArray{
                let value = CandidateDashboardExtra(fromDictionary: dic)
                extra.append(value)
            }
        }
        info = [CandidateDashboardInfo]()
        if let infoArray = dictionary["info"] as? [[String:Any]]{
            for dic in infoArray{
                let value = CandidateDashboardInfo(fromDictionary: dic)
                info.append(value)
            }
        }
        profileImg = dictionary["profile_img"] as? String
        skills = [CandidateDashboardSkill]()
        if let skillsArray = dictionary["skills"] as? [[String:Any]]{
            for dic in skillsArray{
                let value = CandidateDashboardSkill(fromDictionary: dic)
                skills.append(value)
            }
        }
        if let socialData = dictionary["social"] as? [String:Any]{
            social = CandidateDashboardSocial(fromDictionary: socialData)
        }
        if let candCoverData = dictionary["cand_cover"] as? [String:Any]{
            candCover = CandidateDashboardCover(fromDictionary: candCoverData)
        }
        candDp = dictionary["cand_dp"] as? String
//        if let extraData = dictionary["extra"] as? [String:Any]{
//            extra = CandidateDashboardExtra(fromDictionary: extraData)
//        }
//        if let profileData = dictionary["profile"] as? [String:Any]{
//            profile = CandidateDashboardData(fromDictionary: profileData)
//        }
        if let socialIconsData = dictionary["social_icons"] as? [String:Any]{
            socialIcons = CandidateDashboardSocial(fromDictionary: socialIconsData)
        }
        if let tabsData = dictionary["tabs"] as? [String:Any]{
            tabs = CandidateDashboardTab(fromDictionary: tabsData)
        }
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if extra != nil{
            var dictionaryElements = [[String:Any]]()
            for extraElement in extra {
                dictionaryElements.append(extraElement.toDictionary())
            }
            dictionary["extra"] = dictionaryElements
        }
        if info != nil{
            var dictionaryElements = [[String:Any]]()
            for infoElement in info {
                dictionaryElements.append(infoElement.toDictionary())
            }
            dictionary["info"] = dictionaryElements
        }
        if profileImg != nil{
            dictionary["profile_img"] = profileImg
        }
        if skills != nil{
            var dictionaryElements = [[String:Any]]()
            for skillsElement in skills {
                dictionaryElements.append(skillsElement.toDictionary())
            }
            dictionary["skills"] = dictionaryElements
        }
        if social != nil{
            dictionary["social"] = social.toDictionary()
        }
        if candCover != nil{
            dictionary["cand_cover"] = candCover.toDictionary()
        }
        if candDp != nil{
            dictionary["cand_dp"] = candDp
        }
//        if extra != nil{
//            dictionary["extra"] = extra.toDictionary()
//        }
//        if profile != nil{
//            dictionary["profile"] = profile.toDictionary()
//        }
        if socialIcons != nil{
            dictionary["social_icons"] = socialIcons.toDictionary()
        }
        if tabs != nil{
            dictionary["tabs"] = tabs.toDictionary()
        }
        return dictionary
    }
    
}
