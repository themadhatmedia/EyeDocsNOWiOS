//
//  CompanyDetailViewController.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 5/1/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import UIKit
import Alamofire
import JGProgressHUD

class CompanyDetailViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    
    //MARK:- IBOutlets
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var btnFollowUs: UIButton!
    @IBOutlet weak var lblCompanyName: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var containerViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var lblPrivate: UILabel!
    @IBOutlet weak var viewCollection: UIView!
    @IBOutlet weak var topConstraintView: NSLayoutConstraint!
    
    //MARK:- Proporties
    
    var appColorNew = UserDefaults.standard.string(forKey: "app_Color")
    //var socilImagesArray = [#imageLiteral(resourceName: "facebookCircle"),#imageLiteral(resourceName: "linkedInCircle"),#imageLiteral(resourceName: "googlePlus"),#imageLiteral(resourceName: "twitter")]
    var company_Id:Int?
    var isFromFollowedCompany:Bool = true
    var infoArray = NSMutableArray()
    var extraArray = NSMutableArray()
    var jobsArray = NSMutableArray()
    var socialIconsDict = NSMutableDictionary()
    var socilImagesArray = [UIImage]()
    var socialArr = [String]()
    var reviewsData = [ReviewsData]()

    var arrayCount = 0
    var fb:String?
    var gogle:String?
    var twit:String?
    var link:String?
    var isLogin:String?
    var isShowSocial:Bool = false
    var withOutLogin = UserDefaults.standard.string(forKey: "aType")
    let type = UserDefaults.standard.integer(forKey: "usrTyp")
    
    var recId :Int = 0
    var recName:String = ""
    var recvEmail :String = ""
    var sender_name :String = ""
    var sender_email :String = ""
    var sender_subject :String = ""
    var sender_message :String = ""
    var btn_txt :String = ""
    var companyFollowBtnShow = ""
    //MARK:- View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        btnFollowUs.layer.cornerRadius = 15
        btnFollowUs.backgroundColor = UIColor(hex:appColorNew!)
        nokri_roundedImage()
        nokri_CompanyPublicProfile()
        self.showBackButton()        
        if type == 1{
            btnFollowUs.isHidden = true
            topConstraintView.constant -= 50
        }else{
            btnFollowUs.isHidden = false
        }
        if let userData = UserDefaults.standard.object(forKey: "settingsData") {
        let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
        let dataTabs = SplashRoot(fromDictionary: objData)
            let obj = dataTabs.data.compnyPublicJobs.details
            self.title = obj
        }
    }
        
    override func viewDidLayoutSubviews() {
        // let tableViewHight = UserDefaults.standard.float(forKey: "tableViewHight")
        // print("\(tableViewHight)")
        self.containerViewHeightConstraint.constant = 1200
        self.scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height + 900)
    }
    
    //MARK:- Actions
    
    @IBAction func btnFollowUsClicked(_ sender: UIButton) {
        //let type = UserDefaults.standard.integer(forKey: "usrTyp")
        if  withOutLogin == "5"{
            let hud = JGProgressHUD(style: .dark)
            hud.textLabel.text = isLogin
            hud.detailTextLabel.text = nil
            hud.indicatorView = JGProgressHUDSuccessIndicatorView()
            hud.position = .bottomCenter
            hud.show(in: self.view)
            hud.dismiss(afterDelay: 2.0)
          //self.view.makeToast(isLogin, duration: 1.5, position: .bottom)
        }else {
            nokri_CompanyFollow()
        }
    }
    
    //MARK:- Custome Functions
    
    func nokri_PopulateData(){
      
        let info = self.infoArray as? [NSDictionary]
        for itemDict in info! {
            if let obj = itemDict["field_type_name"] as? String{
                if obj == "emp_name"{
                    if let key = itemDict["value"] as? String {
                        self.lblCompanyName.text = key
                    }
                }
                if obj == "emp_adress"{
                    if let key = itemDict["value"] as? String {
                        self.lblLocation.text = key
                    }
                }
            }
        }
        
        let extra = self.extraArray as? [NSDictionary]
        for itemDict in extra! {
            if let obj = itemDict["field_type_name"] as? String{
                if obj == "comp_follow"{
                    if let key = itemDict["key"] as? String {
                       self.btnFollowUs.setTitle(key, for: .normal)
                    }
                }
                if obj == "login_as"{
                    if let key = itemDict["key"] as? String {
                        self.isLogin = key
                    }
                }
                if obj == "map_switch"{
                    if let value = itemDict["value"] as? String {
                        UserDefaults.standard.set("isEmpMapShow", forKey: value)
                    }
                }
            }
        }
    
        if let fb = self.fb{
            if fb != ""{
                socialArr.append(fb)
                socilImagesArray.append(#imageLiteral(resourceName: "facebookCircle"))
            }
        }
        if let googl = self.gogle{
            if googl != ""{
                socialArr.append(googl)
                socilImagesArray.append(#imageLiteral(resourceName: "instagram"))
            }
        }
        if let linkedIn = self.link{
            if linkedIn != ""{
                socialArr.append(linkedIn)
                socilImagesArray.append(#imageLiteral(resourceName: "linkedInCircle"))
            }
        }
        if let twit = self.twit{
            if twit != ""{
                socialArr.append(twit)
                socilImagesArray.append(#imageLiteral(resourceName: "twitter"))
            }
        }
        print(socialArr.count)
    }
  
    //MARK:- CollectionView
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return socilImagesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SocialCompanyCollectionViewCell", for: indexPath) as! SocialCompanyCollectionViewCell
        //cell.imageViewSocial.image = socilImagesArray[indexPath.row]
        
        print(socilImagesArray)
        
        cell.imageViewSocial.image = socilImagesArray[indexPath.row]
        cell.btnSocialIcon.setTitle(socialArr[indexPath.row], for: .normal)
        cell.btnSocialIcon.addTarget(self, action: #selector(CompanyDetailViewController.nokri_btnSocialClicked(_:)), for: .touchUpInside)
        if cell.imageViewSocial.image == #imageLiteral(resourceName: "facebookCircle") {
            cell.btnSocialIcon.tag = 1
        }
        if cell.imageViewSocial.image == #imageLiteral(resourceName: "instagram") {
            cell.btnSocialIcon.tag = 2
        }
        if cell.imageViewSocial.image == #imageLiteral(resourceName: "linkedInCircle") {
            cell.btnSocialIcon.tag = 3
        }
        if cell.imageViewSocial.image == #imageLiteral(resourceName: "twitter") {
            cell.btnSocialIcon.tag = 4
        }
        arrayCount = socialArr.count
        
        return cell
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
    
    @objc func nokri_btnSocialClicked(_ sender: UIButton){
        
        var inValidUrl:String = ""
        
        if let userData = UserDefaults.standard.object(forKey: "settingsData") {
            let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
            let dataTabs = SplashRoot(fromDictionary: objData)
            inValidUrl = dataTabs.data.extra.invalid_url
            
        }
        
        if sender.tag == 1{
            print("Facebook")
                if #available(iOS 10.0, *) {
                    if verifyUrl(urlString: fb!) == false {
                        let hud = JGProgressHUD(style: .dark)
                        hud.textLabel.text = inValidUrl
                        hud.detailTextLabel.text = nil
                        hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                        hud.position = .bottomCenter
                        hud.show(in: self.view)
                        hud.dismiss(afterDelay: 2.0)
                        //self.view.makeToast(inValidUrl, duration: 2.5, position: .center)
                    }else{
                        
                        UIApplication.shared.open(URL(string: fb!)!, options: [:], completionHandler: nil)
                     }
                    }
            else {
                    if verifyUrl(urlString: fb!) == false {
                        let hud = JGProgressHUD(style: .dark)
                        hud.textLabel.text = inValidUrl
                        hud.detailTextLabel.text = nil
                        hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                        hud.position = .bottomCenter
                        hud.show(in: self.view)
                        hud.dismiss(afterDelay: 2.0)
                        //self.view.makeToast(inValidUrl, duration: 2.5, position: .center)
                    }else{
                        UIApplication.shared.openURL(URL(string: fb!)!)
                        
                    }
            }
        }
        if sender.tag == 2{
            print("google")
            if #available(iOS 10.0, *) {
                if verifyUrl(urlString: gogle!) == false {
                    let hud = JGProgressHUD(style: .dark)
                    hud.textLabel.text = inValidUrl
                    hud.detailTextLabel.text = nil
                    hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                    hud.position = .bottomCenter
                    hud.show(in: self.view)
                    hud.dismiss(afterDelay: 2.0)
                    //self.view.makeToast(inValidUrl, duration: 2.5, position: .center)
                }else{
                    UIApplication.shared.open(URL(string: gogle!)!, options: [:], completionHandler: nil)
                    
                }
            } else {
                if verifyUrl(urlString: gogle!) == false {
                    let hud = JGProgressHUD(style: .dark)
                    hud.textLabel.text = inValidUrl
                    hud.detailTextLabel.text = nil
                    hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                    hud.position = .bottomCenter
                    hud.show(in: self.view)
                    hud.dismiss(afterDelay: 2.0)
                    //self.view.makeToast(inValidUrl, duration: 2.5, position: .center)
                }else{
                    UIApplication.shared.openURL(URL(string: gogle!)!)
                    
                }
            }
        }
        if sender.tag == 3{
            print("linked")
            if #available(iOS 10.0, *) {
                if verifyUrl(urlString: link!) == false {
                    let hud = JGProgressHUD(style: .dark)
                    hud.textLabel.text = inValidUrl
                    hud.detailTextLabel.text = nil
                    hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                    hud.position = .bottomCenter
                    hud.show(in: self.view)
                    hud.dismiss(afterDelay: 2.0)
                    //self.view.makeToast(inValidUrl, duration: 2.5, position: .center)
                }else{
                UIApplication.shared.open(URL(string: link!)!, options: [:], completionHandler: nil)
                }
            } else {
                if verifyUrl(urlString: link!) == false {
                    let hud = JGProgressHUD(style: .dark)
                    hud.textLabel.text = inValidUrl
                    hud.detailTextLabel.text = nil
                    hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                    hud.position = .bottomCenter
                    hud.show(in: self.view)
                    hud.dismiss(afterDelay: 2.0)
                    //self.view.makeToast(inValidUrl, duration: 2.5, position: .center)
                }else{
                    UIApplication.shared.openURL(URL(string: link!)!)
                    
                }
            }
        }
        if sender.tag == 4{
            print("twitter")
            if #available(iOS 10.0, *) {
                if verifyUrl(urlString: twit!) == false {
                    let hud = JGProgressHUD(style: .dark)
                    hud.textLabel.text = inValidUrl
                    hud.detailTextLabel.text = nil
                    hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                    hud.position = .bottomCenter
                    hud.show(in: self.view)
                    hud.dismiss(afterDelay: 2.0)
                    //self.view.makeToast(inValidUrl, duration: 2.5, position: .center)
                }else{
                UIApplication.shared.open(URL(string: twit!)!, options: [:], completionHandler: nil)
                }
            } else {
                if verifyUrl(urlString: twit!) == false {
                    let hud = JGProgressHUD(style: .dark)
                    hud.textLabel.text = inValidUrl
                    hud.detailTextLabel.text = nil
                    hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                    hud.position = .bottomCenter
                    hud.show(in: self.view)
                    hud.dismiss(afterDelay: 2.0)
                    //self.view.makeToast(inValidUrl, duration: 2.5, position: .center)
                }else{
                    UIApplication.shared.openURL(URL(string: twit!)!)
                    
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        return CGSize(width: width/CGFloat(socilImagesArray.count), height: 35)
    }
    
    
    
    func nokri_roundedImage(){
        imageView.layer.borderWidth = 2
        imageView.layer.masksToBounds = false
        imageView.layer.borderColor = UIColor(hex:appColorNew!).cgColor
        imageView.layer.cornerRadius = imageView.frame.height/2
        imageView.clipsToBounds = true
    }
    
    //MARK:- API Calls
    
    func nokri_CompanyPublicProfile(){
        
        var langCode = UserDefaults.standard.string(forKey: "langCode")
        if langCode == nil {
            langCode = "en"
        }
        
        self.btnFollowUs.isHidden = true
        self.imageView.isHidden = true
        self.lblCompanyName.isHidden = true
        self.lblLocation.isHidden = true
        self.containerView.isHidden = true
        self.viewCollection.isHidden = true
        
        var isTimeOut = false
        let comp_id = UserDefaults.standard.integer(forKey: "comp_Id")
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
            let param: [String: Any]?
            //        if isFromFollowedCompany == false{
            //            param = [
            //                "comp_id": company_Id!
            //            ]
            //            print(param!)
            //        }else{
            param = [
                "company_id": comp_id
            ]
            print(param!)
            // }
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.employer_publicProfile, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    guard let res = response.value else{return}
                    let responseData = res as! NSDictionary
                    let message = responseData["message"] as? String
                    let success = responseData["success"] as! Bool
                    //success = false
                    if success == true{
                        self.btnFollowUs.isHidden = false
                        self.imageView.isHidden = false
                        self.lblCompanyName.isHidden = false
                        self.lblLocation.isHidden = false
                        self.containerView.isHidden = false
                        self.viewCollection.isHidden = false
                        isTimeOut = true
                        let data = responseData["data"] as! NSDictionary
                        let basicInfo = data["basic_ifo"] as! NSDictionary
                        let profileImage  = basicInfo["profile_img"] as! NSDictionary
                        let socialIcon  = basicInfo["social"] as! NSDictionary
                        self.isShowSocial = (socialIcon["is_show"] as? Bool)!
                        self.fb = socialIcon["facebook"] as? String
                        self.twit = socialIcon["twitter"] as? String
                        self.gogle = socialIcon["google_plus"] as? String
                        self.link = socialIcon["linkedin"] as? String
                        let companyContact = data["user_contact"] as! NSDictionary
                        self.recId = (companyContact["receiver_id"] as? Int)!
                        self.recName = (companyContact["receiver_name"] as? String)!
                        self.recvEmail = (companyContact["receiver_email"] as? String)!
                        self.sender_name = (companyContact["sender_name"] as? String)!
                        self.sender_email = (companyContact["sender_email"] as? String)!
                        self.sender_subject = (companyContact["sender_subject"] as? String)!
                        self.sender_message = (companyContact["sender_message"] as? String)!
                        self.btn_txt = (companyContact["btn_txt"] as? String)!
                        
                        UserDefaults.standard.set(self.recId, forKey: "receiver_id")
                        UserDefaults.standard.set(self.recName, forKey: "receiver_name")
                        UserDefaults.standard.set(self.recvEmail, forKey: "receiver_email")
                        UserDefaults.standard.set(self.sender_name, forKey: "sender_name")
                        UserDefaults.standard.set(self.sender_email, forKey: "sender_email")
                        UserDefaults.standard.set(self.sender_subject, forKey: "sender_subject")
                        UserDefaults.standard.set(self.sender_message, forKey: "sender_message")
                        UserDefaults.standard.set(self.btn_txt, forKey: "btn_txt")
                        
                        
                        if self.isShowSocial == true{
                            self.collectionView.isHidden = false
                        }else{
                            self.collectionView.isHidden = true
                        }
                        if let value = profileImage["img"] as? String
                        {
                            self.imageView.sd_setImage(with: URL(string: value), completed: nil)
                            self.imageView.sd_setShowActivityIndicatorView(true)
                            self.imageView.sd_setIndicatorStyle(.gray)
                        }
                        
                        
                        //                    if let imageUrl = URL(string: profileImage["img"] as! String){
                        //                        self.imageView.sd_setImage(with: imageUrl, completed: nil)
                        //                        self.imageView.sd_setShowActivityIndicatorView(true)
                        //                        self.imageView.sd_setIndicatorStyle(.gray)
                        //                    }
                        if let infoArr = basicInfo["info"] as? NSArray {
                            self.nokri_infoDataParser(infoArray: infoArr)
                        }
                        if let extraArray = data["extra"] as? NSArray {
                            self.nokri_extraDataParser(extrArr: extraArray)
                        }
                        if let jobsArr = data["jobs"] as? NSArray {
                            self.nokri_jobs(jobsAr: jobsArr)
                        }
                        self.nokri_PopulateData()
                        let param: [String: Any]?
                        //        if isFromFollowedCompany == false{
                        //            param = [
                        //                "comp_id": company_Id!
                        //            ]
                        //            print(param!)
                        //        }else{
                        param = [
                            "company_id": comp_id
                        ]
                        print(param!)
                        self.nokri_employerReviewData(params: param as! NSDictionary)

                        self.stopAnimating()
                        self.collectionView.reloadData()
                    }else{
                        
                        self.lblPrivate.text = message
                        self.btnFollowUs.isHidden = true
                        self.imageView.isHidden = true
                        self.lblCompanyName.isHidden = true
                        self.lblLocation.isHidden = true
                        self.containerView.isHidden = true
                        self.viewCollection.isHidden = true
                        
                        //self.view.makeToast(message, duration: 1.5, position: .center)
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
            let param: [String: Any]?
            //        if isFromFollowedCompany == false{
            //            param = [
            //                "comp_id": company_Id!
            //            ]
            //            print(param!)
            //        }else{
            param = [
                "company_id": comp_id
            ]
            print(param!)
            // }
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.employer_publicProfile, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    guard let res = response.value else{return}
                    let responseData = res as! NSDictionary
                    let message = responseData["message"] as? String
                    let success = responseData["success"] as! Bool
                    //success = false
                    if success == true{
                        //self.btnFollowUs.isHidden = false
                        self.imageView.isHidden = false
                        self.lblCompanyName.isHidden = false
                        self.lblLocation.isHidden = false
                        self.containerView.isHidden = false
                        self.viewCollection.isHidden = false
                        isTimeOut = true
                        let data = responseData["data"] as! NSDictionary
                        let basicInfo = data["basic_ifo"] as! NSDictionary
                        let profileImage  = basicInfo["profile_img"] as! NSDictionary
                        let socialIcon  = basicInfo["social"] as! NSDictionary
                        self.isShowSocial = (socialIcon["is_show"] as? Bool)!
                        self.fb = socialIcon["facebook"] as? String
                        self.twit = socialIcon["twitter"] as? String
                        self.gogle = socialIcon["google_plus"] as? String
                        self.link = socialIcon["linkedin"] as? String
                        let companyContact = data["user_contact"] as! NSDictionary
                        self.recId = (companyContact["receiver_id"] as? Int)!
                        self.recName = (companyContact["receiver_name"] as? String)!
                        self.recvEmail = (companyContact["receiver_email"] as? String)!
                        self.sender_name = (companyContact["sender_name"] as? String)!
                        self.sender_email = (companyContact["sender_email"] as? String)!
                        self.sender_subject = (companyContact["sender_subject"] as? String)!
                        self.sender_message = (companyContact["sender_message"] as? String)!
                        self.btn_txt = (companyContact["btn_txt"] as? String)!
                        
                        UserDefaults.standard.set(self.recId, forKey: "receiver_id")
                        UserDefaults.standard.set(self.recName, forKey: "receiver_name")
                        UserDefaults.standard.set(self.recvEmail, forKey: "receiver_email")
                        UserDefaults.standard.set(self.sender_name, forKey: "sender_name")
                        UserDefaults.standard.set(self.sender_email, forKey: "sender_email")
                        UserDefaults.standard.set(self.sender_subject, forKey: "sender_subject")
                         UserDefaults.standard.set(self.sender_message, forKey: "sender_message")
                         UserDefaults.standard.set(self.btn_txt, forKey: "btn_txt")
                        
                        
                        
                     
                        if self.isShowSocial == true{
                            self.collectionView.isHidden = false
                        }else{
                            self.collectionView.isHidden = true
                        }
                        
                        if let value = profileImage["img"] as? String
                        {
                            self.imageView.sd_setImage(with: URL(string: value), completed: nil)
                            self.imageView.sd_setShowActivityIndicatorView(true)
                            self.imageView.sd_setIndicatorStyle(.gray)
                        }
                        
                        
                        //                    if let imageUrl = URL(string: profileImage["img"] as! String){
                        //                        self.imageView.sd_setImage(with: imageUrl, completed: nil)
                        //                        self.imageView.sd_setShowActivityIndicatorView(true)
                        //                        self.imageView.sd_setIndicatorStyle(.gray)
                        //                    }
                        if let infoArr = basicInfo["info"] as? NSArray {
                            self.nokri_infoDataParser(infoArray: infoArr)
                        }
                        if let extraArray = data["extra"] as? NSArray {
                            self.nokri_extraDataParser(extrArr: extraArray)
                        }
                        if let jobsArr = data["jobs"] as? NSArray {
                            self.nokri_jobs(jobsAr: jobsArr)
                        }
                        self.nokri_PopulateData()
                        let param: [String: Any]?
                        //        if isFromFollowedCompany == false{
                        //            param = [
                        //                "comp_id": company_Id!
                        //            ]
                        //            print(param!)
                        //        }else{
                        param = [
                            "company_id": comp_id
                        ]
                        print(param!)
                        self.nokri_employerReviewData(params: param as! NSDictionary)
                        self.stopAnimating()
                        self.collectionView.reloadData()
                    }else{
                        self.lblPrivate.text = message
                        self.btnFollowUs.isHidden = true
                        self.imageView.isHidden = true
                        self.lblCompanyName.isHidden = true
                        self.lblLocation.isHidden = true
                        self.containerView.isHidden = true
                        self.viewCollection.isHidden = true
                        //self.view.makeToast(message, duration: 1.5, position: .center)
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
    func nokri_employerReviewData(params: NSDictionary){
        self.showLoader()
        UserHandler.nokri_PostEmployerPublicProfile(parameter: params , success: { (successResponse) in
            self.stopAnimating()
            if successResponse.success {
               
                self.reviewsData = successResponse.data.userReviewsData.reviewsArray
                self.companyFollowBtnShow = successResponse.data.companyFollowShow
//                if self.companyFollowBtnShow == "1"{
//                    self.btnFollowUs.isHidden = false
//                }else{
//                    self.btnFollowUs.isHidden = true
//                    self.topConstraintView.constant -= 50
//                }
                print(self.reviewsData)
                
            }
            else{}
        })
        { (error) in
            let alert = Constants.showBasicAlert(message: error.message)
            self.present(alert, animated: true, completion: nil)
            self.stopAnimating()
        }}
    func nokri_infoDataParser(infoArray:NSArray){
        self.infoArray.removeAllObjects()
        for item in infoArray{
            self.infoArray.add(item)
        }
    }
    
    func nokri_extraDataParser(extrArr:NSArray){
        self.extraArray.removeAllObjects()
        for item in extrArr{
            self.extraArray.add(item)
        }
    }
    
    func nokri_jobs(jobsAr:NSArray){
        self.jobsArray.removeAllObjects()
        for item in jobsAr{
            self.jobsArray.add(item)
        }
    }
    
    func nokri_CompanyFollow(){
        
        var langCode = UserDefaults.standard.string(forKey: "langCode")
        if langCode == nil {
            langCode = "en"
        }
        
        let isTimeOut = false
        let comp_id = UserDefaults.standard.integer(forKey: "comp_Id")
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
            let date = Date()
            let formatter = DateFormatter()
            //formatter.dateFormat = "dd.MM.yyyy"
            formatter.dateFormat = "MMM yyyy"
            let currentDate = formatter.string(from: date)
            let param: [String: Any] = [
                "company_id": comp_id,
                "follow_date" : currentDate
            ]
            print(param)
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.follow_Company, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    guard let res = response.value else{return}
                    let responseData = res as! NSDictionary
                    let message = responseData["message"] as? String
                    let success = responseData["success"] as! Bool
                    if success == true{
                        let hud = JGProgressHUD(style: .dark)
                        hud.textLabel.text = message
                        hud.detailTextLabel.text = nil
                        hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                        hud.position = .bottomCenter
                        hud.show(in: self.view)
                        hud.dismiss(afterDelay: 2.0)
                        //self.view.makeToast(message, duration: 1.5, position: .center)
                        self.stopAnimating()
                    }else{
                        let hud = JGProgressHUD(style: .dark)
                        hud.textLabel.text = message
                        hud.detailTextLabel.text = nil
                        hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                        hud.position = .bottomCenter
                        hud.show(in: self.view)
                        hud.dismiss(afterDelay: 2.0)
                        //self.view.makeToast(message, duration: 1.5, position: .center)
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
            let date = Date()
            let formatter = DateFormatter()
            //formatter.dateFormat = "dd.MM.yyyy"
            formatter.dateFormat = "MMM yyyy"
            let currentDate = formatter.string(from: date)
            let param: [String: Any] = [
                "company_id": comp_id,
                "follow_date" : currentDate
            ]
            print(param)
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.follow_Company, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    guard let res = response.value else{return}
                    let responseData = res as! NSDictionary
                    let message = responseData["message"] as? String
                    let success = responseData["success"] as! Bool
                    if success == true{
                        let hud = JGProgressHUD(style: .dark)
                        hud.textLabel.text = message
                        hud.detailTextLabel.text = nil
                        hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                        hud.position = .bottomCenter
                        hud.show(in: self.view)
                        hud.dismiss(afterDelay: 2.0)
                        //self.view.makeToast(message, duration: 1.5, position: .center)
                        self.stopAnimating()
                    }else{
                        let hud = JGProgressHUD(style: .dark)
                        hud.textLabel.text = message
                        hud.detailTextLabel.text = nil
                        hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                        hud.position = .bottomCenter
                        hud.show(in: self.view)
                        hud.dismiss(afterDelay: 2.0)
                        //self.view.makeToast(message, duration: 1.5, position: .center)
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
}

