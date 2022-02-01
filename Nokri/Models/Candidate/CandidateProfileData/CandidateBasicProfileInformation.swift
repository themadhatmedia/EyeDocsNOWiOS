//
//  CandidateBasicProfileInformation.swift
//  Nokri
//
//  Created by Apple on 21/12/2020.
//  Copyright © 2020 Furqan Nadeem. All rights reserved.
//

import Foundation
struct CandidateBasicProfileInformation {
    var basicInfo : CandidateScheduledHourData!
    
    var  userReviewsData : UserReviewsData!
    var companyFollowShow: String!
    

    init(fromDictionary dictionary: [String:Any]){
        if let dataData = dictionary["basic_ifo"] as? [String:Any]{
            basicInfo = CandidateScheduledHourData(fromDictionary: dataData)
        }
        if let dataData = dictionary["user_reviews"] as? [String:Any]{
            userReviewsData = UserReviewsData(fromDictionary: dataData)
        }
    companyFollowShow = dictionary["is_follow_show"] as? String
    }
}
