
//
//  LeftViewController.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 4/11/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift
import FBSDKCoreKit
import FBSDKLoginKit
import RAMAnimatedTabBarController
import AuthenticationServices



enum LeftMenu: Int {

    case home = 0
    case dashBoard
    case editProfile
    case myProfile
    case myResumes
    case jobs
    case jobsApplied
    case jobsForYou
    case savedJobs
    case advanceSearch
    case employerSearch
    case followedCompanies
    case jobNotification
    case jobAlert
    case candPkg
    case candPkgDetail
    case bloged
    case setting
    case language
    case logouT
    case exit
    
}

enum LeftMenu2: Int {
    
    case home = 0
    case explrore
    case blogg
    case sighIn
    case signUp
    case setting
    case language
    case Exit
    
}

enum LeftMenu3: Int {
    
    case home = 0
    case dashBoard
    case editProfile
    case emailTemp
    case job
    case follower
    case matchResume
    case saveResume
    case jobPost
    case PackageDetail
    case package
    case blog
    case canSearch
    case employerSearch
    case setting
    case language
    case logout
    case exit
    
    
}

protocol LeftMenuProtocol : class {
    func changeViewController(_ menu: LeftMenu)
}

protocol LeftMenuProtocol2 : class {
    func changeViewController2(_ menu2: LeftMenu2)
}

protocol LeftMenuProtocol3 : class {
    func changeViewController3(_ menu3: LeftMenu3)
}

