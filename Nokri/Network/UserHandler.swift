//
//  UserHandler.swift
//  AdForest
//
//  Created by apple on 3/8/18.
//  Copyright © 2018 apple. All rights reserved.
//

import Foundation
import Alamofire
class UserHandler {
    
    static let sharedInstance = UserHandler()
    
    var objUser: SignupData?
    var objLoginUser: LoginData?
    var objLoginPost:LoginPost?
    var objSignUpPost:SignUpPostData?
    var objForgotUser: ForgotPassword?
    var objFbUser: FbSocialLogin?
    var objSetAccount: SetAccount?
    var objSaplash: SplashData?
    var objDashboard:DashboardData?
    var languagesData = [LangData]()
    var dictionary:[String:Any]?
    
    //MARK:- Saplash Get
    
    class func nokri_saplashData(success: @escaping(SplashRoot)->Void, failure: @escaping(NetworkError)->Void) {
        
        let url = Constants.URL.baseUrl+Constants.URL.saplashData
        print(url)
        NetworkHandler.getRequest(url: url, parameters: nil, success: { (successResponse) in
            let dictionary = successResponse as! [String: Any]
            let data = NSKeyedArchiver.archivedData(withRootObject: dictionary)
            UserDefaults.standard.set(data, forKey: "settingsData")
            UserDefaults.standard.synchronize()
            let objData = SplashRoot(fromDictionary: dictionary)
            success(objData)
        }) { (error) in
            failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
        }
    }
    
    //MARK:- Signup Get
    class func nokri_signUpData(success: @escaping(SignupDataRoot)->Void, failure: @escaping(NetworkError)->Void) {
        
        let url = Constants.URL.baseUrl+Constants.URL.signup
        print(url)
        NetworkHandler.getRequest(url: url, parameters: nil, success: { (successResponse) in
            let dictionary = successResponse as! [String: Any]
            let objData = SignupDataRoot(fromDictionary: dictionary)
            success(objData)
        }) { (error) in
            failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
        }
    }
    
    //MARK:- Signup Post
    class func nokri_signUpUser(parameter: NSDictionary, success: @escaping(SignUpPostRoot)-> Void, failure: @escaping(NetworkError)-> Void) {
        let url = Constants.URL.baseUrl+Constants.URL.signup
        print(url)
        NetworkHandler.postRequest(url: url, parameters: parameter as? Parameters, success: { (successResponse) in
            let dictionary = successResponse as! [String: Any]
            let data = NSKeyedArchiver.archivedData(withRootObject: dictionary)
            UserDefaults.standard.set(data, forKey: "userData")
            UserDefaults.standard.synchronize()
            let objLogin = SignUpPostRoot(fromDictionary: dictionary)
            success(objLogin)
        }) { (error) in
            failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
        }
    }

    //MARK:- login Get
    class func nokri_loginData(success: @escaping(LoginDataRoot)->Void, failure: @escaping(NetworkError)->Void) {
        
        let url = Constants.URL.baseUrl+Constants.URL.login
        print(url)
        NetworkHandler.getRequest(url: url, parameters: nil, success: { (successResponse) in
            let dictionary = successResponse as! [String: Any]
            let objData = LoginDataRoot(fromDictionary: dictionary)
            success(objData)
        }) { (error) in
            failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
        }
    }
    
    //MARK:- login Post
    class func nokri_loginUser(parameter: NSDictionary, success: @escaping(LoginPostRoot)-> Void, failure: @escaping(NetworkError)-> Void) {
        let url = Constants.URL.baseUrl+Constants.URL.login
        print(url)
        NetworkHandler.postRequest(url: url, parameters: parameter as? Parameters, success: { (successResponse) in
            let dictionary = successResponse as! [String: Any]
            let data = NSKeyedArchiver.archivedData(withRootObject: dictionary)
            UserDefaults.standard.set(data, forKey: "userData")
            UserDefaults.standard.synchronize()
            let objLogin = LoginPostRoot(fromDictionary: dictionary)
            success(objLogin)
        }) { (error) in
            failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
        }
    }
    
    class func nokri_resumeSave(parameter: NSDictionary, success: @escaping(LoginPostRoot)-> Void, failure: @escaping(NetworkError)-> Void) {
        let url = Constants.URL.baseUrl+Constants.URL.resumeSave
        print(url)
        NetworkHandler.postRequest(url: url, parameters: parameter as? Parameters, success: { (successResponse) in
            let dictionary = successResponse as! [String: Any]
          
            let objLogin = LoginPostRoot(fromDictionary: dictionary)
            success(objLogin)
        }) { (error) in
            failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
        }
    }
    
    class func nokri_loginUserFb(parameter: NSDictionary, success: @escaping(FbSocialLoginRoot)-> Void, failure: @escaping(NetworkError)-> Void) {
        let url = Constants.URL.baseUrl+Constants.URL.login
        print(url)
        NetworkHandler.postRequest(url: url, parameters: parameter as? Parameters, success: { (successResponse) in
            let dictionary = successResponse as! [String: Any]
            let data = NSKeyedArchiver.archivedData(withRootObject: dictionary)
            UserDefaults.standard.set(data, forKey: "userData")
            UserDefaults.standard.synchronize()
            let objLogin = FbSocialLoginRoot(fromDictionary: dictionary)
            success(objLogin)
            
        }) { (error) in
            failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
        }
    }
    
    class func nokri_loginUserGoogle(parameter: NSDictionary, success: @escaping(GoogleSocialLoginRoot)-> Void, failure: @escaping(NetworkError)-> Void) {
        let url = Constants.URL.baseUrl+Constants.URL.login
        print(url)
        NetworkHandler.postRequest(url: url, parameters: parameter as? Parameters, success: { (successResponse) in
            let dictionary = successResponse as! [String: Any]
            let data = NSKeyedArchiver.archivedData(withRootObject: dictionary)
            UserDefaults.standard.set(data, forKey: "userData")
            UserDefaults.standard.synchronize()
            let objLogin = GoogleSocialLoginRoot(fromDictionary: dictionary)
            success(objLogin)
            
        }) { (error) in
            failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
        }
    }
    
    //MARK:- Forgot Get
    class func nokri_forgotData(success: @escaping(ForgotPasswordRoot)->Void, failure: @escaping(NetworkError)->Void) {
        
        let url = Constants.URL.baseUrl+Constants.URL.forgotPassword
        print(url)
        NetworkHandler.getRequest(url: url, parameters: nil, success: { (successResponse) in
            let dictionary = successResponse as! [String: Any]
            let objData = ForgotPasswordRoot(fromDictionary: dictionary)
            success(objData)
        }) { (error) in
            failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
        }
    }
    
    //MARK:- Forgot Post
    class func nokri_forgotPost(parameter: NSDictionary, success: @escaping(ForgotPasswordRoot)-> Void, failure: @escaping(NetworkError)-> Void) {
        let url = Constants.URL.baseUrl+Constants.URL.forgotPassword
        print(url)
        NetworkHandler.postRequest(url: url, parameters: parameter as? Parameters, success: { (successResponse) in
            let dictionary = successResponse as! [String: Any]
            let objForgot = ForgotPasswordRoot(fromDictionary: dictionary)
            success(objForgot)
        }) { (error) in
            failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
        }
    }
    
    class func nokri_PostJob(parameter: NSDictionary, success: @escaping(ForgotPasswordRoot)-> Void, failure: @escaping(NetworkError)-> Void) {
        let url = Constants.URL.baseUrl+Constants.URL.jobPost
        print(url)
        NetworkHandler.postRequest(url: url, parameters: parameter as? Parameters, success: { (successResponse) in
            let dictionary = successResponse as! [String: Any]
            let objForgot = ForgotPasswordRoot(fromDictionary: dictionary)
            success(objForgot)
        }) { (error) in
            failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
        }
    }
    
    //MARK:- SetAccount Get
    class func nokri_setAccount(success: @escaping(SetAccountRoot)->Void, failure: @escaping(NetworkError)->Void) {
        
        let url = Constants.URL.baseUrl+Constants.URL.setAcount
        print(url)
        NetworkHandler.getRequest(url: url, parameters: nil, success: { (successResponse) in
            let dictionary = successResponse as! [String: Any]
            let objData = SetAccountRoot(fromDictionary: dictionary)
            success(objData)
        }) { (error) in
            failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
        }
    }
    
