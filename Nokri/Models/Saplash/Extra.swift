//
//  dashBoardEx
//  Opportunities
//
//  Created by Furqan Nadeem on 5/9/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import Foundation

struct splashExtra{
    
    var nxtStep : String!
    var stripePkey : String!
    var stripeSkey : String!
    var isLogin : String!
    var allField : String!
    var no_url : String!
    var comment : String!
    var reply : String!
    var validEmail : String!
    var agreeTerm : String!
    var invalid_url : String!
    var camera : String!  
    var gallery : String!
    var cameraNot : String!
    var galleryNot : String!
    var select : String!
    var setting : String!
    var isEmployerLogin : String!
    var JobTitle : String!
    var JobDes : String!
    var JobVec : String!
    var JobLoc : String!
    var JobSkill : String!
    var tag : String!
    var saved_resumes : String!
    var view_profile : String!
    var remove_resume : String!
    var jobalert : String!
    var jobalertdetail : String!
    var alertName : String!
    var yourEmail : String!
    var selectEmailFreq : String!
    var jobCat : String!
    var matched_resume : String!
    var gotologin : String!
    var jobsFor : String!
    var notifypage : String!
    var external_link :String!
    var external_email_link : String!
    var btnConfirm:String!
    var btnCancel:String!
    var confTitle:String!
    var confContent:String!
    var skillT:String!
    var select_opt:String!
    var employerSearch:String!
    var linkedinurl:String!
    var listStyle:String!
    var candMap:Bool!
    var empMap:Bool!
    var applied:String!
    var missMatch:String!
    var pass_confirm:String!
    var whtsapp:String!
    var lang_choose:String!
    var lang:String!
    var lang_desc:String!
    var skip:String!
    var isPaidAlert:String!
    var radius:String!
    var lat:String!
    var long:String!
    var customLocation:String!
    var port_video:String!
    var resume_video:String!
    var upload_resume_txt:String!
    var unable_to_get:String!
    
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        nxtStep = dictionary["nxt_step"] as? String
        stripePkey = dictionary["stripe_Pkey"] as? String
        stripeSkey = dictionary["stripe_Skey"] as? String
        isLogin = dictionary["is_login"] as? String
        isEmployerLogin = dictionary["is_login_emp"] as? String
        allField = dictionary["all_fields"] as? String
        reply = dictionary["rply_first"] as? String
        validEmail = dictionary["valid_email"] as? String
        agreeTerm = dictionary["agree_term"] as? String
        invalid_url = dictionary["invalid_url"] as? String
        comment = dictionary["coment_first"] as? String
        camera = dictionary["camera_txt"] as? String
        gallery = dictionary["gallery_txt"] as? String
        cameraNot = dictionary["not_camera"] as? String
        galleryNot = dictionary["not_gallery"] as? String
        select = dictionary["select"] as? String
        setting = dictionary["settings_txt"] as? String
        JobTitle = dictionary["job_title"] as? String
        JobDes = dictionary["job_desc"] as? String
        JobVec = dictionary["job_vacan"] as? String
        JobLoc = dictionary["job_loc"] as? String
        JobSkill = dictionary["select_one"] as? String
        tag = dictionary["job_tag"] as? String
        saved_resumes = dictionary["saved_resumes"] as? String
        view_profile = dictionary["view_profile"] as? String
        remove_resume = dictionary["remove_resume"] as? String
        jobalert = dictionary["job_alerts_btn"] as? String
        jobalertdetail = dictionary["job_alerts_tagline"] as? String
        alertName = dictionary["alert_name"] as? String
        yourEmail = dictionary["alert_email"] as? String
        selectEmailFreq = dictionary["email_freq_plc"] as? String
        jobCat = dictionary["job_category_plc"] as? String
        matched_resume = dictionary["matched_resume"] as? String
        gotologin = dictionary["log_txt"] as? String
        jobsFor = dictionary["Jobs_for"] as? String
        notifypage = dictionary["notify_page"] as? String
        external_link = dictionary["external_link"] as? String
        external_email_link = dictionary["external_email_link"] as? String
        confTitle = dictionary["ext_confrim_title"] as? String
        confContent = dictionary["ext_confirm_content"] as? String
        btnConfirm = dictionary["ext_confirm_btn"] as? String
        btnCancel = dictionary["ext_cancel_btn"] as? String
        skillT = dictionary["skill_txt"] as? String
        select_opt = dictionary["select_opt"] as? String
        employerSearch = dictionary["emp_search_txt"] as? String
        linkedinurl = dictionary["enter_linked_url"] as? String
        listStyle = dictionary["app_style_check"] as? String
        applied = dictionary["have_applied"] as? String
        candMap = dictionary["cand_map_switch"] as? Bool
        empMap = dictionary["emp_map_switch"] as? Bool
        missMatch = dictionary["password_mismatch"] as? String
        pass_confirm = dictionary["pass_confirm"] as? String
        whtsapp = dictionary["enter_whatsapp"] as? String
        lang = dictionary["lang"] as? String
        lang_choose = dictionary["lang_choose"] as? String
        lang_desc = dictionary["lang_desc"] as? String
        skip = dictionary["skip"] as? String
        isPaidAlert = dictionary["is_paid_alert"] as? String
        radius = dictionary["radius"] as? String
        lat = dictionary["lat"] as? String
        long = dictionary["long"] as? String
        customLocation = dictionary["geo_location"] as? String
        port_video = dictionary["port_video"] as? String
        resume_video = dictionary["resume_video"] as? String
        upload_resume_txt = dictionary["upload_resume_txt"] as? String
        unable_to_get = dictionary["unable_to_get"] as? String
        
    }
   
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if nxtStep != nil{
            dictionary["nxt_step"] = nxtStep
        }
        if stripePkey != nil{
            dictionary["stripe_Pkey"] = stripePkey
        }
        if stripeSkey != nil{
            dictionary["stripe_Skey"] = stripeSkey
        }
        if setting != nil{
            dictionary["settings_txt"] = setting
        }
        return dictionary
    }
    
}

