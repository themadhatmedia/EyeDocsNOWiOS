//
//  HomeViewController.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 4/11/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import UIKit
import Foundation
//import BetterSegmentedControl
import TTSegmentedControl
import Alamofire
import SwiftyStoreKit
import GoogleMobileAds
import IQKeyboardManagerSwift
import Firebase
import FirebaseMessaging
import UserNotifications
import FirebaseCore
import FirebaseInstanceID
import JGProgressHUD
import SlideMenuControllerSwift

class HomeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,GADBannerViewDelegate,SwiftyAdDelegate {
    
    //MARK:- IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    //@IBOutlet weak var adMobBanner: GADBannerView!
    @IBOutlet weak var heightConstraintBanner: NSLayoutConstraint!
    @IBOutlet weak var adBannerView: GADBannerView!
    @IBOutlet weak var bannerViewBottom: GADBannerView!
    @IBOutlet weak var heightConstraintBottomBanner: NSLayoutConstraint!
    
    //MARK:- Proporties
    
    var interstitial: GADInterstitial!
    var appColorNew = UserDefaults.standard.string(forKey: "app_Color")
    var defaults = UserDefaults.standard
    var tableViewHeight:CGFloat = 0.0
    var heading:String = ""
    var findJobText:String = ""
    var searchKeywordText:String = ""
    var placeholderText:String = ""
    var homeDataObj:homeData?
    var imageHeader:String = ""
    var categoryText:String = ""
    var activeJobArray = NSMutableArray()
    var blogArr = [BlogPost]()
    var extra:BlogExtra?
    var message:String?
    var senderButtonTag:Int?
    var featureTitle:String = ""
    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
    var jobsArray = NSMutableArray()
    var txtFieldString:String = ""
    private var mySearchBar: UISearchBar!
    var nextPage:Int?
    var searchedText:String?
    var hasNextPage:Bool = false
    var catCellHeight = false
    var featureCellHeight = false
    var blogExrtra:BlogExtra?
    var ticketTop : NSLayoutConstraint?
    var company_Id:Int = 0
    var jobCount1:Int = 0
    var jobCount2:Int = 0
    var jobliststyle = 1
    var withOutLogin = UserDefaults.standard.string(forKey: "aType")
    var listStyle = UserDefaults.standard.string(forKey: "listStyle")
    var userType = UserDefaults.standard.string(forKey: "usrTyp")
    
    
    //    lazy var adBannerView: GADBannerView = {
    //        let adBannerView = GADBannerView(adSize: kGADAdSizeSmartBannerPortrait)
    //        //adBannerView.adUnitID = "ca-app-pub-3940256099942544/6300978111"
    //        adBannerView.delegate = self
    //        adBannerView.rootViewController = self
    //
    //        return adBannerView
    //    }()
    
    //var adBannerView: GADBannerView?
    
    //MARK:- View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        if let userData = UserDefaults.standard.object(forKey: "settingsData") {
            let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
            let dataTabs = SplashRoot(fromDictionary: objData)
            let obj = dataTabs.data.tabs
            self.title = obj?.home
        }
        nokri_homeData()
        self.nokri_jobDataAll()
        nokri_blogData()
        nokri_homeData()

        nokri_ltrRtl()
        showSearchButton()
        subscribeToTopicMessage()
        
        if withOutLogin != "5"{
            if userType != "1"{
                var fcmToken = ""
                if let token = defaults.value(forKey: "fcmToken") as? String {
                    fcmToken = token
                } else {
                    fcmToken = appDelegate.deviceFcmToken
                }
                
                let param: [String: Any] = [
                    "api_fcm_token": fcmToken
                ]
                print(param)
                self.nokri_sendFcmToken(parameter: param as NSDictionary)
            }
        }
        