    //MARK:- SetAccount Post
    class func nokri_setAccountPost(parameter: NSDictionary, success: @escaping(SetAccountRoot)-> Void, failure: @escaping(NetworkError)-> Void) {
        let url = Constants.URL.baseUrl+Constants.URL.setAcount
        print(url)
        NetworkHandler.postRequest(url: url, parameters: parameter as? Parameters, success: { (successResponse) in
            let dictionary = successResponse as! [String: Any]
           // let data = NSKeyedArchiver.archivedData(withRootObject: dictionary)
            //UserDefaults.standard.set(data, forKey: "userData")
            //UserDefaults.standard.synchronize()
            let objForgot = SetAccountRoot(fromDictionary: dictionary)
            success(objForgot)
        }) { (error) in
            failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
        }
    }
    
    //MARK:- CompanyDashboard Get
//    class func companyDashboard(success: @escaping(DashboardRoot)->Void, failure: @escaping(NetworkError)->Void) {
//
//        let url = Constants.URL.baseUrl+Constants.URL.companyDashboard
//        print(url)
//
//        NetworkHandler.getRequest(url: url, parameters: nil, success: { (successResponse) in
//            let dictionary = successResponse as! [String: Any]
//            let objData = DashboardRoot(fromDictionary: dictionary)
//            success(objData)
//
//        }) { (error) in
//            failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
//        }
//    }
    
    
    //MARK:- Candidate Dahboard Get
    
    class func nokri_dashboardCompany(success: @escaping(DashboardRoot)->Void, failure: @escaping(NetworkError)->Void) {
        
        let url = Constants.URL.baseUrl+Constants.URL.companyDashboard
        print(url)
        NetworkHandler.getRequest(url: url, parameters: nil, success: { (successResponse) in
            let dictionary = successResponse as! [String: Any]
            let objData = DashboardRoot(fromDictionary: dictionary)
            success(objData)
        }) { (error) in
            failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
        }
    }
    
    class func nokri_changePassword(success: @escaping(ResetPasswordRoot)->Void, failure: @escaping(NetworkError)->Void) {
        
        let url = Constants.URL.baseUrl+Constants.URL.changePassword
        print(url)
        NetworkHandler.getRequest(url: url, parameters: nil, success: { (successResponse) in
            let dictionary = successResponse as! [String: Any]
            let objData = ResetPasswordRoot(fromDictionary: dictionary)
            success(objData)
        }) { (error) in
            failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
        }
    }
    
    class func nokri_changePasswordPost(parameter: NSDictionary, success: @escaping(ResetPasswordRoot)-> Void, failure: @escaping(NetworkError)-> Void) {
        let url = Constants.URL.baseUrl+Constants.URL.changePassword
        print(url)
        NetworkHandler.postRequest(url: url, parameters: parameter as? Parameters, success: { (successResponse) in
            let dictionary = successResponse as! [String: Any]
            let objForgot = ResetPasswordRoot(fromDictionary: dictionary)
            success(objForgot)
        }) { (error) in
            failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
        }
    }
    
    //MARK:- Edit Profile Company
    //-->> Basic Info
    class func nokri_updateBasiInfoPost(parameter: NSDictionary, success: @escaping(CandidateEditRoot)-> Void, failure: @escaping(NetworkError)-> Void) {
        let url = Constants.URL.baseUrl+Constants.URL.companyBasicInfo
        print(url)
        NetworkHandler.postRequest(url: url, parameters: parameter as? Parameters, success: { (successResponse) in
            let dictionary = successResponse as! [String: Any]
            let objForgot = CandidateEditRoot(fromDictionary: dictionary)
            success(objForgot)
        }) { (error) in
            failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
        }
    }
    
    class func nokri_updateBasiInfo(success: @escaping(CandidateEditRoot)->Void, failure: @escaping(NetworkError)->Void) {
        
        let url = Constants.URL.baseUrl+Constants.URL.companyBasicInfo
        print(url)
        NetworkHandler.getRequest(url: url, parameters: nil, success: { (successResponse) in
            let dictionary = successResponse as! [String: Any]
            let objData = CandidateEditRoot(fromDictionary: dictionary)
            success(objData)
        }) { (error) in
            failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
        }
    }
    
    class func nokri_updateBasiInfoDynamic(success: @escaping(PersonalInfoRoot)->Void, failure: @escaping(NetworkError)->Void) {
        
        let url = Constants.URL.baseUrl+Constants.URL.companyBasicInfo
        print(url)
        NetworkHandler.getRequest(url: url, parameters: nil, success: { (successResponse) in
            let dictionary = successResponse as! [String: Any]
            let objData = PersonalInfoRoot(fromDictionary: dictionary)
            success(objData)
        }) { (error) in
            failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
        }
    }
    
    class func nokri_dashboardBasiInfoPost(success: @escaping(CandidateEditRoot)->Void, failure: @escaping(NetworkError)->Void) {
        
        let url = Constants.URL.baseUrl+Constants.URL.companyBasicInfo
        print(url)
        NetworkHandler.postRequest(url: url, parameters: nil, success: { (successResponse) in
            let dictionary = successResponse as! [String: Any]
            let objData = CandidateEditRoot(fromDictionary: dictionary)
            success(objData)
        }) { (error) in
            failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
        }
    }
    
     //-->> Skills
    
    class func nokri_specializationCompany(success: @escaping(UpdateSkillsRoot)->Void, failure: @escaping(NetworkError)->Void) {
        
        let url = Constants.URL.baseUrl+Constants.URL.specializationCompany
        print(url)
        NetworkHandler.getRequest(url: url, parameters: nil, success: { (successResponse) in
            let dictionary = successResponse as! [String: Any]
            let objData = UpdateSkillsRoot(fromDictionary: dictionary)
            success(objData)
        }) { (error) in
            failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
        }
    }
    
    class func nokri_specializationCompanyPost(parameter: NSDictionary, success: @escaping(UpdateSkillsRoot)-> Void, failure: @escaping(NetworkError)-> Void) {
        let url = Constants.URL.baseUrl+Constants.URL.specializationCompany
        print(url)
        NetworkHandler.postRequest(url: url, parameters: parameter as? Parameters, success: { (successResponse) in
            let dictionary = successResponse as! [String: Any]
            let objForgot = UpdateSkillsRoot(fromDictionary: dictionary)
            success(objForgot)
        }) { (error) in
            failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
        }
    }

    //-->> Social Links
    
    class func nokri_socialLinks(success: @escaping(SocialLinkRoot)->Void, failure: @escaping(NetworkError)->Void) {
        
        let url = Constants.URL.baseUrl+Constants.URL.socialLinks
        print(url)
        NetworkHandler.getRequest(url: url, parameters: nil, success: { (successResponse) in
            let dictionary = successResponse as! [String: Any]
            let objData = SocialLinkRoot(fromDictionary: dictionary)
            success(objData)
        }) { (error) in
            failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
        }
    }
    
    class func nokri_socialLinksPost(parameter: NSDictionary, success: @escaping(SocialLinkRoot)-> Void, failure: @escaping(NetworkError)-> Void) {
        let url = Constants.URL.baseUrl+Constants.URL.socialLinks
        print(url)
        NetworkHandler.postRequest(url: url, parameters: parameter as? Parameters, success: { (successResponse) in
            let dictionary = successResponse as! [String: Any]
            let objForgot = SocialLinkRoot(fromDictionary: dictionary)
            success(objForgot)
        }) { (error) in
            failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
        }
    }
    
    //-->> Location
    
    class func nokri_locationData(success: @escaping(LocationRoot)->Void, failure: @escaping(NetworkError)->Void) {
        
        let url = Constants.URL.baseUrl+Constants.URL.location
        print(url)
        NetworkHandler.getRequest(url: url, parameters: nil, success: { (successResponse) in
            let dictionary = successResponse as! [String: Any]
            let objData = LocationRoot(fromDictionary: dictionary)
            success(objData)
        }) { (error) in
            failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
        }
    }
    
    class func nokri_locationPost(parameter: NSDictionary, success: @escaping(LocationRoot)-> Void, failure: @escaping(NetworkError)-> Void) {
        let url = Constants.URL.baseUrl+Constants.URL.location
        print(url)
        NetworkHandler.postRequest(url: url, parameters: parameter as? Parameters, success: { (successResponse) in
            let dictionary = successResponse as! [String: Any]
            let objLocation = LocationRoot(fromDictionary: dictionary)
            success(objLocation)
        }) { (error) in
            failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
        }
    }
    
    //MARK:- Email Temp
    
