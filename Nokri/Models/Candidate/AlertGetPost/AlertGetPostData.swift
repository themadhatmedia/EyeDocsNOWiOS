//
//  AlertGetPostData.swift
//  Nokri
//
//  Created by Apple on 13/10/2020.
//  Copyright © 2020 Furqan Nadeem. All rights reserved.
//

import Foundation

struct AlertGetPostData{
    
    var product : String!
    var price : String!
    var subTotal : String!
    var vat : String!
    var productValue : String!
    var priceValue : String!
    var subTotalValue : String!
    var vatValue : String!
    var id :String!
    var buy:String!
    var title:String!
    
    init(fromDictionary dictionary: [String:Any]){
        product = dictionary["product"] as? String
        price = dictionary["price"] as? String
        subTotal = dictionary["subTotal"] as? String
        vat = dictionary["subTotal"] as? String
        productValue = dictionary["productVal"] as? String
        priceValue = dictionary["priceVal"] as? String
        subTotalValue = dictionary["subTotalVal"] as? String
        vatValue = dictionary["vatVal"] as? String
        id = dictionary["pkgId"] as? String
        buy = dictionary["buy"] as? String
        title = dictionary["page_title"] as? String
    }
    
}
