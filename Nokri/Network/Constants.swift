//
//  Constants.swift
//  AdForest
//
//  Created by apple on 3/8/18.
//  Copyright © 2018 apple. All rights reserved.
//

import Foundation
import UIKit

import DeviceKit

class Constants {
    struct  URL {
        
        
        
        
        static let ipAddress = "https://www.yourdomainname.com/"
        
        static let baseUrl =  ipAddress + "wp-json/nokri/v1/"
        
        static let signup = "register"
        static let login = "login/"
        static let forgotPassword = "forgot/"
        static let candidateDashboard = "canidate/dashboard/"
        static let setAcount = "set_acount/"
        static let saplashData = "candidate/dashboard_tabs/"
        static let companyDashboard = "employer/get_profile/"
        static let companyBasicInfo = "employer/update_personal_info/"
        static let changePassword = "reset_password/"
        static let specializationCompany = "employer/update_skills/"
        static let socialLinks = "employer/update_social_link/"
        static let location = "employer/update_location/"
        static let folower = "employer/company_followers/"
        static let activeJob = "employer/active_jobs/"
        static let inActiveThisJob = "employer/inactive_this_job/"
        static let inActiveJob = "employer/inactive_jobs/"
        static let activeThisJob = "employer/active_this_job/"
        //-->> For Filter Jobs
        static let filterJob = "employer/active_jobs/"
        //----->>>
        static let emailTemplate = "employer/view_template/"
        static let deleteEmplTemp = "employer/del_email_temp/"
        static let addTempEmployer = "employer/email_template/"
        static let followerDell = "employer/company_del_followers/"
        static let packageDetail = "employer/package_details/"
        static let candPackageDetail = "candidate/package_details/"
        
        
        static let jobDelete = "employer/del_this_job/"
        static let resDelete = "employer/del_this_candidate/"
        static let resumeReceived = "employer/resumes_recieved/"
        static let blog = "posts/"
        static let blogDetail = "posts/detail/"
        static let jobDetail = "view_job/"
        static let candidateProfile = "candidate/public_profile/"
        static let jobPost = "employer/job_post/"
        static let childCat = "child_cats/"
        static let dynamicFields = "employer/job_post/dynamic_fields/"
        static let countryCat = "city_state/"
        static let faq = "faqs/"
        static let buyPackage = "packages/"
        static let candbuyPackage = "cand_packages"
        static let payment = "payment/"
        static let checkOut = "payment/complete/"
        static let dashboardCandidate = "canidate/dashboard/"
        static let allJobs = "all_jobs/"
        static let jobsForYou = "candidate/jobs_matched/"
        static let paymentCand = "cand_payment/"
        