    class func nokri_emailTempDelete(parameter: NSDictionary, success: @escaping(EmailTempRoot)-> Void, failure: @escaping(NetworkError)-> Void) {
        let url = Constants.URL.baseUrl+Constants.URL.deleteEmplTemp
        print(url)
        NetworkHandler.postRequest(url: url, parameters: parameter as? Parameters, success: { (successResponse) in
            let dictionary = successResponse as! [String: Any]
            let obj = EmailTempRoot(fromDictionary: dictionary)
            success(obj)
        }) { (error) in
            failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
        }
    }
    
    class func nokri_emailTempGet(success: @escaping(AddEmailTempRoot)->Void, failure: @escaping(NetworkError)->Void) {
        let url = Constants.URL.baseUrl+Constants.URL.addTempEmployer
        print(url)
        NetworkHandler.getRequest(url: url, parameters: nil, success: { (successResponse) in
            let dictionary = successResponse as! [String: Any]
            let obj = AddEmailTempRoot(fromDictionary: dictionary)
            success(obj)
        }) { (error) in
            failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
        }
    }
    
    class func nokri_emailTempPost(parameter: NSDictionary, success: @escaping(AddEmailTempRoot)-> Void, failure: @escaping(NetworkError)-> Void) {
        let url = Constants.URL.baseUrl+Constants.URL.addTempEmployer
        print(url)
        NetworkHandler.postRequest(url: url, parameters: parameter as? Parameters, success: { (successResponse) in
            let dictionary = successResponse as! [String: Any]
            let obj = AddEmailTempRoot(fromDictionary: dictionary)
            success(obj)
        }) { (error) in
            failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
        }
    }
   
    
    
    //MARK:- Company Follower
    
    class func nokri_companyFollowerRemove(parameter: NSDictionary, success: @escaping(FollowerRoot)-> Void, failure: @escaping(NetworkError)-> Void) {
        let url = Constants.URL.baseUrl+Constants.URL.followerDell
        print(url)
        NetworkHandler.postRequest(url: url, parameters: parameter as? Parameters, success: { (successResponse) in
            let dictionary = successResponse as! [String: Any]
            let obj = FollowerRoot(fromDictionary: dictionary)
            success(obj)
        }) { (error) in
            failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
        }
    }
    
    class func nokri_RemoveResume(parameter: NSDictionary, success: @escaping(FollowerRoot)-> Void, failure: @escaping(NetworkError)-> Void) {
           let url = Constants.URL.baseUrl+Constants.URL.removeResume
           print(url)
           NetworkHandler.postRequest(url: url, parameters: parameter as? Parameters, success: { (successResponse) in
               let dictionary = successResponse as! [String: Any]
               let obj = FollowerRoot(fromDictionary: dictionary)
               success(obj)
           }) { (error) in
               failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
           }
       }
    
    //MARK:- Remove Follow Company
    
    class func nokri_removeFollowedCompany(parameter: NSDictionary, success: @escaping(FollowerRoot)-> Void, failure: @escaping(NetworkError)-> Void) {
        let url = Constants.URL.baseUrl+Constants.URL.unfollowCompany
        print(url)
        NetworkHandler.postRequest(url: url, parameters: parameter as? Parameters, success: { (successResponse) in
            let dictionary = successResponse as! [String: Any]
            let obj = FollowerRoot(fromDictionary: dictionary)
            success(obj)
        }) { (error) in
            failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
        }
    }
    
    //MARK:- Package Details
    
    class func nokri_packageDetail(success: @escaping(PackageDetailRoot)->Void, failure: @escaping(NetworkError)->Void) {
        let url = Constants.URL.baseUrl+Constants.URL.packageDetail
        print(url)
        NetworkHandler.getRequest(url: url, parameters: nil, success: { (successResponse) in
            let dictionary = successResponse as! [String: Any]
            let objData = PackageDetailRoot(fromDictionary: dictionary)
            success(objData)
        }) { (error) in
            failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
        }
    }
    
    class func nokri_candPackageDetail(success: @escaping(PackageDetailRoot)->Void, failure: @escaping(NetworkError)->Void) {
           let url = Constants.URL.baseUrl+Constants.URL.candPackageDetail
           print(url)
           NetworkHandler.getRequest(url: url, parameters: nil, success: { (successResponse) in
               let dictionary = successResponse as! [String: Any]
               let objData = PackageDetailRoot(fromDictionary: dictionary)
               success(objData)
           }) { (error) in
               failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
           }
       }

    //MARK:- Jobs
    
    class func nokri_jobDelete(parameter: NSDictionary, success: @escaping(JobDeleteRoot)-> Void, failure: @escaping(NetworkError)-> Void) {
        let url = Constants.URL.baseUrl+Constants.URL.jobDelete
        print(url)
        NetworkHandler.postRequest(url: url, parameters: parameter as? Parameters, success: { (successResponse) in
            let dictionary = successResponse as! [String: Any]
            let obj = JobDeleteRoot(fromDictionary: dictionary)
            success(obj)
        }) { (error) in
            failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
        }
    }

    class func nokri_resumeDelete(parameter: NSDictionary, success: @escaping(JobDeleteRoot)-> Void, failure: @escaping(NetworkError)-> Void) {
         let url = Constants.URL.baseUrl+Constants.URL.resDelete
         print(url)
         NetworkHandler.postRequest(url: url, parameters: parameter as? Parameters, success: { (successResponse) in
             let dictionary = successResponse as! [String: Any]
             let obj = JobDeleteRoot(fromDictionary: dictionary)
             success(obj)
         }) { (error) in
             failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
         }
     }
    
    //MARK:- Blog
    
    class func nokri_blog(parameter: NSDictionary, success: @escaping(BlogRoot)-> Void, failure: @escaping(NetworkError)-> Void) {
        let url = Constants.URL.baseUrl+Constants.URL.blog
        print(url)
        NetworkHandler.postRequest(url: url, parameters: parameter as? Parameters, success: { (successResponse) in
            let dictionary = successResponse as! [String: Any]
            let obj = BlogRoot(fromDictionary: dictionary)
            success(obj)
        }) { (error) in
            failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
        }
    }
    
    class func nokri_blogDetail(parameter: NSDictionary, success: @escaping(BlogDetailRoot)-> Void, failure: @escaping(NetworkError)-> Void) {
        let url = Constants.URL.baseUrl+Constants.URL.blogDetail
        print(url)
        NetworkHandler.postRequest(url: url, parameters: parameter as? Parameters, success: { (successResponse) in
            let dictionary = successResponse as! [String: Any]
            let obj = BlogDetailRoot(fromDictionary: dictionary)
            success(obj)
        }) { (error) in
            failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
        }
    }

    //MARK:- job Detail
    
    class func nokri_viewJob(parameter: NSDictionary, success: @escaping(ViewJobRoot)-> Void, failure: @escaping(NetworkError)-> Void) {
        let url = Constants.URL.baseUrl+Constants.URL.jobDetail
        print(url)
        NetworkHandler.postRequest(url: url, parameters: parameter as? Parameters, success: { (successResponse) in
            let dictionary = successResponse as! [String: Any]
            let obj = ViewJobRoot(fromDictionary: dictionary)
            success(obj)
        }) { (error) in
            failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
        }
    }
    
    //MARK:- Candidate Profile
    
    class func nokri_candidateProfile(parameter: NSDictionary, success: @escaping(ViewJobRoot)-> Void, failure: @escaping(NetworkError)-> Void) {
        let url = Constants.URL.baseUrl+Constants.URL.jobDetail
        print(url)
        NetworkHandler.postRequest(url: url, parameters: parameter as? Parameters, success: { (successResponse) in
            let dictionary = successResponse as! [String: Any]
            let obj = ViewJobRoot(fromDictionary: dictionary)
            success(obj)
        }) { (error) in
            failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
        }
    }
    
    //MARK:- Faq
    
    class func nokri_faqData(success: @escaping(FaqRoot)->Void, failure: @escaping(NetworkError)->Void) {
        
        let url = Constants.URL.baseUrl+Constants.URL.faq
        print(url)
        
        NetworkHandler.getRequest(url: url, parameters: nil, success: { (successResponse) in
            let dictionary = successResponse as! [String: Any]
            let objData = FaqRoot(fromDictionary: dictionary)
            success(objData)
        }) { (error) in
            failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
        }
    }
    
    //MARK:- BuyPackage
    
    class func nokri_buyPackage(success: @escaping(BuyPackageRoot)->Void, failure: @escaping(NetworkError)->Void) {
        
