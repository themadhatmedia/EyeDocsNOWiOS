//
//  Certification.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 8/9/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import Foundation

struct Certification {
    
    var certificationId: Int!
    var certificationFields: [CertificationField]!
    
    public init() {}
    
    init(fromDictionary dictionary: [[String:Any]]){
        certificationFields = [CertificationField]()
        for dic in dictionary{
            let value = CertificationField(fromDictionary: dic)
            certificationFields.append(value)
        }
    }
}
