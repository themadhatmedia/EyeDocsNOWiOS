//
//  DashboardData.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 5/11/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import Foundation

struct DashboardData{
    
    var cvrImg : DashboardCoverImage!
    var extra : [DashboardExtra]!
    var info : [DashboardExtra]!
    var profileImg : DashboardProfileImage!
    var skills : [DashboardSkill]!
    var social : DashboardSocial!
    var dataImgArr : [DashboardImages]!
    
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        if let cvrImgData = dictionary["cvr_img"] as? [String:Any]{
            cvrImg = DashboardCoverImage(fromDictionary: cvrImgData)
        }
        extra = [DashboardExtra]()
        if let extraArray = dictionary["extra"] as? [[String:Any]]{
            for dic in extraArray{
                let value = DashboardExtra(fromDictionary: dic)
                extra.append(value)
            }
        }
        info = [DashboardExtra]()
        if let infoArray = dictionary["info"] as? [[String:Any]]{
            for dic in infoArray{
                let value = DashboardExtra(fromDictionary: dic)
                info.append(value)
            }
        }
        if let profileImgData = dictionary["profile_img"] as? [String:Any]{
            profileImg = DashboardProfileImage(fromDictionary: profileImgData)
        }
        
        skills = [DashboardSkill]()
        if let extraArray = dictionary["skills"] as? [[String:Any]]{
            for dic in extraArray{
                let value = DashboardSkill(fromDictionary: dic)
                skills.append(value)
            }
        }
        if let sociali = dictionary["social"] as? [String:Any]{
            social = DashboardSocial(fromDictionary: sociali)
        }
        
        dataImgArr = [DashboardImages]()
        if let extraArr = dictionary["gal_images"] as? [[String:Any]]{
            for dic in extraArr{
                let value = DashboardImages(fromDictionary: dic)
                dataImgArr.append(value)
            }
        }
    }
    
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if cvrImg != nil{
            dictionary["cvr_img"] = cvrImg.toDictionary()
        }
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
            dictionary["profile_img"] = profileImg.toDictionary()
        }
        if skills != nil{
            dictionary["skills"] = skills
        }
        if social != nil{
            dictionary["social"] = social.toDictionary()
        }
        return dictionary
    }
    
}
