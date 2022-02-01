//
//  SplashData.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 5/9/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import Foundation

struct SplashData{
    
    var candTabs : CandTab!
    var compnyPublicJobs : CompnyPublicJob!
    var empEditTabs : EmployeEditTab!
    var empJobs : EmployeJob!
    var empTabs : EmployeTab!
    var extra : splashExtra!
    var genericTxts : GenericTxt!
    var guestTabs : GuestTab!
    var menuActive : MenuActive!
    var menuJob : MenuJob!
    var menuResume : MenuResume!
    var menuSaved : MenuSaved!
    var progressTxt : ProgressText!
    var publicJobs : PublicJobTab!
    var tabs : CandidateTab!
    var adMob : AdMob!
    var aboutSap : AboutSaplash!
    var versionSap : VersionSap!
    var ratingSap : RatngSaplash!
    var shareSap : ShareSaplash!
    var privacySap : PrivacySaplash!
    var termSaplash : TermSaplash!
    var faqSaplash : FaqSaplash!
    var feedBackSaplash : FeedBackSaplash!
    var langData : [LangData]!
    var isRtl : String!
    var app_color:String!
    var logo:String!
    var isWpmlActive:Bool!
    var home:String!
    var isBlog:String!
    var job_form:Bool!
   
    
    init(fromDictionary dictionary: [String:Any]){
        if let candTabsData = dictionary["cand_tabs"] as? [String:Any]{
            candTabs = CandTab(fromDictionary: candTabsData)
        }
        print(dictionary)
        if let compnyPublicJobsData = dictionary["compny_public_jobs"] as? [String:Any]{
            compnyPublicJobs = CompnyPublicJob(fromDictionary: compnyPublicJobsData)
        }
        if let empEditTabsData = dictionary["emp_edit_tabs"] as? [String:Any]{
            empEditTabs = EmployeEditTab(fromDictionary: empEditTabsData)
        }
        if let empJobsData = dictionary["emp_jobs"] as? [String:Any]{
            empJobs = EmployeJob(fromDictionary: empJobsData)
        }
        if let empTabsData = dictionary["emp_tabs"] as? [String:Any]{
            empTabs = EmployeTab(fromDictionary: empTabsData)
        }
        if let extraData = dictionary["extra"] as? [String:Any]{
            extra = splashExtra(fromDictionary: extraData)
        }
        if let genericTxtsData = dictionary["generic_txts"] as? [String:Any]{
            genericTxts = GenericTxt(fromDictionary: genericTxtsData)
        }
        if let guestTabsData = dictionary["guest_tabs"] as? [String:Any]{
            guestTabs = GuestTab(fromDictionary: guestTabsData)
        }
        if let menuActiveData = dictionary["menu_active"] as? [String:Any]{
            menuActive = MenuActive(fromDictionary: menuActiveData)
        }
        if let menuJobData = dictionary["menu_job"] as? [String:Any]{
            menuJob = MenuJob(fromDictionary: menuJobData)
        }
        if let menuResumeData = dictionary["menu_resume"] as? [String:Any]{
            menuResume = MenuResume(fromDictionary: menuResumeData)
        }
        if let menuSavedData = dictionary["menu_saved"] as? [String:Any]{
            menuSaved = MenuSaved(fromDictionary: menuSavedData)
        }
        if let progressTxtData = dictionary["progress_txt"] as? [String:Any]{
            progressTxt = ProgressText(fromDictionary: progressTxtData)
        }
        if let publicJobsData = dictionary["public_jobs"] as? [String:Any]{
            publicJobs = PublicJobTab(fromDictionary: publicJobsData)
        }
        if let tabsData = dictionary["tabs"] as? [String:Any]{
            tabs = CandidateTab(fromDictionary: tabsData)
        }
        if let adData = dictionary["ads"] as? [String:Any]{
            adMob = AdMob(fromDictionary: adData)
        }
        if let aboutSapp = dictionary["about"] as? [String:Any]{
             aboutSap = AboutSaplash(fromDictionary: aboutSapp)
        }
        if let versionSapp = dictionary["version"] as? [String:Any]{
            versionSap = VersionSap(fromDictionary: versionSapp)
        }
        if let ratingSapp = dictionary["rating"] as? [String:Any]{
            ratingSap = RatngSaplash(fromDictionary: ratingSapp)
        }
        if let shareSapp = dictionary["share"] as? [String:Any]{
            shareSap = ShareSaplash(fromDictionary: shareSapp)
        }
        if let shareSapp = dictionary["share"] as? [String:Any]{
            shareSap = ShareSaplash(fromDictionary: shareSapp)
        }
        if let privacySapp = dictionary["privacy"] as? [String:Any]{
            privacySap = PrivacySaplash(fromDictionary: privacySapp)
        }
        if let termSapp = dictionary["terms_n_conditions"] as? [String:Any]{
            termSaplash = TermSaplash(fromDictionary: termSapp)
        }
        if let faqSapp = dictionary["faqs_section"] as? [String:Any]{
            faqSaplash = FaqSaplash(fromDictionary: faqSapp)
        }
        if let feedBack = dictionary["feedback"] as? [String:Any]{
            feedBackSaplash = FeedBackSaplash(fromDictionary: feedBack)
        }
        langData = [LangData]()
        if let langArr = dictionary["site_languages"] as? [[String:Any]]{
            for dic in langArr{
                let value = LangData(fromDictionary: dic)
                langData.append(value)
            }
        }
        
        isRtl = dictionary["is_rtl"] as? String
        app_color = dictionary["app_color"] as? String
        home = dictionary["home"] as? String
        isBlog = dictionary["isBlog"] as? String
        job_form = dictionary["job_form"] as? Bool
        isWpmlActive = dictionary["is_wpml_active"] as? Bool
        logo = dictionary["wpml_logo"] as? String
        
    }
    
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if candTabs != nil{
            dictionary["cand_tabs"] = candTabs.toDictionary()
        }
        if compnyPublicJobs != nil{
            dictionary["compny_public_jobs"] = compnyPublicJobs.toDictionary()
        }
        if empEditTabs != nil{
            dictionary["emp_edit_tabs"] = empEditTabs.toDictionary()
        }
        if empJobs != nil{
            dictionary["emp_jobs"] = empJobs.toDictionary()
        }
        if empTabs != nil{
            dictionary["emp_tabs"] = empTabs.toDictionary()
        }
        if extra != nil{
            dictionary["extra"] = extra.toDictionary()
        }
        if genericTxts != nil{
            dictionary["generic_txts"] = genericTxts.toDictionary()
        }
        if guestTabs != nil{
            dictionary["guest_tabs"] = guestTabs.toDictionary()
        }
        if menuActive != nil{
            dictionary["menu_active"] = menuActive.toDictionary()
        }
        if menuJob != nil{
            dictionary["menu_job"] = menuJob.toDictionary()
        }
        if menuResume != nil{
            dictionary["menu_resume"] = menuResume.toDictionary()
        }
        if menuSaved != nil{
            dictionary["menu_saved"] = menuSaved.toDictionary()
        }
        if progressTxt != nil{
            dictionary["progress_txt"] = progressTxt.toDictionary()
        }
        if publicJobs != nil{
            dictionary["public_jobs"] = publicJobs.toDictionary()
        }
        if tabs != nil{
            dictionary["tabs"] = tabs.toDictionary()
        }
        if adMob != nil{
            dictionary["ads"] = adMob.toDictionary()
        }
        if isRtl != nil{
            dictionary["is_rtl"] = isRtl
        }
        if app_color != nil{
            dictionary["app_color"] = app_color
        }
        if aboutSap != nil{
            dictionary["about"] = aboutSap
        }
        if versionSap != nil{
            dictionary["version"] = versionSap
        }
        if ratingSap != nil{
            dictionary["rating"] = ratingSap
        }
        if shareSap != nil{
            dictionary["share"] = shareSap
        }
        if privacySap != nil{
            dictionary["privacy"] = privacySap
        }
        if termSaplash != nil{
            dictionary["terms_n_conditions"] = termSaplash
        }
        if faqSaplash != nil{
            dictionary["faqs_section"] = faqSaplash
        }
        if feedBackSaplash != nil{
            dictionary["feedback"] = feedBackSaplash
        }
        if home != nil{
            dictionary["home"] = isRtl
        }
        if isBlog != nil{
            dictionary["isBlog"] = isRtl
        }
       
        return dictionary
    }
    
}
