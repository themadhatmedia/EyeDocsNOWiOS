//
//  UserReviewsData.swift
//  Nokri
//
//  Created by Apple on 23/12/2020.
//  Copyright © 2020 Furqan Nadeem. All rights reserved.
//

import Foundation
struct UserReviewsData {
    var reviewsArray : [ReviewsData]
    var extra : ReviewExtraData!
    init(fromDictionary dictionary: [String:Any]){
        reviewsArray = [ReviewsData]()
        if let daysArray = dictionary["reviews_data"] as? [[String:Any]]{
            for dic in daysArray{
                let value = ReviewsData(fromDictionary: dic)
                reviewsArray.append(value)
            }
        }
        
        if let dataData = dictionary["extra"] as? [String:Any]{
            extra = ReviewExtraData(fromDictionary: dataData)
        }
        //        extra = dictionary["extra"] as? String
        
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        //        if extra != nil{
        //            dictionary["extra"] = extra
        //        }
        
        return dictionary
    }
    
}