        let url = Constants.URL.baseUrl+Constants.URL.buyPackage
        print(url)
        NetworkHandler.getRequest(url: url, parameters: nil, success: { (successResponse) in
            let dictionary = successResponse as! [String: Any]
            let objData = BuyPackageRoot(fromDictionary: dictionary)
            success(objData)
        }) { (error) in
            failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
        }
    }
    
    class func nokri_buyPackageCandidate(success: @escaping(BuyPackageRoot)->Void, failure: @escaping(NetworkError)->Void) {
           
           let url = Constants.URL.baseUrl+Constants.URL.candbuyPackage
           print(url)
           NetworkHandler.getRequest(url: url, parameters: nil, success: { (successResponse) in
               let dictionary = successResponse as! [String: Any]
               let objData = BuyPackageRoot(fromDictionary: dictionary)
               success(objData)
           }) { (error) in
               failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
           }
       }
    
    //MARK:- Payment
    
    class func nokri_payment(parameter: NSDictionary, success: @escaping(PaymentRoot)-> Void, failure: @escaping(NetworkError)-> Void) {
        let url = Constants.URL.baseUrl+Constants.URL.payment
        print(url)
        NetworkHandler.postRequest(url: url, parameters: parameter as? Parameters, success: { (successResponse) in
            let dictionary = successResponse as! [String: Any]
            let obj = PaymentRoot(fromDictionary: dictionary)
            success(obj)
        }) { (error) in
            failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
        }
    }
    
    class func nokri_paymentCand(parameter: NSDictionary, success: @escaping(PaymentRoot)-> Void, failure: @escaping(NetworkError)-> Void) {
          let url = Constants.URL.baseUrl+Constants.URL.paymentCand
          print(url)
          NetworkHandler.postRequest(url: url, parameters: parameter as? Parameters, success: { (successResponse) in
              let dictionary = successResponse as! [String: Any]
              let obj = PaymentRoot(fromDictionary: dictionary)
              success(obj)
          }) { (error) in
              failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
          }
      }
    
    class func nokri_paymentComplete(success: @escaping(PaymentCompleteRoot)->Void, failure: @escaping(NetworkError)->Void) {
        
        let url = Constants.URL.baseUrl+Constants.URL.checkOut
        print(url)
        NetworkHandler.getRequest(url: url, parameters: nil, success: { (successResponse) in
            let dictionary = successResponse as! [String: Any]
            let objData = PaymentCompleteRoot(fromDictionary: dictionary)
            success(objData)
        }) { (error) in
            failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
        }
    }

    //MARK:- Candidate
    
    class func nokri_candidateDashboard(success: @escaping(CandidateDashboardRoot)->Void, failure: @escaping(NetworkError)->Void) {
        
        let url = Constants.URL.baseUrl+Constants.URL.dashboardCandidate
        print(url)
        NetworkHandler.getRequest(url: url, parameters: nil, success: { (successResponse) in
            let dictionary = successResponse as! [String: Any]
            let objData = CandidateDashboardRoot(fromDictionary: dictionary)
            success(objData)
        }) { (error) in
            failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
        }
    }
    
    //MARK:- Saved Job
    
    class func nokri_ExternalApply(parameter: NSDictionary, success: @escaping(SaveJobRoot)-> Void, failure: @escaping(NetworkError)-> Void) {
           let url = Constants.URL.baseUrl+Constants.URL.externalApply
           print(url)
           NetworkHandler.postRequest(url: url, parameters: parameter as? Parameters, success: { (successResponse) in
               let dictionary = successResponse as! [String: Any]
               let obj = SaveJobRoot(fromDictionary: dictionary)
               success(obj)
           }) { (error) in
               failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
           }
       }
    
    class func nokri_bookMarkJob(parameter: NSDictionary, success: @escaping(SaveJobRoot)-> Void, failure: @escaping(NetworkError)-> Void) {
        let url = Constants.URL.baseUrl+Constants.URL.bookMarkJob
        print(url)
        NetworkHandler.postRequest(url: url, parameters: parameter as? Parameters, success: { (successResponse) in
            let dictionary = successResponse as! [String: Any]
            let obj = SaveJobRoot(fromDictionary: dictionary)
            success(obj)
        }) { (error) in
            failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
        }
    }
    
    //MARK:- Deleter Resume
    
    class func nokri_deleteResume(parameter: NSDictionary, success: @escaping(EmailTempRoot)-> Void, failure: @escaping(NetworkError)-> Void) {
        let url = Constants.URL.baseUrl+Constants.URL.deleteResume
        print(url)
        NetworkHandler.postRequest(url: url, parameters: parameter as? Parameters, success: { (successResponse) in
            let dictionary = successResponse as! [String: Any]
            let obj = EmailTempRoot(fromDictionary: dictionary)
            success(obj)
        }) { (error) in
            failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
        }
    }
    
    //MARK:- Upload Resume
    
    class func nokri_uploadResume(parameter: NSDictionary, fileUrl: URL,progress: @escaping(Int)-> Void, success: @escaping(EmailTempRoot)-> Void, failure: @escaping(NetworkError)-> Void) {
        let url = Constants.URL.baseUrl+Constants.URL.uploadResume
        print(url)
        NetworkHandler.upload(url: url, fileUrl: fileUrl,fileName: "my_cv_upload", params: [:] , uploadProgress:  progress, success: { (successResponse) in
            let dictionary = successResponse as! [String: Any]
            let obj = EmailTempRoot(fromDictionary: dictionary)
            success(obj)
        }) { (error) in
             failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
        }
    }
    
    //MARK:- Advance Search
    
    class func nokri_advanceSearch(success: @escaping(AdvanceSearchRoot)->Void, failure: @escaping(NetworkError)->Void) {
        let url = Constants.URL.baseUrl+Constants.URL.advanceSearch
        print(url)
        NetworkHandler.getRequest(url: url, parameters: nil, success: { (successResponse) in
            let dictionary = successResponse as! [String: Any]
            let objData = AdvanceSearchRoot(fromDictionary: dictionary)
            success(objData)
        }) { (error) in
            failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
        }
    }
    //MARK:- GEt Candidate Availability
    class func nokri_candidateAvailability(success: @escaping(CandidateAvailabilityRoot)->Void, failure: @escaping(NetworkError)->Void) {
        let url = Constants.URL.baseUrl+Constants.URL.candidateAvailability
        print(url)
        NetworkHandler.getRequest(url: url, parameters: nil, success: { (successResponse) in
            let dictionary = successResponse as! [String: Any]
            let objData = CandidateAvailabilityRoot(fromDictionary: dictionary)
            success(objData)
        }) { (error) in
            failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
        }
    }
    
    class func nokri_subCategory(parameter: NSDictionary, success: @escaping(EmailTempRoot)-> Void, failure: @escaping(NetworkError)-> Void) {
        let url = Constants.URL.baseUrl+Constants.URL.subCategory
        print(url)
        NetworkHandler.postRequest(url: url, parameters: parameter as? Parameters, success: { (successResponse) in
            let dictionary = successResponse as! [String: Any]
            let obj = EmailTempRoot(fromDictionary: dictionary)
            success(obj)
        }) { (error) in
            failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
        }
    }
   //MARK:- POST Candidate TimeTable
    class func nokri_postCandidateAvailableData(parameter: NSDictionary, success: @escaping(CandidateAvailabilityPostModel)-> Void, failure: @escaping(NetworkError)-> Void) {
        let url = Constants.URL.baseUrl+Constants.URL.candidateAvailabilityPost
        print(url)
        NetworkHandler.postRequest(url: url, parameters: parameter as? Parameters, success: { (successResponse) in
            let dictionary = successResponse as! [String: Any]
            let obj = CandidateAvailabilityPostModel(fromDictionary: dictionary)
            success(obj)
        }) { (error) in
            failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
        }
    }
    
    class func nokri_employerSearch(success: @escaping(CandidateSearchRoot)->Void, failure: @escaping(NetworkError)->Void) {
        let url = Constants.URL.baseUrl+Constants.URL.employerSearch
        print(url)
        NetworkHandler.getRequest(url: url, parameters: nil, success: { (successResponse) in
            let dictionary = successResponse as! [String: Any]
            let objData = CandidateSearchRoot(fromDictionary: dictionary)
            success(objData)
        }) { (error) in
            failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
        }
    }
    //CandProfileData
    //MARK:- Candidate Availabledayforprofile
    
