//
//  ReviewExtraData.swift
//  Nokri
//
//  Created by Apple on 23/12/2020.
//  Copyright © 2020 Furqan Nadeem. All rights reserved.
//

import Foundation
struct ReviewExtraData {
    var writeReviewTitle: String!
    var firstRating: String!
    var secondRating: String!
    var thirdRating: String!
    var reviewTitle:String!
    var yourReview: String!
    var empId: Int!
    var loginFirst: String!
    var enterTitle: String!
    var enterMessage: String!
    var submit: String!
    var pageTitle: String!
    var replyBtnText: String!
    var cancelBtnText: String!
    var addReviewtext: String!
    var viewAll: String!
    init(fromDictionary dictionary: [String:Any]){
        writeReviewTitle = dictionary["reviews_title"] as? String
        firstRating = dictionary["first_rating"] as? String
        secondRating = dictionary["second_rating"] as? String
        thirdRating = dictionary["third_rating"] as? String
        reviewTitle = dictionary["title_review"] as? String
        yourReview = dictionary["your_review"] as? String
        empId = dictionary["cand_id"] as? Int
        loginFirst = dictionary["login_first"] as? String
        enterTitle = dictionary["enter_title"] as? String
        enterMessage = dictionary["enter_message"] as? String
        submit = dictionary["submit"] as? String
        pageTitle = dictionary["page_title"] as? String
        replyBtnText = dictionary["reply_btn_text"] as? String
        cancelBtnText = dictionary["cancel_btn"] as? String
        addReviewtext = dictionary["add_review"] as? String
        viewAll = dictionary["view_all"] as? String
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        
        
        return dictionary
    }
}
