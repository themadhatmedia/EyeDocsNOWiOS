//
//  PackageDetailData.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 5/25/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import Foundation

struct PackageDetailData{
    
    var expiry : String!
    var featureProfile : String!
    var jobLeft : String!
    var info : PackageDetailInfo!
    var resumes : PackageDetailResumes!
    var packages : [PackageDetailPackage]!
    var packagesBumpUp : [PackageDetailPackage]!
    var pageTitle : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        expiry = dictionary["expiry"] as? String
        featureProfile = dictionary["feature_profile"] as? String
        jobLeft = dictionary["jobs_left"] as? String
        if let infoData = dictionary["info"] as? [String:Any]{
            info = PackageDetailInfo(fromDictionary: infoData)
        }
        if let resumesDet = dictionary["resumes"] as? [String:Any]{
            resumes = PackageDetailResumes(fromDictionary: resumesDet)
        }
        packages = [PackageDetailPackage]()
        if let packagesArray = dictionary["packages"] as? [[String:Any]]{
            for dic in packagesArray{
                let value = PackageDetailPackage(fromDictionary: dic)
                packages.append(value)
            }
        }
        packagesBumpUp = [PackageDetailPackage]()
        if let packagesArray = dictionary["bump_jobs"] as? [[String:Any]]{
            for dic in packagesArray{
                let value = PackageDetailPackage(fromDictionary: dic)
                packagesBumpUp.append(value)
            }
        }

        pageTitle = dictionary["page_title"] as? String
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if expiry != nil{
            dictionary["expiry"] = expiry
        }
        if info != nil{
            dictionary["info"] = info.toDictionary()
        }
        if resumes != nil{
            dictionary["resumes"] = resumes.toDictionary()
        }
        if packages != nil{
            var dictionaryElements = [[String:Any]]()
            for packagesElement in packages {
                dictionaryElements.append(packagesElement.toDictionary())
            }
            dictionary["packages"] = dictionaryElements
        }
        if pageTitle != nil{
            dictionary["page_title"] = pageTitle
        }
        return dictionary
    }
    
}
