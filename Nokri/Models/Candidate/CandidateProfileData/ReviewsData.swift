//
//  ReviewsData.swift
//  Nokri
//
//  Created by Apple on 24/12/2020.
//  Copyright © 2020 Furqan Nadeem. All rights reserved.
//

import Foundation
struct  ReviewsData {
    var ratingService : String!
    var ratingProcess : String!
    var ratingSelecttion : String!
    var ratingAverage : Int!
    var ratingTitle : String!
    var ratingDescription : String!
    var ratingPoster:String!
    var ratingDate: String!
    var canReply : Bool!
    var replyBtnText: String!
    var userImage: String!
    var commentId: String!
    var hasReply: Bool!
    var repliedTxt: String!
    var repliedHeadingTxt:String!
    
    init(fromDictionary dictionary: [String:Any]){
        ratingService = dictionary["_rating_service"] as? String
        ratingProcess = dictionary["_rating_proces"] as? String
        ratingSelecttion = dictionary["_rating_selection"] as? String
        ratingAverage = dictionary["_rating_avg"] as? Int
        ratingTitle = dictionary["_rating_title"] as? String
        ratingDescription = dictionary["_rating_description"] as? String
        ratingPoster = dictionary["_rating_poster"] as? String
        ratingDate = dictionary["_rating_date"] as? String
        canReply = dictionary["can_reply"] as? Bool
        userImage = dictionary["emp_image"] as? String
        commentId = dictionary["cid"] as? String
        hasReply = dictionary["has_reply"] as? Bool
        repliedTxt = dictionary["reply_text"] as? String
        repliedHeadingTxt = dictionary["reply_heading"] as? String
        //        replyBtnText = dictionary[""] as? String
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if ratingService != nil{
            dictionary["_rating_service"] = ratingService
        }
        if ratingProcess != nil{
            dictionary["_rating_proces"] = ratingProcess
        }
        if ratingSelecttion != nil{
            dictionary["_rating_selection"] = ratingSelecttion
        }
        if ratingAverage != nil{
            dictionary["_rating_avg"] = ratingAverage
        }
        if ratingTitle != nil{
            dictionary["_rating_title"] = ratingTitle
        }
        if ratingDescription != nil{
            dictionary["_rating_description"] = ratingDescription
        }
        if ratingPoster != nil{
            dictionary["_rating_poster"] = ratingPoster
        }
        if ratingDate != nil{
            dictionary["_rating_date"] = ratingDate
        }
        if canReply != nil{
            dictionary["can_reply"] = canReply
        }
        
        return dictionary
    }
    
    
}
