//
//  ViewJobData.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 5/28/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import Foundation

struct ViewJobData{
    
    var compInfo : [viewCompInfo]!
    var extras : [ViewJobExtra]!
    var jobContent : [VIewJobContent]!
    var jobInfo : [ViewCompanyInfo]!
    var nearByJobsInfo :[NearByJobsDataArray]!
    var nearBySwitch : String!
    var nearbySectionTitle: String!
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        compInfo = [viewCompInfo]()
        if let compInfoArray = dictionary["comp_info"] as? [[String:Any]]{
            for dic in compInfoArray{
                let value = viewCompInfo(fromDictionary: dic)
                compInfo.append(value)
            }
        }
        extras = [ViewJobExtra]()
        if let extrasArray = dictionary["extras"] as? [[String:Any]]{
            for dic in extrasArray{
                let value = ViewJobExtra(fromDictionary: dic)
                extras.append(value)
            }
        }
        jobContent = [VIewJobContent]()
        if let jobContentArray = dictionary["job_content"] as? [[String:Any]]{
            for dic in jobContentArray{
                let value = VIewJobContent(fromDictionary: dic)
                jobContent.append(value)
            }
        }
        jobInfo = [ViewCompanyInfo]()
        if let jobInfoArray = dictionary["job_info"] as? [[String:Any]]{
            for dic in jobInfoArray{
                let value = ViewCompanyInfo(fromDictionary: dic)
                jobInfo.append(value)
            }
        }
        nearByJobsInfo = [NearByJobsDataArray]()
        if let nearbyJobsData = dictionary["nearby_jobs"] as? [[String:Any]]{
            for dic in nearbyJobsData{
                let value = NearByJobsDataArray(fromDictionary: dic)
                nearByJobsInfo.append(value)
            }
        }
        nearBySwitch = dictionary["nearby_jobs_switch"] as? String
        nearbySectionTitle =  dictionary["nearby_section_heading"] as? String
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if compInfo != nil{
            var dictionaryElements = [[String:Any]]()
            for compInfoElement in compInfo {
                dictionaryElements.append(compInfoElement.toDictionary())
            }
            dictionary["comp_info"] = dictionaryElements
        }
        if extras != nil{
            var dictionaryElements = [[String:Any]]()
            for extrasElement in extras {
                dictionaryElements.append(extrasElement.toDictionary())
            }
            dictionary["extras"] = dictionaryElements
        }
        if jobContent != nil{
            var dictionaryElements = [[String:Any]]()
            for jobContentElement in jobContent {
                dictionaryElements.append(jobContentElement.toDictionary())
            }
            dictionary["job_content"] = dictionaryElements
        }
        if jobInfo != nil{
            var dictionaryElements = [[String:Any]]()
            for jobInfoElement in jobInfo {
                dictionaryElements.append(jobInfoElement.toDictionary())
            }
            dictionary["job_info"] = dictionaryElements
        }
        if nearByJobsInfo != nil{
            var dictionaryElements = [[String:Any]]()
            for NearbyInfoElement in nearByJobsInfo {
                dictionaryElements.append(NearbyInfoElement.toDictionary())
            }
            dictionary["nearby_jobs"] = dictionaryElements
        }
        return dictionary
    }
    
}