    class func nokri_candidateProfileDays(success: @escaping(CandProfileData)->Void, failure: @escaping(NetworkError)->Void) {
        let url = Constants.URL.baseUrl+Constants.URL.candidateProfile
        print(url)
        NetworkHandler.getRequest(url: url, parameters: nil, success: { (successResponse) in
            let dictionary = successResponse as! [String: Any]
            let objData = CandProfileData(fromDictionary: dictionary)
            success(objData)
        }) { (error) in
            failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
        }
    }
    //MARK:- CandidatePublicProfile Post
    class func nokri_PostPublicProfilecandidateProfileDays(parameter: NSDictionary, success: @escaping(CandProfileData)-> Void, failure: @escaping(NetworkError)-> Void) {
        
        let url = Constants.URL.baseUrl+Constants.URL.candidateProfile
        print(url)
        NetworkHandler.postRequest(url: url, parameters: parameter as? Parameters, success: { (successResponse) in
            let dictionary = successResponse as! [String: Any]
            let objLogin = CandProfileData(fromDictionary: dictionary)
            success(objLogin)
        }) { (error) in
            failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
        }
    }
    //MARK:- Employer public profile Post
    class func nokri_PostEmployerPublicProfile(parameter: NSDictionary, success: @escaping(CandProfileData)-> Void, failure: @escaping(NetworkError)-> Void) {
        let url = Constants.URL.baseUrl+Constants.URL.employer_publicProfile
        print(url)
        NetworkHandler.postRequest(url: url, parameters: parameter as? Parameters, success: { (successResponse) in
            let dictionary = successResponse as! [String: Any]
            let objLogin = CandProfileData(fromDictionary: dictionary)
            success(objLogin)
        }) { (error) in
            failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
        }
    }
    //MARK:- RatingReviewsData
    class func nokri_RatingReviewsData(parameter: NSDictionary, success: @escaping(RatingsReviews)-> Void, failure: @escaping(NetworkError)-> Void) {
        
        let url = Constants.URL.baseUrl+Constants.URL.RatingsReviewsData
        print(url)
        NetworkHandler.postRequest(url: url, parameters: parameter as? Parameters, success: { (successResponse) in
            let dictionary = successResponse as! [String: Any]
            let objLogin = RatingsReviews(fromDictionary: dictionary)
            success(objLogin)
        }) { (error) in
            failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
        }
    }
    //MARK:- EMployeeRatingReviewsData
    class func nokri_EMployeRatingReviewsData(parameter: NSDictionary, success: @escaping(RatingsReviews)-> Void, failure: @escaping(NetworkError)-> Void) {
        
        let url = Constants.URL.baseUrl+Constants.URL.employeGetRatings
        print(url)
        NetworkHandler.postRequest(url: url, parameters: parameter as? Parameters, success: { (successResponse) in
            let dictionary = successResponse as! [String: Any]
            let objLogin = RatingsReviews(fromDictionary: dictionary)
            success(objLogin)
        }) { (error) in
            failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
        }
    }
    //MARK:- review Post
    class func nokri_PostReviews(parameter: NSDictionary, success: @escaping(CandProfileData)-> Void, failure: @escaping(NetworkError)-> Void) {
        let url = Constants.URL.baseUrl+Constants.URL.RatingsRevviws
        print(url)
        NetworkHandler.postRequest(url: url, parameters: parameter as? Parameters, success: { (successResponse) in
            let dictionary = successResponse as! [String: Any]
            let objLogin = CandProfileData(fromDictionary: dictionary)
            success(objLogin)
        }) { (error) in
            failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
        }
    }
    //MARK:- EMploy Post Review
    class func nokri_PostEmployeReviews(parameter: NSDictionary, success: @escaping(CandProfileData)-> Void, failure: @escaping(NetworkError)-> Void) {
        let url = Constants.URL.baseUrl+Constants.URL.employPostRatings
        print(url)
        NetworkHandler.postRequest(url: url, parameters: parameter as? Parameters, success: { (successResponse) in
            let dictionary = successResponse as! [String: Any]
            let objLogin = CandProfileData(fromDictionary: dictionary)
            success(objLogin)
        }) { (error) in
            failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
        }
    }
    //MARK:- review Reply Post
    class func nokri_PostReplyReviews(parameter: NSDictionary, success: @escaping(CandProfileData)-> Void, failure: @escaping(NetworkError)-> Void) {
        let url = Constants.URL.baseUrl+Constants.URL.RatingsReply
        print(url)
        NetworkHandler.postRequest(url: url, parameters: parameter as? Parameters, success: { (successResponse) in
            let dictionary = successResponse as! [String: Any]
            let objLogin = CandProfileData(fromDictionary: dictionary)
            success(objLogin)
        }) { (error) in
            failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
        }
    }


    //MARK:- Candidate Search
    
    class func nokri_candidateSearch(success: @escaping(CandidateSearchRoot)->Void, failure: @escaping(NetworkError)->Void) {
        let url = Constants.URL.baseUrl+Constants.URL.candidateSearch
        print(url)
        NetworkHandler.getRequest(url: url, parameters: nil, success: { (successResponse) in
            let dictionary = successResponse as! [String: Any]
            let objData = CandidateSearchRoot(fromDictionary: dictionary)
            success(objData)
        }) { (error) in
            failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
        }
    }
    
    //MARK:- Candidate Personal Info
    
    class func nokri_candidatePersonalInfo(success: @escaping(PersonalInfoRoot)->Void, failure: @escaping(NetworkError)->Void) {
        let url = Constants.URL.baseUrl+Constants.URL.canPersonalInfo
        print(url)
        NetworkHandler.getRequest(url: url, parameters: nil, success: { (successResponse) in
            let dictionary = successResponse as! [String: Any]
            let objData = PersonalInfoRoot(fromDictionary: dictionary)
            success(objData)
        }) { (error) in
            failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
        }
    }

    class func nokri_personalInfoPost(parameter: NSDictionary, success: @escaping(PersonalInfoRoot)-> Void, failure: @escaping(NetworkError)-> Void) {
        let url = Constants.URL.baseUrl+Constants.URL.canPersonalInfo
        print(url)
        NetworkHandler.postRequest(url: url, parameters: parameter as? Parameters, success: { (successResponse) in
            let dictionary = successResponse as! [String: Any]
            let obj = PersonalInfoRoot(fromDictionary: dictionary)
            success(obj)
        }) { (error) in
            failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
        }
    }
    
    class func nokri_uploadImage(fileName:String, fileUrl: URL,progress: @escaping(Int)-> Void, success: @escaping(ImageUploadRoot)-> Void, failure: @escaping(NetworkError)-> Void) {
        let url = Constants.URL.baseUrl+Constants.URL.canImageUpload
        print(url)
        
        NetworkHandler.upload(url: url, fileUrl: fileUrl,fileName:fileName, params: [:], uploadProgress:  progress, success: { (successResponse) in
            let dictionary = successResponse as! [String: Any]
            let obj = ImageUploadRoot(fromDictionary: dictionary)
            success(obj)
        }) { (error) in
            failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
        }
    }
    
    //MARK:- Candidate Skills
    
    class func nokri_candidateSkill(success: @escaping(AddSkillCandRoot)->Void, failure: @escaping(NetworkError)->Void) {
        let url = Constants.URL.baseUrl+Constants.URL.candSkills
        print(url)
        NetworkHandler.getRequest(url: url, parameters: nil, success: { (successResponse) in
            let dictionary = successResponse as! [String: Any]
            let objData = AddSkillCandRoot(fromDictionary: dictionary)
            success(objData)
        }) { (error) in
            failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
        }
    }
    
    class func nokri_CandSkillsPost(parameter: NSDictionary, success: @escaping(UpdateSkillsRoot)-> Void, failure: @escaping(NetworkError)-> Void) {
        let url = Constants.URL.baseUrl+Constants.URL.candSkills
        print(url)
        NetworkHandler.postRequest(url: url, parameters: parameter as? Parameters, success: { (successResponse) in
            let dictionary = successResponse as! [String: Any]
            let objForgot = UpdateSkillsRoot(fromDictionary: dictionary)
            success(objForgot)
        }) { (error) in
            failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
        }
    }
//    class func nokri_candidateSkillPost(success: @escaping(AddSkillCandRoot)->Void, failure: @escaping(NetworkError)->Void) {
//
//        let url = Constants.URL.baseUrl+Constants.URL.candSkills
//        print(url)
//
//        NetworkHandler.getRequest(url: url, parameters: nil, success: { (successResponse) in
//            let dictionary = successResponse as! [String: Any]
//            let objData = AddSkillCandRoot(fromDictionary: dictionary)
//            success(objData)
//        }) { (error) in
//            failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
//        }
//    }
    
