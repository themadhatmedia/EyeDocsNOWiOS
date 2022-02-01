//
//  CertificationData.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 8/9/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import Foundation

struct CertificationData{
    
    var certification : [Certification]!
    var extras : [CertificationField]!
    
    init(fromDictionary dictionary: [String:Any]){
        
        if let educationArray = dictionary["certification"] as? [Any] {
            certification = [Certification]()
            for dic in educationArray {
                let currentEducation = Certification(fromDictionary: dic as! [[String:Any]])
                certification.append(currentEducation)
            }
        }
        
        extras = [CertificationField]()
        if let extrasArray = dictionary["extras"] as? [[String:Any]]{
            for dic in extrasArray{
                let value = CertificationField(fromDictionary: dic)
                extras.append(value)
            }
        }
    }
    
}
