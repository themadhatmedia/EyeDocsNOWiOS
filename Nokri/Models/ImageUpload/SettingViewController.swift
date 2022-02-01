//
//  SettingViewController.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 10/2/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import UIKit
import EggRating

class SettingViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    //MARK:- IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK:- Proporties
    
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
        let isRtl = UserDefaults.standard.string(forKey: "isRtl")
        if isRtl == "0"{
            self.addLeftBarButtonWithImage(#imageLiteral(resourceName: "menu"))
        }else{
            self.addRightBarButtonWithImage(#imageLiteral(resourceName: "menu"))
        }

        self.title = "Settings"
        rateUs()
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
            cell.lblShare.text = "Share this App"
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
            cell.lblFeedBack.text = "Feedback"
            let htmlString = "Got any queries ? , we are here to help you!"
            let data = htmlString.data(using: String.Encoding.unicode)!
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
        return cell
            
        }else if indexPath.section == 5 {
    
            let cell = tableView.dequeueReusableCell(withIdentifier: "FaqTableViewCell", for: indexPath) as! FaqTableViewCell
         
            if let userData = UserDefaults.standard.object(forKey: "settingsData") {
                let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
                let dataTabs = SplashRoot(fromDictionary: objData)
            cell.lblFaq.text = "Faq's"
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
            cell.lblPrivacy.text = "Privacy Polivicy"
            cell.btnPrivacy.addTarget(self, action: #selector(SettingViewController.nokri_btnPrivacyClicked(_:)), for: .touchUpInside)
            
            if isPrivacy == false{
                if indexPath.section == 7{
                    cell.isHidden = true
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
    
   // MARK:- IBActions
    
    
    @objc func nokri_btnRatingClicked(_ sender: UIButton){
        EggRating.promptRateUs(in: self)
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
    
    func nokri_appShare(){
        if let userData = UserDefaults.standard.object(forKey: "settingsData") {
            let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
            let dataTabs = SplashRoot(fromDictionary: objData)
        let link = NSURL(string: "https://itunes.apple.com/us/app/nokri/id1430717904#?platform=iphone")
        let shareTitle = dataTabs.data.shareSap.popupTitle
        let shareText = dataTabs.data.shareSap.subject
            let vc = UIActivityViewController(activityItems: [shareTitle!,shareText,link!], applicationActivities: nil)
        self.present(vc, animated: true, completion: nil)
        }
    }
    
    func rateUs(){
        EggRating.starFillColor = UIColor(hex: appColorNew!)
        EggRating.starBorderColor = UIColor(hex: appColorNew!)
        EggRating.titleLabelText = "Rate Us"
        EggRating.descriptionLabelText = "if you found this app awesome rate us."
        EggRating.dismissButtonTitleText = "Cancel"
        EggRating.rateButtonTitleText = "Rate Now"
        EggRating.minRatingToAppStore = 4
        EggRating.thankyouDescriptionLabelText = ""
        EggRating.thankyouDismissButtonTitleText = ""
    }
    
    //MARK:- Api Calls
    
}

extension SettingViewController: EggRatingDelegate {
    
    func didRate(rating: Double) {
        print("didRate: \(rating)")
    }
    
    func didRateOnAppStore() {
        print("didRateOnAppStore")
    }
    
    func didIgnoreToRate() {
        print("didIgnoreToRate")
    }
    
    func didIgnoreToRateOnAppStore() {
        print("didIgnoreToRateOnAppStore")
    }
    
    func didDissmissThankYouDialog() {
        print("didDissmissThankYouDialog")
    }
}

