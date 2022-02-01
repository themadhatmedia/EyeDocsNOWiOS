//
//  RatingsReviews.swift
//  Nokri
//
//  Created by Apple on 28/12/2020.
//  Copyright © 2020 Furqan Nadeem. All rights reserved.
//

import Foundation
struct RatingsReviews {
    
    //    var  userReviewsData : UserReviewsData!
    var success: Bool!
    var data : RatingReviewsDataModel!
    var message: String!
    
    init(fromDictionary dictionary: [String:Any]){
        if let dataData = dictionary["data"] as? [String:Any]{
            data = RatingReviewsDataModel(fromDictionary: dataData)
        }
        success = dictionary["success"] as? Bool
        message = dictionary["message"] as? String
        
    }
}
