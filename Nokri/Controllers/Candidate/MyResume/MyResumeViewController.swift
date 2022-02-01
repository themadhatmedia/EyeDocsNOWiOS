//
//  MyResumeViewController.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 4/30/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import UIKit
//import FileBrowser
import Alamofire
import MobileCoreServices
import JGProgressHUD
import GoogleMobileAds

class MyResumeViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UIDocumentPickerDelegate,UINavigationControllerDelegate ,GADBannerViewDelegate,SwiftyAdDelegate{
    
    //MARK:- IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnAddMoreResume: UIButton!
    @IBOutlet weak var lblSrKey: UILabel!
    @IBOutlet weak var lblNameKey: UILabel!
    @IBOutlet weak var lblDownloadKey: UILabel!
    @IBOutlet weak var lblDeleteKey: UILabel!
    @IBOutlet weak var lblYourResume: UILabel!
    @IBOutlet weak var heightConstraintTableView: NSLayoutConstraint!
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var heightConstraintBanner: NSLayoutConstraint!
    @IBOutlet weak var adBannerView: GADBannerView!
    @IBOutlet weak var bannerViewBottom: GADBannerView!
    @IBOutlet weak var heightConstraintBottomBanner: NSLayoutConstraint!
    
    //MARK:- Proporties
    
    var interstitial: GADInterstitial!
    var appColorNew = UserDefaults.standard.string(forKey: "app_Color")
    var message:String?
    var resumesArray = NSMutableArray()
    var extraArray = NSMutableArray()
    var messageForResume:String?
    var fileUrl:URL?
    private lazy var uploadingProgressBar: JGProgressHUD = {
        let progressBar = JGProgressHUD(style: .dark)
        progressBar.indicatorView = JGProgressHUDRingIndicatorView()
        progressBar.textLabel.text = "Uploading"
        return progressBar
    }()
    
    //MARK:- View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        tableView.dataSource = self
        tableView.delegate = self
        self.title = "My Resumes"
        //nokri_ltrRtl()
        addLeftBarButtonWithImage(#imageLiteral(resourceName: "menu"))
        btnAddMoreResume.layer.borderWidth = 1
        btnAddMoreResume.layer.borderColor = UIColor.gray.cgColor
        nokri_myResumesData()
        showSearchButton()
//        let request = GADRequest()
//        request.testDevices = [kGADSimulatorID]
//        interstitial.load(request)
//        self.perform(#selector(self.nokri_adMob), with: nil, afterDelay: 7.5)
        nokri_adMob()
    }
    
    //MARK:- IBActions
    
