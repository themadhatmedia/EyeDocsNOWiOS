//
//  ProgressText.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 5/9/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import Foundation

struct  ProgressText{
    
    var btnOk : String!
    var msgFail : String!
    var msgSuccess : String!
    var title : String!
    var titleFail : String!
    var titleSuccess : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        btnOk = dictionary["btn_ok"] as? String
        msgFail = dictionary["msg_fail"] as? String
        msgSuccess = dictionary["msg_success"] as? String
        title = dictionary["title"] as? String
        titleFail = dictionary["title_fail"] as? String
        titleSuccess = dictionary["title_success"] as? String
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if btnOk != nil{
            dictionary["btn_ok"] = btnOk
        }
        if msgFail != nil{
            dictionary["msg_fail"] = msgFail
        }
        if msgSuccess != nil{
            dictionary["msg_success"] = msgSuccess
        }
        if title != nil{
            dictionary["title"] = title
        }
        if titleFail != nil{
            dictionary["title_fail"] = titleFail
        }
        if titleSuccess != nil{
            dictionary["title_success"] = titleSuccess
        }
        return dictionary
    }
    
}
