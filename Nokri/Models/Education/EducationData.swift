//
//  EducationData.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 8/6/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import Foundation

struct EducationData{
    
    var education : [Education]!
    var extras : [EducationField]!
    
    init(fromDictionary dictionary: [String:Any]){

        if let educationArray = dictionary["education"] as? [Any] {
            education = [Education]()
            for dic in educationArray {
                let currentEducation = Education(fromDictionary: dic as! [[String:Any]])
                education.append(currentEducation)
            }
        }
        
        extras = [EducationField]()
        if let extrasArray = dictionary["extras"] as? [[String:Any]]{
            for dic in extrasArray{
                let value = EducationField(fromDictionary: dic)
                extras.append(value)
            }
        }
    }
    
}