        static let appliedJobs = "canidate/applied_jobs/"
        static let savedJobs = "canidate/saved_jobs/"
        static let delSavedJob = "canidate/dell_saved_job/"
        static let bookMarkJob = "candidate/saving_jobs/"
        static let employer_publicProfile = "employer/public_profile/"
        static let follow_Company = "candidate/following_companies/"
        static let followedCompaniesGet = "canidate/followed_companies/"
        static let jobNotificationget = "candidate/skill_match_notification/"
        static let unfollowCompany = "canidate/dell_followed_companies/"
        static let myResumes = "canidate/resumes_list/"
        static let deleteResume = "canidate/dell_resumes/"
        static let uploadResume = "canidate/resume_upload/"
        static let advanceSearch = "job_search/"
        static let subCategory = "child_cats/"
        static let candidateSearch = "candidate_search/"
        static let employerSearch = "employer_search/"
        static let canPersonalInfo = "canidate/update_personal_info/"
        static let canImageUpload = "candidate/dp/"
        static let candSkills = "canidate/update_skills/"
        static let candSocialLinks = "canidate/update_social_link/"
        static let candLocation = "canidate/update_location/"
        static let educationalDetail = "canidate/education/"
        static let updateEducation = "candidate/update_education/"
        static let candPortfolioGet = "canidate/portfolio/"
        static let compPortfolioGet = "employer/portfolio/"
        static let candPortfolioPost = "canidate/portfolio_upload/"
        static let candPortfolioDelete = "canidate/del_portfolio/"
        static let compPortfolioDelete = "employer/del_portfolio/"
        static let candResumesGet = "canidate/resumes_list/"
        static let candResumesUpload =  "canidate/resume_upload/"  //
        static let candResumesUploadWithOutLogin =  "canidate/uploding_resume/"
        
        
        static let companyProfileImage = "employer/logo/"
        static let companyPortfolioImage = "employer/portfolio_upload/"
        static let videoUrlUp = "candidate/cand_resumes_video"
        //"employer/portfolio_upload"
        static let blogComment = "posts/comments/"
        static let home = "home/"
        static let homeTwo = "home2/"
        static let featureJob = "premium_jobs/"
        static let all_jobs = "all_jobs/"
        static let experienceDetail = "canidate/profession/"
        static let updateProfession = "candidate/update_profession/"
        static let certificationGet = "canidate/certifications/"
        static let updateCertification = "candidate/update_certifications/"
        static let takeActionGet = "employer/get_templates/"
        static let takeActionPost = "employer/sending_email/"
        static let selectTemplatePost = "employer/template_load/"
        static let applyJobGet = "candidate/applying_jobs/"
        static let applyJobPost = "candidate/sending_resume/"
        static let loginActivity = "login_activity/"
        static let postJobFromEdit = "employer/job_update/"
        static let deleteAccount = "deactivate_my_acount/"
        static let feedBack = "feedback/"
        static let videoUrl = "candidate/portfolio_video_url/"
        static let videoUrlComp = "employer/portfolio_video_url/"
        static let companyContact = "candidate/portfolio_video_url/"
        static let candidateContact = "user_contact/"
        static let multiImages = "job_post/upload_attach/"
        static let videoUrlCand = "canidate/cand_save_video/"
        static let resumeSave = "employer/saving_cand_resumes/"
        static let removeResume = "employer/removing_cand_resumes/"
        static let saveResume = "employer/saved_resumes/"
        static let emailAlert = "job_alert_subsucription/"
        static let jobAlert = "candidate/job_alerts/"
        static let removeAlert = "candidate/delete_job_alert/"
        static let matchedResume = "employer/jobs_matched_resumes/"
        static let matchedResumeFilter = "employer/jobs_matched_resumes_filter/"
        static let matchedResSingle = "employer/single_job_matched_resume/"
        static let externalApply = "candidate/external_apply/"
        static let applyJobPostMail = "candidate/sending_email_resume/"
        static let bumpUp = "employer/bump_this_job"
        static let buyAlertGet = "candidate/post_paid_alert"
        static let candidateAvailability = "canidate/schedule_hours"
        static let candidateAvailabilityPost = "candidate/schedule_hours_post"
        static let RatingsRevviws = "candidate/post_ratings"
        static let RatingsReviewsData = "candidate/get_ratings"
        static let RatingsReply = "user_post_reply"
        static let employPostRatings = "employer/post_ratings"
        static let employeGetRatings = "employer/get_ratings"
    }
    
    
    struct customCodes {
        static let purchaseCode = "purchaseCode"
        static let securityCode = "securityCode"
        static let contentType = "application/json"
        static let requestFrom = "ios"
    }
    
    struct AppColor {
        static let appColor = "#ffc420"
        static let ratingColor = "#ffcc00"
        
    }
    
    struct GooglePlacesApiKey {
        static let placeskey = "Places Key"
        static let mapkey = ""
    }
    
    struct appVariables {
        static var comp_Id = 0
    }
    
    //Convert data to json string
    static func json(from object:Any) -> String? {
        guard let data = try? JSONSerialization.data(withJSONObject: object, options: []) else {
            return nil
        }
        return String(data: data, encoding: String.Encoding.utf8)
    }
    
    
    struct NetworkError {
        static let timeOutInterval: TimeInterval = 20
        
        static let error = "Error"
        static let internetNotAvailable = "Internet Not Available"
        static let pleaseTryAgain = "Please Try Again"
        
        static let generic = 4000
        static let genericError = "Please Try Again."
        
        static let serverErrorCode = 5000
        static let serverNotAvailable = "Server Not Available"
        static let serverError = "Server Not Availabe, Please Try Later."
        
        static let timout = 4001
        static let timoutError = "Network Time Out, Please Try Again."
        
        static let login = 4003
        static let loginMessage = "Unable To Login"
        static let loginError = "Please Try Again."
        
        static let internet = 4004
        static let internetError = "Internet Not Available"
    }
    
    struct NetworkSuccess {
        static let statusOK = 200
    }
    
    struct activitySize {
        static let size = CGSize(width: 40, height: 40)
    }
    
    enum loaderMessages : String {
        case loadingMessage = ""
    }
    
