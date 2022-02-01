//
//  BlogDetailComment.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 5/27/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import Foundation

struct  BlogDetailComment{
    
    var comments : [CommentBlogDetail]!
    var pagination : BlogDetailPagination!
   
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        
        comments = [CommentBlogDetail]()
        if let commentArray = dictionary["comments"] as? [[String:Any]]{
            for dic in commentArray{
                let value = CommentBlogDetail(fromDictionary: dic)
                comments.append(value)
            }
            
        }
        if let paginationData = dictionary["pagination"] as? [String:Any]{
            pagination = BlogDetailPagination(fromDictionary: paginationData)
        }
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if comments != nil{
            var dictionaryElements = [[String:Any]]()
            for replyElement in comments {
                dictionaryElements.append(replyElement.toDictionary())
            }
            dictionary["comments"] = dictionaryElements
        }
        if pagination != nil{
            dictionary["pagination"] = pagination.toDictionary()
        }
        return dictionary
    }
    
}