    @IBAction func btnAddMoreResumeClicked(_ sender: UIButton) {
        let options = [kUTTypePDF as String, kUTTypeZipArchive  as String, kUTTypePNG as String, kUTTypeJPEG as String, kUTTypeText  as String, kUTTypePlainText as String]
        let documentPicker: UIDocumentPickerViewController = UIDocumentPickerViewController(documentTypes: options, in: .import)
        documentPicker.delegate = self
        documentPicker.modalPresentationStyle = .formSheet
        self.present(documentPicker, animated: true, completion: nil)
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
        return resumesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyResumeTableViewCell", for: indexPath) as! MyResumeTableViewCell
        let selectedActiveJob = self.resumesArray[indexPath.row] as? [NSDictionary]
        for itemDict in selectedActiveJob! {
            let innerDict = itemDict ;
            if let field_type_name = innerDict["field_type_name"] as? String{
                if field_type_name == "resume_name" {
                    if let value = innerDict["value"] as? String {
                        cell.lblNameValue.text = value
                    }
                }
                if field_type_name == "resume_id" {
                    if let value = innerDict["value"] as? String {
                        cell.btnDelete.tag = Int(value)!
                        cell.btnDownload.tag = Int(value)!
                    }
                }
            }
        }
        let extraObj = self.extraArray as? [NSDictionary]
        for itemDict in extraObj! {
            let innerDict = itemDict ;
            if let field_type_name = innerDict["field_type_name"] as? String{
                if field_type_name == "dwnld_resume" {
                    if let value = innerDict["value"] as? String {
                        cell.btnDownload.setTitle(value, for: .normal)
                    }
                }
                if field_type_name == "del_resume" {
                    if let value = innerDict["value"] as? String {
                        cell.btnDelete.setTitle(value, for: .normal)
                    }
                }
            }
        }
        cell.lblSrKeyValue.text = String(indexPath.row + 1)
        cell.btnDelete.addTarget(self, action: #selector(MyResumeViewController.nokri_btnDeleteClicked(_:)), for: .touchUpInside)
        //cell.btnUpdateForTempID.addTarget(self, action: #selector(EmailTemplateViewController.btnUpdateClicked(_:)), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
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
    
    func  nokri_populateData(){
        let extraObj = self.extraArray as? [NSDictionary]
        for itemDict in extraObj! {
            let innerDict = itemDict ;
            if let field_type_name = innerDict["field_type_name"] as? String{
                if field_type_name == "section_label" {
                    if let value = innerDict["value"] as? String {
                        self.lblYourResume.text = value
                    }
                }
                if field_type_name == "ad_more_btn" {
                    if let value = innerDict["value"] as? String {
                        self.btnAddMoreResume.setTitle(value, for: .normal)
                    }
                }
                if field_type_name == "sr_txt" {
                    if let value = innerDict["value"] as? String {
                        self.lblSrKey.text = value
                    }
                }
                if field_type_name == "resume_name" {
                    if let value = innerDict["value"] as? String {
                        self.lblNameKey.text = value
                    }
                }
                if field_type_name == "dwnld_resume" {
                    if let value = innerDict["value"] as? String {
                        self.lblDownloadKey.text = value
                    }
                }
                if field_type_name == "del_resume" {
                    if let value = innerDict["value"] as? String {
                        self.lblDeleteKey.text = value
                    }
                }
                if field_type_name == "not_added" {
                    if let value = innerDict["value"] as? String {
                        messageForResume = value
                    }
                }
            }
        }
        if self.resumesArray.count == 0{
            nokri_tableViewHelper()
            tableView.separatorColor = UIColor.clear
        }else{
            nokri_tableViewHelper2()
        }
        print("\(self.resumesArray.count)");
        self.tableView.reloadData()
    }
    
    @objc func  nokri_btnDeleteClicked(_ sender: UIButton){
        let resumeId = sender.tag
        print(resumeId)
        if let userData = UserDefaults.standard.object(forKey: "settingsData") {
            let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
            let alertData = SplashRoot(fromDictionary: objData)
            let obj = alertData.data.genericTxts
            let alert = UIAlertController(title: obj?.confirm, message: nil, preferredStyle: .alert)
            let okButton = UIAlertAction(title: obj?.btnConfirm, style: .default) { (ok) in
                let param: [String: Any] = [
                    "resume_id": resumeId,
                    ]
                print(param)
                self.nokri_deleteResume(parameter: param as NSDictionary)
            }
            let cancelButton = UIAlertAction(title: obj?.btnCancel, style: .default) { (cancel) in
            }
            alert.addAction(cancelButton)
            alert.addAction(okButton)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func  nokri_tableViewHelper(){
        let rect = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: self.view.bounds.size.width, height: self.view.bounds.size.height))
        let messageLabel = UILabel(frame: rect)
        messageLabel.text = messageForResume
        messageLabel.textColor = UIColor.lightGray
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont(name: "TrebuchetMS", size: 20)
        messageLabel.sizeToFit()
        tableView.backgroundView = messageLabel
    }
    
    func  nokri_tableViewHelper2(){
        let rect = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: self.view.bounds.size.width, height: self.view.bounds.size.height))
        let messageLabel = UILabel(frame: rect)
        messageLabel.text = ""
        messageLabel.textAlignment = .center;
        tableView.backgroundView = messageLabel
    }
    