    static func showBasicAlert (message: String) -> UIAlertController{
        
        let userData = UserDefaults.standard.object(forKey: "settingsData")
        if userData != nil {
            let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
            let dataTabs = SplashRoot(fromDictionary: objData)
            
            let alert = UIAlertController(title: dataTabs.data.extra.alertName, message: message, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: dataTabs.data.progressTxt.btnOk, style: UIAlertAction.Style.default, handler: nil))
            return alert
        }
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        return alert
        
    }
    
    static func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    struct AdMob {
        static let objData = UserHandler.sharedInstance.objSaplash?.adMob
        static let intersetialId = objData?.ad_id
        static let intersetialIdTest = "ca-app-pub-3940256099942544/4411468910" //
    }
    
    
    
    public static var isiPadDevice: Bool {
        
        let device = Device()
        
        if device.isPad {
            return true
        }
        switch device {
        case .simulator(.iPad2), .simulator(.iPad3), .simulator(.iPad4), .simulator(.iPad5), .simulator(.iPadAir), .simulator(.iPadAir2), .simulator(.iPadMini), .simulator(.iPadMini2), .simulator(.iPadMini3), .simulator(.iPadMini4), .simulator(.iPadPro9Inch), .simulator(.iPadPro10Inch), .simulator(.iPadPro12Inch), .simulator(.iPadPro12Inch2), .iPadAir, .iPad5, .iPad4, .iPad3, .iPad2, .iPadAir2, .iPadMini, .iPadMini2, .iPadMini3, .iPadMini4:
            return true
            
        default:
            return false
        }
    }
    
    public static var isiPhone5 : Bool {
        
        let device = Device()
        
        switch device {
        
        case .simulator(.iPhone4), .simulator(.iPhone4s), .simulator(.iPhone5), .simulator(.iPhone5s), . simulator(.iPhone5c), .simulator(.iPhoneSE):
            return true
            
        case .iPhone4, .iPhone4s, .iPhone5, .iPhone5s, .iPhone5c, .iPhoneSE:
            return true
            
        default:
            return false
        }
    }
    
    public static var isIphone6 : Bool {
        let device = Device()
        switch device {
        case .iPhone6 , .simulator(.iPhone6), .iPhone6s , .simulator(.iPhone6s) , .iPhone7, .simulator(.iPhone7), .iPhone8, .simulator(.iPhone8):
            return true
        default:
            return false
        }
    }
    
    public static var isIphonePlus : Bool {
        let device = Device()
        switch device {
        case .iPhone6Plus, .simulator(.iPhone6Plus)  ,.iPhone7Plus, .simulator(.iPhone7Plus),.iPhone8Plus, .simulator(.iPhone8Plus):
            return true
        default:
            return false
        }
    }
    
    public static var isIphoneX : Bool {
        
        let device = Device()
        
        switch device {
        case .iPhoneX, .simulator(.iPhoneX) :
            return true
        default:
            return false
        }
    }
    
    public static var isIphoneXR : Bool {
        let device = Device()
        switch device {
        case .iPhoneX, .simulator(.iPhoneX) :
            return true
        default:
            return false
        }
    }
    
    public static var isSimulator: Bool {
        
        let device = Device()
        
        if device.isSimulator {
            return true
        }
        else {
            return false
        }
    }
    
    static func setFontSize (size : Int) -> UIFont {
        let device = Device()
        
        switch device {
        case .iPad2, .iPad3, .iPad4 , .iPad5 , .iPadAir, .iPadAir2, .iPadMini, .iPadMini2, .iPadMini3, .iPadMini4, .iPadPro9Inch, .iPadPro10Inch, .iPadPro12Inch, .iPadPro12Inch2:
            return UIFont(name: "System-Thin", size: CGFloat(size + 2))!
        case .iPhone4, .iPhone4s , .iPhone5, .iPhone5c, .iPhone5s:
            return UIFont (name: "System-Thin", size: CGFloat(size - 2))!
        default:
            return UIFont (name: "System-Thin", size: CGFloat(size))!
        }
    }
    
    struct LinkedInConstants {
        //https://github.com/tonyli508/LinkedinSwift
        static let CLIENT_ID = "CLIENT_ID"
        static let CLIENT_SECRET = "CLIENT_SECRET"
        static let REDIRECT_URI="REDIRECT_URI"
        static let SCOPE = "r_liteprofile%20r_emailaddress"
        static let AUTHURL = "https://www.linkedin.com/oauth/v2/authorization"
        static let TOKENURL = "https://www.linkedin.com/oauth/v2/accessToken"
        
        
        
    }
}

