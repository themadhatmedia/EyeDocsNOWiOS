//
//  RatingReviewsDataModel.swift
//  Nokri
//
//  Created by Apple on 28/12/2020.
//  Copyright © 2020 Furqan Nadeem. All rights reserved.
//

import Foundation
struct RatingReviewsDataModel {
    var  userReviewsData : UserReviewsData!
    init(fromDictionary dictionary: [String:Any]){
        if let dataData = dictionary["user_reviews"] as? [String:Any]{
            userReviewsData = UserReviewsData(fromDictionary: dataData)
        }
    }
    
}