    //MARK:- Delegates For UIDocumentPicker
    
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        self.saveFileToDocumentDirectory(document: url)
        self.nokri_uploadResume(documentUrl: url)
    }
    
    public func documentMenu(_ documentMenu:UIDocumentPickerViewController, didPickDocumentPicker documentPicker: UIDocumentPickerViewController) {
        documentPicker.delegate = self
        present(documentPicker, animated: true, completion: nil)
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print("view was cancelled")
        dismiss(animated: true, completion: nil)
    }
    
    func saveFileToDocumentDirectory(document: URL) {
        if let fileUrl = FileManager.default.saveFileToDocumentDirectory(fileUrl: document, name: "my_cv_upload", extention: ".pdf") {
            print(fileUrl)
            //self.uploadResume(documentUrl: fileUrl)
        }
    }
    
    func removeFileFromDocumentsDirectory(fileUrl: URL) {
        _ = FileManager.default.removeFileFromDocumentsDirectory(fileUrl: fileUrl)
    }
    
    //MARK:- API Calls
    
    func  nokri_myResumesData(){
        //var isTimeOut = false
        
        var langCode = UserDefaults.standard.string(forKey: "langCode")
        if langCode == nil {
            langCode = "en"
        }
        
        self.viewHeader.isHidden = true
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
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.myResumes, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    let responseData = response.value as! NSDictionary
                    self.message = responseData["message"] as? String
                    let success = responseData["success"] as! Bool
                    if success == true{
                        //isTimeOut = true
                        self.viewHeader.isHidden = false
                        let data = responseData["data"] as! NSDictionary
                        if let resumeArr = data["resumes"] as? NSArray {
                            self.nokri_ResumesDataParser(resumeArray: resumeArr)
                            //self.heightConstraintTableView.constant = self.tableView.contentSize.height
                        }
                        if let exArray = data["extras"] as? NSArray {
                            self.nokri_extraDataParser(extraDataArray: exArray)
                        }
                    }else{
                        self.viewHeader.isHidden = true
                        let alert = Constants.showBasicAlert(message: self.message!)
                        self.present(alert, animated: true, completion: nil)
                    }
                    self.nokri_populateData()
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
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.myResumes, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    let responseData = response.value as! NSDictionary
                    self.message = responseData["message"] as? String
                    let success = responseData["success"] as! Bool
                    if success == true{
                        //isTimeOut = true
                        self.viewHeader.isHidden = false
                        let data = responseData["data"] as! NSDictionary
                        if let resumeArr = data["resumes"] as? NSArray {
                            self.nokri_ResumesDataParser(resumeArray: resumeArr)
                            //self.heightConstraintTableView.constant = self.tableView.contentSize.height
                        }
                        if let exArray = data["extras"] as? NSArray {
                            self.nokri_extraDataParser(extraDataArray: exArray)
                        }
                    }else{
                        self.viewHeader.isHidden = true
                        let alert = Constants.showBasicAlert(message: self.message!)
                        self.present(alert, animated: true, completion: nil)
                    }
                    self.nokri_populateData()
                    self.stopAnimating()
                
            }
        }
        
     
    }
    
    func nokri_extraDataParser(extraDataArray:NSArray){
        self.extraArray.removeAllObjects()
        for item in extraDataArray{
            self.extraArray.add(item)
        }
        print(extraArray)
    }
    
    func nokri_ResumesDataParser(resumeArray:NSArray){
        self.resumesArray.removeAllObjects()
        for item in resumeArray{
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
            self.resumesArray.add(arrayOfDictionaries);
        }
    }
    
    func  nokri_deleteResume(parameter: NSDictionary) {
        self.showLoader()
        UserHandler.nokri_deleteResume(parameter: parameter as NSDictionary, success: { (successResponse) in
           self.stopAnimating()
            if successResponse.success == true{
                let hud = JGProgressHUD(style: .dark)
                hud.textLabel.text = successResponse.message! as! String
                hud.detailTextLabel.text = nil
                hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                hud.position = .bottomCenter
                hud.show(in: self.view)
                hud.dismiss(afterDelay: 2.0)
                //self.view.makeToast(successResponse.message as? String, duration: 1.5, position: .center)
                self.nokri_myResumesData()
                self.tableView.reloadData()
            }
            else {
                let alert = Constants.showBasicAlert(message: successResponse.message as! String)
                self.present(alert, animated: true, completion: nil)
                self.stopAnimating()
            }
            
        }) { (error) in
            let alert = Constants.showBasicAlert(message: error.message)
            self.present(alert, animated: true, completion: nil)
             self.stopAnimating()
        }
    }
    
    func nokri_uploadResume(documentUrl: URL) {
        uploadingProgressBar.progress = 0.0
        uploadingProgressBar.detailTextLabel.text = "0% Completed"
        uploadingProgressBar.show(in: view)
        //startActivityIndicator()
        UserHandler.nokri_uploadResume(fileName: "my_cv_upload", fileUrl: documentUrl, progress: { (uploadProgress) in
            print(uploadProgress)
            let currentProgress = Float(uploadProgress)/100
            self.uploadingProgressBar.detailTextLabel.text = "\(uploadProgress)% Completed"
            self.uploadingProgressBar.setProgress(currentProgress, animated: true)
        }, success: { (successResponse) in
            self.uploadingProgressBar.dismiss(animated: true)
            //self.removeFileFromDocumentsDirectory(fileUrl: self.fileUrl!)
            let hud = JGProgressHUD(style: .dark)
            hud.textLabel.text = successResponse.message!
            hud.detailTextLabel.text = nil
            hud.indicatorView = JGProgressHUDSuccessIndicatorView()
            hud.position = .bottomCenter
            hud.show(in: self.view)
            hud.dismiss(afterDelay: 2.0)
            //self.view.makeToast(successResponse.message, duration: 2.5, position: .center)
            self.nokri_myResumesData()
            self.tableView.reloadData()
            self.stopAnimating()
        }, failure: { (error) in
            
            let alert = Constants.showBasicAlert(message: error.message)
            self.present(alert, animated: true, completion: nil)
            self.stopAnimating()
            
        })
    }
}