    //MARK:- Candidate SocialLinks
    
    class func nokri_candidateSocialLinksGet(success: @escaping(CandSocialLinksRoot)->Void, failure: @escaping(NetworkError)->Void) {
        
        let url = Constants.URL.baseUrl+Constants.URL.candSocialLinks
        print(url)
        NetworkHandler.getRequest(url: url, parameters: nil, success: { (successResponse) in
            let dictionary = successResponse as! [String: Any]
            let objData = CandSocialLinksRoot(fromDictionary: dictionary)
            success(objData)
        }) { (error) in
            failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
        }
    }
    
   class func nokri_candidateSocialLinksPost(parameter: NSDictionary, success: @escaping(CandSocialLinksRoot)-> Void, failure: @escaping(NetworkError)-> Void) {
    
        let url = Constants.URL.baseUrl+Constants.URL.candSocialLinks
        print(url)
        NetworkHandler.postRequest(url: url, parameters: parameter as? Parameters, success: { (successResponse) in
            let dictionary = successResponse as! [String: Any]
            let obj = CandSocialLinksRoot(fromDictionary: dictionary)
            success(obj)
        }) { (error) in
            failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
        }
    }
    
    //MARK:- Candidate Location
    
    class func nokri_canLocationData(success: @escaping(CanLocationRoot)->Void, failure: @escaping(NetworkError)->Void) {
        
        let url = Constants.URL.baseUrl+Constants.URL.candLocation
        print(url)
        NetworkHandler.getRequest(url: url, parameters: nil, success: { (successResponse) in
            let dictionary = successResponse as! [String: Any]
            let objData = CanLocationRoot(fromDictionary: dictionary)
            success(objData)
        }) { (error) in
            failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
        }
    }
    
    class func nokri_canLocationPost(parameter: NSDictionary, success: @escaping(CanLocationRoot)-> Void, failure: @escaping(NetworkError)-> Void) {
        let url = Constants.URL.baseUrl+Constants.URL.candLocation
        print(url)
        NetworkHandler.postRequest(url: url, parameters: parameter as? Parameters, success: { (successResponse) in
            let dictionary = successResponse as! [String: Any]
            let objLocation = CanLocationRoot(fromDictionary: dictionary)
            success(objLocation)
        }) { (error) in
            failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
        }
    }
    
    //MARK:- Candidate Portfolio
    
    class func nokri_canPortfolioGet(success: @escaping(CandPortfolioRoot)->Void, failure: @escaping(NetworkError)->Void) {
        let url = Constants.URL.baseUrl+Constants.URL.candPortfolioGet
        print(url)
        NetworkHandler.getRequest(url: url, parameters: nil, success: { (successResponse) in
            let dictionary = successResponse as! [String: Any]
            let objData = CandPortfolioRoot(fromDictionary: dictionary)
            success(objData)
        }) { (error) in
            failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
        }
    }
    
    class func nokri_compPortfolioGet(success: @escaping(CandPortfolioRoot)->Void, failure: @escaping(NetworkError)->Void) {
           let url = Constants.URL.baseUrl+Constants.URL.compPortfolioGet
           print(url)
           NetworkHandler.getRequest(url: url, parameters: nil, success: { (successResponse) in
               let dictionary = successResponse as! [String: Any]
               let objData = CandPortfolioRoot(fromDictionary: dictionary)
               success(objData)
           }) { (error) in
               failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
           }
       }
    
    class func nokri_uploadImageArr(fileName:String, images: [UIImage],progress: @escaping(Int)-> Void, success: @escaping(candPortfolioRootPost)-> Void, failure: @escaping(NetworkError)-> Void) {
        
        let url = Constants.URL.baseUrl+Constants.URL.candPortfolioPost
        print(url)
        NetworkHandler.uploadImageArrayNew(url: url, imagesArray: images, fileName: "portfolio_upload[]", params: nil, uploadProgress: progress, success: { (successResponse) in
            
            let dictionary = successResponse as! [String: Any]
            let obj = candPortfolioRootPost(fromDictionary: dictionary)
            success(obj)
            
        }, failure: { (error) in
           failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
        })
    }
    
    
    class func nokri_videoUpload(fileName:String, vUrl: URL,progress: @escaping(Int)-> Void, success: @escaping(candPortfolioRootPost)-> Void, failure: @escaping(NetworkError)-> Void) {
        
        let url = Constants.URL.baseUrl+Constants.URL.videoUrlUp
        print(url)
        NetworkHandler.uploadVideo(url: url, fileUrl: vUrl, fileName: "resume_video", params: nil, uploadProgress: progress, success: { (successResponse) in
            
            let dictionary = successResponse as! [String: Any]
            let obj = candPortfolioRootPost(fromDictionary: dictionary)
            success(obj)
            
        }, failure: { (error) in
           failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
        })
    }
    
    class func nokri_CompUploadImageArr(fileName:String, images: [UIImage],progress: @escaping(Int)-> Void, success: @escaping(candPortfolioRootPost)-> Void, failure: @escaping(NetworkError)-> Void) {
        
        let url = Constants.URL.baseUrl+Constants.URL.companyPortfolioImage
        print(url)
        NetworkHandler.uploadImageArrayNew(url: url, imagesArray: images, fileName: "portfolio_upload[]", params: nil, uploadProgress: progress, success: { (successResponse) in
            
            let dictionary = successResponse as! [String: Any]
            let obj = candPortfolioRootPost(fromDictionary: dictionary)
            success(obj)
            
        }, failure: { (error) in
           failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
        })
    }
    
    class func nokri_canPortfolioDel(parameter: NSDictionary, success: @escaping(EmailTempRoot)-> Void, failure: @escaping(NetworkError)-> Void) {
        let url = Constants.URL.baseUrl+Constants.URL.candPortfolioDelete
        print(url)
        NetworkHandler.postRequest(url: url, parameters: parameter as? Parameters, success: { (successResponse) in
            let dictionary = successResponse as! [String: Any]
            let objLocation = EmailTempRoot(fromDictionary: dictionary)
            success(objLocation)
        }) { (error) in
            failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
        }
    }
    
    class func nokri_compPortfolioDel(parameter: NSDictionary, success: @escaping(EmailTempRoot)-> Void, failure: @escaping(NetworkError)-> Void) {
           let url = Constants.URL.baseUrl+Constants.URL.compPortfolioDelete
           print(url)
           NetworkHandler.postRequest(url: url, parameters: parameter as? Parameters, success: { (successResponse) in
               let dictionary = successResponse as! [String: Any]
               let objLocation = EmailTempRoot(fromDictionary: dictionary)
               success(objLocation)
           }) { (error) in
               failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
           }
       }
    
    //MARK:- Resumes
    
    class func nokri_canResumesGet(success: @escaping(CandPortfolioRoot)->Void, failure: @escaping(NetworkError)->Void) {
        
        let url = Constants.URL.baseUrl+Constants.URL.candResumesGet
        print(url)
        NetworkHandler.getRequest(url: url, parameters: nil, success: { (successResponse) in
            let dictionary = successResponse as! [String: Any]
            let objData = CandPortfolioRoot(fromDictionary: dictionary)
            success(objData)
        }) { (error) in
            failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
        }
    }
    
    class func nokri_uploadResume(fileName:String, fileUrl: URL,progress: @escaping(Int)-> Void, success: @escaping(ImageUploadRoot)-> Void, failure: @escaping(NetworkError)-> Void) {
        let url = Constants.URL.baseUrl+Constants.URL.candResumesUpload
        print(url)
        NetworkHandler.upload(url: url, fileUrl: fileUrl,fileName:"my_cv_upload", params: [:], uploadProgress:  progress, success: { (successResponse) in
            let dictionary = successResponse as! [String: Any]
            let obj = ImageUploadRoot(fromDictionary: dictionary)
            success(obj)
        }) { (error) in
            failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
        }
    }
    
    class func nokri_uploadResumeJobPost(fileName:String, fileUrl: URL,progress: @escaping(Int)-> Void, success: @escaping(ImageUploadRoot)-> Void, failure: @escaping(NetworkError)-> Void) {
        let url = Constants.URL.baseUrl+Constants.URL.multiImages
        print(url)
        NetworkHandler.upload(url: url, fileUrl: fileUrl,fileName:"my_cv_upload", params: [:], uploadProgress:  progress, success: { (successResponse) in
            let dictionary = successResponse as! [String: Any]
            let obj = ImageUploadRoot(fromDictionary: dictionary)
            success(obj)
        }) { (error) in
            failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
        }
    }
    
