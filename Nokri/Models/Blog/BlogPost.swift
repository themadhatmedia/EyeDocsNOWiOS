//
//  BlogPost.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 5/27/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import Foundation

struct BlogPost{
    
    var cats : [BlogCat]!
    var comments : String!
    var commentInt : Int!
    var date : String!
    var excerpt : String!
    var hasImage : Bool!
    var image : String!
    var postId : Int!
    var readMore : String!
    var title : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        cats = [BlogCat]()
        if let catsArray = dictionary["cats"] as? [[String:Any]]{
            for dic in catsArray{
                let value = BlogCat(fromDictionary: dic)
                cats.append(value)
            }
        }
        comments = dictionary["comments"] as? String
        commentInt = dictionary["comments"] as? Int
        date = dictionary["date"] as? String
        excerpt = dictionary["excerpt"] as? String
        hasImage = dictionary["has_image"] as? Bool
        image = dictionary["image"] as? String
        postId = dictionary["post_id"] as? Int
        readMore = dictionary["read_more"] as? String
        title = dictionary["title"] as? String
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if cats != nil{
            var dictionaryElements = [[String:Any]]()
            for catsElement in cats {
                dictionaryElements.append(catsElement.toDictionary())
            }
            dictionary["cats"] = dictionaryElements
        }
        if comments != nil{
            dictionary["comments"] = comments
        }
        if commentInt != nil{
            dictionary["comments"] = commentInt
        }
        if date != nil{
            dictionary["date"] = date
        }
        if excerpt != nil{
            dictionary["excerpt"] = excerpt
        }
        if hasImage != nil{
            dictionary["has_image"] = hasImage
        }
        if image != nil{
            dictionary["image"] = image
        }
        if postId != nil{
            dictionary["post_id"] = postId
        }
        if readMore != nil{
            dictionary["read_more"] = readMore
        }
        if title != nil{
            dictionary["title"] = title
        }
        return dictionary
    }
    
}
