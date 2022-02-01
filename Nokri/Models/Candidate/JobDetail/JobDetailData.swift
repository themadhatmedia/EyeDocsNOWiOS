//
//  JobDetailData.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 6/21/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import Foundation

struct JobDetailData{
    
    var compInfo : [jobDetailCompInfo]!
    var extras : [jobDetailCompInfo]!
    var jobContent : [jobDetailCompInfo]!
    var jobInfo : [jobDetailCompInfo]!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        compInfo = [jobDetailCompInfo]()
        if let compInfoArray = dictionary["comp_info"] as? [[String:Any]]{
            for dic in compInfoArray{
                let value = jobDetailCompInfo(fromDictionary: dic)
                compInfo.append(value)
            }
        }
        extras = [jobDetailCompInfo]()
        if let extrasArray = dictionary["extras"] as? [[String:Any]]{
            for dic in extrasArray{
                let value = jobDetailCompInfo(fromDictionary: dic)
                extras.append(value)
            }
        }
        jobContent = [jobDetailCompInfo]()
        if let jobContentArray = dictionary["job_content"] as? [[String:Any]]{
            for dic in jobContentArray{
                let value = jobDetailCompInfo(fromDictionary: dic)
                jobContent.append(value)
            }
        }
        jobInfo = [jobDetailCompInfo]()
        if let jobInfoArray = dictionary["job_info"] as? [[String:Any]]{
            for dic in jobInfoArray{
                let value = jobDetailCompInfo(fromDictionary: dic)
                jobInfo.append(value)
            }
        }
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
        return dictionary
    }
    
}