class LeftViewController : UIViewController, LeftMenuProtocol,LeftMenuProtocol2,LeftMenuProtocol3,ASAuthorizationControllerDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet var backGroundView: UIView!
    
    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var appColorNew = UserDefaults.standard.string(forKey: "app_Color")
    var menus = [String]()
    var menuIcons = [UIImage]()
    var aType:Int = 4
    var menusCompany = [String]()
    var menuIconsCompany = [UIImage]()
    var menuWithOutLogin = [String]()
    var menuIconsWithOutLogin = [UIImage]()
    
    var homeViewController: UIViewController!
    var dashBoardController: UIViewController!
    var editProfileController: UIViewController!
    var myProfileController: UIViewController!
    var myResumeController: UIViewController!
    var jobsController: UIViewController!
    var jobAppliedController: UIViewController!
    var jobsForYouController: UIViewController!
    var savedJobController: UIViewController!
    var advanceSearchController: UIViewController!
    var followedCompaniesController: UIViewController!
    var saveResumesController: UIViewController!
    var blogController: UIViewController!
    var signUpController: UIViewController!
    var dashboardCompany: UIViewController!
    var companyInfoController: UIViewController!
    var companyJobController: UIViewController!
    var companyFollower: UIViewController!
    var packageDetailController: UIViewController!
    var packagesController: UIViewController!
    var emailTemplateController: UIViewController!
    var postJobController: UIViewController!
    var faqController: UIViewController!
    var settingController: UIViewController!
    var candidateSearchController: UIViewController!
    var jobAlertController: UIViewController!
    var matchResumeController: UIViewController!
    var candPackageController: UIViewController!
    var candPackageDetailController: UIViewController!
    var jobnotificationController: UIViewController!
    var employerSearchController: UIViewController!
    var languageController: UIViewController!
    var imageHeaderView: UIImageView!
    var window: UIWindow?
    var signUp:String?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func nokri_appShare(){
        let link = NSURL(string: "http://www.sadadaaafaf.com")
        let shareTitle = "Test"
        let shareText = "Test"
        let vc = UIActivityViewController(activityItems: [shareTitle,shareText,link!], applicationActivities: nil)
        self.present(vc, animated: true, completion: nil)
    }
    
    func nokri_settngData() {
        if let userData = UserDefaults.standard.object(forKey: "settingsData") {
            let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
            let dataTabs = SplashRoot(fromDictionary: objData)
            let obj = dataTabs.data.tabs
            let obj2 = dataTabs.data.empTabs
            let obj3 = dataTabs.data.guestTabs
            let objExtraTxt = dataTabs.data.extra.setting
            
            let iswpml = UserDefaults.standard.bool(forKey: "isWpmlActive")
                        
            //if iswpml == true{
            menus = [obj!.home,obj!.dashboard,obj!.edit,obj!.profile,obj!.resume,obj!.jobs,obj!.apllied,dataTabs.data.extra.jobsFor,obj!.saved,obj!.search,dataTabs.data.extra.employerSearch,/*obj!.canSearch,*/obj!.company,dataTabs.data.extra.notifypage,dataTabs.data.extra.jobalert,obj2!.buyPackage,obj2!.pkgDetail ,obj!.blog,/*obj!.faq,*/objExtraTxt,dataTabs.data.extra.lang,obj!.logout,obj!.exit] as! [String]
            menuIcons = [#imageLiteral(resourceName: "iconHome"),#imageLiteral(resourceName: "iconDashboard"),#imageLiteral(resourceName: "iconUpdateProfile"),#imageLiteral(resourceName: "iconProfile"),#imageLiteral(resourceName: "iconMyResume"),#imageLiteral(resourceName: "iconAllJobs"),#imageLiteral(resourceName: "iconJobApplied"),#imageLiteral(resourceName: "customer"),#imageLiteral(resourceName: "iconJobApplied"),#imageLiteral(resourceName: "iconSearch"),#imageLiteral(resourceName: "employer_search_icon"),#imageLiteral(resourceName: "icomFollowers"),#imageLiteral(resourceName: "bell"),#imageLiteral(resourceName: "alarm"),#imageLiteral(resourceName: "iconPackages"),#imageLiteral(resourceName: "iconPkgDetail"),#imageLiteral(resourceName: "iconBlog"),#imageLiteral(resourceName: "settings"),#imageLiteral(resourceName: "globe"),#imageLiteral(resourceName: "iconLogout"),#imageLiteral(resourceName: "iconExit")]
            menusCompany = [obj2!.home,obj2!.dashboard,obj2!.profile,obj2!.templates,obj2!.jobs,obj2!.followers,dataTabs.data.extra.matched_resume,dataTabs.data.extra.saved_resumes,obj2!.postJob,obj2!.pkgDetail,obj2!.buyPackage,obj2!.blog,obj2!.canSearch,dataTabs.data.extra.employerSearch,/*obj2!.faq,*/objExtraTxt,dataTabs.data.extra.lang,obj2!.logout,obj2!.exit] as! [String]
            menuIconsCompany = [#imageLiteral(resourceName: "iconHome"),#imageLiteral(resourceName: "iconDashboard"),#imageLiteral(resourceName: "iconUpdateProfile"),#imageLiteral(resourceName: "iconMsg"),#imageLiteral(resourceName: "iconAllJobs"),#imageLiteral(resourceName: "icomFollowers"),#imageLiteral(resourceName: "matched_resume_icon"),#imageLiteral(resourceName: "save-file"),#imageLiteral(resourceName: "iconPostJob"),#imageLiteral(resourceName: "iconPackages"),#imageLiteral(resourceName: "iconPkgDetail"),#imageLiteral(resourceName: "iconBlog"),#imageLiteral(resourceName: "iconCanSearch"),#imageLiteral(resourceName: "employer_search_icon"),#imageLiteral(resourceName: "settings"),#imageLiteral(resourceName: "globe"),#imageLiteral(resourceName: "iconLogout"),#imageLiteral(resourceName: "iconExit")]
            menuWithOutLogin = [obj3!.home,obj3!.explore,/*obj3!.canSearch*/obj3!.templates,obj3!.signin,obj3!.signup,/*obj3!.faq,"Share",*/objExtraTxt,dataTabs.data.extra.lang,obj3!.exit] as! [String]
            menuIconsWithOutLogin = [#imageLiteral(resourceName: "iconHome"),#imageLiteral(resourceName: "iconSearch"),/*#imageLiteral(resourceName: "iconCanSearch")*/#imageLiteral(resourceName: "iconBlog"),#imageLiteral(resourceName: "iconSignIn"),#imageLiteral(resourceName: "iconSignUp"),#imageLiteral(resourceName: "settings"),#imageLiteral(resourceName: "globe"),#imageLiteral(resourceName: "iconExit")]
//            }else{
//                menus = [obj!.home,obj!.dashboard,obj!.edit,obj!.profile,obj!.resume,obj!.jobs,obj!.apllied,dataTabs.data.extra.jobsFor,obj!.saved,obj!.search,dataTabs.data.extra.employerSearch,/*obj!.canSearch,*/obj!.company,dataTabs.data.extra.notifypage,dataTabs.data.extra.jobalert,obj2!.buyPackage,obj2!.pkgDetail ,obj!.blog,/*obj!.faq,*/objExtraTxt,obj!.logout,obj!.exit] as! [String]
//                menuIcons = [#imageLiteral(resourceName: "iconHome"),#imageLiteral(resourceName: "iconDashboard"),#imageLiteral(resourceName: "iconUpdateProfile"),#imageLiteral(resourceName: "iconProfile"),#imageLiteral(resourceName: "iconMyResume"),#imageLiteral(resourceName: "iconAllJobs"),#imageLiteral(resourceName: "iconJobApplied"),#imageLiteral(resourceName: "customer"),#imageLiteral(resourceName: "iconJobApplied"),#imageLiteral(resourceName: "iconSearch"),#imageLiteral(resourceName: "employer_search_icon"),#imageLiteral(resourceName: "icomFollowers"),#imageLiteral(resourceName: "bell"),#imageLiteral(resourceName: "alarm"),#imageLiteral(resourceName: "iconPackages"),#imageLiteral(resourceName: "iconPkgDetail"),#imageLiteral(resourceName: "iconBlog"),#imageLiteral(resourceName: "settings"),#imageLiteral(resourceName: "iconLogout"),#imageLiteral(resourceName: "iconExit")]
//                menusCompany = [obj2!.home,obj2!.dashboard,obj2!.profile,obj2!.templates,obj2!.jobs,obj2!.followers,dataTabs.data.extra.matched_resume,dataTabs.data.extra.saved_resumes,obj2!.postJob,obj2!.pkgDetail,obj2!.buyPackage,obj2!.blog,obj2!.canSearch,dataTabs.data.extra.employerSearch,objExtraTxt,obj2!.logout,obj2!.exit] as! [String]
//                menuIconsCompany = [#imageLiteral(resourceName: "iconHome"),#imageLiteral(resourceName: "iconDashboard"),#imageLiteral(resourceName: "iconUpdateProfile"),#imageLiteral(resourceName: "iconMsg"),#imageLiteral(resourceName: "iconAllJobs"),#imageLiteral(resourceName: "icomFollowers"),#imageLiteral(resourceName: "matched_resume_icon"),#imageLiteral(resourceName: "save-file"),#imageLiteral(resourceName: "iconPostJob"),#imageLiteral(resourceName: "iconPackages"),#imageLiteral(resourceName: "iconPkgDetail"),#imageLiteral(resourceName: "iconBlog"),#imageLiteral(resourceName: "iconCanSearch"),#imageLiteral(resourceName: "employer_search_icon"),#imageLiteral(resourceName: "settings"),#imageLiteral(resourceName: "iconLogout"),#imageLiteral(resourceName: "iconExit")]
//                menuWithOutLogin = [obj3!.home,obj3!.explore,/*obj3!.canSearch*/obj3!.templates,obj3!.signin,obj3!.signup,/*obj3!.faq,"Share",*/objExtraTxt,obj3!.exit] as! [String]
//                menuIconsWithOutLogin = [#imageLiteral(resourceName: "iconHome"),#imageLiteral(resourceName: "iconSearch"),/*#imageLiteral(resourceName: "iconCanSearch")*/#imageLiteral(resourceName: "iconBlog"),#imageLiteral(resourceName: "iconSignIn"),#imageLiteral(resourceName: "iconSignUp"),#imageLiteral(resourceName: "settings"),#imageLiteral(resourceName: "iconExit")]
//            }
            var signUp = UserDefaults.standard.string(forKey: "signUp")
            if signUp == nil{
                signUp = "8"
            }else{
                signUp = UserDefaults.standard.string(forKey: "signUp")
            }
            
            let withOutLogin = UserDefaults.standard.string(forKey: "aType")
            let accountTypeFromFb = UserDefaults.standard.string(forKey: "acountTypeafb")
            if accountTypeFromFb == nil || accountTypeFromFb ==  ""{
                aType = 4
            } else{
                aType = Int(accountTypeFromFb!)!
            }
            
            let check = UserDefaults.standard.string(forKey: "loginCheck")
            if withOutLogin == "5"{
                if let imgUrl = URL(string: (obj3?.candDp)!) {
                    print(imgUrl)
                    self.imageView.sd_setImage(with: imgUrl, completed: nil)
                    self.imageView.sd_setShowActivityIndicatorView(true)
                    self.imageView.sd_setIndicatorStyle(.gray)
                }
                lblName.text = obj3?.guset
                self.lblEmail.text = ""
            }
            //5
            if check == "5"{
                //settingsData
                if let userdata = UserDefaults.standard.object(forKey: "userData") {
                    let objData = NSKeyedUnarchiver.unarchiveObject(with: userdata as! Data) as! [String: Any]
                    print(aType)
                    let data = LoginPostRoot(fromDictionary: objData)
                    if withOutLogin != "5"{
                        
                        if data.data != nil{
                            if data.data.userType == "0" || aType == 0  {
                                let isUpdatedImage = UserDefaults.standard.integer(forKey: "isUpdatedImage")
                                if data.data.profileImg != nil{
                                    if let imgUrl = URL(string: data.data.profileImg) {
                                        print(imgUrl)
                                        self.imageView.sd_setImage(with: imgUrl, completed: nil)
                                        self.imageView.sd_setShowActivityIndicatorView(true)
                                        self.imageView.sd_setIndicatorStyle(.gray)
                                    }
                                    UserDefaults.standard.set(data.data.profileImg, forKey: "img")
                                }
                                
                                self.lblName.text = data.data.displayName
                                UserDefaults.standard.set(data.data.displayName, forKey: "contactName")
                                self.lblEmail.text = data.data.userEmail
                                if isUpdatedImage == 10 {
                                    let updateImage = UserDefaults.standard.string(forKey: "updatedImage")
                                    if let imgUrl = URL(string: updateImage!) {
                                        print(imgUrl)
                                        self.imageView.sd_setImage(with: imgUrl, completed: nil)
                                        self.imageView.sd_setShowActivityIndicatorView(true)
                                        self.imageView.sd_setIndicatorStyle(.gray)
                                    }
                                }
                                let name = UserDefaults.standard.string(forKey: "updateName")
                                let isName = UserDefaults.standard.integer(forKey: "isUpdat")
                                if isName == 10{
                                    self.lblName.text = name
                                }
                            }
                            else{
                                if data.data.userType == "1" || aType == 1{
                                    if data.data.profileImg != nil{
                                        if let imgUrl = URL(string: data.data.profileImg) {
                                            print(imgUrl)
                                            
                                            self.imageView.sd_setImage(with: imgUrl, completed: nil)
                                            self.imageView.sd_setShowActivityIndicatorView(true)
                                            self.imageView.sd_setIndicatorStyle(.gray)
                                            UserDefaults.standard.set(data.data.profileImg, forKey: "img")
                                        }
                                    }
                                    
                                    self.lblName.text = data.data.displayName
                                    UserDefaults.standard.set(data.data.displayName, forKey: "contactName")
                                    self.lblEmail.text = data.data.userEmail
                                    let isUpdatedImage = UserDefaults.standard.integer(forKey: "isUpdatedImage")
                                    if isUpdatedImage == 5 {
                                        let updateImage = UserDefaults.standard.string(forKey: "updatedImage")
                                        if let imgUrl = URL(string: updateImage!) {
                                            print(imgUrl)
                                            self.imageView.sd_setImage(with: imgUrl, completed: nil)
                                            self.imageView.sd_setShowActivityIndicatorView(true)
                                            self.imageView.sd_setIndicatorStyle(.gray)
                                        }
                                        UserDefaults.standard.string(forKey: "updatedImage")
                                        
                                    }
                                    let name = UserDefaults.standard.string(forKey: "updateName")
                                    let isName = UserDefaults.standard.integer(forKey: "isUpdat")
                                    if isName == 10{
                                        self.lblName.text = name
                                    }
                                }
                            }
                            
                        }
                    }
                    
                    if withOutLogin == "5"{
                        if let imgUrl = URL(string: (obj3?.candDp)!) {
                            print(imgUrl)
                            self.imageView.sd_setImage(with: imgUrl, completed: nil)
                            self.imageView.sd_setShowActivityIndicatorView(true)
                            self.imageView.sd_setIndicatorStyle(.gray)
                        }
                        lblName.text = obj3?.guset
                        self.lblEmail.text = ""
                    }
                }
            }else{
                
                if let userdata = UserDefaults.standard.object(forKey: "userData") {
                    let objData = NSKeyedUnarchiver.unarchiveObject(with: userdata as! Data) as! [String: Any]
                    print(aType)
                    let data = SignUpPostRoot(fromDictionary: objData)
                    if withOutLogin != "5"{
                        if  aType == 0 || signUp == "0"  {
                            if data.data != nil{
                                if let imgUrl = URL(string: data.data.profileData.profileImg) {
                                    print(imgUrl)
                                    self.imageView.sd_setImage(with: imgUrl, completed: nil)
                                    self.imageView.sd_setShowActivityIndicatorView(true)
                                    self.imageView.sd_setIndicatorStyle(.gray)
                                }
                                UserDefaults.standard.set(data.data.profileData.profileImg, forKey: "img")
                                self.lblName.text = data.data.profileData.displayName
                                UserDefaults.standard.set(data.data.profileData.displayName, forKey: "contactName")
                                self.lblEmail.text = data.data.profileData.userEmail
                                
                                let isUpdatedImage = UserDefaults.standard.integer(forKey: "isUpdatedImage")
                                if isUpdatedImage == 10 {
                                    let updateImage = UserDefaults.standard.string(forKey: "updatedImage")
                                    if let imgUrl = URL(string: updateImage!) {
                                        print(imgUrl)
                                        self.imageView.sd_setImage(with: imgUrl, completed: nil)
                                        self.imageView.sd_setShowActivityIndicatorView(true)
                                        self.imageView.sd_setIndicatorStyle(.gray)
                                    }
                                }
                                let name = UserDefaults.standard.string(forKey: "updateName")
                                let isName = UserDefaults.standard.integer(forKey: "isUpdat")
                                if isName == 10{
                                    self.lblName.text = name
                                }
                            }
                            
                        }else{
//                            if aType == 1 || signUp == "1"{
                                if data.data != nil{
                                    if let imgUrl = URL(string: data.data.profileData.profileImg) {
                                        print(imgUrl)
                                        self.imageView.sd_setImage(with: imgUrl, completed: nil)
                                        self.imageView.sd_setShowActivityIndicatorView(true)
                                        self.imageView.sd_setIndicatorStyle(.gray)
                                    }
                                    UserDefaults.standard.set(data.data.profileData.profileImg, forKey: "img")
                                    self.lblName.text = data.data.profileData.displayName
                                    UserDefaults.standard.set(data.data.profileData.displayName, forKey: "contactName")
                                    self.lblEmail.text = data.data.profileData.userEmail
                                    let isUpdatedImage = UserDefaults.standard.integer(forKey: "isUpdatedImage")
                                    if isUpdatedImage == 5 {
                                        let updateImage = UserDefaults.standard.string(forKey: "updatedImage")
                                        if let imgUrl = URL(string: updateImage!) {
                                            print(imgUrl)
                                            self.imageView.sd_setImage(with: imgUrl, completed: nil)
                                            self.imageView.sd_setShowActivityIndicatorView(true)
                                            self.imageView.sd_setIndicatorStyle(.gray)
                                        }
                                    }
                                    let name = UserDefaults.standard.string(forKey: "updateName")
                                    let isName = UserDefaults.standard.integer(forKey: "isUpdat")
                                    if isName == 10{
                                        self.lblName.text = name
                                    }
//                                }
                            }
                        }
                    }
                    
                    if withOutLogin == "5"{
                        if let imgUrl = URL(string: (obj3?.candDp)!) {
                            print(imgUrl)
                            self.imageView.sd_setImage(with: imgUrl, completed: nil)
                            self.imageView.sd_setShowActivityIndicatorView(true)
                            self.imageView.sd_setIndicatorStyle(.gray)
                        }
                        lblName.text = obj3?.guset
                        self.lblEmail.text = ""
                    }
                }
                
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.nokri_settngData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserDefaults.standard.set(5 , forKey: "acountType")
        self.backGroundView.backgroundColor = UIColor(hex:appColorNew!)
        nokri_roundedImage()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        
        let homeViewController = storyboard.instantiateViewController(withIdentifier: "HomeOrignalTabViewController") as! HomeOrignalTabViewController
        //window?.rootViewController = UINavigationController(rootViewController: homeViewController)
        self.homeViewController = UINavigationController(rootViewController: homeViewController)
        
        let dashBoardController = storyboard.instantiateViewController(withIdentifier: "DashboardCompanyViewController") as! DashboardCompanyViewController
        self.dashBoardController = UINavigationController(rootViewController: dashBoardController)
        
        let editProfileController = storyboard.instantiateViewController(withIdentifier: "HomeTabViewController") as! HomeTabViewController
        self.editProfileController = UINavigationController(rootViewController: editProfileController)
        
        let myProfileVController = storyboard.instantiateViewController(withIdentifier: "MyProfileViewController") as! MyProfileViewController
        self.myProfileController = UINavigationController(rootViewController: myProfileVController)
        
        let myResumeController = storyboard.instantiateViewController(withIdentifier: "MyResumeViewController") as! MyResumeViewController
        self.myResumeController = UINavigationController(rootViewController: myResumeController)
        
        let jobsController = storyboard.instantiateViewController(withIdentifier: "JobsListViewController") as! JobsListViewController
        self.jobsController = UINavigationController(rootViewController: jobsController)
        
        let jobAppliedController = storyboard.instantiateViewController(withIdentifier: "JobsAppliedListViewController") as! JobsAppliedListViewController
        self.jobAppliedController = UINavigationController(rootViewController: jobAppliedController)
        let jobForYouController = storyboard.instantiateViewController(withIdentifier: "JobsForYouViewController") as! JobsForYouViewController
        self.jobsForYouController = UINavigationController(rootViewController: jobForYouController)
        
        let savedJobController = storyboard.instantiateViewController(withIdentifier: "JobsSavedListViewController") as! JobsSavedListViewController
        self.savedJobController = UINavigationController(rootViewController: savedJobController)
        
        let advanceSearchController = storyboard.instantiateViewController(withIdentifier: "AdvanceSearchViewController") as! AdvanceSearchViewController
        self.advanceSearchController = UINavigationController(rootViewController: advanceSearchController)
        
        let candidateSearchController = storyboard.instantiateViewController(withIdentifier: "CandSearchViewController") as! CandSearchViewController
        self.candidateSearchController = UINavigationController(rootViewController: candidateSearchController)
        
        let followedCompaniesController = storyboard.instantiateViewController(withIdentifier: "FollowedCompanyListViewController") as! FollowedCompanyListViewController
        self.followedCompaniesController = UINavigationController(rootViewController: followedCompaniesController)
        
        let savedResumesController = storyboard.instantiateViewController(withIdentifier: "SaveResumeViewController") as! SaveResumeViewController
        self.saveResumesController = UINavigationController(rootViewController: savedResumesController)
        
        let blogController = storyboard.instantiateViewController(withIdentifier: "BlogViewController") as! BlogViewController
        self.blogController = UINavigationController(rootViewController: blogController)
        
        let signUpController = storyboard.instantiateViewController(withIdentifier: "CustomSignupViewController") as! CustomSignupViewController
        self.signUpController = UINavigationController(rootViewController: signUpController)
        
        let companyDashboard = storyboard.instantiateViewController(withIdentifier: "DashboarCompanyViewController") as! DashboarCompanyViewController
        self.dashboardCompany = UINavigationController(rootViewController: companyDashboard)
        
        let companyInfoController = storyboard.instantiateViewController(withIdentifier: "EditProfileCompanyInfoViewController") as! EditProfileCompanyInfoViewController
        self.companyInfoController = UINavigationController(rootViewController: companyInfoController)
        
        let companyJobController = storyboard.instantiateViewController(withIdentifier: "CompanyActiveJobViewController") as! CompanyActiveJobViewController
        self.companyJobController = UINavigationController(rootViewController: companyJobController)
        
        let companyFollowerController = storyboard.instantiateViewController(withIdentifier: "CompanyFollowerViewController") as! CompanyFollowerViewController
        self.companyFollower = UINavigationController(rootViewController: companyFollowerController)
        
        let packageDetailController = storyboard.instantiateViewController(withIdentifier: "PackageDetailViewController") as! PackageDetailViewController
        self.packageDetailController = UINavigationController(rootViewController: packageDetailController)
        
        let packageController = storyboard.instantiateViewController(withIdentifier: "PackagesViewController") as! PackagesViewController
        self.packagesController = UINavigationController(rootViewController: packageController)
        
        let emailTemplateController = storyboard.instantiateViewController(withIdentifier: "EmailTemplateViewController") as! EmailTemplateViewController
        self.emailTemplateController = UINavigationController(rootViewController: emailTemplateController)
        
        let postJobController = storyboard.instantiateViewController(withIdentifier: "JobPostViewController") as! JobPostViewController
        self.postJobController = UINavigationController(rootViewController: postJobController)
        
        let faqController = storyboard.instantiateViewController(withIdentifier: "Faq_sViewController") as! Faq_sViewController
        self.faqController = UINavigationController(rootViewController: faqController)
        
        let settingController = storyboard.instantiateViewController(withIdentifier: "SettingViewController") as! SettingViewController
        self.settingController = UINavigationController(rootViewController: settingController)
        
        let jobAlertController = storyboard.instantiateViewController(withIdentifier: "JobAlertViewController") as! JobAlertViewController
        self.jobAlertController = UINavigationController(rootViewController: jobAlertController)
        
        let matchResumeController = storyboard.instantiateViewController(withIdentifier: "MatchedResumeViewController") as! MatchedResumeViewController
        self.matchResumeController = UINavigationController(rootViewController: matchResumeController)
        
        let candPackjController = storyboard.instantiateViewController(withIdentifier: "CandPackagesViewController") as! CandPackagesViewController
        self.candPackageController = UINavigationController(rootViewController: candPackjController)
        
        let candPackjDetController = storyboard.instantiateViewController(withIdentifier: "CandPkjDetailViewController") as! CandPkjDetailViewController
        self.candPackageDetailController = UINavigationController(rootViewController: candPackjDetController)
        
        let jobNotificationController = storyboard.instantiateViewController(withIdentifier: "JobNotificationViewController") as! JobNotificationViewController
        self.jobnotificationController = UINavigationController(rootViewController: jobNotificationController)
        
        let empSearchController = storyboard.instantiateViewController(withIdentifier: "EmployerSearchViewController") as! EmployerSearchViewController
        self.employerSearchController = UINavigationController(rootViewController: empSearchController)
        let langController = storyboard.instantiateViewController(withIdentifier: "LanguageViewController") as! LanguageViewController
        self.languageController = UINavigationController(rootViewController: langController)
        // self.settngData()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func nokri_roundedImage(){
        
        imageView.layer.borderWidth = 2
        imageView.layer.masksToBounds = false
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.cornerRadius = imageView.frame.height/2
        imageView.clipsToBounds = true
        
    }
    
    func changeViewController(_ menu: LeftMenu) {
        
        let withOutLogin = UserDefaults.standard.string(forKey: "aType")
        if withOutLogin != "5"{
            let accountTypeFromFb = UserDefaults.standard.string(forKey: "acountTypeafb")
            if accountTypeFromFb == nil || accountTypeFromFb ==  ""{
                aType = 4
            }else{
                aType = Int(accountTypeFromFb!)!
                
            }
            
            let check = UserDefaults.standard.string(forKey: "loginCheck")
            if check == "5"{
                if let userData = UserDefaults.standard.object(forKey: "userData") {
                    let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
                    let data = LoginPostRoot(fromDictionary: objData)
                    
                    if data.data.userType == "0" || aType == 0  {
                        switch menu {
                            
                        case .home:
                            
                            let isHome = UserDefaults.standard.string(forKey: "home")
                            if isHome == "1"{
                                appDelegate.nokri_moveToHome1()
                            }else{
                                appDelegate.nokri_moveToHome2()
                            }
                            
                        case .dashBoard:
                            appDelegate.nokri_moveToDashBoard()
                        case .editProfile:
                            appDelegate.nokri_moveToTabBarEmployeEditProfile()
                        case .myProfile:
                            appDelegate.nokri_moveToMyProfile()
                        case .myResumes:
                            appDelegate.nokri_moveToMyResume()
                        case .jobs:
                            appDelegate.nokri_moveToJobsList()
                        case .jobsApplied:
                            appDelegate.nokri_moveToJobsAppliedList()
                        case .jobsForYou:
                            appDelegate.nokri_moveToJobsForYouList()
                        case .savedJobs:
                            appDelegate.nokri_moveToJobsSavedList()
                        case .advanceSearch:
                            appDelegate.nokri_moveToAdvanceSearch()
                        case .employerSearch:
                            appDelegate.nokri_moveToEmployerSearch()
                        case .followedCompanies:
                            appDelegate.nokri_moveToFollowedCompany()
                        case .jobNotification:
                            appDelegate.nokri_moveToJobNotification()
                        case .jobAlert:
                            appDelegate.nokri_moveToJobAlertCompany()
                        case .candPkg:
                            appDelegate.nokri_moveTocandPkg()
                        case .candPkgDetail:
                            appDelegate.nokri_moveTocandPkgDetail()
                        case .bloged:
                            appDelegate.nokri_moveToBlog()
                        case .setting:
                            appDelegate.nokri_moveToSetting()
                        case .language:
                            appDelegate.nokri_moveToLang()
                        case .exit:
                            var confirmString:String?
                            var btnOk:String?
                            var btnCncel:String?
                            if let userData = UserDefaults.standard.object(forKey: "settingsData") {
                                let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
                                let dataTabs = SplashRoot(fromDictionary: objData)
                                confirmString = dataTabs.data.genericTxts.confirm
                                btnOk = dataTabs.data.genericTxts.btnConfirm
                                btnCncel = dataTabs.data.genericTxts.btnCancel
                            }
                            let Alert = UIAlertController(title: confirmString, message:"", preferredStyle: .alert)
                            let okButton = UIAlertAction(title: btnOk, style: .default) { _ in
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                                    self.showLoader()
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                                        exit(EXIT_SUCCESS)
                                    })
                                })
                                self.stopAnimating()
                                
                            }
                            let CancelButton = UIAlertAction(title: btnCncel, style: .cancel)
                            Alert.addAction(okButton)
                            Alert.addAction(CancelButton)
                            self.present(Alert, animated: true, completion: nil)
                            
                        case .logouT:
                            var confirmString:String?
                            var btnOk:String?
                            var btnCncel:String?
                            if let userData = UserDefaults.standard.object(forKey: "settingsData") {
                                let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
                                let dataTabs = SplashRoot(fromDictionary: objData)
                                confirmString = dataTabs.data.genericTxts.confirm
                                btnOk = dataTabs.data.genericTxts.btnConfirm
                                btnCncel = dataTabs.data.genericTxts.btnCancel
                            }
                            let Alert = UIAlertController(title: confirmString, message:"", preferredStyle: .alert)
                            let okButton = UIAlertAction(title: btnOk, style: .default) { _ in
                                
                                let loginManager = LoginManager()
                                loginManager.logOut()
                                UserDefaults.standard.set(false, forKey: "FirstTime")
                                UserDefaults.standard.set(nil , forKey: "id")
                                UserDefaults.standard.set(nil , forKey: "email")
                                UserDefaults.standard.set(nil, forKey: "password")
                                UserDefaults.standard.removeObject(forKey: "password")
                                UserDefaults.standard.set(false, forKey: "isSocial")
                                UserDefaults.standard.set("3" , forKey: "acountTypeafb")
                                self.aType = 100
                                UserDefaults.standard.set(5, forKey: "aType")
                                UserDefaults.standard.set(nil, forKey: "img")
                                self.appDelegate.nokri_moveToSignIn()
                                UserDefaults.standard.set(nil , forKey: "loginCheck")
                                UserDefaults.standard.set(nil, forKey: "isUpdat")
                                UserDefaults.standard.set(nil , forKey: "user_type")
                                UserDefaults.standard.set(0, forKey: "isUpdatedImage")
                                //self.appleLogut()
                                
                            }
                            let CancelButton = UIAlertAction(title: btnCncel, style: .cancel)
                            Alert.addAction(okButton)
                            Alert.addAction(CancelButton)
                            self.present(Alert, animated: true, completion: nil)
                      
                        }
                    }
                }
            }
            else{
                
                if signUp == nil{
                    signUp = "8"
                }else{
                    signUp = UserDefaults.standard.string(forKey: "signUp")
                }
                
                if let userData = UserDefaults.standard.object(forKey: "UserData") {
                    // let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
                    // let data = SignUpPostRoot(fromDictionary: objData)
                    
                    if aType == 0 || signUp == "0" {
                        switch menu {
                        case .home:
                            let isHome = UserDefaults.standard.string(forKey: "home")
                            if isHome == "1"{
                                appDelegate.nokri_moveToHome1()
                            }else{
                                appDelegate.nokri_moveToHome2()
                            }
                            
                        case .dashBoard:
                            appDelegate.nokri_moveToDashBoard()
                        case .editProfile:
                            appDelegate.nokri_moveToTabBarEmployeEditProfile()
                        case .myProfile:
                            appDelegate.nokri_moveToMyProfile()
                        case .myResumes:
                            appDelegate.nokri_moveToMyResume()
                        case .jobs:
                            appDelegate.nokri_moveToJobsList()
                        case .jobsApplied:
                            appDelegate.nokri_moveToJobsAppliedList()
                        case .jobsForYou:
                            appDelegate.nokri_moveToJobsForYouList()
                        case .savedJobs:
                            appDelegate.nokri_moveToJobsSavedList()
                        case .advanceSearch:
                            appDelegate.nokri_moveToAdvanceSearch()
                        case .employerSearch:
                            appDelegate.nokri_moveToEmployerSearch()
                            //case .candidateSearch:
                        //appDelegate.nokri_moveToCandidateSearch()
                        case .followedCompanies:
                            appDelegate.nokri_moveToFollowedCompany()
                        case .jobNotification:
                            appDelegate.nokri_moveToJobNotification()
                        case .jobAlert:
                            appDelegate.nokri_moveToJobAlertCompany()
                        case .candPkg:
                            appDelegate.nokri_moveTocandPkg()
                        case .candPkgDetail:
                            appDelegate.nokri_moveTocandPkgDetail()
                        case .bloged:
                            appDelegate.nokri_moveToBlog()
                            //case .faq:
                        //  appDelegate.nokri_moveToFaqs()
                        case .setting:
                            appDelegate.nokri_moveToSetting()
                        //nokri_appShare()
                        case .language:
                            appDelegate.nokri_moveToLang()
                        case .exit:
                            var confirmString:String?
                            var btnOk:String?
                            var btnCncel:String?
                            if let userData = UserDefaults.standard.object(forKey: "settingsData") {
                                let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
                                let dataTabs = SplashRoot(fromDictionary: objData)
                                confirmString = dataTabs.data.genericTxts.confirm
                                btnOk = dataTabs.data.genericTxts.btnConfirm
                                btnCncel = dataTabs.data.genericTxts.btnCancel
                            }
                            let Alert = UIAlertController(title: confirmString, message:"", preferredStyle: .alert)
                            let okButton = UIAlertAction(title: btnOk, style: .default) { _ in
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                                    self.startAnimating()
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                                        exit(EXIT_SUCCESS)
                                    })
                                })
                                self.stopAnimating()
                                
                            }
                            let CancelButton = UIAlertAction(title: btnCncel, style: .cancel)
                            Alert.addAction(okButton)
                            Alert.addAction(CancelButton)
                            self.present(Alert, animated: true, completion: nil)
                        case .logouT:
                            var confirmString:String?
                            var btnOk:String?
                            var btnCncel:String?
                            if let userData = UserDefaults.standard.object(forKey: "settingsData") {
                                let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
                                let dataTabs = SplashRoot(fromDictionary: objData)
                                confirmString = dataTabs.data.genericTxts.confirm
                                btnOk = dataTabs.data.genericTxts.btnConfirm
                                btnCncel = dataTabs.data.genericTxts.btnCancel
                            }
                            let Alert = UIAlertController(title: confirmString, message:"", preferredStyle: .alert)
                            let okButton = UIAlertAction(title: btnOk, style: .default) { _ in
                                
                                let loginManager = LoginManager()
                                loginManager.logOut()
                                UserDefaults.standard.set(false, forKey: "FirstTime")
                                UserDefaults.standard.set(nil , forKey: "id")
                                UserDefaults.standard.set(nil , forKey: "email")
                                UserDefaults.standard.set(nil, forKey: "password")
                                UserDefaults.standard.removeObject(forKey: "password")
                                UserDefaults.standard.set(false, forKey: "isSocial")
                                UserDefaults.standard.set("3" , forKey: "acountTypeafb")
                                self.aType = 100
                                UserDefaults.standard.set(5, forKey: "aType")
                                UserDefaults.standard.set(nil, forKey: "img")
                                UserDefaults.standard.set(nil, forKey: "isUpdat")
                                UserDefaults.standard.set(nil , forKey: "user_type")
                                UserDefaults.standard.set(nil , forKey: "loginCheck")
                                UserDefaults.standard.set(0, forKey: "isUpdatedImage")
                                //self.appleLogut()
                                self.appDelegate.nokri_moveToSignIn()
                                
                                
                            }
                            let CancelButton = UIAlertAction(title: btnCncel, style: .cancel)
                            Alert.addAction(okButton)
                            Alert.addAction(CancelButton)
                            self.present(Alert, animated: true, completion: nil)
                        }
                    }
                }
            }
        }
    }
    
    func changeViewController2(_ menu2: LeftMenu2) {
        
        UserDefaults.standard.set(true, forKey: "isNotSignIn")
       
        
        
        let withOutLogin = UserDefaults.standard.string(forKey: "aType")
        if withOutLogin == "5"{
            switch menu2 {
                
            case .home:
                let isHome = UserDefaults.standard.string(forKey: "home")
                if isHome == "1"{
                    appDelegate.nokri_moveToHome1()
                }else{
                    appDelegate.nokri_moveToHome2()
                }
                
            case .explrore:
                appDelegate.nokri_moveToAdvanceSearch()
            case .blogg:
                appDelegate.nokri_moveToBlog()
            case.sighIn:
                appDelegate.nokri_moveToSignIn()
            case.signUp:
                appDelegate.nokri_moveToSignUpCustom()
            case .setting:
                appDelegate.nokri_moveToSetting()
            case .language:
                appDelegate.nokri_moveToLang()
            case .Exit:
                var confirmString:String?
                var btnOk:String?
                var btnCncel:String?
                if let userData = UserDefaults.standard.object(forKey: "settingsData") {
                    let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
                    let dataTabs = SplashRoot(fromDictionary: objData)
                    confirmString = dataTabs.data.genericTxts.confirm
                    btnOk = dataTabs.data.genericTxts.btnConfirm
                    btnCncel = dataTabs.data.genericTxts.btnCancel
                }
                let Alert = UIAlertController(title: confirmString, message:"", preferredStyle: .alert)
                let okButton = UIAlertAction(title: btnOk, style: .default) { _ in
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                        self.showLoader()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                            exit(EXIT_SUCCESS)
                        })
                    })
                    self.stopAnimating()
                    
                }
                let CancelButton = UIAlertAction(title: btnCncel, style: .cancel)
                Alert.addAction(okButton)
                Alert.addAction(CancelButton)
                self.present(Alert, animated: true, completion: nil)
            }
        }
    }
    
    func changeViewController3(_ menu3: LeftMenu3) {
        
        let withOutLogin = UserDefaults.standard.string(forKey: "aType")
        
        if withOutLogin != "5"{
            
            let accountTypeFromFb = UserDefaults.standard.string(forKey: "acountTypeafb")
            if accountTypeFromFb == nil || accountTypeFromFb ==  ""{
                aType = 4
            }else{
                aType = Int(accountTypeFromFb!)!
            }
            let check = UserDefaults.standard.string(forKey: "loginCheck")
            
            if check == "5"{
                if let userData = UserDefaults.standard.object(forKey: "userData") {
                    let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
                    let data = LoginPostRoot(fromDictionary: objData)
                    if data.data.userType == "1" || aType == 1 {
                        switch menu3 {
                        case .home:
                            let isHome = UserDefaults.standard.string(forKey: "home")
                            if isHome == "1"{
                                appDelegate.nokri_moveToHome1()
                            }else{
                                appDelegate.nokri_moveToHome2()
                            }
                        case .dashBoard:
                            appDelegate.nokri_moveToCompanyDashboard()
                        case .editProfile:
                            appDelegate.nokri_moveToTabBarCompanyEditProfile()
                        case .emailTemp:
                            appDelegate.nokri_moveToEmailTemplate()
                        case .job:
                            appDelegate.nokri_moveToTabBarCompanyJob()
                        case .follower:
                            appDelegate.nokri_moveToCompanyFollower()
                        case .matchResume:
                            appDelegate.nokri_matchResumeCtrl()
                        case .saveResume:
                            appDelegate.nokri_moveToSaveResume()
                        case .jobPost:
                            let jobForm = UserDefaults.standard.bool(forKey: "job_form")
                            if jobForm == false{
                                appDelegate.nokri_moveToJobPost()
                            }else{
                                appDelegate.nokri_moveToJobPostCustom()
                            }
                        case .PackageDetail:
                            appDelegate.nokri_moveToPackageDetail()
                        case .package:
                            appDelegate.nokri_moveToPackage()
                        case .blog:
                            appDelegate.nokri_moveToBlog()
                        case .canSearch:
                            appDelegate.nokri_moveToCandidateSearch()
                        case .employerSearch:
                            appDelegate.nokri_moveToEmployerSearch()
                        case .setting:
                            appDelegate.nokri_moveToSetting()
                        case .language:
                            appDelegate.nokri_moveToLang()
                        case .logout:
                            var confirmString:String?
                            var btnOk:String?
                            var btnCncel:String?
                            if let userData = UserDefaults.standard.object(forKey: "settingsData") {
                                let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
                                let dataTabs = SplashRoot(fromDictionary: objData)
                                confirmString = dataTabs.data.genericTxts.confirm
                                btnOk = dataTabs.data.genericTxts.btnConfirm
                                btnCncel = dataTabs.data.genericTxts.btnCancel
                            }
                            let Alert = UIAlertController(title:confirmString, message:"", preferredStyle: .alert)
                            let okButton = UIAlertAction(title: btnOk, style: .default) { _ in
                                let loginManager = LoginManager()
                                loginManager.logOut()
                                UserDefaults.standard.set(false, forKey: "FirstTime")
                                UserDefaults.standard.set(false, forKey: "isSocial")
                                UserDefaults.standard.set(nil , forKey: "id")
                                UserDefaults.standard.set(nil , forKey: "email")
                                UserDefaults.standard.set(nil, forKey: "password")
                                UserDefaults.standard.removeObject(forKey: "password")
                                UserDefaults.standard.set(nil, forKey: "img")
                                UserDefaults.standard.set("3" , forKey: "acountTypeafb")
                                UserDefaults.standard.set(5, forKey: "aType")
                                UserDefaults.standard.set(nil, forKey: "isUpdat")
                                UserDefaults.standard.set(nil , forKey: "user_type")
                                UserDefaults.standard.set(nil , forKey: "loginCheck")
                                UserDefaults.standard.set(0, forKey: "isUpdatedImage")
                                //self.appleLogut()
                                self.appDelegate.nokri_moveToSignIn()
                            }
                            let CancelButton = UIAlertAction(title: btnCncel, style: .cancel)
                            Alert.addAction(okButton)
                            Alert.addAction(CancelButton)
                            self.present(Alert, animated: true, completion: nil)
                            
                        case .exit:
                            var confirmString:String?
                            var btnOk:String?
                            var btnCncel:String?
                            if let userData = UserDefaults.standard.object(forKey: "settingsData") {
                                let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
                                let dataTabs = SplashRoot(fromDictionary: objData)
                                confirmString = dataTabs.data.genericTxts.confirm
                                btnOk = dataTabs.data.genericTxts.btnConfirm
                                btnCncel = dataTabs.data.genericTxts.btnCancel
                            }
                            let Alert = UIAlertController(title: confirmString, message:"", preferredStyle: .alert)
                            let okButton = UIAlertAction(title: btnOk, style: .default) { _ in
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                                    self.showLoader()
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                                        exit(EXIT_SUCCESS)
                                    })
                                })
                                self.stopAnimating()
                            }
                            let CancelButton = UIAlertAction(title: btnCncel, style: .cancel)
                            Alert.addAction(okButton)
                            Alert.addAction(CancelButton)
                            self.present(Alert, animated: true, completion: nil)
                        }
                    }
                }
            }else{
                if signUp == nil{
                    signUp = "8"
                }else{
                    signUp = UserDefaults.standard.string(forKey: "signUp")
                }
                if aType == 1 || signUp == "1"{
                    switch menu3 {
                    case .home:
                        let isHome = UserDefaults.standard.string(forKey: "home")
                        if isHome == "1"{
                            appDelegate.nokri_moveToHome1()
                        }else{
                            appDelegate.nokri_moveToHome2()
                        }
                    case .dashBoard:
                        appDelegate.nokri_moveToCompanyDashboard()
                    case .editProfile:
                        appDelegate.nokri_moveToTabBarCompanyEditProfile()
                    case .emailTemp:
                        appDelegate.nokri_moveToEmailTemplate()
                    case .job:
                        appDelegate.nokri_moveToTabBarCompanyJob()
                    case .follower:
                        appDelegate.nokri_moveToCompanyFollower()
                    case .matchResume:
                        appDelegate.nokri_matchResumeCtrl()
                    case .saveResume:
                        appDelegate.nokri_moveToSaveResume()
                    case .jobPost:
                        let jobForm = UserDefaults.standard.bool(forKey: "job_form")
                        if jobForm == false{
                            appDelegate.nokri_moveToJobPost()
                        }else{
                            appDelegate.nokri_moveToJobPostCustom()
                        }
                    case .PackageDetail:
                        appDelegate.nokri_moveToPackageDetail()
                    case .package:
                        appDelegate.nokri_moveToPackage()
                    case .blog:
                        appDelegate.nokri_moveToBlog()
                    case .canSearch:
                        appDelegate.nokri_moveToCandidateSearch()
                    case .employerSearch:
                        appDelegate.nokri_moveToEmployerSearch()
                    case .setting:
                        appDelegate.nokri_moveToSetting()
                    case .language:
                        appDelegate.nokri_moveToLang()
                    case .logout:
                        var confirmString:String?
                        var btnOk:String?
                        var btnCncel:String?
                        if let userData = UserDefaults.standard.object(forKey: "settingsData") {
                            let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
                            let dataTabs = SplashRoot(fromDictionary: objData)
                            confirmString = dataTabs.data.genericTxts.confirm
                            btnOk = dataTabs.data.genericTxts.btnConfirm
                            btnCncel = dataTabs.data.genericTxts.btnCancel
                        }
                        let Alert = UIAlertController(title:confirmString, message:"", preferredStyle: .alert)
                        let okButton = UIAlertAction(title: btnOk, style: .default) { _ in
                            let loginManager = LoginManager()
                            loginManager.logOut()
                            UserDefaults.standard.set(false, forKey: "FirstTime")
                            UserDefaults.standard.set(false, forKey: "isSocial")
                            UserDefaults.standard.set(nil , forKey: "id")
                            UserDefaults.standard.set(nil , forKey: "email")
                            UserDefaults.standard.set(nil, forKey: "password")
                            UserDefaults.standard.removeObject(forKey: "password")
                            UserDefaults.standard.set(nil, forKey: "img")
                            UserDefaults.standard.set("3" , forKey: "acountTypeafb")
                            UserDefaults.standard.set(5, forKey: "aType")
                            UserDefaults.standard.set(nil, forKey: "isUpdat")
                            UserDefaults.standard.set(nil , forKey: "user_type")
                            UserDefaults.standard.set(nil , forKey: "loginCheck")
                            UserDefaults.standard.set(0, forKey: "isUpdatedImage")
                            //self.appleLogut()
                            self.appDelegate.nokri_moveToSignIn()
                        }
                        let CancelButton = UIAlertAction(title: btnCncel, style: .cancel)
                        Alert.addAction(okButton)
                        Alert.addAction(CancelButton)
                        self.present(Alert, animated: true, completion: nil)
                    case.exit:
                        var confirmString:String?
                        var btnOk:String?
                        var btnCncel:String?
                        if let userData = UserDefaults.standard.object(forKey: "settingsData") {
                            let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
                            let dataTabs = SplashRoot(fromDictionary: objData)
                            confirmString = dataTabs.data.genericTxts.confirm
                            btnOk = dataTabs.data.genericTxts.btnConfirm
                            btnCncel = dataTabs.data.genericTxts.btnCancel
                        }
                        let Alert = UIAlertController(title: confirmString, message:"", preferredStyle: .alert)
                        let okButton = UIAlertAction(title: btnOk, style: .default) { _ in
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                                self.showLoader()
                                DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                                    exit(EXIT_SUCCESS)
                                })
                            })
                            self.stopAnimating()
                        }
                        let CancelButton = UIAlertAction(title: btnCncel, style: .cancel)
                        Alert.addAction(okButton)
                        Alert.addAction(CancelButton)
                        self.present(Alert, animated: true, completion: nil)
                    }
                }
                //}
            }
            
        }
        
    }
    
}

