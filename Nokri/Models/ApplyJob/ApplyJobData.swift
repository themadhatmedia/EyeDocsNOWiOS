//
//  ApplyJobData.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 8/21/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import Foundation

struct ApplyJobData{
    
    var info : [ApplyJobInfo]!
    var resumes : [ApplyJobResume]!
    var questions = [String]()
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        info = [ApplyJobInfo]()
        if let infoArray = dictionary["info"] as? [[String:Any]]{
            for dic in infoArray{
                let value = ApplyJobInfo(fromDictionary: dic)
                info.append(value)
            }
        }
        resumes = [ApplyJobResume]()
        if let resumesArray = dictionary["resumes"] as? [[String:Any]]{
            for dic in resumesArray{
                let value = ApplyJobResume(fromDictionary: dic)
                resumes.append(value)
            }
        }
        questions = [String]()
        if let resumesArray = dictionary["job_questions"] as? Array<Any>{
//                   for dic in resumesArray{
//                    let value = String(describing: dic)
//                       questions.append(value)
//                   }
                
            questions = resumesArray as! [String]
                
               }
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if info != nil{
            var dictionaryElements = [[String:Any]]()
            for infoElement in info {
                dictionaryElements.append(infoElement.toDictionary())
            }
            dictionary["info"] = dictionaryElements
        }
        if resumes != nil{
            var dictionaryElements = [[String:Any]]()
            for resumesElement in resumes {
                dictionaryElements.append(resumesElement.toDictionary())
            }
            dictionary["resumes"] = dictionaryElements
        }
        return dictionary
    }
    
}
