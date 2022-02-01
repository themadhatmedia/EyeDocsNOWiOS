//
//  FollowedCompanyListViewController.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 4/13/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import UIKit
import Alamofire
import JGProgressHUD
import GoogleMobileAds

class FollowedCompanyListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,GADBannerViewDelegate,SwiftyAdDelegate {

    //MARK:- IBOutlets
    
    @IBOutlet weak var btnLoadMore: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var heightConstraintBanner: NSLayoutConstraint!
    @IBOutlet weak var adBannerView: GADBannerView!
    @IBOutlet weak var bannerViewBottom: GADBannerView!
    @IBOutlet weak var heightConstraintBottomBanner: NSLayoutConstraint!
    
    //MARK:- Proporties
    
    var appColorNew = UserDefaults.standard.string(forKey: "app_Color")
    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
    var message:String?
    var companiesArray = NSMutableArray()
    var btnUnfollowText:String?
    var comp_Id:Int?
    var nextPage:Int?
    var hasNextPage:Bool?
    var interstitial: GADInterstitial!
    
    //MARK:- View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        //nokri_ltrRtl()
        addLeftBarButtonWithImage(#imageLiteral(resourceName: "menu"))
        nokri_companiesData()
        
        
        //let params = ["page_number":1]
        
        
        cutomeButton()
        showSearchButton()
//        let request = GADRequest()
//        request.testDevices = [kGADSimulatorID]
//        interstitial.load(request)
//        self.perform(#selector(self.nokri_adMob), with: nil, afterDelay: 7.5)
        nokri_adMob()
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
                   // print(objData?.banner_id!)
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
        return companiesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FollowedCompanyListTableViewCell", for: indexPath) as! FollowedCompanyListTableViewCell
        var keyOpen:String?
        var valueOpen:String?
        let selectedActiveJob = self.companiesArray[indexPath.row] as? [NSDictionary];
        for itemDict in selectedActiveJob! {
            let innerDict = itemDict ;
            if let field_type_name = innerDict["field_type_name"] as? String{
                if field_type_name == "company_name" {
                    if let value = innerDict["value"] as? String {
                        cell.lblCompanyName.text = value
                    }
                }
                if field_type_name == "company_adress" {
                    if let value = innerDict["value"] as? String {
                        cell.lblCompanyLocation.text = value
                    }
                }
                if field_type_name == "open_position" {
                    if let key = innerDict["key"] as? String {
                        keyOpen = key
                    }
                    if let value = innerDict["value"] as? String {
                        valueOpen = value
                    }
                }
                if field_type_name == "company_id"{
                    if let value = innerDict["value"] as? Int {
                        cell.btnUnfollow.tag = value
                        cell.btnCompanyDetail.tag = value
                        print(value)
                    }
                }
                if field_type_name == "company_logo" {
                    if let value = innerDict["value"] as? String {
                        
                        if let url = URL(string: value){
                            cell.imageViewCompany?.sd_setImage(with: url, completed: nil)
                            cell.imageViewCompany.sd_setShowActivityIndicatorView(true)
                            cell.imageViewCompany.sd_setIndicatorStyle(.gray)
                        }
                    }
                }
            }
        }
        cell.btnUnfollow.backgroundColor = UIColor(hex: appColorNew!)
        cell.btnUnfollow.setTitle(btnUnfollowText, for: .normal)
        cell.lblOpenPosition.text = "\(keyOpen!)" + ": " + "\(valueOpen!)"
        cell.btnCompanyDetail.addTarget(self, action:  #selector(FollowedCompanyListViewController.nokri_btnCompanyDetailClicked), for: .touchUpInside)
        cell.btnUnfollow.addTarget(self, action:  #selector(FollowedCompanyListViewController.nokri_btnUnfollowClicked), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 114
    }
    
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
    
    @IBAction func btnLoadMoreClicked(_ sender: UIButton) {
        if hasNextPage == true{
           nokri_companiesDataPagination()
        }
    }
    
    func cutomeButton(){
        btnLoadMore.isHidden = true
        btnLoadMore.layer.cornerRadius = 22
        btnLoadMore.backgroundColor = UIColor(hex: appColorNew!)
        btnLoadMore.setTitleColor(UIColor.white, for: .normal)
    }
    
    @objc func nokri_btnJobDetailClicked( _ sender: UIButton){
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CompanyDetailViewController") as! CompanyDetailViewController
        print(sender.tag)
        nextViewController.company_Id = sender.tag
        nextViewController.isFromFollowedCompany = false
        comp_Id = sender.tag
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    @objc func nokri_btnCompanyDetailClicked( _ sender: UIButton){
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CompanyDetailViewController") as! CompanyDetailViewController
        print(sender.tag)
        nextViewController.company_Id = sender.tag
        nextViewController.isFromFollowedCompany = true
        comp_Id = sender.tag
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    @objc func nokri_btnUnfollowClicked( _ sender: UIButton){
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
        let alert = UIAlertController(title: confirmString, message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: btnOk, style: .default) { (ok) in
            let comp_id = sender.tag
            print(comp_id)
            let param: [String: Any] = [
                "company_id": comp_id
            ]
            print(param)
            self.nokri_removeFollower(parameter: param as NSDictionary)
        }
        let cancel = UIAlertAction(title: btnCncel, style: .cancel) { (cancel) in
        }
        alert.addAction(ok)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
   
    func nokri_tableViewHelper(){
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
        let rect = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: self.view.bounds.size.width, height: self.view.bounds.size.height))
        let messageLabel = UILabel(frame: rect)
        messageLabel.text = ""
        messageLabel.textAlignment = .center;
        tableView.backgroundView = messageLabel
    }
    
    //MARK:- API Calls
    
    func nokri_companiesData(){
        
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
                "page_number": "1"
            ]
            print(param)
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.followedCompaniesGet, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers)
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
                        if let btnUnfollow = data["btn_text"]  as? String{
                            self.btnUnfollowText = btnUnfollow
                        }
                        if let companiesArr = data["comapnies"] as? NSArray {
                            self.nokri_compParser(compArr: companiesArr)
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
                        hud.textLabel.text = self.message
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
                            self.view.makeToast("Network Time out", duration: 1.5, position: .center)
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
                "page_number": "1"
            ]
            print(param)
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.followedCompaniesGet, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers)
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
                        if let btnUnfollow = data["btn_text"]  as? String{
                            self.btnUnfollowText = btnUnfollow
                        }
                        if let companiesArr = data["comapnies"] as? NSArray {
                            self.nokri_compParser(compArr: companiesArr)
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
                        hud.textLabel.text = self.message
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
                            self.view.makeToast("Network Time out", duration: 1.5, position: .center)
                        }
                    }
            }
        }
    }
    
    func nokri_companiesDataPagination(){
        
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
                "page_number": "1"
            ]
            print(param)
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.followedCompaniesGet, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers)
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
                        if let btnUnfollow = data["btn_text"]  as? String{
                            self.btnUnfollowText = btnUnfollow
                        }
                        if let companiesArr = data["comapnies"] as? NSArray {
                            self.nokri_compParser(compArr: companiesArr)
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
                        hud.textLabel.text = self.message
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
                            self.view.makeToast("Network Time out", duration: 1.5, position: .center)
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
                "page_number": "1"
            ]
            print(param)
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.followedCompaniesGet, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers)
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
                        if let btnUnfollow = data["btn_text"]  as? String{
                            self.btnUnfollowText = btnUnfollow
                        }
                        if let companiesArr = data["comapnies"] as? NSArray {
                            self.nokri_compParser(compArr: companiesArr)
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
                        hud.textLabel.text = self.message
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
                            self.view.makeToast("Network Time out", duration: 1.5, position: .center)
                        }
                    }
            }
        }
    }
    
    func nokri_compParser(compArr:NSArray){
        self.companiesArray.removeAllObjects()
        for item in compArr{
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
            self.companiesArray.add(arrayOfDictionaries);
        }
        if compArr.count == 0{
            nokri_tableViewHelper()
            self.tableView.reloadData()
        }else{
            nokri_tableViewHelper2()
        }
        print("\(self.companiesArray.count)");
        self.tableView.reloadData()
    }
    
    func nokri_removeFollower(parameter: NSDictionary) {
        self.showLoader()
        UserHandler.nokri_removeFollowedCompany(parameter: parameter as NSDictionary, success: { (successResponse) in
            //self.view.makeToast(successResponse.message, duration: 1.5, position: .center)
            let hud = JGProgressHUD(style: .dark)
            hud.textLabel.text = successResponse.message 
            hud.detailTextLabel.text = nil
            hud.indicatorView = JGProgressHUDSuccessIndicatorView()
            hud.position = .bottomCenter
            hud.show(in: self.view)
            hud.dismiss(afterDelay: 2.0)
            self.nokri_companiesData()
            self.tableView.reloadData()
            self.stopAnimating()
        }) { (error) in
            self.stopAnimating()
            let alert = Constants.showBasicAlert(message: error.message)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
}
