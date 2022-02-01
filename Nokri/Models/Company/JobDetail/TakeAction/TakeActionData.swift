//
//  TakeActionData.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 8/13/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import Foundation

struct TakeActionData{
    
    var emailData : [EmailData]!
    var extra : [TakeActionExtra]!
   
    init(fromDictionary dictionary: [String:Any]){
        emailData = [EmailData]()
        if let emailDataArray = dictionary["email_data"] as? [[String:Any]]{
            for dic in emailDataArray{
                let value = EmailData(fromDictionary: dic)
                emailData.append(value)
            }
        }
        extra = [TakeActionExtra]()
        if let extraArray = dictionary["extra"] as? [[String:Any]]{
            for dic in extraArray{
                let value = TakeActionExtra(fromDictionary: dic)
                extra.append(value)
            }
        }
    }
   
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if emailData != nil{
            var dictionaryElements = [[String:Any]]()
            for emailDataElement in emailData {
                dictionaryElements.append(emailDataElement.toDictionary())
            }
            dictionary["email_data"] = dictionaryElements
        }
        if extra != nil{
            var dictionaryElements = [[String:Any]]()
            for extraElement in extra {
                dictionaryElements.append(extraElement.toDictionary())
            }
            dictionary["extra"] = dictionaryElements
        }
        return dictionary
    }
    
}
