//
//  CompanyInActiveJobViewController.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 4/17/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import UIKit
import Alamofire
import JGProgressHUD

class CompanyInActiveJobViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    //MARK:- IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var btnLoadMore: UIButton!
    
    //MARK:- Proporties
    
    var inActiveJobArray = NSMutableArray();
    var message:String?
    var nextPage:Int?
    var hasNextPage:Bool?
    var appColorNew = UserDefaults.standard.string(forKey: "app_Color")
    var tabBarAppearence = UITabBar.appearance()
  
    //MARK:- View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarAppearence.barTintColor = UIColor(hex:appColorNew!)
        //tabBar.barTintColor = UIColor(hex: appColorNew!)
        if let userData = UserDefaults.standard.object(forKey: "settingsData") {
            let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
            let dataTabs = SplashRoot(fromDictionary: objData)
            let obj = dataTabs.data.empJobs
            self.tabBarItem.title = obj?.inactive
        }
         self.title = "InActive Jobs"
        tableView.dataSource = self
        tableView.delegate = self
        cutomeButton()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        nokri_inActiveJobData()
    }

    func cutomeButton(){
        btnLoadMore.isHidden = true
        btnLoadMore.layer.cornerRadius = 22
        btnLoadMore.backgroundColor = UIColor(hex: appColorNew!)
        btnLoadMore.setTitleColor(UIColor.white, for: .normal)
    }
    
    @IBAction func btnLoadMoreClicked(_ sender: UIButton) {
        if hasNextPage == true{
            nokri_inActiveJobDataPagination()
        }
    }
    
    //MARK:- Table View
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inActiveJobArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CompanyJobInActiveTableViewCell", for: indexPath) as! CompanyJobInActiveTableViewCell
        
        let selectedActiveJob = self.inActiveJobArray[indexPath.row] as? [NSDictionary];
        for itemDict in selectedActiveJob! {
            let innerDict = itemDict ;
            if let field_type_name = innerDict["field_type_name"] as? String{
                
                if field_type_name == "job_title" {
                    if let value = innerDict["value"] as? String {
                        cell.lblJobTitle.text = value
                    }
                }
                if field_type_name == "job_expiry" {
                    if let value = innerDict["value"] as? String {
                        cell.lblDate.text = value
                    }
                }
                if field_type_name == "job_type" {
                    if let value = innerDict["value"] as? String {
                        cell.lblJobType.text = value
                    }
                }
                if field_type_name == "job_location" {
                    if let value = innerDict["value"] as? String {
                        cell.lblLocation.text = value
                    }
                }
                
                if let userData = UserDefaults.standard.object(forKey: "settingsData") {
                    let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
                    let dataTabs = SplashRoot(fromDictionary: objData)
                    let obj = dataTabs.data.empJobs
                    cell.lblBtnInactive.text = obj?.active
                }
                
                if field_type_name == "job_expiry" {
                    if let key = innerDict["key"] as? String {
                        cell.lblJobExpiry.text = key
                    }
                }
                if field_type_name == "job_id" {
                    if let value = innerDict["value"] as? Int {
                        
                        cell.btnInActive.tag = value
                                                
                    }
                }
            }
        }
        cell.btnInActive.addTarget(self, action: #selector(CompanyActiveJobViewController.nokri_btnInactiveClicked(_:)), for: .touchUpInside)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 147
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
    
    @objc func nokri_btnInactiveClicked(_ sender: UIButton){
        
       // self.activePost()
        
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
            let senderButtonTag = sender.tag
            print(senderButtonTag)
            self.nokri_activePost(jobId: senderButtonTag)        }
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
        messageLabel.textColor = UIColor.black
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont(name: "TrebuchetMS", size: 15)
        messageLabel.sizeToFit()
        tableView.backgroundView = messageLabel
    }
    
    //MARK:- API Calls
    
    func nokri_inActiveJobData(){
        
        var langCode = UserDefaults.standard.string(forKey: "langCode")
        if langCode == nil {
            langCode = "en"
        }
        
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
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.inActiveJob, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    
                    let responseData = response.value as! NSDictionary
                    self.message = responseData["message"] as? String
                    let success = responseData["success"] as! Bool
                    if success == true{
                        
                        let data = responseData["data"] as! NSDictionary
                        if let page = data["page_title"]  as? String{
                            self.tabBarController?.navigationItem.title = page
                        }
                        
                        if let inActiveJobArr = data["jobs"] as? NSArray {
                            self.nokri_jobDataParser(inActiveJobArray: inActiveJobArr)
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
                        self.tableView.reloadData()
                        
                    }else{
                    }
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
            
            let param: [String: Any] = [
                "page_number": "1"
            ]
            print(param)
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.inActiveJob, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    
                    if response.value != nil{
                        let responseData = response.value as! NSDictionary
                        self.message = responseData["message"] as? String
                        let success = responseData["success"] as! Bool
                        if success == true{
                            
                            let data = responseData["data"] as! NSDictionary
                            if let page = data["page_title"]  as? String{
                                self.tabBarController?.navigationItem.title = page
                            }
                            
                            if let inActiveJobArr = data["jobs"] as? NSArray {
                                self.nokri_jobDataParser(inActiveJobArray: inActiveJobArr)
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
                            self.tableView.reloadData()
                            
                        }else{
                        }
                    }
                    self.stopAnimating()
            }
        }
    }
    
    func nokri_inActiveJobDataPagination(){
        
        var langCode = UserDefaults.standard.string(forKey: "langCode")
        if langCode == nil {
            langCode = "en"
        }
        
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
                "page_number": nextPage!
            ]
            print(param)
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.inActiveJob, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    
                    let responseData = response.value as! NSDictionary
                    self.message = responseData["message"] as? String
                    let success = responseData["success"] as! Bool
                    if success == true{
                        
                        let data = responseData["data"] as! NSDictionary
                        if let page = data["page_title"]  as? String{
                            self.tabBarController?.navigationItem.title = page
                        }
                        
                        if let inActiveJobArr = data["jobs"] as? NSArray {
                            self.nokri_jobDataParser(inActiveJobArray: inActiveJobArr)
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
                    }
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
            let param: [String: Any] = [
                "page_number": nextPage!
            ]
            print(param)
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.inActiveJob, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    let responseData = response.value as! NSDictionary
                    self.message = responseData["message"] as? String
                    let success = responseData["success"] as! Bool
                    if success == true{
                        let data = responseData["data"] as! NSDictionary
                        if let page = data["page_title"]  as? String{
                            self.tabBarController?.navigationItem.title = page
                        }
                        if let inActiveJobArr = data["jobs"] as? NSArray {
                            self.nokri_jobDataParser(inActiveJobArray: inActiveJobArr)
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
                    }
                    self.stopAnimating()
            }
        }
    }

    func nokri_jobDataParser(inActiveJobArray:NSArray){
        
        self.inActiveJobArray.removeAllObjects()
        for item in inActiveJobArray{
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
            self.inActiveJobArray.add(arrayOfDictionaries);
        }
        if inActiveJobArray.count == 0{
            nokri_tableViewHelper()
            
        }else{
            nokri_tableViewHelper2()
        }
        
        print("\(self.inActiveJobArray.count)");
        self.tableView.reloadData()
        
    }
    
    
    func nokri_activePost(jobId:Int){
        
        var langCode = UserDefaults.standard.string(forKey: "langCode")
        if langCode == nil {
            langCode = "en"
        }
        
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
            let x : Int = jobId
            let myString = String(x)
            let param: [String: Any] = [
                "job_id": myString,
                ]
            print(param)
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.activeThisJob, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                
                    
                    let responseData = response.value as! NSDictionary
                    
                    let success = responseData["success"] as! Bool
                    
                    if success == true{                    
                    let message = responseData["message"] as! String
                    let hud = JGProgressHUD(style: .dark)
                    hud.textLabel.text = message
                    hud.detailTextLabel.text = nil
                    hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                    hud.position = .bottomCenter
                    hud.show(in: self.view)
                    hud.dismiss(afterDelay: 2.0)
                    self.nokri_inActiveJobData()
                    self.tableView.reloadData()
                    self.stopAnimating()
                    }else{
                        let message = responseData["message"] as! String
                        var btnOk:String?
                        var btnCncel:String?
                        if let userData = UserDefaults.standard.object(forKey: "settingsData") {
                            let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
                            let dataTabs = SplashRoot(fromDictionary: objData)
                            btnOk = dataTabs.data.genericTxts.btnConfirm
                            btnCncel = dataTabs.data.genericTxts.btnCancel
                        }
                        let Alert = UIAlertController(title:message, message:"", preferredStyle: .alert)
                        let okButton = UIAlertAction(title: btnOk, style: .default) { _ in
                            appDelegate.nokri_moveToPackage()
                        }
                        let CancelButton = UIAlertAction(title: btnCncel, style: .cancel)
                        Alert.addAction(okButton)
                        Alert.addAction(CancelButton)
                        self.present(Alert, animated: true, completion: nil)

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
            let x : Int = jobId
            let myString = String(x)
            let param: [String: Any] = [
                "job_id": myString,
                ]
            print(param)
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.activeThisJob, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    
                    let responseData = response.value as! NSDictionary
                    let success = responseData["success"] as! Bool
                    
                    if success == true{
                    
                    let message = responseData["message"] as! String
                    let hud = JGProgressHUD(style: .dark)
                    hud.textLabel.text = message
                    hud.detailTextLabel.text = nil
                    hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                    hud.position = .bottomCenter
                    hud.show(in: self.view)
                    hud.dismiss(afterDelay: 2.0)
                    self.nokri_inActiveJobData()
                    self.tableView.reloadData()
                        self.stopAnimating()
                        
                    }else{
                        let message = responseData["message"] as! String
                        var btnOk:String?
                        var btnCncel:String?
                        if let userData = UserDefaults.standard.object(forKey: "settingsData") {
                            let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
                            let dataTabs = SplashRoot(fromDictionary: objData)
                            btnOk = dataTabs.data.genericTxts.btnConfirm
                            btnCncel = dataTabs.data.genericTxts.btnCancel
                        }
                        let Alert = UIAlertController(title:message, message:"", preferredStyle: .alert)
                        let okButton = UIAlertAction(title: btnOk, style: .default) { _ in
                            appDelegate.nokri_moveToPackage()
                        }
                        let CancelButton = UIAlertAction(title: btnCncel, style: .cancel)
                        Alert.addAction(okButton)
                        Alert.addAction(CancelButton)
                        self.present(Alert, animated: true, completion: nil)
 
                    }
            }
        }
    }
   
}