//        interstitial = GADInterstitial(adUnitID: Constants.AdMob.intersetialIdTest)
//        let request = GADRequest()
//        request.testDevices = [kGADSimulatorID]
//        interstitial.load(request)
//        self.perform(#selector(self.nokri_adMob), with: nil, afterDelay: 7.5)
        nokri_adMob()
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        UserDefaults.standard.set(false, forKey: "selected")
    }
    
    //-->>> Search Bar
    
    func subscribeToTopicMessage(){
        
        if withOutLogin != "5"{
            Messaging.messaging().subscribe(toTopic: "global")
        }
    }
    
    func nokri_searchBarButton() {
        let imageSearch = UIImage (named: "search")
        let searchTintedImage = imageSearch?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        let searchButton = UIButton(type: .custom)
        searchButton.setImage(searchTintedImage, for: .normal)
        searchButton.addTarget(self, action: #selector(nokri_onClickSearchButton), for: .touchUpInside)
        let barButton = UIBarButtonItem(customView: searchButton)
        self.navigationItem.rightBarButtonItem = barButton
    }
    
    @objc func nokri_onClickSearchButton() {
        mySearchBar = UISearchBar()
        mySearchBar.delegate = self
        mySearchBar.showsCancelButton = true
        mySearchBar.showsBookmarkButton = false
        mySearchBar.searchBarStyle = UISearchBar.Style.default
        mySearchBar.prompt = "Title"
        mySearchBar.placeholder = "Search here"
        mySearchBar.text = ""
        mySearchBar.tintColor = UIColor.black
        mySearchBar.showsSearchResultsButton = false
        let leftNavBarButton = UIBarButtonItem(customView:mySearchBar)
        navigationController?.navigationBar.addSubview(mySearchBar)
        mySearchBar.sizeToFit()
        if #available(iOS 11, *) {
            mySearchBar.widthAnchor.constraint(equalToConstant: 230).isActive = true
            mySearchBar.heightAnchor.constraint(equalToConstant: 35).isActive = true
        }
        else {
            mySearchBar.frame = CGRect(x: 0, y: 0, width: 280, height: 35)
        }
        let isRtl = UserDefaults.standard.string(forKey: "isRtl")
        if isRtl == "0"{
            self.navigationItem.leftBarButtonItem = leftNavBarButton
            self.addRightBarButtonWithImage(#imageLiteral(resourceName: "menu"))
        }else{
            self.addLeftBarButtonWithImage(#imageLiteral(resourceName: "menu"))
            self.navigationItem.rightBarButtonItem = leftNavBarButton
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        let isRtl = UserDefaults.standard.string(forKey: "isRtl")
        mySearchBar.text = ""
        
        if isRtl == "0"{
            self.addLeftBarButtonWithImage(#imageLiteral(resourceName: "menu"))
            //nokri_searchBarButton()
            
        }else{
            self.addRightBarButtonWithImage(#imageLiteral(resourceName: "menu"))
            //nokri_searchBarButton()
        }
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
        //txtFieldSearch.resignFirstResponder()
        nokri_searchJob()
    }
    
    func nokri_ltrRtl(){
//        let isRtl = UserDefaults.standard.string(forKey: "isRtl")
//        if isRtl == "0"{
            self.addLeftBarButtonWithImage(#imageLiteral(resourceName: "menu"))
//
//        }else{
//
//            self.addRightBarButtonWithImage(#imageLiteral(resourceName: "menu"))
//
//        }
    }
    
    @objc func nokri_adMob(){
    
        heightConstraintBanner.constant = 0
        heightConstraintBottomBanner.constant = 0
        if UserHandler.sharedInstance.objSaplash?.adMob != nil {
            let objData = UserHandler.sharedInstance.objSaplash?.adMob
            var isShowAd = false
            if let adShow = objData?.show {
                isShowAd = adShow
            }
            
            if isShowAd == true {
                let objData = UserHandler.sharedInstance.objSaplash?.adMob
                let req = GADRequest()
                adBannerView?.adUnitID = objData?.banner_id
                adBannerView?.delegate = self
                adBannerView?.rootViewController = self
                adBannerView!.load(req)
                bannerViewBottom?.adUnitID = objData?.banner_id
                bannerViewBottom?.delegate = self
                bannerViewBottom?.rootViewController = self
                bannerViewBottom!.load(req)
                SwiftyAd.shared.delegate = self
                var isShowBanner = false
                var isShowInterstital = false
                
                if let banner = objData?.is_show_banner {
                    isShowBanner = banner
                }
                if let intersitial = objData?.is_show_initial {
                    isShowInterstital = intersitial
                }
                if isShowBanner {
                    //print(objData?.banner_id!)
                    SwiftyAd.shared.setup(withBannerID: (objData?.banner_id)!, interstitialID: "", rewardedVideoID: "")
                    self.tableView.translatesAutoresizingMaskIntoConstraints = false
                    
                }
                if objData?.position == "top"{
                    heightConstraintBottomBanner.constant = 0
                    heightConstraintBanner.constant = 65
                }else{
                    heightConstraintBanner.constant = 0
                    heightConstraintBottomBanner.constant = 65
                }
                if isShowInterstital {
                    interstitial = GADInterstitial(adUnitID: Constants.AdMob.intersetialId!)
                    let request = GADRequest()
                    request.testDevices = [kGADSimulatorID]
                    interstitial.load(request)
                    if interstitial.isReady {
                        interstitial.present(fromRootViewController: self)
                    } else {
                        print("Ad wasn't ready")
                    }
                }
            }else{
                heightConstraintBanner.constant = 0
                heightConstraintBottomBanner.constant = 0
            }
        }
    }
    
    //MARK:- AdMob Delegate Methods
    
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        print("Banner loaded successfully")
        let translateTransform = CGAffineTransform(translationX: 0, y: -bannerView.bounds.size.height)
        bannerView.transform = translateTransform
        
        UIView.animate(withDuration: 0.5) {
            bannerView.transform = CGAffineTransform.identity
        }
        if UserHandler.sharedInstance.objSaplash?.adMob != nil {
            let objData = UserHandler.sharedInstance.objSaplash?.adMob
            var isShowAd = false
            if let adShow = objData?.show {
                isShowAd = adShow
            }
            isShowAd = true
            if isShowAd {
                
                SwiftyAd.shared.delegate = self
                var isShowBanner = false
                var isShowInterstital = false
                if let banner = objData?.is_show_banner {
                    isShowBanner = banner
                }
                if let intersitial = objData?.is_show_initial {
                    isShowInterstital = intersitial
                }
                if isShowBanner {
                    SwiftyAd.shared.setup(withBannerID: (objData?.banner_id)!, interstitialID: "", rewardedVideoID: "")
                    self.tableView.translatesAutoresizingMaskIntoConstraints = false
                    if objData?.position == "top" {
                        heightConstraintBanner.constant = 65
                        heightConstraintBottomBanner.constant = 0
                    }
                    else {
                        heightConstraintBottomBanner.constant = 65
                        heightConstraintBanner.constant = 0
                    }
                }
                
                if isShowInterstital {
                    SwiftyAd.shared.setup(withBannerID: "", interstitialID: (objData?.ad_id)!, rewardedVideoID: "")
                    SwiftyAd.shared.showInterstitial(from: self)
                }
            }
        }
    }
    
    func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
        print("Fail to receive ads")
        print(error)
    }
    
    func swiftyAdDidOpen(_ swiftyAd: SwiftyAd) {
        print("Open")
    }
    
    func swiftyAdDidClose(_ swiftyAd: SwiftyAd) {
        print("Close")
    }
    
    func swiftyAd(_ swiftyAd: SwiftyAd, didRewardUserWithAmount rewardAmount: Int) {
        print(rewardAmount)
    }
    
    //MARK:- TableView
    
    func numberOfSections(in tableView: UITableView) -> Int {
        let isBlog = UserDefaults.standard.string(forKey: "isBlog")
        if isBlog == "0"{
            return 5
        }else{
            return 6
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }else if section == 1{
            return 1
        }else if section == 2{
            return 1
        }
        else if section == 3{
            return activeJobArray.count
        }else if section == 4{
            return 1
        }
        else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeHeaderTableViewCell", for: indexPath) as! HomeHeaderTableViewCell
            cell.lblTitle.text = heading
            cell.lblFindJob.text = findJobText
            cell.btnSearch.backgroundColor = UIColor(hex: appColorNew!)
            cell.txtFieldSearch.placeholder = placeholderText
            txtFieldString = cell.txtFieldSearch.text!
            cell.imageViewHeader.sd_setImage(with: URL(string: imageHeader), completed: nil)
            cell.imageViewHeader.sd_setShowActivityIndicatorView(true)
            cell.imageViewHeader.sd_setIndicatorStyle(.gray)
            // cell.btnSearch.addTarget(self, action: #selector(HomeViewController.btnSearchClicked(_:)), for: .touchUpInside)
            return cell
        }else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCategoryTableViewCell", for: indexPath) as! HomeCategoryTableViewCell
            cell.lblSelectCategory.text = categoryText
            return cell
        }else if indexPath.section == 2{
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeJobSelectionTableViewCell", for: indexPath) as! HomeJobSelectionTableViewCell
            if let userData = UserDefaults.standard.object(forKey: "settingsData") {
                let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
                let dataTabs = SplashRoot(fromDictionary: objData)
                cell.segmentedControl.itemTitles = [dataTabs.data.publicJobs.latest,dataTabs.data.publicJobs.premium]
                
            }
            cell.segmentedControl.defaultTextColor = UIColor.darkGray
            cell.segmentedControl.selectedTextColor = UIColor.white
            cell.segmentedControl.thumbGradientColors = [UIColor(hex:appColorNew!), UIColor(hex:appColorNew!)]
            cell.segmentedControl.layer.borderWidth = 1
            cell.segmentedControl.layer.borderColor = UIColor(hex:appColorNew!).cgColor
            cell.segmentedControl.useShadow = true
            cell.segmentedControl.layer.borderColor = UIColor(hex: appColorNew!).cgColor
            cell.segmentedControl.selectedTextFont = UIFont(name: "HelveticaNeue-Bold", size: 14.0)!
            cell.segmentedControl.didSelectItemWith = { (index, title) -> () in
                print("Selected item \(index)")
                if index == 0{
                    self.nokri_jobDataAll()
                }else{
                    
                    self.nokri_jobData()
                }
            }
            return cell
        }
        else if indexPath.section == 3{
            
            if listStyle == "style2"{
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "Home3JobsListTableViewCell", for: indexPath) as! Home3JobsListTableViewCell
                
                let selectedActiveJob = self.activeJobArray[indexPath.row] as? [NSDictionary];
                for itemDict in selectedActiveJob! {
                    let innerDict = itemDict ;
                    if let field_type_name = innerDict["field_type_name"] as? String{
                        
                        if field_type_name == "job_name" {
                            if let value = innerDict["value"] as? String {
                                cell.lblJobTitle.text = value
                            }
                        }
                        if field_type_name == "company_name" {
                            if let value = innerDict["value"] as? String {
                                cell.lblCompany.text = value
                            }
                        }
                        if field_type_name == "job_type" {
                            if let value = innerDict["value"] as? String {
                                cell.lblJobType.text = value
                                if value == ""{
                                    cell.lblJobType.text = "N/A"
                                }
                                
                                
                            }
                        }
                        if field_type_name == "job_location" {
                            if let value = innerDict["value"] as? String {
                                cell.lblLocation.text = value
                            }
                        }
                        if field_type_name == "job_salary" {
                            if let value = innerDict["value"] as? String {
                                cell.lblPrice.text = value
                                if value == ""{
                                    cell.lblPrice.text = "N/A"
                                }
                            }
                        }
                        if field_type_name == "job_posted" {
                            if let key = innerDict["value"] as? String {
                                cell.lblDate.text = key
                                if key == ""{
                                    cell.lblDate.text = ""
                                }
                            }
                        }
                        if field_type_name == "job_id" {
                            if let value = innerDict["value"] as? Int {
                                cell.btnJobDetail.tag = value
                                cell.btnCompanyDetail.tag = value
                                print(value)
                            }
                        }
                        if field_type_name == "company_id" {
                            
                            if let value = innerDict["value"] as? String {
                                
                                cell.btnCompanyDetail.tag = Int(value)!
                                cell.btnJobDetail.setTitle(value, for: .normal)
                                print(value)
                                cell.btnJobDetail.titleLabel?.textColor = UIColor.clear
                            }
                        }
                        if field_type_name == "company_logo" {
                            if let value = innerDict["value"] as? String {
                                if let url = URL(string: value){
                                    cell.imageViewFeature?.sd_setImage(with: url, completed: nil)
                                    cell.imageViewFeature.sd_setShowActivityIndicatorView(true)
                                    cell.imageViewFeature.sd_setIndicatorStyle(.gray)
                                }
                            }
                        }
                        
                        if field_type_name == "is_feature"{
                            if let value = innerDict["value"] as? Bool {
                                print(value)
                                if value == false{
                                    cell.imgFeature.isHidden = true
                                }else{
                                    cell.imgFeature.isHidden = false
                                }
                            }
                        }
                    }
                }
                cell.btnCompanyDetail.addTarget(self, action:  #selector(JobsListViewController.nokri_btnCompanyDetailClicked), for: .touchUpInside)
                cell.btnJobDetail.addTarget(self, action:  #selector(HomeViewController.nokri_btnJobDetailClicked), for: .touchUpInside)
                
                return cell
                
            }else{
                
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "HomeJobsListTableViewCell", for: indexPath) as! HomeJobsListTableViewCell
                let selectedActiveJob = self.activeJobArray[indexPath.row] as? [NSDictionary];
                for itemDict in selectedActiveJob! {
                    let innerDict = itemDict ;
                    if let field_type_name = innerDict["field_type_name"] as? String{
                        if field_type_name == "job_name" {
                            if let value = innerDict["value"] as? String {
                                cell.lblJobTitle.text = value
                            }
                        }
                        if field_type_name == "company_name" {
                            if let value = innerDict["value"] as? String {
                                cell.lblCompany.text = value
                            }
                        }
                        if field_type_name == "job_salary" {
                            if let value = innerDict["value"] as? String {
                                cell.lblPrice.text = value
                            }
                        }
                        if field_type_name == "job_posted" {
                            if let value = innerDict["value"] as? String {
                                cell.lblDate.text = value
                            }
                        }
                        if field_type_name == "job_type" {
                            if let value = innerDict["value"] as? String {
                                cell.lblJobType.text = value
                            }
                        }
                        if field_type_name == "job_location" {
                            if let value = innerDict["value"] as? String {
                                cell.lblLocation.text = value
                            }
                        }
                        if field_type_name == "company_logo" {
                            if let value = innerDict["value"] as? String
                            {
                                cell.imageViewFeature.sd_setImage(with: URL(string: value), completed: nil)
                                cell.imageViewFeature.sd_setShowActivityIndicatorView(true)
                                cell.imageViewFeature.sd_setIndicatorStyle(.gray)
                            }
                        }
                        if field_type_name == "job_id" {
                            if let value = innerDict["value"] as? Int {
                                cell.btnJobDetail.tag = value
                                print(value)
                            }
                        }
                        if field_type_name == "company_id"{
                            if let value = innerDict["value"] as? String {
                                //cell.btnCompanyDetail.tag = Int(value)!
                                cell.tag = Int(value)!
                                cell.btnJobDetail.setTitle(value, for: .normal)
                                print(value)
                            }
                        }
                    }
                }
                cell.lblPrice.textColor = UIColor(hex:appColorNew!)
                cell.btnJobDetail.addTarget(self, action: #selector(HomeViewController.nokri_btnJobDetailClicked(_:)), for: .touchUpInside)
                if selectedActiveJob?.count == 0 {
                    nokri_tableViewHelper()
                }else{
                    nokri_tableViewHelper2()
                }
                return cell
            }
        }else if indexPath.section == 4{
            let cell = tableView.dequeueReusableCell(withIdentifier: "BlogNameTableViewCell", for: indexPath) as! BlogNameTableViewCell
            
            let isBlog = UserDefaults.standard.string(forKey: "isBlog")
            if isBlog == "0"{
                cell.lblBlog.text = ""
            }else{
                cell.lblBlog.text = blogExrtra?.pageTitle
            }
            
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeBlogTableViewCell", for: indexPath) as! HomeBlogTableViewCell
            
            
            return cell
        }
    }
    
    @objc func nokri_btnJobDetailClicked( _ sender: UIButton){
        
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "JobDetailViewController") as! JobDetailViewController
        print(sender.tag)
        nextViewController.jobId = sender.tag
        nextViewController.isFromAllJob = false
        nextViewController.compId = Int((sender.titleLabel?.text)!)!
        UserDefaults.standard.set(false, forKey: "isFromNoti")
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    @objc func nokri_btnBlogClicked(_ sender: UIButton){
        let senderButtonTag = sender.tag
        print(senderButtonTag)
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "BlogDetailViewController") as! BlogDetailViewController
        nextViewController.id = senderButtonTag
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return 209
        }else if indexPath.section == 1 {
            if catCellHeight == false{
                return 190
            }else{
                return 0
            }
            
        }else if indexPath.section == 2{
            if featureCellHeight == true{
                return 10
            }else{
                return 66
            }
        }
        else if indexPath.section == 3{
            if listStyle == "style2"{
                return 210
            }else{
                return 180
            }
        }
        else if indexPath.section == 4{
            return 40
        }
        else{
            return 540
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if tableView.isDragging {
            cell.transform = CGAffineTransform.init(scaleX: 0.5, y: 0.5)
            UIView.animate(withDuration: 0.3, animations: {
                cell.transform = CGAffineTransform.identity
            })
        }
    }
    
    //MARK:- API Calls
   
    func nokri_homeData() {
        tableView.isHidden = true
        self.showLoader()
        UserHandler.nokri_home(success: { (successResponse) in
            self.stopAnimating()
            if successResponse.success {
                DispatchQueue.main.async {
                    self.tableView.isHidden = false
                    self.homeDataObj =  successResponse.data
                    self.heading = successResponse.data.heading
                    self.findJobText = successResponse.data.tagline
                    self.placeholderText = successResponse.data.placehldr
                    self.imageHeader = successResponse.data.img
                    self.categoryText = successResponse.data.catsText
                    self.tableView.reloadData()
                }
            }
            else {
                let alert = Constants.showBasicAlert(message: successResponse.message)
                self.present(alert, animated: true, completion: nil)
                self.stopAnimating()
                self.tableView.isHidden = true
            }
        }) { (error) in
            let alert = Constants.showBasicAlert(message: error.message)
            self.present(alert, animated: true, completion: nil)
            self.stopAnimating()
            self.tableView.isHidden = true
        }
    }
    
    func nokri_jobData(){
        
        var langCode = UserDefaults.standard.string(forKey: "langCode")
        if langCode == nil {
            langCode = "en"
        }
        
        self.showLoader()
        var email = ""
        var password = ""
        if let userEmail = UserDefaults.standard.string(forKey: "email") {
            email = userEmail
        }
        if let userPassword = UserDefaults.standard.string(forKey: "password") {
            password = userPassword
        }
        let emailPass = "\(email):\(password)"
        let encodedString = emailPass.data(using: String.Encoding.utf8)!
        let base64String = encodedString.base64EncodedString(options: [])
        let headers = [
            "Content-Type":Constants.customCodes.contentType,
            "Authorization" : "Basic \(base64String)",
            "Purchase-Code" : Constants.customCodes.purchaseCode,
            "Custom-Security": Constants.customCodes.securityCode,
            "Nokri-Request-From" : Constants.customCodes.requestFrom,
            "Nokri-Lang-Locale" : "\(langCode!)"
        ]
        let param: [String: Any] = [
            "page_number": "1",
        ]
        print(param)
        Alamofire.request(Constants.URL.baseUrl+Constants.URL.featureJob, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { response in
                guard let res = response.value else{return}
                let responseData = res as! NSDictionary
                self.message = responseData["message"] as? String
                let success = responseData["success"] as! Bool
                if success == true{
                    self.stopAnimating()
                    let data = responseData["data"] as! NSDictionary
                    self.featureTitle = data["tab_title"] as! String
                    
                    if let activeJobArr = data["jobs"] as? NSArray {
                        self.nokri_jobDataParser(activeJobArray: activeJobArr)
                    }
                    UserDefaults.standard.set(5, forKey: "height")
                }else{
                }
            }
    }
    
    func nokri_jobDataAll(){
        
        var langCode = UserDefaults.standard.string(forKey: "langCode")
        if langCode == nil {
            langCode = "en"
        }
        
        self.showLoader()
        var email = ""
        var password = ""
        if let userEmail = UserDefaults.standard.string(forKey: "email") {
            email = userEmail
        }
        if let userPassword = UserDefaults.standard.string(forKey: "password") {
            password = userPassword
        }
        let emailPass = "\(email):\(password)"
        let encodedString = emailPass.data(using: String.Encoding.utf8)!
        let base64String = encodedString.base64EncodedString(options: [])
        let headers = [
            "Content-Type":Constants.customCodes.contentType,
            "Authorization" : "Basic \(base64String)",
            "Purchase-Code" : Constants.customCodes.purchaseCode,
            "Custom-Security": Constants.customCodes.securityCode,
            "Nokri-Request-From" : Constants.customCodes.requestFrom,
            "Nokri-Lang-Locale" : "\(langCode!)"
        ]
        let param: [String: Any] = [
            "page_number": "1"
        ]
        print(param)
        Alamofire.request(Constants.URL.baseUrl+Constants.URL.all_jobs, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { response in
                guard let res = response.value else{return}
                let responseData = res as! NSDictionary
                self.message = responseData["message"] as? String
                let success = responseData["success"] as! Bool
                if success == true{
                    self.stopAnimating()
                    let data = responseData["data"] as! NSDictionary
                    if let activeJobArr = data["jobs"] as? NSArray {
                        self.nokri_jobDataParser(activeJobArray: activeJobArr)
                    }
                    self.tableView.reloadData()
                }else{
                }
            }
    }
    
    func nokri_jobDataParser(activeJobArray:NSArray){
        
        self.activeJobArray.removeAllObjects()
        for item in activeJobArray{
            print(item)
            var arrayOfDictionaries = [NSDictionary]();
            if let innerArray = item as? NSArray{
                for innerItem in innerArray{
                    
                    print(innerItem);
                    if let innerDictionary = innerItem as? NSDictionary{
                        arrayOfDictionaries.append(innerDictionary);
                    }
                }
            }
            self.activeJobArray.add(arrayOfDictionaries);
        }
        if activeJobArray.count == 0{
            nokri_tableViewHelper()
            self.tableView.reloadData()
        }else{
            nokri_tableViewHelper2()
        }
        print("\(self.activeJobArray.count)");
        self.tableView.reloadData()
    }
    
    func nokri_tableViewHelper(){
        let rect = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: self.tableView.bounds.size.width, height: self.tableView.bounds.size.height))
        let messageLabel = UILabel(frame: rect)
        messageLabel.text =  "No Data" //self.message
        messageLabel.textColor = UIColor.lightGray
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont(name: "TrebuchetMS", size: 20)
        messageLabel.sizeToFit()
        tableView.backgroundView = messageLabel
    }
    func nokri_tableViewHelper2(){
        let rect = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: self.tableView.bounds.size.width, height: self.tableView.bounds.size.height))
        let messageLabel = UILabel(frame: rect)
        messageLabel.text = ""
        messageLabel.textAlignment = .center;
        tableView.backgroundView = messageLabel
    }
    
    func nokri_blogData() {
        let param : [String:Any] = [
            "page_num":"1"
        ]
        self.showLoader()
        UserHandler.nokri_blog(parameter: param as NSDictionary, success: { (successResponse) in
            self.stopAnimating()
            if successResponse.success == true{
                self.blogArr = successResponse.data.post
                self.blogExrtra = successResponse.extra
                //self.title = self.extra?.pageTitle
                self.tableView.reloadData()
            }
            else {
                let alert = Constants.showBasicAlert(message: successResponse.message)
                self.present(alert, animated: true, completion: nil)
                self.stopAnimating()
            }
        }) { (error) in
            let alert = Constants.showBasicAlert(message: error.message)
            self.present(alert, animated: true, completion: nil)
            self.stopAnimating()
        }
    }
    
    func nokri_searchJob(){
        var isTimeOut = false
        self.showLoader()
        var email = ""
        var password = ""
        if let userEmail = UserDefaults.standard.string(forKey: "email") {
            email = userEmail
        }
        if let userPassword = UserDefaults.standard.string(forKey: "pass") {
            password = userPassword
        }
        let emailPass = "\(email):\(password)"
        let encodedString = emailPass.data(using: String.Encoding.utf8)!
        let base64String = encodedString.base64EncodedString(options: [])
        let headers = [
            "Content-Type":Constants.customCodes.contentType,
            "Authorization" : "Basic \(base64String)",
            "Purchase-Code" : Constants.customCodes.purchaseCode,
            "Custom-Security": Constants.customCodes.securityCode,
            "Nokri-Request-From" : Constants.customCodes.requestFrom
        ]
        
        if mySearchBar.text! == ""{
            //var confirmString:String?
            //let btnOk:String?
            //            if let userData = UserDefaults.standard.object(forKey: "settingsData") {
            //                let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
            //                let dataTabs = SplashRoot(fromDictionary: objData)
            //                //confirmString = dataTabs.data.genericTxts.confirm
            //                //btnOk = dataTabs.data.genericTxts.btnConfirm
            //
            //            }
            let Alert = UIAlertController(title: "Alert", message:"search field can not be empty.", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "ok", style: .default) { _ in
                
            }
            Alert.addAction(okButton)
            self.present(Alert, animated: true, completion: nil)
        }else{
            let param: [String: Any] = [
                "page_number" : "1",
                "job_title" :mySearchBar.text!
            ]
            print(param)
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.advanceSearch, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    guard let res = response.value else{return}
                    let responseData = res as! NSDictionary
                    self.message = responseData["message"] as? String
                    let success = responseData["success"] as! Bool
                    if success == true{
                        isTimeOut = true
                        var pageTitle:String?
                        let data = responseData["data"] as! NSDictionary
                        if let page = data["page_title"]  as? String{
                            pageTitle = page
                        }
                        if let JobArr = data["jobs"] as? NSArray {
                            self.nokri_jobDataParser(jobsArr: JobArr)
                        }
                        if let pagination = responseData["pagination"] as? NSDictionary{
                            self.hasNextPage = (pagination["has_next_page"] as? Bool)!
                            self.nextPage = pagination["next_page"] as? Int
                        }
                        if self.hasNextPage == true{
                            print(self.hasNextPage)
                            //self.btnLoadMore.isHidden = false
                        }
                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SearchedJobViewController") as! SearchedJobViewController
                        nextViewController.jobsArray = self.jobsArray
                        nextViewController.message = self.message
                        nextViewController.pageTitle = pageTitle
                        nextViewController.hasNextPage = self.hasNextPage
                        nextViewController.nextPage = self.nextPage
                        nextViewController.searchedText = self.txtFieldString
                        self.navigationController?.pushViewController(nextViewController, animated: true)
                    }else{
                        let hud = JGProgressHUD(style: .dark)
                        hud.textLabel.text = self.message!
                        hud.detailTextLabel.text = nil
                        hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                        hud.position = .bottomCenter
                        hud.show(in: self.view)
                        hud.dismiss(afterDelay: 2.0)
                        //self.view.makeToast(self.message, duration: 1.5, position: .center)
                    }
                    self.stopAnimating()
                    if isTimeOut == false{
                        DispatchQueue.main.asyncAfter(deadline: .now() + 30) {
                            self.stopAnimating()
                            let hud = JGProgressHUD(style: .dark)
                            hud.textLabel.text = "Network time out"
                            hud.detailTextLabel.text = nil
                            hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                            hud.position = .bottomCenter
                            hud.show(in: self.view)
                            hud.dismiss(afterDelay: 2.0)
                            //self.view.makeToast("Network Time out", duration: 1.5, position: .center)
                        }
                    }
                }
        }
        
    }
    
    func nokri_jobDataParser(jobsArr:NSArray){
        self.jobsArray.removeAllObjects()
        for item in jobsArr{
            print(item)
            var arrayOfDictionaries = [NSDictionary]();
            if let innerArray = item as? NSArray{
                for innerItem in innerArray{
                    
                    print(innerItem);
                    if let innerDictionary = innerItem as? NSDictionary{
                        arrayOfDictionaries.append(innerDictionary);
                    }
                }
            }
            self.jobsArray.add(arrayOfDictionaries);
        }
    }
    
    
    func nokri_sendFcmToken(parameter: NSDictionary) {
        self.showLoader()
        UserHandler.nokri_homePost(parameter: parameter as NSDictionary, success: { (successResponse) in
            if successResponse.success == true {
                print("Token sent to server...!!!!!!!")
            }else{
                print("Token NOT sent to server... xxxxxx")
            }
            
        }) { (error) in
            let alert = Constants.showBasicAlert(message: error.message)
            self.present(alert, animated: true, completion: nil)
            self.stopAnimating()
        }
    }
}

//-->>>
//       SwiftyStoreKit.retrieveProductsInfo(["com.scriptsbundle.jobZone.BasicPackage"]) { result in
//            if let product = result.retrievedProducts.first {
//                let priceString = product.localizedPrice!
//                print("Product: \(product.localizedDescription), price: \(priceString)")
//            }
//            else if let invalidProductId = result.invalidProductIDs.first {
//                print("Invalid product identifier: \(invalidProductId)")
//            }
//            else {
//
//                print("Error: \(String(describing: result.error))")
//            }
//        }
