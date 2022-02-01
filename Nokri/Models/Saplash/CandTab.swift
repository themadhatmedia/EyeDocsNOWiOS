//
//  CandTab.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 5/9/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import Foundation

struct CandTab{
    
    var certification : String!
    var education : String!
    var experience : String!
    var loca : String!
    var personal : String!
    var portfolio : String!
    var resumes : String!
    var skills : String!
    var socail : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        certification = dictionary["certification"] as? String
        education = dictionary["education"] as? String
        experience = dictionary["experience"] as? String
        loca = dictionary["loca"] as? String
        personal = dictionary["personal"] as? String
        portfolio = dictionary["portfolio"] as? String
        resumes = dictionary["resumes"] as? String
        skills = dictionary["skills"] as? String
        socail = dictionary["socail"] as? String
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if certification != nil{
            dictionary["certification"] = certification
        }
        if education != nil{
            dictionary["education"] = education
        }
        if experience != nil{
            dictionary["experience"] = experience
        }
        if loca != nil{
            dictionary["loca"] = loca
        }
        if personal != nil{
            dictionary["personal"] = personal
        }
        if portfolio != nil{
            dictionary["portfolio"] = portfolio
        }
        if resumes != nil{
            dictionary["resumes"] = resumes
        }
        if skills != nil{
            dictionary["skills"] = skills
        }
        if socail != nil{
            dictionary["socail"] = socail
        }
        return dictionary
    }
    
}
