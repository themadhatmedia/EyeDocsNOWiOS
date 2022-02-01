//
//  CompanyOpenPositionViewController.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 5/1/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import Alamofire

class CompanyOpenPositionViewController: UIViewController,IndicatorInfoProvider,UITableViewDataSource,UITableViewDelegate {

    //MARK:- Table View
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var btnLoadMore: UIButton!
    
    //MARK:- Proporties
    
    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
    var appColorNew = UserDefaults.standard.string(forKey: "app_Color")
    var compId:Int?
    var jobsArray = NSMutableArray()
    var message:String?
    var infoArray = NSMutableArray()
    var keyArray = [String]()
    var valueArray = [String]()
    var extraArray = NSMutableArray()
    var nextPage:Int?
    var hasNextPage:Bool?
    
    //MARK:- View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        nokri_CompanyPublicProfile()
        cutomeButton()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.tableViewHeightConstraint.constant = self.view.bounds.height + 1200
        print("\(self.tableViewHeightConstraint.constant)")
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        var title:String?
        if let userData = UserDefaults.standard.object(forKey: "settingsData") {
            let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
            let dataTabs = SplashRoot(fromDictionary: objData)
            title = dataTabs.data.compnyPublicJobs.open
        }
        
        return IndicatorInfo(title: title)
    }

    //MARK:- Custome Functions
    
    @IBAction func btnLoadMoreClicked(_ sender: UIButton) {
        if hasNextPage == true{
            nokri_CompanyPublicProfilePagination()
        }
    }
    
    func cutomeButton(){
        btnLoadMore.isHidden = true
        btnLoadMore.layer.cornerRadius = 22
        btnLoadMore.backgroundColor = UIColor(hex: appColorNew!)
        btnLoadMore.setTitleColor(UIColor.white, for: .normal)
    }
    
    func nokri_PopulateData(){
        let bascArr = self.infoArray as? [NSDictionary]
       // print(bascArr)
        for itemDict in bascArr! {
            if let obj = itemDict["field_type_name"] as? String{
                if obj == "emp_email" || obj == "emp_phone" || obj == "emp_rgstr" || obj == "emp_nos" || obj == "last_esdu" || obj == "emp_adress"
                {
                    if let key = itemDict["key"] as? String {
                        if key != ""{
                            self.keyArray.append(key)
                        }
                    }
                    if let value = itemDict["value"] as? String  {
                        if value != ""{
                             self.valueArray.append(value)
                        }
                    }
                }
            }
        }
        print(keyArray.count)
        print(valueArray.count)
        for itemDict in bascArr! {
            if let obj = itemDict["field_type_name"] as? String{
                print(obj)
                if obj == "about_me"
                {
                    if let key = itemDict["key"] as? String {
                        UserDefaults.standard.set(key, forKey: "keyAbout")
                    }
                    if let value = itemDict["value"] as? String {
                        UserDefaults.standard.set(value, forKey: "valueAbout")
                    }
                }
                if obj == "emp_long"
                {
                    if let key = itemDict["value"] as? String {
                        UserDefaults.standard.set( key, forKey: "long")
                    }
                }
                if obj == "emp_lat"
                {
                    if let key = itemDict["value"] as? String {
                        UserDefaults.standard.set( key, forKey: "lat")
                    }
                }
                if obj == "loc"
                {
                    if let key = itemDict["value"] as? String {
                        UserDefaults.standard.set( key, forKey: "loc")
                    }
                }
                if obj == "emp_lat"
                {
                    if let key = itemDict["value"] as? String {
                        UserDefaults.standard.set( key, forKey: "lat")
                    }
                }
                
            }
        }
        let extraArray = self.extraArray as? [NSDictionary]
        for itemDict in extraArray! {
            if let obj = itemDict["field_type_name"] as? String{
                if obj == "comp_detail"
                {
                    if let key = itemDict["key"] as? String {
                         UserDefaults.standard.set( key, forKey: "detail")
                    }
                }
            }
        }
        
        UserDefaults.standard.set( keyArray, forKey: "arr")
        UserDefaults.standard.set( valueArray, forKey: "arr2")
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
    
    //MARK:- Table View
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jobsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CompanyOpenPositionTableViewCell", for: indexPath) as! CompanyOpenPositionTableViewCell
        let selectedActiveJob = self.jobsArray[indexPath.row] as? [NSDictionary];
        for itemDict in selectedActiveJob! {
            let innerDict = itemDict ;
            if let field_type_name = innerDict["field_type_name"] as? String{
                if field_type_name == "job_name" {
                    if let value = innerDict["value"] as? String {
                        cell.lblJobName.text = value
                    }
                }
                if field_type_name == "job_expiry" {
                    if let value = innerDict["value"] as? String {
                        cell.lblJobExpiryValue.text = value
                    }
                    if let key = innerDict["key"] as? String {
                        cell.lblJobExpiryKey.text = key
                    }
                }
                if field_type_name == "job_location" {
                    if let value = innerDict["value"] as? String {
                        cell.lblLoation.text = value
                    }
                }
                if field_type_name == "job_salary" {
                    if let value = innerDict["value"] as? String {
                        cell.lblPrice.text = value
                    }
                }
                if field_type_name == "job_id" {
                    if let value = innerDict["value"] as? Int {
                        cell.btnJobDetail.tag = value
                    }
                }
                
                if field_type_name == "company_id" {
                    
                    if let value = innerDict["value"] as? String {
                        compId = Int(value)!
                        UserDefaults.standard.set(compId, forKey: "comp_id")
                        cell.btnJobDetail.setTitle(value, for: .normal)
                        print(value)
                        
                    }
                }
                
                
            cell.btnJobDetail.addTarget(self, action:  #selector(CompanyOpenPositionViewController.nokri_btnJobDetailClicked), for: .touchUpInside)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 147
    }
    
    @objc func nokri_btnJobDetailClicked( _ sender: UIButton){
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "JobDetailViewController") as! JobDetailViewController
        print(sender.tag)
        let comp_id = UserDefaults.standard.integer(forKey: "comp_Id")
        nextViewController.jobId = sender.tag
        nextViewController.isFromAllJob = false
        nextViewController.compId = comp_id
         UserDefaults.standard.set(false, forKey: "isFromNoti")
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    
    //MARK:- API Calls
    
    func nokri_CompanyPublicProfile(){
        
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
               let comp_id = UserDefaults.standard.integer(forKey: "comp_Id")
               let param: [String: Any] = [
                   "company_id": comp_id,
                   "page_number" : "1"
               ]
               print(param)
               Alamofire.request(Constants.URL.baseUrl+Constants.URL.employer_publicProfile, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers)
                   .responseJSON { response in
                       guard let res = response.value else{return}
                       let responseData = res as! NSDictionary
                       //self.message = responseData["message"] as? String
                       let success = responseData["success"] as! Bool
                       if success == true{
                           let data = responseData["data"] as! NSDictionary
                           self.message = responseData["message"] as? String
                           if let jobsArr = data["jobs"] as? NSArray {
                               self.nokri_jobsParser(jobsAr: jobsArr)
                           }
                           if let pagination = responseData["pagination"] as? NSDictionary{
                               self.hasNextPage = pagination["has_next_page"] as? Bool
                               self.nextPage = pagination["next_page"] as? Int
                           }
                           if self.hasNextPage == true{
                               print(self.hasNextPage!)
                               self.btnLoadMore.isHidden = false
                           }
                           if self.hasNextPage == false{
                               self.btnLoadMore.isHidden = true
                           }
                           let basicInfo = data["basic_ifo"] as! NSDictionary
                           
                           if let infoArray = basicInfo["info"] as? NSArray {
                               self.nokri_InfoParser(infArr: infoArray)
                           }
                           if let extraArray = data["extra"] as? NSArray {
                               self.nokri_ExtraParser(extrArr: extraArray)
                           }
                           self.nokri_PopulateData()
                           self.tableView.reloadData()
                          //self.stopActivityIndicator()
                       }else{
                       }
               }
          } else{
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
                   let comp_id = UserDefaults.standard.integer(forKey: "comp_Id")
                   let param: [String: Any] = [
                       "company_id": comp_id,
                       "page_number" : "1"
                   ]
                   print(param)
                   Alamofire.request(Constants.URL.baseUrl+Constants.URL.employer_publicProfile, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers)
                       .responseJSON { response in
                           guard let res = response.value else{return}
                           let responseData = res as! NSDictionary
                           //self.message = responseData["message"] as? String
                           let success = responseData["success"] as! Bool
                           if success == true{
                               let data = responseData["data"] as! NSDictionary
                               self.message = responseData["message"] as? String
                               if let jobsArr = data["jobs"] as? NSArray {
                                   self.nokri_jobsParser(jobsAr: jobsArr)
                               }
                               if let pagination = responseData["pagination"] as? NSDictionary{
                                   self.hasNextPage = pagination["has_next_page"] as? Bool
                                   self.nextPage = pagination["next_page"] as? Int
                               }
                               if self.hasNextPage == true{
                                   print(self.hasNextPage!)
                                   self.btnLoadMore.isHidden = false
                               }
                               if self.hasNextPage == false{
                                   self.btnLoadMore.isHidden = true
                               }
                               let basicInfo = data["basic_ifo"] as! NSDictionary
                               
                               if let infoArray = basicInfo["info"] as? NSArray {
                                   self.nokri_InfoParser(infArr: infoArray)
                               }
                               if let extraArray = data["extra"] as? NSArray {
                                   self.nokri_ExtraParser(extrArr: extraArray)
                               }
                               self.nokri_PopulateData()
                               self.tableView.reloadData()
                              //self.stopActivityIndicator()
                           }else{
                           }
                   }
        }
        
       
    }
    
    func nokri_CompanyPublicProfilePagination(){
        
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
            let comp_id = UserDefaults.standard.integer(forKey: "comp_Id")
            let param: [String: Any] = [
                "company_id": comp_id,
                "page_number" : nextPage!
            ]
            print(param)
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.employer_publicProfile, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    guard let res = response.value else{return}
                    let responseData = res as! NSDictionary
                    //self.message = responseData["message"] as? String
                    let success = responseData["success"] as! Bool
                    if success == true{
                        let data = responseData["data"] as! NSDictionary
                        self.message = responseData["message"] as? String
                        if let jobsArr = data["jobs"] as? NSArray {
                            self.nokri_jobsParser(jobsAr: jobsArr)
                        }
                        if let pagination = responseData["pagination"] as? NSDictionary{
                            self.hasNextPage = pagination["has_next_page"] as? Bool
                            self.nextPage = pagination["next_page"] as? Int
                        }
                        if self.hasNextPage == true{
                            print(self.hasNextPage!)
                            self.btnLoadMore.isHidden = false
                        }
                        if self.hasNextPage == false{
                            self.btnLoadMore.isHidden = true
                        }
                        let basicInfo = data["basic_ifo"] as! NSDictionary
                        
                        if let infoArray = basicInfo["info"] as? NSArray {
                            self.nokri_InfoParser(infArr: infoArray)
                        }
                        
                        if let extraArray = data["extra"] as? NSArray {
                            self.nokri_ExtraParser(extrArr: extraArray)
                        }
                        self.nokri_PopulateData()
                        self.tableView.reloadData()
                        //self.stopActivityIndicator()
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
            let comp_id = UserDefaults.standard.integer(forKey: "comp_Id")
            let param: [String: Any] = [
                "company_id": comp_id,
                "page_number" : nextPage!
            ]
            print(param)
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.employer_publicProfile, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    guard let res = response.value else{return}
                    let responseData = res as! NSDictionary
                    //self.message = responseData["message"] as? String
                    let success = responseData["success"] as! Bool
                    if success == true{
                        let data = responseData["data"] as! NSDictionary
                        self.message = responseData["message"] as? String
                        if let jobsArr = data["jobs"] as? NSArray {
                            self.nokri_jobsParser(jobsAr: jobsArr)
                        }
                        if let pagination = responseData["pagination"] as? NSDictionary{
                            self.hasNextPage = pagination["has_next_page"] as? Bool
                            self.nextPage = pagination["next_page"] as? Int
                        }
                        if self.hasNextPage == true{
                            print(self.hasNextPage!)
                            self.btnLoadMore.isHidden = false
                        }
                        if self.hasNextPage == false{
                            self.btnLoadMore.isHidden = true
                        }
                        let basicInfo = data["basic_ifo"] as! NSDictionary
                        
                        if let infoArray = basicInfo["info"] as? NSArray {
                            self.nokri_InfoParser(infArr: infoArray)
                        }
                        
                        if let extraArray = data["extra"] as? NSArray {
                            self.nokri_ExtraParser(extrArr: extraArray)
                        }
                        self.nokri_PopulateData()
                        self.tableView.reloadData()
                        //self.stopActivityIndicator()
                    }else{
                    }
            }
        }
        
      
    }
    
    func nokri_jobsParser(jobsAr:NSArray){
        self.jobsArray.removeAllObjects()
        for item in jobsAr{
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
        if jobsArray.count == 0{
            nokri_tableViewHelper()
            self.tableView.reloadData()
        }else{
            nokri_tableViewHelper2()
        }
        print("\(self.jobsArray.count)");
        self.tableView.reloadData()
    }
    
    func nokri_InfoParser(infArr:NSArray){
        //self.infoArray.removeAllObjects()
        for item in infArr{
            self.infoArray.add(item)
        }
    }
    
    func nokri_ExtraParser(extrArr:NSArray){
        self.extraArray.removeAllObjects()
        for item in extrArr{
            self.extraArray.add(item)
        }
    }
}
