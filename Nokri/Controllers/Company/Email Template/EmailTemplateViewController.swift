//
//  EmailTemplateViewController.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 4/19/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import UIKit
import Alamofire
import GoogleMobileAds
import JGProgressHUD

class EmailTemplateViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,GADBannerViewDelegate,SwiftyAdDelegate {

    //MARK:- IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var lblSrNoKey: UILabel!
    @IBOutlet weak var lblNameKey: UILabel!
    @IBOutlet weak var lblUpdateKy: UILabel!
    @IBOutlet weak var lblDeleteKey: UILabel!
    @IBOutlet weak var btnAddNew: UIButton!
    @IBOutlet weak var lblYourEmailTemp: UILabel!
    @IBOutlet weak var lblAddNew: UILabel!
    @IBOutlet weak var viewTop: UIView!
    @IBOutlet weak var heightConstraintBanner: NSLayoutConstraint!
    @IBOutlet weak var adBannerView: GADBannerView!
    @IBOutlet weak var bannerViewBottom: GADBannerView!
    @IBOutlet weak var heightConstraintBottomBanner: NSLayoutConstraint!
    
    //MARK:- Proporties
    
    var appColorNew = UserDefaults.standard.string(forKey: "app_Color")
    var message:String?
    var emailTempArray = NSMutableArray()
    var extraArr = NSMutableArray()
    var senderButtonTag:String?
    var interstitial: GADInterstitial!
    
