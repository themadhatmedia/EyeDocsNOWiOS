//
//  DashboardCandidateHeaderTableViewCell.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 5/5/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import UIKit
import Alamofire
import Toast_Swift

class DashboardCandidateHeaderTableViewCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var imgCurv: UIImageView!
    @IBOutlet weak var imageViewDashboard: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var viewBehindCell: UIView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    //@IBOutlet weak var btnChangePassword: UIButton!
    var fb:String?
    var gogle:String?
    var twit:String?
    var link:String?
    var arrayCount = 0
    var socilImagesArray = [UIImage]()
    var socialArr = [String]()
    var appColorNew = UserDefaults.standard.string(forKey: "app_Color")
    
    
    //var socilImagesArray = [#imageLiteral(resourceName: "facebookCircle"),#imageLiteral(resourceName: "linkedInCircle"),#imageLiteral(resourceName: "googlePlus"),#imageLiteral(resourceName: "twitter")]

    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        nokri_roundedImage()
        nokri_dashboardData()
        imgCurv.image = imgCurv.image?.withRenderingMode(.alwaysTemplate)
        imgCurv.tintColor = UIColor(hex: appColorNew!)
        //btnChangePassword.setTitleColor(UIColor(hex: appColorNew!), for: .normal)
    }
  
    //MARK:- CollectionView
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return socilImagesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SocialIconCandidateCollectionViewCell", for: indexPath) as! SocialIconCandidateCollectionViewCell
       
        cell.imageViewSocial.image = socilImagesArray[indexPath.row]
        cell.btnSocialIcon.setTitle(socialArr[indexPath.row], for: .normal)
        cell.btnSocialIcon.addTarget(self, action: #selector(DashboardCandidateHeaderTableViewCell.nokri_btnSocialClicked(_:)), for: .touchUpInside)
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
        return CGSize(width: width/CGFloat(socialArr.count), height: 25)
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
                    self.viewBehindCell.makeToast(inValidUrl, duration: 2.5, position: .center)
                }else{
                    UIApplication.shared.open(URL(string: fb!)!, options: [:], completionHandler: nil)
                }
            } else {
                
                if verifyUrl(urlString: fb!) == false {
                    self.viewBehindCell.makeToast(inValidUrl, duration: 2.5, position: .center)
                }else{
                    UIApplication.shared.openURL(URL(string: fb!)!)
                }
            }
        }
        if sender.tag == 2{
            print("google")
            if #available(iOS 10.0, *) {
                
                if verifyUrl(urlString: gogle!) == false {
                    self.viewBehindCell.makeToast(inValidUrl, duration: 2.5, position: .center)
                }else{
                    UIApplication.shared.open(URL(string: gogle!)!, options: [:], completionHandler: nil)
                    
                }
            } else {
                
                if verifyUrl(urlString: gogle!) == false {
                    self.viewBehindCell.makeToast(inValidUrl, duration: 2.5, position: .center)
                }else{
                UIApplication.shared.openURL(URL(string: gogle!)!)
                }
            }
        }
        if sender.tag == 3{
            print("linked")
            if #available(iOS 10.0, *) {
                
                if verifyUrl(urlString: link!) == false {
                    self.viewBehindCell.makeToast(inValidUrl, duration: 2.5, position: .center)
                }else{
                UIApplication.shared.open(URL(string: link!)!, options: [:], completionHandler: nil)
                }
            } else {
                
                if verifyUrl(urlString: link!) == false {
                    self.viewBehindCell.makeToast(inValidUrl, duration: 2.5, position: .center)
                }else{
                    UIApplication.shared.openURL(URL(string: link!)!)
                    
                }
            }
        }
        if sender.tag == 4{
            print("twitter")
            if #available(iOS 10.0, *) {
                
                if verifyUrl(urlString: twit!) == false {
                    self.viewBehindCell.makeToast(inValidUrl, duration: 2.5, position: .center)
                }else{
                    UIApplication.shared.open(URL(string: twit!)!, options: [:], completionHandler: nil)
                    
                }
            } else {
                
                if verifyUrl(urlString: twit!) == false {
                    self.viewBehindCell.makeToast(inValidUrl, duration: 2.5, position: .center)
                }else{
                    UIApplication.shared.openURL(URL(string: twit!)!)
                    
                }
            }
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
    
    /*
    @IBAction func btnChangePasswordClicked(_ sender: UIButton) {

       let controller = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ChangePasswordViewController") as! ChangePasswordViewController
        
        controller.modalPresentationStyle = .overCurrentContext
        //controller.modalTransitionStyle =    .flipHorizontal
        self.window?.rootViewController?.present(controller, animated: true, completion: nil)
        
    }*/
    
    //MARK:- Image Round
    
    func nokri_populateData(){
        
        //self.fb = "fACEBBOK"
        //self.gogle = "fACEBBOK"
        //self.link = "fACEBBOK"
        //self.twit = "fACEBBOK"
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
    
    func nokri_roundedImage(){
        
        imageViewDashboard.layer.borderWidth = 2.8
        imageViewDashboard.layer.masksToBounds = false
        imageViewDashboard.layer.borderColor = UIColor(hex:appColorNew!).cgColor
        imageViewDashboard.layer.cornerRadius = imageViewDashboard.frame.height/2
        imageViewDashboard.clipsToBounds = true
        
    }
    
    func nokri_dashboardData(){
        
        var langCode = UserDefaults.standard.string(forKey: "langCode")
        if langCode == nil {
            langCode = "en"
        }
        
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
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.dashboardCandidate, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    guard let res = response.value else{return}
                    let responseData = res as! NSDictionary
                    let success = responseData["success"] as! Bool
                    if success == true{
                        let data = responseData["data"] as! NSDictionary
                        let profile = data["profile"] as! NSDictionary
                        let innerData = profile["data"] as! NSDictionary
                        let social = innerData ["social"] as! NSDictionary
                        self.fb = social["facebook"] as? String
                        self.gogle = social["google_plus"] as? String
                        self.link = social["linkedin"] as? String
                        self.twit = social["twitter"] as? String
                        //print(self.fb!)
                        //print(self.gogle!)
                        //print(self.link!)
                        //print(self.twit!)
                        self.nokri_populateData()
                        self.collectionView.reloadData()
                    }else{
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
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.dashboardCandidate, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    guard let res = response.value else{return}
                    let responseData = res as! NSDictionary
                    let success = responseData["success"] as! Bool
                    if success == true{
                        let data = responseData["data"] as! NSDictionary
                        let profile = data["profile"] as! NSDictionary
                        let innerData = profile["data"] as! NSDictionary
                        let social = innerData ["social"] as! NSDictionary
                        self.fb = social["facebook"] as? String
                        self.gogle = social["google_plus"] as? String
                        self.link = social["linkedin"] as? String
                        self.twit = social["twitter"] as? String
                        //print(self.fb!)
                        //print(self.gogle!)
                        //print(self.link!)
                        //print(self.twit!)
                        self.nokri_populateData()
                        self.collectionView.reloadData()
                    }else{
                    }
            }
        }
        
      
    }
}