extension LeftViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let iswpml = UserDefaults.standard.bool(forKey: "isWpmlActive")
                
        let withOutLogin = UserDefaults.standard.string(forKey: "aType")
        
        if withOutLogin == "5"{
        
        
            
        if let menu = LeftMenu2(rawValue: indexPath.row) {
            switch menu {
            case .home:
                return 48
                
            case .explrore:
                return 48
            case .blogg:
                return 48
            case .signUp:
                return 48
            case .sighIn:
                return 48
            case .setting:
                return 48
            
            case .language:
                if iswpml == true{
                    return 48
                }else{
                    return 0
                }
                
            case.Exit:
                return 48
            }
            
        }
        
        
            
            
            
        }else{
            let iswpml = UserDefaults.standard.bool(forKey: "isWpmlActive")

           // if iswpml == true
            
            
             let userData = UserDefaults.standard.object(forKey: "userData")
                let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
                let data = LoginPostRoot(fromDictionary: objData)
                let withOutLogin = UserDefaults.standard.string(forKey: "aType")
                if withOutLogin != "5"{
                    if data.data.userType == "0" || aType == 0 {
                      
                        if let menu = LeftMenu(rawValue: indexPath.row) {
                            switch menu {
                            case.home:
                                return 48
                            case.dashBoard:
                                return 48
                            case.editProfile:
                                return 48
                            case.myProfile:
                                return 48
                            case.myResumes:
                                return 48
                            case.jobs:
                                return 48
                            case.jobsApplied:
                                return 48
                            case.jobsForYou:
                                return 48
                            case.savedJobs:
                                return 48
                            case.advanceSearch:
                                return 48
                            case.employerSearch:
                                return 48
                            case.followedCompanies:
                                return 48
                            case.jobNotification:
                                return 48
                            case.jobAlert:
                                return 48
                            case.candPkg:
                                return 48
                            case.candPkgDetail:
                                return 48
                            case.bloged:
                                return 48
                            case.setting:
                                return 48
                            case.logouT:
                                return 48
                            case .language:
                                if iswpml == true{
                                    return 48
                                }else{
                                    return 0
                                }
                            default:
                                return 48
                            }
                        }
                        
                    
                        
                        
                        
                        
                        
                        
                    }else{
                                if let menu = LeftMenu3(rawValue: indexPath.row) {
                                    switch menu {
                                    case .home:
                                        return 48
                                    case .dashBoard:
                                        return 48
                                    case .editProfile:
                                        return 48
                                    case .emailTemp:
                                        return 48
                                    case .job:
                                        return 48
                                    case .follower:
                                        return 48
                                    case .matchResume:
                                        return 48
                                    case .saveResume:
                                        return 48
                                    case .jobPost:
                                        return 48
                                    case .PackageDetail:
                                        return 48
                                    case .package:
                                        return 48
                                    case .blog:
                                        return 48
                                    case .canSearch:
                                        return 48
                                    case .employerSearch:
                                        return 48
                                    case .setting:
                                        return 48
                                    case .logout:
                                        return 48
                                    case .exit:
                                        return 48
                                    case .language:
                                        if iswpml == true{
                                            return 48
                                        }else{
                                            return 0
                                        }
                                    }
                                }
                    }
                }
            
            
            
            
            
            
        }
        
        return 48
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let accountTypeFromFb = UserDefaults.standard.string(forKey: "acountTypeafb")
        let aType:Int?
        if accountTypeFromFb == nil || accountTypeFromFb ==  ""{
            aType = 4
        }else{
            aType = Int(accountTypeFromFb!)!
            
        }
        let check = UserDefaults.standard.string(forKey: "loginCheck")
        let withOutLogin = UserDefaults.standard.string(forKey: "aType")
        if withOutLogin == "5"{
            if let menu2 = LeftMenu2(rawValue: indexPath.row) {
                self.changeViewController2(menu2)
                let selectedCell:UITableViewCell = tableView.cellForRow(at: indexPath)!
                selectedCell.contentView.backgroundColor = UIColor(hex:appColorNew!)
                
            }
        }
        
        if check == "5"{
            
            if let userData = UserDefaults.standard.object(forKey: "userData") {
                let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
                let data = LoginPostRoot(fromDictionary: objData)
                let withOutLogin = UserDefaults.standard.string(forKey: "aType")
                if withOutLogin != "5"{
                    if data.data.userType == "0" || aType == 0 {
                        if let menu = LeftMenu(rawValue: indexPath.row) {
                            self.changeViewController(menu)
                            let selectedCell:UITableViewCell = tableView.cellForRow(at: indexPath)!
                            selectedCell.contentView.backgroundColor = UIColor(hex:appColorNew!)
                        }
                    }
                }
                if withOutLogin != "5"{
                    if data.data.userType == "1" || aType == 1 || signUp == "1"
                    {
                        if let menu = LeftMenu3(rawValue: indexPath.row) {
                            self.changeViewController3(menu)
                            let selectedCell:UITableViewCell = tableView.cellForRow(at: indexPath)!
                            selectedCell.contentView.backgroundColor = UIColor(hex:appColorNew!)
                        }
                    }
                    
                }
                if withOutLogin == "5"{
                    if let menu2 = LeftMenu2(rawValue: indexPath.row) {
                        self.changeViewController2(menu2)
                        let selectedCell:UITableViewCell = tableView.cellForRow(at: indexPath)!
                        selectedCell.contentView.backgroundColor = UIColor(hex:appColorNew!)
                    }
                }
            }
        }else{
            if signUp == nil{
                signUp = "8"
            }else{
                signUp = UserDefaults.standard.string(forKey: "signUp")
            }
            let withOutLogin = UserDefaults.standard.string(forKey: "aType")
            if withOutLogin != "5"{
                if aType == 0 || signUp == "0"{
                    if let menu = LeftMenu(rawValue: indexPath.row) {
                        self.changeViewController(menu)
                        let selectedCell:UITableViewCell = tableView.cellForRow(at: indexPath)!
                        selectedCell.contentView.backgroundColor = UIColor(hex:appColorNew!)
                    }
                }
            }
            if withOutLogin != "5"{
                if aType == 1 || signUp == "1"
                {
                    if let menu = LeftMenu3(rawValue: indexPath.row) {
                        self.changeViewController3(menu)
                        let selectedCell:UITableViewCell = tableView.cellForRow(at: indexPath)!
                        selectedCell.contentView.backgroundColor = UIColor(hex:appColorNew!)
                    }
                }
                
            }
            if withOutLogin == "5"{
                if let menu2 = LeftMenu2(rawValue: indexPath.row) {
                    self.changeViewController2(menu2)
                    let selectedCell:UITableViewCell = tableView.cellForRow(at: indexPath)!
                    selectedCell.contentView.backgroundColor = UIColor(hex:appColorNew!)
                    
                }
            }
            // }
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.tableView == scrollView {
        }
    }
}

