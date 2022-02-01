//
//  Experience.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 8/9/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import Foundation
struct Experience {
    
    var educationId: Int!
    var experienceFields: [ExperienceField]!
    
    public init() {}
    
    init(fromDictionary dictionary: [[String:Any]]){
        experienceFields = [ExperienceField]()
        for dic in dictionary{
            let value = ExperienceField(fromDictionary: dic)
            experienceFields.append(value)
        }
    }
    
}
