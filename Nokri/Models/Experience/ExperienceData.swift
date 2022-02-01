//
//  ExperienceData.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 8/9/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import Foundation

struct ExperienceData{
    
    var experience : [Experience]!
    var extras : [ExperienceField]!
    
    init(fromDictionary dictionary: [String:Any]){
        
        if let educationArray = dictionary["profession"] as? [Any] {
            experience = [Experience]()
            for dic in educationArray {
                let currentEducation = Experience(fromDictionary: dic as! [[String:Any]])
                experience.append(currentEducation)
            }
        }
        
        extras = [ExperienceField]()
        if let extrasArray = dictionary["extras"] as? [[String:Any]]{
            for dic in extrasArray{
                let value = ExperienceField(fromDictionary: dic)
                extras.append(value)
            }
        }
    }
    
}
