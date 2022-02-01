//
//  BuyPackageProduct.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 6/11/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import Foundation

struct BuyPackageProduct{
    
    var color : String!
    var daysText : String!
    var daysValue : String!
    var freeAdsText : String!
    var freeAdsValue : Int!
    var premiumJobs : [BuyPackagePremiumJob]!
    var bumpJobs : [BuyPackagePremiumJob]!
    var productBtn : String!
    var productId : String!
    var productLink : String!
    var productPrice : String!
    var productPriceOnly : String!
    var productPriceSign : String!
    var productQty : Int!
    var productTitle : String!
    var product_ios_inapp:String!
    var isFree:String!
    var candSearch:String!
    var candSearchValue:String!
    var jobs_left_text :String!
    var jobs_left_value:String!
    var feature_days_text:String!
    var feature_days_value:String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        color = dictionary["color"] as? String
        daysText = dictionary["days_text"] as? String
        daysValue = dictionary["days_value"] as? String
        freeAdsText = dictionary["free_ads_text"] as? String
        isFree = dictionary["is_free"] as? String
        freeAdsValue = dictionary["free_ads_value"] as? Int
        premiumJobs = [BuyPackagePremiumJob]()
        if let premiumJobsArray = dictionary["premium_jobs"] as? [[String:Any]]{
            for dic in premiumJobsArray{
                let value = BuyPackagePremiumJob(fromDictionary: dic)
                premiumJobs.append(value)
            }
        }
        bumpJobs = [BuyPackagePremiumJob]()
        if let bumpJobsArray = dictionary["bump_jobs"] as? [[String:Any]]{
            for dic in bumpJobsArray{
                let value = BuyPackagePremiumJob(fromDictionary: dic)
                bumpJobs.append(value)
            }
        }

        productBtn = dictionary["product_btn"] as? String
        productId = dictionary["product_id"] as? String
        productLink = dictionary["product_link"] as? String
        productPrice = dictionary["product_price"] as? String
        productPriceOnly = dictionary["product_price_only"] as? String
        productPriceSign = dictionary["product_price_sign"] as? String
        productQty = dictionary["product_qty"] as? Int
        productTitle = dictionary["product_title"] as? String
        candSearch = dictionary["cand_search"] as? String
        candSearchValue = dictionary["cand_search_value"] as? String
        product_ios_inapp = dictionary["product_ios_inapp"] as? String
        jobs_left_text = dictionary["jobs_left_text"] as? String
        jobs_left_value = dictionary["jobs_left_value"] as? String
        //feature_days_text = dictionary["feature_days_text"] as? String
        //feature_days_value = dictionary["feature_days_value"] as? String
        feature_days_text = dictionary["cand_search"] as? String
        feature_days_value = dictionary["cand_search_value"] as? String
        
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if color != nil{
            dictionary["color"] = color
        }
        if daysText != nil{
            dictionary["days_text"] = daysText
        }
        if daysValue != nil{
            dictionary["days_value"] = daysValue
        }
        if freeAdsText != nil{
            dictionary["free_ads_text"] = freeAdsText
        }
        if freeAdsValue != nil{
            dictionary["free_ads_value"] = freeAdsValue
        }
        if isFree != nil{
            dictionary["isFree"] = isFree
        }
        if premiumJobs != nil{
            var dictionaryElements = [[String:Any]]()
            for premiumJobsElement in premiumJobs {
                dictionaryElements.append(premiumJobsElement.toDictionary())
            }
            dictionary["premium_jobs"] = dictionaryElements
        }
        if productBtn != nil{
            dictionary["product_btn"] = productBtn
        }
        if productId != nil{
            dictionary["product_id"] = productId
        }
        if productLink != nil{
            dictionary["product_link"] = productLink
        }
        if productPrice != nil{
            dictionary["product_price"] = productPrice
        }
        if productPriceOnly != nil{
            dictionary["product_price_only"] = productPriceOnly
        }
        if productPriceSign != nil{
            dictionary["product_price_sign"] = productPriceSign
        }
        if productQty != nil{
            dictionary["product_qty"] = productQty
        }
        if productTitle != nil{
            dictionary["product_title"] = productTitle
        }
        if  product_ios_inapp != nil{
            dictionary["product_ios_inapp"] = productTitle
        }
        return dictionary
    }
    
}
