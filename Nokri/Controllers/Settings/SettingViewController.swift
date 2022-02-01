//
//  SettingViewController.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 10/2/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import UIKit
//import EggRating
import GoogleMobileAds
import JGProgressHUD

class SettingViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,GADBannerViewDelegate,SwiftyAdDelegate {
    
    //MARK:- IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var heightConstraintBanner: NSLayoutConstraint!
    @IBOutlet weak var adBannerView: GADBannerView!
    @IBOutlet weak var bannerViewBottom: GADBannerView!
    @IBOutlet weak var heightConstraintBottomBanner: NSLayoutConstraint!
    
    //MARK:- Proporties
    
    var interstitial: GADInterstitial!
    var aboutCellHeight:CGFloat = 0.0
    var feedBckCellHeight:CGFloat = 0.0
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var appColorNew = UserDefaults.standard.string(forKey: "app_Color")
    var isAbout:Bool?
    var isVersion:Bool?
    var isRating:Bool?
    var isShare:Bool?
    var isPrivacy:Bool?
    var isTerm:Bool?
    var isFeedback:Bool?
    var isFaq:Bool?
    
    //MARK:- View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        nokri_adMob()
        //nokri_ltrRtl()
        addLeftBarButtonWithImage(#imageLiteral(resourceName: "menu"))
        showSearchButton()
        //rateUs()
//        interstitial = GADInterstitial(adUnitID: Constants.AdMob.intersetialId!)
//        let request = GADRequest()
//        request.testDevices = [kGADSimulatorID]
//        interstitial.load(request)
        self.perform(#selector(self.nokri_adMob), with: nil, afterDelay: 7.5)
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if let userData = UserDefaults.standard.object(forKey: "settingsData") {
            let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
            let dataTabs = SplashRoot(fromDictionary: objData)
            let obj = dataTabs.data.extra
            self.navigationController?.navigationBar.topItem?.title = obj?.setting
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
    
    
    //MARK:- TableView
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let userData = UserDefaults.standard.object(forKey: "settingsData") {
            let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
            let dataTabs = SplashRoot(fromDictionary: objData)
            isAbout = dataTabs.data.aboutSap.aboutSec
            isVersion = dataTabs.data.versionSap.versionSec
            isRating = dataTabs.data.ratingSap.ratingSec
            isShare = dataTabs.data.shareSap.shareSec
            isFeedback = dataTabs.data.feedBackSaplash.isShow
            isFaq = dataTabs.data.faqSaplash.isfaq
        }
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "AboutAppTableViewCell", for: indexPath) as! AboutAppTableViewCell
            
            if let userData = UserDefaults.standard.object(forKey: "settingsData") {
                let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
                let dataTabs = SplashRoot(fromDictionary: objData)
                let htmlString = dataTabs.data.aboutSap.aboutDet 
                let data = htmlString?.data(using: String.Encoding.unicode)!
                let attrStr = try? NSAttributedString(
                    data: data!,
                    options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html],
                    documentAttributes: nil)
                cell.lblAboutDetail.attributedText = attrStr
                self.aboutCellHeight = (cell.lblAboutDetail.attributedText?.height(withConstrainedWidth: self.view.frame.size.width))!+16;
                cell.lblAbout.text = dataTabs.data.aboutSap.about_title //"About" //dataTabs.data.aboutSap.aboutSec
                if (UserDefaults.standard.bool(forKey: "isNotSignIn") == true){
                    let isRtl = UserDefaults.standard.string(forKey: "isRtl")
                    if isRtl == "0"{
                        //cell.lblAboutDetail.attributedText.
                    }else{
                        
                    }
                }
            }
            
            if isAbout == false{
                if indexPath.section == 0{
                    cell.isHidden = true
                }
            }
            
            return cell
            
        }else if indexPath.section == 1 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "AppVersionTableViewCell", for: indexPath) as! AppVersionTableViewCell
            let appVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String
            
            if let userData = UserDefaults.standard.object(forKey: "settingsData") {
                let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
                let dataTabs = SplashRoot(fromDictionary: objData)
                
                cell.lblAppVersion.text = dataTabs.data.versionSap.versionDet
                cell.lblAppVersionDetail.text = appVersion
                
            }
            if isVersion == false{
                if indexPath.section == 1{
                    cell.isHidden = true
                }
            }
            return cell
            
        }else if indexPath.section == 2 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "AppStoreRatingTableViewCell", for: indexPath) as! AppStoreRatingTableViewCell
            cell.lblRating.text = "App Store Rating"
            cell.btnRating.addTarget(self, action: #selector(SettingViewController.nokri_btnRatingClicked(_:)), for: .touchUpInside)
            
            if isRating == false{
                if indexPath.section == 2{
                    cell.isHidden = true
                }
            }
            
            return cell
            
        }else if indexPath.section == 3 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "ShareTableViewCell", for: indexPath) as! ShareTableViewCell
            
            if let userData = UserDefaults.standard.object(forKey: "settingsData") {
                let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
                let dataTabs = SplashRoot(fromDictionary: objData)
                cell.lblShare.text = dataTabs.data.shareSap.popupTitle
                cell.btnShare.addTarget(self, action: #selector(SettingViewController.nokri_btnAppShareClicked(_:)), for: .touchUpInside)
                if isShare == false{
                    if indexPath.section == 3{
                        cell.isHidden = true
                    }
                }
            }
            return cell
            
        }else if indexPath.section == 4{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "FeedBackTableViewCell", for: indexPath) as! FeedBackTableViewCell
            
            if let userData = UserDefaults.standard.object(forKey: "settingsData") {
                let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
                let dataTabs = SplashRoot(fromDictionary: objData)
                
                
                if isFeedback == true{
                    
                    cell.lblFeedBack.text = dataTabs.data.feedBackSaplash.title
                    let htmlString = dataTabs.data.feedBackSaplash.subline
                    let data = htmlString!.data(using: String.Encoding.unicode)!
                    let attrStr = try? NSAttributedString(
                        data: data,
                        options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html],
                        documentAttributes: nil)
                    cell.lblFeedBackDetail.attributedText = attrStr
                    self.feedBckCellHeight = (cell.lblFeedBackDetail.attributedText?.height(withConstrainedWidth: self.view.frame.size.width))!+16;
                    cell.btnFeedBack.addTarget(self, action: #selector(SettingViewController.nokri_btnFeedBackClicked(_:)), for: .touchUpInside)
                    if (UserDefaults.standard.bool(forKey: "isNotSignIn") == true){
                        let isRtl = UserDefaults.standard.string(forKey: "isRtl")
                        if isRtl == "0"{
                            cell.lblFeedBackDetail.textAlignment = .left
                        }else{
                            cell.lblFeedBackDetail.textAlignment = .right
                        }
                        
                        if isFeedback == false{
                            if indexPath.section == 4{
                                cell.isHidden = true
                            }
                        }
                        
                        
                        
                    }
                    
                }
                
                
            }
            return cell
            
        }else if indexPath.section == 5 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FaqTableViewCell", for: indexPath) as! FaqTableViewCell
            if let userData = UserDefaults.standard.object(forKey: "settingsData") {
                let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
                let dataTabs = SplashRoot(fromDictionary: objData)
                cell.lblFaq.text = dataTabs.data.empTabs.faq
                cell.btnFaq.addTarget(self, action: #selector(SettingViewController.nokri_btnFaqClicked(_:)), for: .touchUpInside)
            }
            if isFaq == false{
                if indexPath.section == 5{
                    cell.isHidden = true
                }
            }
            
            return cell
            
        }else if indexPath.section == 6{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "TermsTableViewCell", for: indexPath) as! TermsTableViewCell
            
            if let userData = UserDefaults.standard.object(forKey: "settingsData") {
                let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
                let dataTabs = SplashRoot(fromDictionary: objData)
                cell.lblTerm.text = dataTabs.data.termSaplash.termTitle
                cell.btnTerm.addTarget(self, action: #selector(SettingViewController.nokri_btnTermsClicked(_:)), for: .touchUpInside)
            }
            
            if isTerm == false{
                if indexPath.section == 6{
                    cell.isHidden = true
                }
            }
            
            return cell
            
        }else{
            
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "PrivacyTableViewCell", for: indexPath) as! PrivacyTableViewCell
            
            if let userData = UserDefaults.standard.object(forKey: "settingsData") {
                let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
                let dataTabs = SplashRoot(fromDictionary: objData)
                cell.lblPrivacy.text = dataTabs.data.privacySap.privactTitle
                cell.btnPrivacy.addTarget(self, action: #selector(SettingViewController.nokri_btnPrivacyClicked(_:)), for: .touchUpInside)
                
                if isPrivacy == false{
                    if indexPath.section == 7{
                        cell.isHidden = true
                    }
                }
            }
            
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if let userData = UserDefaults.standard.object(forKey: "settingsData") {
            let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
            let dataTabs = SplashRoot(fromDictionary: objData)
            isAbout = dataTabs.data.aboutSap.aboutSec
            isVersion = dataTabs.data.versionSap.versionSec
            isTerm = dataTabs.data.termSaplash.termSec
            isShare = dataTabs.data.shareSap.shareSec
            isRating = dataTabs.data.ratingSap.ratingSec
            isPrivacy = dataTabs.data.privacySap.privacySec
            isFeedback = dataTabs.data.feedBackSaplash.isShow
            isFaq = dataTabs.data.faqSaplash.isfaq
            
        }
        
        if indexPath.section == 0{
            if isAbout == false{
                return 0
            }else{
                return  aboutCellHeight + 60
            }
            
        }else if indexPath.section == 1{
            if isVersion == false{
                return 0
            }else{
                return 72
            }
            
        }else if indexPath.section == 2{
            if isRating == false{
                return 0
            }else{
                return 46
            }
        }else if indexPath.section == 3{
            if isShare == false{
                return 0
            }else{
                return 46
            }
        }else if indexPath.section == 4{
            
            if isFeedback == false{
                return 0
            }else{
                return feedBckCellHeight + 60
            }
            
        }else if indexPath.section == 5{
            if isFaq == false{
                return 0
            }else{
                return 46
            }
            
        }else if indexPath.section == 6{
            if isTerm == false{
                return 0
            }else{
                return 46
            }
            
        }else{
            if isPrivacy == false{
                return 0
            }else{
                return 46
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if tableView.isDragging {
            cell.transform = CGAffineTransform.init(scaleX: 0.5, y: 0.5)
            UIView.animate(withDuration: 1.0, animations: {
                cell.transform = CGAffineTransform.identity
            })
        }
    }
    
    func verifyUrl (urlString: String?) -> Bool {
        //Check for nil
        if let urlString = urlString {
            // create NSURL instance
            if let url = NSURL(string: urlString) {
                // check if your application can open the NSURL instance
                return UIApplication.shared.canOpenURL(url as URL)
            }
        }
        return false
    }
    
    // MARK:- IBActions
    
    @objc func nokri_btnRatingClicked(_ sender: UIButton){
        // EggRating.promptRateUs(in: self)
        var inValidUrl:String = ""
        if let userData = UserDefaults.standard.object(forKey: "settingsData") {
            let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
            let dataTabs = SplashRoot(fromDictionary: objData)
            inValidUrl = dataTabs.data.extra.invalid_url
            if #available(iOS 10.0, *) {
                if verifyUrl(urlString: dataTabs.data.shareSap.url) == false {
                    let hud = JGProgressHUD(style: .dark)
                    hud.textLabel.text = inValidUrl
                    hud.detailTextLabel.text = nil
                    hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                    hud.position = .bottomCenter
                    hud.show(in: self.view)
                    hud.dismiss(afterDelay: 2.0)
                    //self.view.makeToast(inValidUrl)
                }else{
                    UIApplication.shared.open(URL(string: dataTabs.data.shareSap.url)!, options: [:], completionHandler: nil)
                }
                
                //                UIApplication.shared.open(URL(string: dataTabs.data.shareSap.url)!, options: [:], completionHandler: nil)
            } else {
                
                if verifyUrl(urlString: dataTabs.data.shareSap.url) == false {
                    //self.view.makeToast(inValidUrl)
                    let hud = JGProgressHUD(style: .dark)
                    hud.textLabel.text = inValidUrl
                    hud.detailTextLabel.text = nil
                    hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                    hud.position = .bottomCenter
                    hud.show(in: self.view)
                    hud.dismiss(afterDelay: 2.0)
                }else{
                    UIApplication.shared.open(URL(string: dataTabs.data.shareSap.url)!, options: [:], completionHandler: nil)
                }
                
                // UIApplication.shared.openURL(URL(string: dataTabs.data.shareSap.url)!)
            }
        }
    }
    
    @objc func nokri_btnAppShareClicked(_ sender: UIButton){
        nokri_appShare()
    }
    
    @objc func nokri_btnTermsClicked(_ sender: UIButton){
        if let userData = UserDefaults.standard.object(forKey: "settingsData") {
            let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
            let dataTabs = SplashRoot(fromDictionary: objData)
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(URL(string: dataTabs.data.termSaplash.url)!, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(URL(string: dataTabs.data.privacySap.url)!)
            }
        }
    }
    
    @objc func nokri_btnPrivacyClicked(_ sender: UIButton){
        if let userData = UserDefaults.standard.object(forKey: "settingsData") {
            let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
            let dataTabs = SplashRoot(fromDictionary: objData)
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(URL(string: dataTabs.data.privacySap.url)!, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(URL(string: dataTabs.data.privacySap.url)!)
            }
        }
    }
    
    @objc func nokri_btnFaqClicked(_ sender: UIButton){
        //appDelegate.nokri_moveToFaqs()
        let buyPkgController = self.storyboard?.instantiateViewController(withIdentifier: "Faq_sViewController") as! Faq_sViewController
        self.navigationController?.pushViewController(buyPkgController, animated: true)
    }
    
    @objc func nokri_btnFeedBackClicked(_ sender: UIButton){
        
        let controller = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "FeedBackViewController") as! FeedBackViewController
        controller.modalPresentationStyle = .overCurrentContext
        controller.modalTransitionStyle = .flipHorizontal
        self.present(controller, animated: true, completion: nil)
        
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
    
    func nokri_appShare(){
        if let userData = UserDefaults.standard.object(forKey: "settingsData") {
            let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
            let dataTabs = SplashRoot(fromDictionary: objData)
            let link = NSURL(string: dataTabs.data.shareSap.url)
            let shareText = dataTabs.data.shareSap.subject
            let vc = UIActivityViewController(activityItems: ["",shareText!,link!], applicationActivities: nil)
            self.present(vc, animated: true, completion: nil)
        }
    }
    
}
