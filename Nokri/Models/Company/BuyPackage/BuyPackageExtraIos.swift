//
//  BuyPackageExtraIos.swift
//  Nokri
//
//  Created by Furqan Nadeem on 23/01/2019.
//  Copyright © 2019 Furqan Nadeem. All rights reserved.
//

import Foundation

struct BuyPackageExtraIos{
    
    var title_text : String!
    var payment_type : String!
    var in_app_on : Bool!
    var secret_code : String!
   
    init(fromDictionary dictionary: [String:Any]){
         title_text = dictionary["title_text"] as? String
         payment_type = dictionary["payment_type"] as? String
         in_app_on = dictionary["in_app_on"] as? Bool
         secret_code = dictionary["secret_code"] as? String
        
    }

    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if title_text != nil{
            dictionary["title_text"] = title_text
        }
        if payment_type != nil{
            dictionary["payment_type"] = payment_type
        }
        if in_app_on != nil{
            dictionary["in_app_on"] = in_app_on
        }
        if secret_code != nil{
            dictionary["secret_code"] = secret_code
        }
        
        return dictionary
    }
    
}
