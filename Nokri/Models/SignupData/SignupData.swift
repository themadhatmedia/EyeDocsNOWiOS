//
//  SignupData.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 5/7/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import Foundation

struct SignupData{
    
    var bgColor : String!
    var emailPlaceholder : String!
    var facebookBtn : String!
    var formBtn : String!
    var googleBtn : String!
    var heading : String!
    var loginText : String!
    var logo : String!
    var namePlaceholder : String!
    var passwordPlaceholder : String!
    var phonePlaceholder : String!
    var separator : String!
    var switchCand : String!
    var switchEmp : String!
    var termsText : String!
    var adminCanPost : String!
    var data : [JobPostCCustomData]!
    var checkPasswordStrengthBool: String!
    var passwordStrengthAlertMessage: String!
    var newsLetterShow: String!
    var newsLetterText: String!
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        bgColor = dictionary["bg_color"] as? String
        emailPlaceholder = dictionary["email_placeholder"] as? String
        facebookBtn = dictionary["facebook_btn"] as? String
        formBtn = dictionary["form_btn"] as? String
        googleBtn = dictionary["google_btn"] as? String
        heading = dictionary["heading"] as? String
        loginText = dictionary["login_text"] as? String
        logo = dictionary["logo"] as? String
        namePlaceholder = dictionary["name_placeholder"] as? String
        passwordPlaceholder = dictionary["password_placeholder"] as? String
        phonePlaceholder = dictionary["phone_placeholder"] as? String
        separator = dictionary["separator"] as? String
        switchCand = dictionary["switch_cand"] as? String
        switchEmp = dictionary["switch_emp"] as? String
        termsText = dictionary["terms_text"] as? String
        adminCanPost = dictionary["is_admin_post"] as? String
        data = [JobPostCCustomData]()
        if let dataArray = dictionary["custom_fields"] as? [[String:Any]]{
            for dic in dataArray{
                let value = JobPostCCustomData(fromDictionary: dic)
                data.append(value)
            }
        }
        checkPasswordStrengthBool = dictionary["is_password_strength"] as? String
        passwordStrengthAlertMessage = dictionary["password_strength_text"] as? String
        newsLetterShow = dictionary["is_newsletter"] as? String
        newsLetterText = dictionary["newsletter-text"] as? String
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if bgColor != nil{
            dictionary["bg_color"] = bgColor
        }
        if emailPlaceholder != nil{
            dictionary["email_placeholder"] = emailPlaceholder
        }
        if facebookBtn != nil{
            dictionary["facebook_btn"] = facebookBtn
        }
        if formBtn != nil{
            dictionary["form_btn"] = formBtn
        }
        if googleBtn != nil{
            dictionary["google_btn"] = googleBtn
        }
        if heading != nil{
            dictionary["heading"] = heading
        }
        if loginText != nil{
            dictionary["login_text"] = loginText
        }
        if logo != nil{
            dictionary["logo"] = logo
        }
        if namePlaceholder != nil{
            dictionary["name_placeholder"] = namePlaceholder
        }
        if passwordPlaceholder != nil{
            dictionary["password_placeholder"] = passwordPlaceholder
        }
        if phonePlaceholder != nil{
            dictionary["phone_placeholder"] = phonePlaceholder
        }
        if separator != nil{
            dictionary["separator"] = separator
        }
        if switchCand != nil{
            dictionary["switch_cand"] = switchCand
        }
        if switchEmp != nil{
            dictionary["switch_emp"] = switchEmp
        }
        if termsText != nil{
            dictionary["terms_text"] = termsText
        }
        return dictionary
    }
    
}