    //MARK:- View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        //nokri_ltrRtl()
        addLeftBarButtonWithImage(#imageLiteral(resourceName: "menu"))
        if let userData = UserDefaults.standard.object(forKey: "settingsData") {
            let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
            let dataTabs = SplashRoot(fromDictionary: objData)
            let obj2 = dataTabs.data.empTabs
            self.title = obj2?.templates
        }
        showSearchButton()
        //let request = GADRequest()
        //request.testDevices = [kGADSimulatorID]
        //interstitial.load(request)
        //self.perform(#selector(self.nokri_adMob), with: nil, afterDelay: 7.5)
        nokri_adMob()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //tableViewHeightConstraint.constant = tableView.contentSize.height
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        nokri_emailTemplateData()
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
                    //print(objData?.banner_id!!)
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
    
    //    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    //        return adBannerView
    //    }
    //
    //    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    //        return adBannerView!.frame.height
    //    }
    
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
        return emailTempArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmailTemplateTableViewCell", for: indexPath) as! EmailTemplateTableViewCell

        let selectedActiveJob = self.emailTempArray[indexPath.row] as? [NSDictionary]
        for itemDict in selectedActiveJob! {
            let innerDict = itemDict ;
            if let field_type_name = innerDict["field_type_name"] as? String{
                if field_type_name == "temp_name" {
                    if let value = innerDict["value"] as? String {
                        cell.lblNameValue.text = value
                    }
                }
                if field_type_name == "temp_id" {
                    if let value = innerDict["value"] as? String {
                        cell.btnUpdateForTempID.setTitle(value, for: .normal)
                        cell.btnDelForTempId.setTitle(value, for: .normal)
                    }
                }
            }
            cell.lblSrNumValue.text = String(indexPath.row + 1)
            cell.btnDelForTempId.addTarget(self, action: #selector(EmailTemplateViewController.nokri_btnDeleteClicked(_:)), for: .touchUpInside)
            cell.btnUpdateForTempID.addTarget(self, action: #selector(EmailTemplateViewController.nokri_btnUpdateClicked(_:)), for: .touchUpInside)
            
        }
     
        let extraObj = self.extraArr as? [NSDictionary]
        for itemDict in extraObj! {
            let innerDict = itemDict ;
            if let field_type_name = innerDict["field_type_name"] as? String{
                if field_type_name == "update" {
                    if let value = innerDict["value"] as? String {
                        cell.btnUPdateValue.setTitle(value, for: .normal)
                    }
                }
                if field_type_name == "del" {
                    if let value = innerDict["value"] as? String {
                        cell.btnDeleteValue.setTitle(value, for: .normal)
                    }
                }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 47
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
    
    @objc func nokri_btnDeleteClicked(_ sender: UIButton){
        
        let temId = sender.titleLabel?.text
        print(temId!)
        if let userData = UserDefaults.standard.object(forKey: "settingsData") {
            let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
            let alertData = SplashRoot(fromDictionary: objData)
            let obj = alertData.data.genericTxts
            let alert = UIAlertController(title: obj?.confirm, message: nil, preferredStyle: .alert)
            let okButton = UIAlertAction(title: obj?.btnConfirm, style: .default) { (ok) in
                let param: [String: Any] = [
                    "temp_id": temId!,
                    ]
                print(param)
                self.nokri_deleteEmailTemp(parameter: param as NSDictionary)
            }
            let cancelButton = UIAlertAction(title: obj?.btnCancel, style: .default) { (cancel) in
            }
            alert.addAction(cancelButton)
            alert.addAction(okButton)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @objc func nokri_btnUpdateClicked(_ sender: UIButton){
        senderButtonTag = sender.titleLabel?.text
        print(senderButtonTag!)
        let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "AddTempTableViewController") as! AddTempTableViewController
        detailVC.tempId = senderButtonTag
        detailVC.isTemp = true
        detailVC.isFromUpdate = true
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func nokri_populateData(){
        
        let extraObj = self.extraArr as? [NSDictionary]
        for itemDict in extraObj! {
            let innerDict = itemDict ;
            if let field_type_name = innerDict["field_type_name"] as? String{
                if field_type_name == "sr_text" {
                    if let value = innerDict["value"] as? String {
                     self.lblSrNoKey.text = value
                    }
                }
                if field_type_name == "name" {
                    if let value = innerDict["value"] as? String {
                        self.lblNameKey.text = value
                    }
                }
                if field_type_name == "update" {
                    if let value = innerDict["value"] as? String {
                        self.lblUpdateKy.text = value
                    }
                }
                if field_type_name == "del" {
                    if let value = innerDict["value"] as? String {
                        self.lblDeleteKey.text = value
                    }
                }
                if field_type_name == "btn_txt" {
                    if let value = innerDict["value"] as? String {
                        self.btnAddNew.setTitle(value, for: .normal)
                    }
                }
                if field_type_name == "section_name" {
                    if let value = innerDict["value"] as? String {
                     self.lblYourEmailTemp.text = value
                    }
                }
                if field_type_name == "page_title" {
                    if let value = innerDict["value"] as? String {
                        self.title = value
                    }
                }
                if field_type_name == "not_added" {
                    if let value = innerDict["value"] as? String {
                       message = value
                    }
                }
            }
        }
        if let temp = self.emailTempArray as? [NSDictionary]{
        for itemDict in temp  {
            let innerDict = itemDict ;
            if let field_type_name = innerDict["field_type_name"] as? String{
                
                if field_type_name == "temp_id" {
                    if let value = innerDict["value"] as? String {
                        senderButtonTag = value
                    }
                }
            }
        }
        }
        if emailTempArray.count == 0{
            nokri_tableViewHelper()
        }else{
            nokri_tableViewHelper2()
        }
        print("\(self.emailTempArray.count)")
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
    
    func nokri_ltrRtl(){
        let isRtl = UserDefaults.standard.string(forKey: "isRtl")
        if isRtl == "0"{
            self.addLeftBarButtonWithImage(#imageLiteral(resourceName: "menu"))
        }else{
            self.addRightBarButtonWithImage(#imageLiteral(resourceName: "menu"))
        }
    }
    
    //MARK:- IBActons
    
    @IBAction func btnAddTempClicked(_ sender: UIButton) {
        let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "AddTempTableViewController") as! AddTempTableViewController
        //detailVC.tempId = senderButtonTag
       // print(senderButtonTag)
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    //MARK:- API Calls
    
    func nokri_emailTemplateData(){
        
        var langCode = UserDefaults.standard.string(forKey: "langCode")
        if langCode == nil {
            langCode = "en"
        }
        
        self.showLoader()
        self.viewTop.isHidden = true
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
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.emailTemplate, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    let responseData = response.value as! NSDictionary
                    let success = responseData["success"] as! Bool
                    if success == true{
                        self.viewTop.isHidden = false
                        let data = responseData["data"] as! NSDictionary
                        if let emailTempArr = data["templates"] as? NSArray {
                            self.nokri_emailTemplateParser(emailTemplateArray: emailTempArr)
                        }
                        if let exArray = data["extras"] as? NSArray {
                            self.nokri_extraDataParser(extraDataArray: exArray)
                        }
                        self.tableView.reloadData()
                    }else{
                    }
                    self.nokri_populateData()
                    self.tableView.reloadData()
                    self.stopAnimating()
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
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.emailTemplate, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    let responseData = response.value as! NSDictionary
                    let success = responseData["success"] as! Bool
                    if success == true{
                        self.viewTop.isHidden = false
                        let data = responseData["data"] as! NSDictionary
                        if let emailTempArr = data["templates"] as? NSArray {
                            self.nokri_emailTemplateParser(emailTemplateArray: emailTempArr)
                        }
                        if let exArray = data["extras"] as? NSArray {
                            self.nokri_extraDataParser(extraDataArray: exArray)
                        }
                        self.tableView.reloadData()
                    }else{
                    }
                    self.nokri_populateData()
                    self.tableView.reloadData()
                    self.stopAnimating()
            }
        }
    }
    
    func nokri_extraDataParser(extraDataArray:NSArray){
        self.extraArr.removeAllObjects()
        for item in extraDataArray{
            self.extraArr.add(item)
        }
    }
    
    func nokri_emailTemplateParser(emailTemplateArray:NSArray){
        self.emailTempArray.removeAllObjects()
        for item in emailTemplateArray{
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
            self.emailTempArray.add(arrayOfDictionaries);
        }
    }
   
    func nokri_deleteEmailTemp(parameter: NSDictionary) {
        self.showLoader()
        UserHandler.nokri_emailTempDelete(parameter: parameter as NSDictionary, success: { (successResponse) in
            self.stopAnimating()
            if successResponse.success == true{
                let hud = JGProgressHUD(style: .dark)
                hud.textLabel.text = successResponse.message as! String
                hud.detailTextLabel.text = nil
                hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                hud.position = .bottomCenter
                hud.show(in: self.view)
                hud.dismiss(afterDelay: 2.0)
                //self.view.makeToast(successResponse.message as? String, duration: 1.5, position: .center)
                self.tableView.reloadData()
            }
            else {
                let alert = Constants.showBasicAlert(message: successResponse.message as! String)
                self.present(alert, animated: true, completion: nil)
            }
             self.nokri_emailTemplateData()
             self.tableView.reloadData()
        }) { (error) in
            let alert = Constants.showBasicAlert(message: error.message)
            self.present(alert, animated: true, completion: nil)
            self.stopAnimating()
        }
    }
}
