//
//  Education.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 8/6/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import Foundation

struct Education {
    
    var educationId: Int!
    var educationFields: [EducationField]!
    
    public init() {}
    
    init(fromDictionary dictionary: [[String:Any]]){
        educationFields = [EducationField]()
        for dic in dictionary{
            let value = EducationField(fromDictionary: dic)
            educationFields.append(value)
        }
    }

}
