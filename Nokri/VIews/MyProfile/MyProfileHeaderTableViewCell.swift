//
//  MyProfileHeaderTableViewCell.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 4/30/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import UIKit
import Alamofire


class MyProfileHeaderTableViewCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var imegViewHeader: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblSubTitle: UILabel!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var btnDownload: UIButton!
    
    
    var userId:Int?
    var fb:String?
    var gogle:String?
    var twit:String?
    var link:String?
    var idCheck:Int?
    var appColorNew = UserDefaults.standard.string(forKey: "app_Color")
    var arrayCount = 0
    var socilImagesArray = [UIImage]()
    var socialArr = [String]()
    var withOutLogin = UserDefaults.standard.string(forKey: "aType")
    let type = UserDefaults.standard.integer(forKey: "usrTyp")
    
    
  
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        nokri_ProfileData()
        nokri_roundedImage()
        //nokri_populateData()
        btnSave.isHidden = true
        if withOutLogin != "5" && type == 1{
            btnSave.isHidden = false
            btnSave.backgroundColor = UIColor(hex: appColorNew!)
        }
    }
    
    func nokri_populateData(){
 
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
        
        imegViewHeader.layer.borderWidth = 2.8
        imegViewHeader.layer.masksToBounds = false
        imegViewHeader.layer.borderColor = UIColor(hex:appColorNew!).cgColor
        imegViewHeader.layer.cornerRadius = imegViewHeader.frame.height/2
        imegViewHeader.clipsToBounds = true
        
    }
    
    
    @IBAction func btnSaveResumClicked(_ sender: UIButton) {
    
    }
    
    // MARK:- CollectionView
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return socilImagesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyProfileSocialCollectionViewCell", for: indexPath) as! MyProfileSocialCollectionViewCell
        
        //cell.imageViewSocialIcon.image = socilImagesArray[indexPath.row]
        cell.imageViewSocial.image = socilImagesArray[indexPath.row]
        cell.btnSocialIcon.setTitle(socialArr[indexPath.row], for: .normal)
        cell.btnSocialIcon.addTarget(self, action: #selector(MyProfileHeaderTableViewCell.nokri_btnSocialClicked(_:)), for: .touchUpInside)
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
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        return CGSize(width: width/CGFloat(arrayCount), height: 25)
    }
    
    @objc func nokri_btnSocialClicked(_ sender: UIButton){
        
        if sender.tag == 1{
            print("Facebook")
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(URL(string: fb!)!, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(URL(string: fb!)!)
            }
            
        }
        
        if sender.tag == 2{
            print("google")
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(URL(string: gogle!)!, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(URL(string: gogle!)!)
            }
        }
        
        if sender.tag == 3{
            print("linked")
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(URL(string: link!)!, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(URL(string: link!)!)
            }
        }
        
        if sender.tag == 4{
            print("twitter")
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(URL(string: twit!)!, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(URL(string: twit!)!)
            }
        }
        
    }
    
    
    func nokri_ProfileData(){
        
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
            let user_id = UserDefaults.standard.integer(forKey: "id")
            let id:Int?
            if idCheck == 1 {
                id = userId
            }else{
                id = user_id
            }
            let param: [String: Any] = [
                "user_id": id!,
                ]
            print(param)
            
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.candidateProfile, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    let responseData = response.value as! NSDictionary
                    let success = responseData["success"] as! Bool
                    if success == true{
                        let data = responseData["data"] as! NSDictionary
                        let basicInfo = data["basic_ifo"] as! NSDictionary
                        let social =  basicInfo ["social"] as! NSDictionary
                        //self.fb = social["facebook"] as? String
                        self.gogle = social["google_plus"] as? String
                        self.link = social["linkedin"] as? String
                        self.twit = social["twitter"] as? String
                        self.nokri_populateData()
                        DispatchQueue.main.async {
                            self.collectionView.reloadData()
                        }
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
            let user_id = UserDefaults.standard.integer(forKey: "id")
            let id:Int?
            if idCheck == 1 {
                id = userId
            }else{
                id = user_id
            }
            
            let param: [String: Any] = [
                "user_id": id!,
                ]
            print(param)
            
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.candidateProfile, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers)
                .responseJSON(queue: .global()) { response in
                    let responseData = response.value as! NSDictionary
                    let success = responseData["success"] as! Bool
                    if success == true{
                        let data = responseData["data"] as! NSDictionary
                        let basicInfo = data["basic_ifo"] as! NSDictionary
                        let social =  basicInfo ["social"] as! NSDictionary
                        //self.fb = social["facebook"] as? String
                        self.gogle = social["google_plus"] as? String
                        self.link = social["linkedin"] as? String
                        self.twit = social["twitter"] as? String
                        self.nokri_populateData()
                        DispatchQueue.main.async {
                             self.collectionView.reloadData()
                        }
                       
                    }else{
                    }
            }
        }
    }

}
