//
//  EducationField.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 8/6/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import Foundation
struct EducationField{
    
    var column : String!
    var fieldTypeName : String!
    var fieldname : String!
    var isRequired : String!
    var key : String!
    var value : String!
        
    init(fromDictionary dictionary: [String:Any]){
        column = dictionary["column"] as? String
        fieldTypeName = dictionary["field_type_name"] as? String
        fieldname = dictionary["fieldname"] as? String
        isRequired = dictionary["is_required"] as? String
        key = dictionary["key"] as? String
        value = dictionary["value"] as? String
    }
    
}