extension LeftViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let accountTypeFromFb = UserDefaults.standard.string(forKey: "acountTypeafb")
        if accountTypeFromFb == nil || accountTypeFromFb ==  ""{
            aType = 4
        }else{
            aType = Int(accountTypeFromFb!)!
        }
        let check = UserDefaults.standard.string(forKey: "loginCheck")
        let withOutLogin = UserDefaults.standard.string(forKey: "aType")
        if withOutLogin == "5"
        {
            return self.menuWithOutLogin.count
        }
        
        if check == "5"{
            if let userData = UserDefaults.standard.object(forKey: "userData")  {
                let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
                let data = LoginPostRoot(fromDictionary: objData)
                let withOutLogin = UserDefaults.standard.string(forKey: "aType")
                if withOutLogin != "5"{
                    if data.data != nil{
                        if data.data.userType == "0" || aType == 0{
                            
                            return menus.count
                        }
                    }
                }
                if withOutLogin != "5"{
                    if data.data != nil{
                        if data.data.userType == "1" || aType == 1 {
                            return menusCompany.count
                        }
                    }
                }
                if withOutLogin == "5"
                {
                    return self.menuWithOutLogin.count
                }
            }
        }
        else{
            
            if signUp == nil{
                signUp = "8"
            }else{
                signUp = UserDefaults.standard.string(forKey: "signUp")
            }
            let withOutLogin = UserDefaults.standard.string(forKey: "aType")
            if withOutLogin == "5"
            {
                return self.menuWithOutLogin.count
            }
            if withOutLogin != "5"{
                if aType == 0 || signUp == "0"{
                    return menus.count
                }
            }
            if withOutLogin != "5"{
                if aType == 1 || signUp == "1" {
                    return menusCompany.count
                }
            }
            
            if withOutLogin == "5"
            {
                return self.menuWithOutLogin.count
            }
            // }
        }
        return menusCompany.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let aType:Int?
        let accountTypeFromFb = UserDefaults.standard.string(forKey: "acountTypeafb")
        if accountTypeFromFb == nil || accountTypeFromFb ==  ""{
            aType = 4
        }else{
            aType = Int(accountTypeFromFb!)!
        }
        
        let cell: BaseTableViewCell = tableView.dequeueReusableCell(withIdentifier: "baseCell", for: indexPath) as! BaseTableViewCell
        let check = UserDefaults.standard.string(forKey: "loginCheck")
        let withOutLogin = UserDefaults.standard.string(forKey: "aType")
        if withOutLogin == "5" || withOutLogin == nil
        {
            cell.lblMenuItems.text = menuWithOutLogin[indexPath.row]
            cell.imageMenuItems.image = menuIconsWithOutLogin[indexPath.row]
        }
        if check == "5"{
            if let userData = UserDefaults.standard.object(forKey: "userData") {
                let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
                let data = LoginPostRoot(fromDictionary: objData)
                let withOutLogin = UserDefaults.standard.string(forKey: "aType")
                if withOutLogin != "5"{
                    
                    if data.data.userType == "0" || aType == 0 {
                        cell.lblMenuItems.text = menus[indexPath.row]
                        cell.imageMenuItems.image = menuIcons[indexPath.row]
                    }
                }
                if withOutLogin != "5"{
                    if data.data.userType == "1" || aType == 1 {
                        cell.lblMenuItems.text = menusCompany[indexPath.row]
                        cell.imageMenuItems.image = menuIconsCompany[indexPath.row]
                    }
                }
                if withOutLogin == "5"
                {
                    cell.lblMenuItems.text = menuWithOutLogin[indexPath.row]
                    cell.imageMenuItems.image = menuIconsWithOutLogin[indexPath.row]
                }
            }
        }else{
            if signUp == nil{
                signUp = "8"
            }else{
                signUp = UserDefaults.standard.string(forKey: "signUp")
            }
            let withOutLogin = UserDefaults.standard.string(forKey: "aType")
            if withOutLogin == "5"
            {
                cell.lblMenuItems.text = menuWithOutLogin[indexPath.row]
                cell.imageMenuItems.image = menuIconsWithOutLogin[indexPath.row]
            }
            if withOutLogin != "5"{
                print("\(String(describing: signUp))")
                if aType == 0 || signUp == "0" {
                    cell.lblMenuItems.text = menus[indexPath.row]
                    cell.imageMenuItems.image = menuIcons[indexPath.row]
                }
            }
            if withOutLogin != "5"{
                if aType == 1 || signUp == "1"{
                    cell.lblMenuItems.text = menusCompany[indexPath.row]
                    cell.imageMenuItems.image = menuIconsCompany[indexPath.row]
                }
            }
            if withOutLogin == "5"
            {
                cell.lblMenuItems.text = menuWithOutLogin[indexPath.row]
                cell.imageMenuItems.image = menuIconsWithOutLogin[indexPath.row]
            }
            
            // }
        }
        return cell
    }
    
    func appleLogut(){
            if #available(iOS 13.0, *) {
                let appleIDProvider = ASAuthorizationAppleIDProvider()
                let appleCred = UserDefaults.standard.string(forKey: "User_AppleID")
                print(appleCred!)
                appleIDProvider.getCredentialState(forUserID: appleCred!) { (credentialState, error) in
                   switch credentialState {
                   case .authorized:
                       // The Apple ID credential is valid.
                       break
                   case .revoked:
                       // The Apple ID credential is revoked.
                       break
                   case .notFound:
                       // No credential was found, so show the sign-in UI.
                       break
                   default:
                       break
                   }
               }
                
            } else {
                // Fallback on earlier versions
            }
        }
    
}