    class func nokri_uploadResumeWithOutLogin(fileName:String, fileUrl: URL,progress: @escaping(Int)-> Void, success: @escaping(ImageUploadRoot)-> Void, failure: @escaping(NetworkError)-> Void) {
        let url = Constants.URL.baseUrl+Constants.URL.candResumesUploadWithOutLogin
        print(url)
        NetworkHandler.upload(url: url, fileUrl: fileUrl,fileName:"my_cv_upload", params: [:], uploadProgress:  progress, success: { (successResponse) in
            let dictionary = successResponse as! [String: Any]
            let obj = ImageUploadRoot(fromDictionary: dictionary)
            success(obj)
        }) { (error) in
            failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
        }
    }
    
    class func nokri_uploadImageCompany(fileName:String, fileUrl: URL,progress: @escaping(Int)-> Void, success: @escaping(ImageUploadRoot)-> Void, failure: @escaping(NetworkError)-> Void) {
        let url = Constants.URL.baseUrl+Constants.URL.companyProfileImage
        print(url)
        NetworkHandler.upload(url: url, fileUrl: fileUrl,fileName:fileName, params: [:], uploadProgress:  progress, success: { (successResponse) in
            let dictionary = successResponse as! [String: Any]
            let obj = ImageUploadRoot(fromDictionary: dictionary)
            success(obj)
        }) { (error) in
            failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
        }
    }

    
    class func nokri_blogComment(parameter: NSDictionary, success: @escaping(BlogCommentRoot)-> Void, failure: @escaping(NetworkError)-> Void) {
        let url = Constants.URL.baseUrl+Constants.URL.blogComment
        print(url)
        NetworkHandler.postRequest(url: url, parameters: parameter as? Parameters, success: { (successResponse) in
            let dictionary = successResponse as! [String: Any]
            let obj = BlogCommentRoot(fromDictionary: dictionary)
            success(obj)
        }) { (error) in
            failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
        }
    }
    
    class func nokri_blogReply(parameter: NSDictionary, success: @escaping(BlogCommentRoot)-> Void, failure: @escaping(NetworkError)-> Void) {
        let url = Constants.URL.baseUrl+Constants.URL.blogComment
        print(url)
        NetworkHandler.postRequest(url: url, parameters: parameter as? Parameters, success: { (successResponse) in
            let dictionary = successResponse as! [String: Any]
            let obj = BlogCommentRoot(fromDictionary: dictionary)
            success(obj)
        }) { (error) in
            failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
        }
    }
    
    class func nokri_home(success: @escaping(homeRoot)->Void, failure: @escaping(NetworkError)->Void) {
        
        let url = Constants.URL.baseUrl+Constants.URL.home
        print(url)
        NetworkHandler.getRequest(url: url, parameters: nil, success: { (successResponse) in
            let dictionary = successResponse as! [String: Any]
            let objData = homeRoot(fromDictionary: dictionary)
            success(objData)
        }) { (error) in
            failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
        }
    }
    
    class func nokri_homePost(parameter: NSDictionary, success: @escaping(ForgotPasswordRoot)-> Void, failure: @escaping(NetworkError)-> Void) {
        let url = Constants.URL.baseUrl+Constants.URL.home
        print(url)
        NetworkHandler.postRequest(url: url, parameters: parameter as? Parameters, success: { (successResponse) in
            let dictionary = successResponse as! [String: Any]
            //let data = NSKeyedArchiver.archivedData(withRootObject: dictionary)
            //UserDefaults.standard.set(data, forKey: "userData")
           // UserDefaults.standard.synchronize()
            let objForgot = ForgotPasswordRoot(fromDictionary: dictionary)
            success(objForgot)
        }) { (error) in
            failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
        }
    }
    
    
    class func nokri_educationGet(success: @escaping(EducationRoot)->Void, failure: @escaping(NetworkError)->Void) {
        
        let url = Constants.URL.baseUrl+Constants.URL.educationalDetail
        print(url)
        NetworkHandler.getRequest(url: url, parameters: nil, success: { (successResponse) in
            let dictionary = successResponse as! [String: Any]
            let objData = EducationRoot(fromDictionary: dictionary)
            success(objData)
        }) { (error) in
            failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
        }
    }
    
    class func nokri_experienceGet(success: @escaping(ExperienceRoot)->Void, failure: @escaping(NetworkError)->Void) {
        
        let url = Constants.URL.baseUrl+Constants.URL.experienceDetail
        print(url)
        NetworkHandler.getRequest(url: url, parameters: nil, success: { (successResponse) in
            let dictionary = successResponse as! [String: Any]
            let objData = ExperienceRoot(fromDictionary: dictionary)
            success(objData)
        }) { (error) in
            failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
        }
    }
    
    class func nokri_certificationGet(success: @escaping(CertificationRoot)->Void, failure: @escaping(NetworkError)->Void) {
        
        let url = Constants.URL.baseUrl+Constants.URL.certificationGet
        print(url)
        NetworkHandler.getRequest(url: url, parameters: nil, success: { (successResponse) in
            let dictionary = successResponse as! [String: Any]
            let objData = CertificationRoot(fromDictionary: dictionary)
            success(objData)
        }) { (error) in
            failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
        }
    }
    
    class func nokri_takeActionGet(success: @escaping(TakeActionRoot)->Void, failure: @escaping(NetworkError)->Void) {
        
        let url = Constants.URL.baseUrl+Constants.URL.takeActionGet
        print(url)
        NetworkHandler.getRequest(url: url, parameters: nil, success: { (successResponse) in
            let dictionary = successResponse as! [String: Any]
            let objData = TakeActionRoot(fromDictionary: dictionary)
            success(objData)
        }) { (error) in
            failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
        }
    }
    
    class func nokri_takeActionPost(parameter: NSDictionary, success: @escaping(ResetPasswordRoot)-> Void, failure: @escaping(NetworkError)-> Void) {
        let url = Constants.URL.baseUrl+Constants.URL.takeActionPost
        print(url)
        NetworkHandler.postRequest(url: url, parameters: parameter as? Parameters, success: { (successResponse) in
            let dictionary = successResponse as! [String: Any]
            let objForgot = ResetPasswordRoot(fromDictionary: dictionary)
            success(objForgot)
        }) { (error) in
            failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
        }
    }
    
    class func nokri_selectTemplatePost(parameter: NSDictionary, success: @escaping(TakActionRoot)-> Void, failure: @escaping(NetworkError)-> Void) {
        let url = Constants.URL.baseUrl+Constants.URL.selectTemplatePost
        print(url)
        NetworkHandler.postRequest(url: url, parameters: parameter as? Parameters, success: { (successResponse) in
            let dictionary = successResponse as! [String: Any]
            let objForgot = TakActionRoot(fromDictionary: dictionary)
            success(objForgot)
        }) { (error) in
            failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
        }
    }

    class func nokri_applyJobGet(parameter: NSDictionary, success: @escaping(ApplyJobRoot)-> Void, failure: @escaping(NetworkError)-> Void) {
        let url = Constants.URL.baseUrl+Constants.URL.applyJobGet
        print(url)
        NetworkHandler.postRequest(url: url, parameters: parameter as? Parameters, success: { (successResponse) in
            let dictionary = successResponse as! [String: Any]
            let objForgot = ApplyJobRoot(fromDictionary: dictionary)
            success(objForgot)
        }) { (error) in
            failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
        }
    }
    
    
    class func nokri_applyJobPostMail(parameter: NSDictionary, success: @escaping(TakActionRoot)-> Void, failure: @escaping(NetworkError)-> Void) {
          let url = Constants.URL.baseUrl+Constants.URL.applyJobPostMail
          print(url)
          NetworkHandler.postRequest(url: url, parameters: parameter as? Parameters, success: { (successResponse) in
              let dictionary = successResponse as! [String: Any]
              let objForgot = TakActionRoot(fromDictionary: dictionary)
              success(objForgot)
          }) { (error) in
              failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
          }
      }
    
    
    class func nokri_applyJobPost(parameter: NSDictionary, success: @escaping(TakActionRoot)-> Void, failure: @escaping(NetworkError)-> Void) {
        let url = Constants.URL.baseUrl+Constants.URL.applyJobPost
        print(url)
        NetworkHandler.postRequest(url: url, parameters: parameter as? Parameters, success: { (successResponse) in
            let dictionary = successResponse as! [String: Any]
            let objForgot = TakActionRoot(fromDictionary: dictionary)
            success(objForgot)
        }) { (error) in
            failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
        }
    }

