//
//  LoginData.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 5/7/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import Foundation

struct LoginData{
    
    var bgColor : String!
    var emailPlaceholder : String!
    var facebookBtn : String!
    var facebookSwitch : String!
    var forgotText : String!
    var formBtn : String!
    var googleBtn : String!
    var googleSwitch : String!
    var appleBtn : String!
    var appleSwitch : String!
    var heading : String!
    var linkedinBtn : String!
    var linkedinSwitch : String!
    var logo : String!
    var passwordPlaceholder : String!
    var registerText : String!
    var registerText2 : String!
    var separator : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        bgColor = dictionary["bg_color"] as? String
        emailPlaceholder = dictionary["email_placeholder"] as? String
        facebookBtn = dictionary["facebook_btn"] as? String
        facebookSwitch = dictionary["facebook_switch"] as? String
        forgotText = dictionary["forgot_text"] as? String
        formBtn = dictionary["form_btn"] as? String
        googleBtn = dictionary["google_btn"] as? String
        googleSwitch = dictionary["google_switch"] as? String
        appleBtn = dictionary["Apple_btn"] as? String
        appleSwitch = dictionary["Apple_switch"] as? String
        heading = dictionary["heading"] as? String
        linkedinBtn = dictionary["linkedin_btn"] as? String
        linkedinSwitch = dictionary["linkedin_switch"] as? String
        logo = dictionary["logo"] as? String
        passwordPlaceholder = dictionary["password_placeholder"] as? String
        registerText = dictionary["register_text"] as? String
        registerText2 = dictionary["register_text2"] as? String
        separator = dictionary["separator"] as? String
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
        if facebookSwitch != nil{
            dictionary["facebook_switch"] = facebookSwitch
        }
        if forgotText != nil{
            dictionary["forgot_text"] = forgotText
        }
        if formBtn != nil{
            dictionary["form_btn"] = formBtn
        }
        if googleBtn != nil{
            dictionary["google_btn"] = googleBtn
        }
        if googleSwitch != nil{
            dictionary["google_switch"] = googleSwitch
        }
        if heading != nil{
            dictionary["heading"] = heading
        }
        if linkedinBtn != nil{
            dictionary["linkedin_btn"] = linkedinBtn
        }
        if linkedinSwitch != nil{
            dictionary["linkedin_switch"] = linkedinSwitch
        }
        if logo != nil{
            dictionary["logo"] = logo
        }
        if passwordPlaceholder != nil{
            dictionary["password_placeholder"] = passwordPlaceholder
        }
        if registerText != nil{
            dictionary["register_text"] = registerText
        }
        if registerText2 != nil{
            dictionary["register_text2"] = registerText2
        }
        if separator != nil{
            dictionary["separator"] = separator
        }
        return dictionary
    }
    
}
