//
//  JobsForYouViewController.swift
//  Nokri
//
//  Created by Furqan Nadeem on 06/03/2019.
//  Copyright © 2019 Furqan Nadeem. All rights reserved.
//

import UIKit
import Alamofire
import GoogleMobileAds
import JGProgressHUD


class JobsForYouViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,GADBannerViewDelegate,SwiftyAdDelegate {
    
    //MARK:- IBOutlets
    
    @IBOutlet weak var tableView: UITableView!{
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.showsVerticalScrollIndicator = false
            tableView.addSubview(refreshControl)
        }
    }
    
    @IBOutlet weak var btnLoadMore: UIButton!
    @IBOutlet weak var heightConstraintBanner: NSLayoutConstraint!
    @IBOutlet weak var adBannerView: GADBannerView!
    @IBOutlet weak var bannerViewBottom: GADBannerView!
    @IBOutlet weak var heightConstraintBottomBanner: NSLayoutConstraint!
    
    //MARK:- Proporties
    
    var interstitial: GADInterstitial!
    var appColorNew = UserDefaults.standard.string(forKey: "app_Color")
    var pageTitle:String?
    var message:String?
    var jobsArray = NSMutableArray()
    var newJobsArr = NSMutableArray()
    var jobId:Int?
    var compId:Int?
    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
    var senderButtonTag:Int?
    var nextPage:Int?
    var hasNextPage:Bool?
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(refreshTableView),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor(hex: appColorNew!)
        
        return refreshControl
    }()
    var jobliststyle = 0
    var listStyle = UserDefaults.standard.string(forKey: "listStyle")
    
    //MARK:- View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        nokri_allJobsData()
        cutomeButton()
        btnLoadMore.isHidden = true
        addLeftBarButtonWithImage(#imageLiteral(resourceName: "menu"))
        showSearchButton()
        //interstitial = GADInterstitial(adUnitID: Constants.AdMob.intersetialId!)
        //let request = GADRequest()
        //request.testDevices = [kGADSimulatorID]
        //interstitial.load(request)
        //self.perform(#selector(self.nokri_adMob), with: nil, afterDelay: 7.5)
        nokri_adMob()
    }
    
    @objc func refreshTableView() {
        nokri_allJobsData()
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
                    //print(objData?.banner_id!)
                    SwiftyAd.shared.setup(withBannerID: (objData?.banner_id)!, interstitialID: "", rewardedVideoID: "")
                    self.tableView.translatesAutoresizingMaskIntoConstraints = false
                    if objData?.position == "top" {
                        heightConstraintBanner.constant = 65
                        heightConstraintBottomBanner.constant = 0
                        //tableView.tableHeaderView?.frame = bannerView.frame
                        //tableView.tableHeaderView = bannerView
                        
                    }
                    else {
                        heightConstraintBottomBanner.constant = 65
                        heightConstraintBanner.constant = 0
                        //tableView.tableFooterView?.frame = bannerView.frame
                        //tableView.tableFooterView = bannerView
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
    
    
    //MARK:- Table View
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jobsArray.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if listStyle == "style2"{
                  let cell = tableView.dequeueReusableCell(withIdentifier: "Home3JobsListTableViewCell", for: indexPath) as! Home3JobsListTableViewCell
               
                  
                  let selectedActiveJob = self.jobsArray[indexPath.row] as? [NSDictionary];
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
                                      cell.lblDate.text = "N/A"
                                  }
                              }
                          }
                          if field_type_name == "job_id" {
                              if let value = innerDict["value"] as? Int {
                                  jobId = value
                                  cell.btnJobDetail.tag = value
                                  cell.btnCompanyDetail.tag = value
                                  print(value)
                              }
                          }
                          if field_type_name == "company_id" {
                              
                              if let value = innerDict["value"] as? String {
                                   cell.btnCompanyDetail.tag = Int(value)!
                                  compId = Int(value)!
                                  cell.btnJobDetail.setTitle(value, for: .normal)
                                  cell.btnJobDetail.titleLabel?.textColor = UIColor.clear
                                  print(value)
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
                      }
                  }
                  
                  cell.btnCompanyDetail.addTarget(self, action:  #selector(JobsListViewController.nokri_btnCompanyDetailClicked), for: .touchUpInside)
                  cell.btnJobDetail.addTarget(self, action:  #selector(JobsListViewController.nokri_btnJobDetailClicked), for: .touchUpInside)
                  
                  return cell
              }else{
        let cell = tableView.dequeueReusableCell(withIdentifier: "JobsForYouTableViewCell", for: indexPath) as! JobsForYouTableViewCell
     
        let selectedActiveJob = self.jobsArray[indexPath.row] as? [NSDictionary];
        for itemDict in selectedActiveJob! {
            let innerDict = itemDict ;
            if let field_type_name = innerDict["field_type_name"] as? String{
                
                if field_type_name == "job_name" {
                    if let value = innerDict["value"] as? String {
                        cell.lblTitle.text = value
                    }
                }
                if field_type_name == "company_name" {
                    if let value = innerDict["value"] as? String {
                        cell.lblSubTitle.text = value
                    }
                }
                if field_type_name == "job_type" {
                    if let value = innerDict["value"] as? String {
                        cell.lblPartOrFullTime.text = value
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
                    }
                }
                if field_type_name == "job_posted" {
                    if let key = innerDict["value"] as? String {
                        cell.lblTime.text = key
                    }
                }
                if field_type_name == "job_id" {
                    if let value = innerDict["value"] as? Int {
                        jobId = value
                        cell.btnJobDetail.tag = value
                        print(value)
                    }
                }
                if field_type_name == "company_id" {
                    
                    if let value = innerDict["value"] as? String {
                        cell.btnCompanyDetail.tag = Int(value)!
                        compId = Int(value)!
                        cell.btnJobDetail.setTitle(value, for: .normal)
                        print(value)
                    }
                }
                if field_type_name == "company_logo" {
                    if let value = innerDict["value"] as? String {
                        if let url = URL(string: value){
                            cell.imageViewJobList?.sd_setImage(with: url, completed: nil)
                            cell.imageViewJobList.sd_setShowActivityIndicatorView(true)
                            cell.imageViewJobList.sd_setIndicatorStyle(.gray)
                        }
                        
                    }
                }
            }
        }
        
        cell.btnCompanyDetail.addTarget(self, action:  #selector(JobsListViewController.nokri_btnCompanyDetailClicked), for: .touchUpInside)
        cell.btnJobDetail.addTarget(self, action:  #selector(JobsListViewController.nokri_btnJobDetailClicked), for: .touchUpInside)
        
        return cell
        
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if listStyle == "style2"{
            return 210
        }else{
            return 180
        }    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if tableView.isDragging {
            cell.transform = CGAffineTransform.init(scaleX: 0.5, y: 0.5)
            UIView.animate(withDuration: 0.3, animations: {
                cell.transform = CGAffineTransform.identity
            })
        }
    }
    
    //MARK:- Custome Functions
    
    func nokri_ltrRtl(){
        let isRtl = UserDefaults.standard.string(forKey: "isRtl")
        if isRtl == "0"{
            self.addLeftBarButtonWithImage(#imageLiteral(resourceName: "menu"))
        }else{
            self.addRightBarButtonWithImage(#imageLiteral(resourceName: "menu"))
        }
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
            //isShowAd = false
            if isShowAd == true {
                let objData = UserHandler.sharedInstance.objSaplash?.adMob
                let req = GADRequest()
                //adBannerView = GADBannerView(adSize: kGADAdSizeSmartBannerPortrait)
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
    
    @objc func nokri_btnCompanyDetailClicked(_ sender: UIButton){
        
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CompanyDetailViewController") as! CompanyDetailViewController
        UserDefaults.standard.set( sender.tag, forKey: "comp_Id")
        self.navigationController?.pushViewController(nextViewController, animated: true)
        
    }
    
    @objc func nokri_btnJobDetailClicked( _ sender: UIButton){
        
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "JobDetailViewController") as! JobDetailViewController
        print(sender.tag)
        nextViewController.jobId = sender.tag
        nextViewController.isFromAllJob = false
        nextViewController.compId =
            Int((sender.titleLabel?.text)!)!
         UserDefaults.standard.set(false, forKey: "isFromNoti")
        self.navigationController?.pushViewController(nextViewController, animated: true)
        
    }
    
    func nokri_tableViewHelper(){
        tableView.backgroundColor = UIColor.clear
        let rect = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: self.view.bounds.size.width, height: self.view.bounds.size.height))
        let messageLabel = UILabel(frame: rect)
        messageLabel.text = self.message
        messageLabel.textColor = UIColor.lightGray
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont(name: "TrebuchetMS", size: 20)
        messageLabel.sizeToFit()
        tableView.backgroundView = messageLabel
    }
    
    func nokri_tableViewHelper2(){
        tableView.backgroundColor = UIColor.white
        let rect = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: self.view.bounds.size.width, height: self.view.bounds.size.height))
        let messageLabel = UILabel(frame: rect)
        messageLabel.text = ""
        messageLabel.textAlignment = .center;
        tableView.backgroundView = messageLabel
    }
    
    func cutomeButton(){
        btnLoadMore.layer.cornerRadius = 22
        btnLoadMore.backgroundColor = UIColor(hex: appColorNew!)
        btnLoadMore.setTitleColor(UIColor.white, for: .normal)
    }
    
    @IBAction func btnLoadMoreClicked(_ sender: UIButton) {
        if hasNextPage == true{
            nokri_allJobsDat2()
        }
    }
    //MARK:- API Calls
    
    func nokri_allJobsData(){
        
        var langCode = UserDefaults.standard.string(forKey: "langCode")
        if langCode == nil {
            langCode = "en"
        }
        
        var isTimeOut = false
        self.showLoader()
        var email = ""
        var password = ""
        
        if UserDefaults.standard.bool(forKey: "isSocial") == true {
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
                "Nokri-Login-Type" : "social",
                "Nokri-Lang-Locale" : "\(langCode!)"
            ]
            let param: [String: Any] = [
                "page_number": "1",
                ]
            print(param)
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.jobsForYou, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    guard let res = response.value else{return}
                    let responseData = res as! NSDictionary
                    self.message = responseData["message"] as? String
                    let success = responseData["success"] as! Bool
                    if success == true{
                        isTimeOut = true
                        let data = responseData["data"] as! NSDictionary
                        if let page = data["page_title"]  as? String{
                            self.title = page
                        }
                        if let JobArr = data["jobs"] as? NSArray {
                            self.nokri_jobDataParser(jobsArr: JobArr)
                        }
                        if let pagination = responseData["pagination"] as? NSDictionary{
                            self.hasNextPage = pagination["has_next_page"] as? Bool
                            self.nextPage = pagination["next_page"] as? Int
                        }
                        if self.hasNextPage == true{
                            print(self.hasNextPage!)
                            self.btnLoadMore.isHidden = false
                        }
                        
                    }else{
                        let hud = JGProgressHUD(style: .dark)
                        hud.textLabel.text = self.message!
                        hud.detailTextLabel.text = nil
                        hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                        hud.position = .bottomCenter
                        hud.show(in: self.view)
                        hud.dismiss(afterDelay: 2.0)
                    }
                    self.refreshControl.endRefreshing()
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
                        }
                    }
            }
        }else{
            
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
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.jobsForYou, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    guard let res = response.value else{return}
                    let responseData = res as! NSDictionary
                    self.message = responseData["message"] as? String
                    let success = responseData["success"] as! Bool
                    if success == true{
                        isTimeOut = true
                        let data = responseData["data"] as! NSDictionary
                        if let page = data["page_title"]  as? String{
                            self.title = page
                        }
                        if let JobArr = data["jobs"] as? NSArray {
                            self.nokri_jobDataParser(jobsArr: JobArr)
                        }
                        if let pagination = responseData["pagination"] as? NSDictionary{
                            self.hasNextPage = pagination["has_next_page"] as? Bool
                            self.nextPage = pagination["next_page"] as? Int
                        }
                        if self.hasNextPage == true{
                            print(self.hasNextPage!)
                            self.btnLoadMore.isHidden = false
                        }
                    }else{
                        let hud = JGProgressHUD(style: .dark)
                        hud.textLabel.text = self.message!
                        hud.detailTextLabel.text = nil
                        hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                        hud.position = .bottomCenter
                        hud.show(in: self.view)
                        hud.dismiss(afterDelay: 2.0)
                    }
                    self.refreshControl.endRefreshing()
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
                        }
                    }
            }
        }
        
    }
    
    func nokri_allJobsDat2(){
        
        var langCode = UserDefaults.standard.string(forKey: "langCode")
        if langCode == nil {
            langCode = "en"
        }
        
        var isTimeOut = false
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
            "page_number": self.nextPage!
        ]
        print(param)
        Alamofire.request(Constants.URL.baseUrl+Constants.URL.jobsForYou, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { response in
                guard let res = response.value else{return}
                let responseData = res as! NSDictionary
                self.message = responseData["message"] as? String
                let success = responseData["success"] as! Bool
                if success == true{
                    isTimeOut = true
                    let data = responseData["data"] as! NSDictionary
                    if let page = data["page_title"]  as? String{
                        self.title = page
                    }
                    if let JobArr = data["jobs"] as? NSArray {
                        
                        self.nokri_jobDataParser(jobsArr: JobArr)
                    }
                    if let pagination = responseData["pagination"] as? NSDictionary{
                        self.hasNextPage = pagination["has_next_page"] as? Bool
                        self.nextPage = pagination["next_page"] as? Int
                    }
                    if self.hasNextPage == false{
                        print(self.hasNextPage!)
                        self.btnLoadMore.isHidden = true
                    }
                    
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
                self.refreshControl.endRefreshing()
                self.stopAnimating()
                self.tableView.reloadData()
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
        
        if jobsArr.count == 0{
            nokri_tableViewHelper()
            self.tableView.reloadData()
            
        }else{
            nokri_tableViewHelper2()
        }
        print("\(self.jobsArray.count)");
        self.tableView.reloadData()
    }
    
}