    class func nokri_loginActivity(success: @escaping(LoginActivityRoot)->Void, failure: @escaping(NetworkError)->Void) {
        let url = Constants.URL.baseUrl+Constants.URL.loginActivity
        print(url)
        
        NetworkHandler.getRequest(url: url, parameters: nil, success: { (successResponse) in
            let dictionary = successResponse as! [String: Any]
            let objData = LoginActivityRoot(fromDictionary: dictionary)
            success(objData)
        }) { (error) in
            failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
        }
    }
    
    class func nokri_deleteAccount(parameter: NSDictionary, success: @escaping(SaveJobRoot)-> Void, failure: @escaping(NetworkError)-> Void) {
        let url = Constants.URL.baseUrl+Constants.URL.deleteAccount
        print(url)
        NetworkHandler.postRequest(url: url, parameters: parameter as? Parameters, success: { (successResponse) in
            let dictionary = successResponse as! [String: Any]
            let objForgot = SaveJobRoot(fromDictionary: dictionary)
            success(objForgot)
        }) { (error) in
            failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
        }
    }
    
    class func nokri_videoUrl(parameter: NSDictionary, success: @escaping(SaveJobRoot)-> Void, failure: @escaping(NetworkError)-> Void) {
        let url = Constants.URL.baseUrl+Constants.URL.videoUrl
        print(url)
        NetworkHandler.postRequest(url: url, parameters: parameter as? Parameters, success: { (successResponse) in
            let dictionary = successResponse as! [String: Any]
            let objForgot = SaveJobRoot(fromDictionary: dictionary)
            success(objForgot)
        }) { (error) in
            failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
        }
    }
    
    class func nokri_videoUrlCompany(parameter: NSDictionary, success: @escaping(SaveJobRoot)-> Void, failure: @escaping(NetworkError)-> Void) {
           let url = Constants.URL.baseUrl+Constants.URL.videoUrlComp
           print(url)
           NetworkHandler.postRequest(url: url, parameters: parameter as? Parameters, success: { (successResponse) in
               let dictionary = successResponse as! [String: Any]
               let objForgot = SaveJobRoot(fromDictionary: dictionary)
               success(objForgot)
           }) { (error) in
               failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
           }
       }
    
    class func nokri_videoUrlCand(parameter: NSDictionary, success: @escaping(SaveJobRoot)-> Void, failure: @escaping(NetworkError)-> Void) {
          let url = Constants.URL.baseUrl+Constants.URL.videoUrlCand
          print(url)
          NetworkHandler.postRequest(url: url, parameters: parameter as? Parameters, success: { (successResponse) in
              let dictionary = successResponse as! [String: Any]
              let objForgot = SaveJobRoot(fromDictionary: dictionary)
              success(objForgot)
          }) { (error) in
              failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
          }
      }
    
    class func nokri_FeedBackPost(parameter: NSDictionary, success: @escaping(SaveJobRoot)-> Void, failure: @escaping(NetworkError)-> Void) {
        let url = Constants.URL.baseUrl+Constants.URL.feedBack
        print(url)
        NetworkHandler.postRequest(url: url, parameters: parameter as? Parameters, success: { (successResponse) in
            let dictionary = successResponse as! [String: Any]
            let objForgot = SaveJobRoot(fromDictionary: dictionary)
            success(objForgot)
        }) { (error) in
            failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
        }
    }
    
    class func nokri_CompanyContactPost(parameter: NSDictionary, success: @escaping(SaveJobRoot)-> Void, failure: @escaping(NetworkError)-> Void) {
        let url = Constants.URL.baseUrl+Constants.URL.companyContact
        print(url)
        NetworkHandler.postRequest(url: url, parameters: parameter as? Parameters, success: { (successResponse) in
            let dictionary = successResponse as! [String: Any]
            let objForgot = SaveJobRoot(fromDictionary: dictionary)
            success(objForgot)
        }) { (error) in
            failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
        }
    }
    
    class func nokri_CandidateContactPost(parameter: NSDictionary, success: @escaping(SaveJobRoot)-> Void, failure: @escaping(NetworkError)-> Void) {
        let url = Constants.URL.baseUrl+Constants.URL.candidateContact
        print(url)
        NetworkHandler.postRequest(url: url, parameters: parameter as? Parameters, success: { (successResponse) in
            let dictionary = successResponse as! [String: Any]
            let objForgot = SaveJobRoot(fromDictionary: dictionary)
            success(objForgot)
        }) { (error) in
            failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
        }
    }
    
    
    class func nokri_HomeTwo(success: @escaping(HomeTwoRoot)->Void, failure: @escaping(NetworkError)->Void) {
        
        let url = Constants.URL.baseUrl+Constants.URL.homeTwo
        print(url)
        NetworkHandler.getRequest(url: url, parameters: nil, success: { (successResponse) in
            let dictionary = successResponse as! [String: Any]
            let objData = HomeTwoRoot(fromDictionary: dictionary)
            success(objData)
        }) { (error) in
            failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
        }
    }
    
    class func nokri_PostJobCustome(parameter: NSDictionary, success: @escaping(JobPostCustomRoot)-> Void, failure: @escaping(NetworkError)-> Void) {
           let url = Constants.URL.baseUrl+Constants.URL.dynamicFields
           print(url)
           NetworkHandler.postRequest(url: url, parameters: parameter as? Parameters, success: { (successResponse) in
               let dictionary = successResponse as! [String: Any]
               let objForgot = JobPostCustomRoot(fromDictionary: dictionary)
               success(objForgot)
           }) { (error) in
               failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
           }
       }
    

//    class func nokri_FeedbackGet(success: @escaping(FeedBackRoot)->Void, failure: @escaping(NetworkError)->Void) {
//        let url = Constants.URL.baseUrl+Constants.URL.feedBack
//        print(url)
//
//        NetworkHandler.getRequest(url: url, parameters: nil, success: { (successResponse) in
//            let dictionary = successResponse as! [String: Any]
//            let objData = FeedBackRoot(fromDictionary: dictionary)
//            success(objData)
//        }) { (error) in
//            failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
//        }
//    }
    
    //MARK:- Post Job
//    class func postJob(parameter: NSDictionary, success: @escaping(PostJobRoot)-> Void, failure: @escaping(NetworkError)-> Void) {
//        let url = Constants.URL.baseUrl+Constants.URL.jobPost
//        print(url)
//        NetworkHandler.postRequest(url: url, parameters: parameter as? Parameters, success: { (successResponse) in
//            let dictionary = successResponse as! [String: Any]
//            let obj = PostJobRoot(fromDictionary: dictionary)
//            success(obj)
//        }) { (error) in
//            failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
//        }
//    }
//
    
    class func nokri_EmailAlertPost(parameter: NSDictionary, success: @escaping(ForgotPasswordRoot)-> Void, failure: @escaping(NetworkError)-> Void) {
           let url = Constants.URL.baseUrl+Constants.URL.emailAlert
           print(url)
           NetworkHandler.postRequest(url: url, parameters: parameter as? Parameters, success: { (successResponse) in
               let dictionary = successResponse as! [String: Any]
           
               let objForgot = ForgotPasswordRoot(fromDictionary: dictionary)
               success(objForgot)
           }) { (error) in
               failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
           }
       }
    
    class func nokri_RemoveAlert(parameter: NSDictionary, success: @escaping(FollowerRoot)-> Void, failure: @escaping(NetworkError)-> Void) {
        let url = Constants.URL.baseUrl+Constants.URL.removeAlert
        print(url)
        NetworkHandler.postRequest(url: url, parameters: parameter as? Parameters, success: { (successResponse) in
            let dictionary = successResponse as! [String: Any]
            let obj = FollowerRoot(fromDictionary: dictionary)
            success(obj)
        }) { (error) in
            failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
        }
    }
    
    class func nokri_buyAlertGet(parameter: NSDictionary, success: @escaping(AlertGetPost)-> Void, failure: @escaping(NetworkError)-> Void) {
           let url = Constants.URL.baseUrl+Constants.URL.buyAlertGet
           print(url)
           NetworkHandler.postRequest(url: url, parameters: parameter as? Parameters, success: { (successResponse) in
               let dictionary = successResponse as! [String: Any]
           
               let alertData = AlertGetPost(fromDictionary: dictionary)
               success(alertData)
           }) { (error) in
               failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
           }
       }

    
}

