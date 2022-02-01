//
//  CompanyActiveJobViewController.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 4/17/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import UIKit
import DropDown
import Alamofire
import JGProgressHUD

class CompanyActiveJobViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    //MARK:- IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnDropDown: UIButton!
    @IBOutlet weak var lblDropDownValue: UILabel!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var iconDropDown: UIImageView!
    @IBOutlet weak var btnLoadMore: UIButton!
    
    //MARK:- Proporties
    
    var tabBarAppearence = UITabBar.appearance()
    var appColorNew = UserDefaults.standard.string(forKey: "app_Color")
    let dropDown = DropDown()
    var pageTitle:String?
    var jobFilterKey:String?
    var filterArray = NSMutableArray()
    var activeJobArray = NSMutableArray()
    var dropDownArr = [MenuActive]()
    var message:String?
    let dropDownSecond = DropDown()
    var dropDownArrSecond = [String]()
    var senderButtonTag:Int?
    var nextPage:Int?
    var hasNextPage:Bool?
    var isBumpShow = false
    var bumpText = ""
 
    //MARK:- View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
         self.tabBarController?.tabBar.barTintColor =  UIColor(hex: appColorNew!)
         //tabBarAppearence.barTintColor = UIColor(hex:appColorNew!)
        //tabBar.barTintColor = UIColor(hex: appColorNew!)
        if let userData = UserDefaults.standard.object(forKey: "settingsData") {
            let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
            let dataTabs = SplashRoot(fromDictionary: objData)
            let obj = dataTabs.data.empJobs
            if let downcastStrings = self.tabBarController?.tabBar.items
            {
                downcastStrings[0].title = obj?.active
                downcastStrings[1].title = obj?.inactive
            }
        }
        cutomeButton()
        nokri_dropDownSetupTwo()
        tableView.delegate = self
        tableView.dataSource = self
        iconDropDown.image = iconDropDown.image?.withRenderingMode(.alwaysTemplate)
        iconDropDown.tintColor = UIColor(hex: appColorNew!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        nokri_activeJobData()
    }

    //MARK:- IBActions
    
    @IBAction func btnDropDownClicked(_ sender: UIButton) {
        dropDown.show()
    }
    
    //MARK:- Table View
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activeJobArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CompanyJobActiveTableViewCell", for: indexPath) as! CompanyJobActiveTableViewCell
        let selectedActiveJob = self.activeJobArray[indexPath.row] as? [NSDictionary];
        for itemDict in selectedActiveJob! {
            let innerDict = itemDict ;
            if let field_type_name = innerDict["field_type_name"] as? String{
                if field_type_name == "job_name" {
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
                   
                         cell.lblBtnInactive.text = obj?.inactive
                    
                }
                if field_type_name == "job_expiry" {
                    if let key = innerDict["key"] as? String {
                        cell.lblJobExpiry.text = key
                    }
                }
                if field_type_name == "job_id" {
                    if let value = innerDict["value"] as? Int {
                        cell.btnInActive.tag = value
                        cell.btnDropDown.tag = value
                        cell.btnBumpUp.tag = value
                        print(value)
                    }
                    
                }
            }
        }
        if isBumpShow == true{
            cell.btnBumpUp.isHidden = false
            cell.btnBumpUp.setTitle(bumpText, for: .normal)
        }else{
            cell.btnBumpUp.isHidden = true
        }
        
       
        cell.btnBumpUp.addTarget(self, action: #selector(CompanyActiveJobViewController.nokri_btnBumpUpClicked(_:)), for: .touchUpInside)
        
        cell.btnInActive.addTarget(self, action: #selector(CompanyActiveJobViewController.nokri_btnInactiveClicked(_:)), for: .touchUpInside)
        cell.btnDropDown.addTarget(self, action: #selector(CompanyActiveJobViewController.nokri_btnDeleteClicked(_:)), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
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
    
    @IBAction func btnLoadMoreClicked(_ sender: UIButton) {
        if hasNextPage == true{
            nokri_activeJobDataPagination()
        }
    }
    
    func cutomeButton(){
        btnLoadMore.isHidden = true
        btnLoadMore.layer.cornerRadius = 22
        btnLoadMore.backgroundColor = UIColor(hex: appColorNew!)
        btnLoadMore.setTitleColor(UIColor.white, for: .normal)
    }
    
    @objc func nokri_btnBumpUpClicked(_ sender: UIButton){
        
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
            self.nokri_BumpUp(jobId: senderButtonTag)
        }
        let cancel = UIAlertAction(title: btnCncel, style: .cancel) { (cancel) in
        }
        alert.addAction(ok)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    
    }
    
    @objc func nokri_btnInactiveClicked(_ sender: UIButton){
        
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
            self.nokri_inActivePost(jobId: senderButtonTag)
        }
        let cancel = UIAlertAction(title: btnCncel, style: .cancel) { (cancel) in
        }
        alert.addAction(ok)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    
    }
    
    @objc func nokri_btnDeleteClicked(_ sender: UIButton){
        dropDownSecond.show()
        senderButtonTag = sender.tag
        print(senderButtonTag!)
        dropDownSecond.anchorView = sender
    }
    
    func nokri_dropDownSetupTwo(){
        
        if let userData = UserDefaults.standard.object(forKey: "settingsData") {
            let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
            let dataTabs = SplashRoot(fromDictionary: objData)
            let obj = dataTabs.data.menuActive
            dropDownArrSecond.append(obj!.resume)
            dropDownArrSecond.append(obj!.del)
            dropDownArrSecond.append(obj!.edit)
            dropDownArrSecond.append(obj!.view)
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            dropDownSecond.dataSource = dropDownArrSecond
            dropDownSecond.selectionAction = { [unowned self] (index: Int, item: String) in
                print("Selected item: \(item) at index: \(index)")
                if index == 0 {
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ResumeReceivedViewController") as! ResumeReceivedViewController
                    nextViewController.jobId = self.senderButtonTag!
                    self.navigationController?.pushViewController(nextViewController, animated: true)
                }else if index == 1{
                    let obj = dataTabs.data.genericTxts
                    let alert = UIAlertController(title: obj?.confirm, message: nil, preferredStyle: .alert)
                    let cancelButton = UIAlertAction(title: obj?.btnCancel, style: .default) { (cancel) in
                    }
                    let okButton = UIAlertAction(title: obj?.btnConfirm, style: .default) { (ok) in
                        let param: [String: Any] = [
                            "job_id": self.senderButtonTag!
                        ]
                        print(param)
                        self.nokri_deletJob(parameter: param as NSDictionary)
                    }
                    alert.addAction(cancelButton)
                    alert.addAction(okButton)
                    self.present(alert, animated: true, completion: nil)
                }else if index == 2{
                    
                     let jobForm = UserDefaults.standard.bool(forKey: "job_form")
                    if jobForm == false{
                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "JobPostViewController") as! JobPostViewController
                        nextViewController.job_Id = self.senderButtonTag!
                        nextViewController.isFromEdit = 0
                        //nextViewController.isFromResumeRecv = true
                        self.navigationController?.pushViewController(nextViewController, animated: true)
                      
                    }else{
                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "JobPostCustomViewController") as! JobPostCustomViewController
                        nextViewController.job_Id = self.senderButtonTag!
                        nextViewController.isFromEdit = 0
                        //nextViewController.isFromResumeRecv = true
                        self.navigationController?.pushViewController(nextViewController, animated: true)
                    }
                    
                }
                else{
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "JobDetailViewController") as! JobDetailViewController
                    nextViewController.jobId = self.senderButtonTag!
                    nextViewController.isFromAllJob = false
                     UserDefaults.standard.set(false, forKey: "isFromNoti")
                    self.navigationController?.pushViewController(nextViewController, animated: true)
                }
            }
            DropDown.startListeningToKeyboard()
            DropDown.appearance().textColor = UIColor.black
            DropDown.appearance().textFont = UIFont.systemFont(ofSize: 12)
            DropDown.appearance().backgroundColor = UIColor.white
            DropDown.appearance().selectionBackgroundColor = UIColor(hex: appColorNew!)
            DropDown.appearance().cellHeight = 40
        }
    }
    
    func nokri_dropDownSetup(){
        
        var dropDownArr = [String]()
        var dropDownArrKey = [Int]()
        let filterArr = self.filterArray as? [NSDictionary]
        for itemDict in filterArr! {
            if let filterObj = itemDict["value"] as? String{
                dropDownArr.append(filterObj)
            }
            if let filterObj = itemDict["key"] as? Int{
                dropDownArrKey.append(filterObj)
            }
        }
        dropDown.dataSource = dropDownArr
        dropDown.reloadAllComponents()
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.lblDropDownValue.text = item
            self.nokri_filterRecvdResume(filterKey: dropDownArrKey[index])
        }
        
        dropDown.anchorView = btnDropDown
        DropDown.startListeningToKeyboard()
        DropDown.appearance().textColor = UIColor.black
        DropDown.appearance().textFont = UIFont.systemFont(ofSize: 12)
        DropDown.appearance().backgroundColor = UIColor.white
        DropDown.appearance().selectionBackgroundColor = UIColor(hex:appColorNew!)
        DropDown.appearance().cellHeight = 40
        
    }
    
    //MARK:- API Calls
    
    func nokri_activeJobData(){
        
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
                "page_number": "1",
                ]
            
            print(param)
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.activeJob, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    guard let res = response.value else{return}
                    let responseData = res as! NSDictionary
                    self.message = responseData["message"] as? String
                    let success = responseData["success"] as! Bool
                    if success == true{
                        let data = responseData["data"] as! NSDictionary
                        
                        if let bump = data["allow_bump_jobs"]  as? Bool{
                            self.isBumpShow = bump
                        }
                        if let bumpT = data["bump_up_txt"]  as? String{
                            self.bumpText = bumpT
                        }
                        if let page = data["page_title"]  as? String{
                            self.tabBarController?.navigationItem.title = page
                        }
                        let jobFilter = data["job_filter"] as! NSDictionary
                        if let jobFilter = data["key"]  as? String{
                            self.jobFilterKey = jobFilter
                        }
                        if let array = jobFilter["value"] as? NSArray {
                            self.nokri_jobFilterDataParser(jobFilterArray: array)
                        }
                        if let activeJobArr = data["jobs"] as? NSArray {
                            self.nokri_jobDataParser(activeJobArray: activeJobArr)
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
                        
                    }else{
                    }
                    self.nokri_dropDownSetup()
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
                "page_number": "1",
                ]
            
            print(param)
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.activeJob, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    guard let res = response.value else{return}
                    let responseData = res as! NSDictionary
                    self.message = responseData["message"] as? String
                    let success = responseData["success"] as! Bool
                    if success == true{
                        let data = responseData["data"] as! NSDictionary
                        if let bump = data["allow_bump_jobs"]  as? Bool{
                            self.isBumpShow = bump
                        }
                        if let bumpT = data["bump_up_txt"]  as? String{
                            self.bumpText = bumpT
                        }
                        if let page = data["page_title"]  as? String{
                            self.tabBarController?.navigationItem.title = page
                        }
                        let jobFilter = data["job_filter"] as! NSDictionary
                        if let jobFilter = data["key"]  as? String{
                            self.jobFilterKey = jobFilter
                        }
                        if let array = jobFilter["value"] as? NSArray {
                            self.nokri_jobFilterDataParser(jobFilterArray: array)
                        }
                        if let activeJobArr = data["jobs"] as? NSArray {
                            self.nokri_jobDataParser(activeJobArray: activeJobArr)
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
                        
                    }else{
                    }
                    self.nokri_dropDownSetup()
                    self.stopAnimating()
            }
        }
        
      
    }
    
    func nokri_activeJobDataPagination(){
        
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
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.activeJob, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    guard let res = response.value else{return}
                    let responseData = res as! NSDictionary
                    self.message = responseData["message"] as? String
                    let success = responseData["success"] as! Bool
                    if success == true{
                        let data = responseData["data"] as! NSDictionary
                        if let page = data["page_title"]  as? String{
                            self.tabBarController?.navigationItem.title = page
                        }
                        let jobFilter = data["job_filter"] as! NSDictionary
                        if let jobFilter = data["key"]  as? String{
                            self.jobFilterKey = jobFilter
                        }
                        if let array = jobFilter["value"] as? NSArray {
                            self.nokri_jobFilterDataParser(jobFilterArray: array)
                        }
                        if let activeJobArr = data["jobs"] as? NSArray {
                            self.nokri_jobDataParser(activeJobArray: activeJobArr)
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
                    self.nokri_dropDownSetup()
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
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.activeJob, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    guard let res = response.value else{return}
                    let responseData = res as! NSDictionary
                    self.message = responseData["message"] as? String
                    let success = responseData["success"] as! Bool
                    if success == true{
                        let data = responseData["data"] as! NSDictionary
                        if let page = data["page_title"]  as? String{
                            self.tabBarController?.navigationItem.title = page
                        }
                        let jobFilter = data["job_filter"] as! NSDictionary
                        if let jobFilter = data["key"]  as? String{
                            self.jobFilterKey = jobFilter
                        }
                        if let array = jobFilter["value"] as? NSArray {
                            self.nokri_jobFilterDataParser(jobFilterArray: array)
                        }
                        if let activeJobArr = data["jobs"] as? NSArray {
                            self.nokri_jobDataParser(activeJobArray: activeJobArr)
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
                    self.nokri_dropDownSetup()
                    self.stopAnimating()
            }
        }
        
        
    }
    
    
    func nokri_jobFilterDataParser(jobFilterArray:NSArray){
        self.filterArray.removeAllObjects()
        for item in jobFilterArray{
            self.filterArray.add(item)
        }
    }
    
    func nokri_jobDataParser(activeJobArray:NSArray){
        self.activeJobArray.removeAllObjects()
        for item in activeJobArray{
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
            self.activeJobArray.add(arrayOfDictionaries);
        }
        if activeJobArray.count == 0{
            nokri_tableViewHelper()
            self.tableView.reloadData()
        }else{
            nokri_tableViewHelper2()
        }
        print("\(self.activeJobArray.count)");
        self.tableView.reloadData()
    }
    
    func nokri_inActivePost(jobId:Int){
        
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
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.inActiveThisJob, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    
                    let responseData = response.value as! NSDictionary
                    let message = responseData["message"] as! String
                    //self.view.makeToast(message, duration: 1.5, position: .center)
                    let hud = JGProgressHUD(style: .dark)
                    hud.textLabel.text = message
                    hud.detailTextLabel.text = nil
                    hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                    hud.position = .bottomCenter
                    hud.show(in: self.view)
                    hud.dismiss(afterDelay: 2.0)
                    self.nokri_activeJobData()
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
            let x : Int = jobId
            let myString = String(x)
            let param: [String: Any] = [
                "job_id": myString,
                ]
            print(param)
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.inActiveThisJob, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    
                    let responseData = response.value as! NSDictionary
                    let message = responseData["message"] as! String
                    //self.view.makeToast(message, duration: 1.5, position: .center)
                    let hud = JGProgressHUD(style: .dark)
                    hud.textLabel.text = message
                    hud.detailTextLabel.text = nil
                    hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                    hud.position = .bottomCenter
                    hud.show(in: self.view)
                    hud.dismiss(afterDelay: 2.0)
                    self.nokri_activeJobData()
                    self.tableView.reloadData()
                    self.stopAnimating()
            }
        }
    }
    
    func nokri_BumpUp(jobId:Int){
        
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
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.bumpUp, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    
                    let responseData = response.value as! NSDictionary
                    let message = responseData["message"] as! String
                    //self.view.makeToast(message, duration: 1.5, position: .center)
                    let hud = JGProgressHUD(style: .dark)
                    hud.textLabel.text = message
                    hud.detailTextLabel.text = nil
                    hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                    hud.position = .bottomCenter
                    hud.show(in: self.view)
                    hud.dismiss(afterDelay: 2.0)
                    //self.nokri_activeJobData()
                    //self.tableView.reloadData()
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
            let x : Int = jobId
            let myString = String(x)
            let param: [String: Any] = [
                "job_id": myString,
                ]
            print(param)
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.bumpUp, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    
                    let responseData = response.value as! NSDictionary
                    let message = responseData["message"] as! String
                    //self.view.makeToast(message, duration: 1.5, position: .center)
                    let hud = JGProgressHUD(style: .dark)
                    hud.textLabel.text = message
                    hud.detailTextLabel.text = nil
                    hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                    hud.position = .bottomCenter
                    hud.show(in: self.view)
                    hud.dismiss(afterDelay: 2.0)
                    //self.nokri_activeJobData()
                    //self.tableView.reloadData()
                    self.stopAnimating()
            }
        }
        
      
    }
    
    func nokri_filterRecvdResume(filterKey:Int){
        
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
            let x : Int = filterKey
            let myString = String(x)
            let param: [String: Any] = [
                "job_class": myString,
                "page_number": "1"
            ]
            print(param)
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.filterJob, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    let responseData = response.value as! NSDictionary
                    let success = responseData["success"] as! Bool
                    if success == true{
                        let data = responseData["data"] as! NSDictionary
                        if let activeJobArr = data["jobs"] as? NSArray {
                            self.nokri_jobDataParser(activeJobArray: activeJobArr)
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
            let x : Int = filterKey
            let myString = String(x)
            let param: [String: Any] = [
                "job_class": myString,
                "page_number": "1"
            ]
            print(param)
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.filterJob, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    let responseData = response.value as! NSDictionary
                    let success = responseData["success"] as! Bool
                    if success == true{
                        let data = responseData["data"] as! NSDictionary
                        if let activeJobArr = data["jobs"] as? NSArray {
                            self.nokri_jobDataParser(activeJobArray: activeJobArr)
                        }
                    }else{
                    }
                    self.stopAnimating()
            }
        }
        
     
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
    
    //MARK:- Api Calls
    
    func nokri_deletJob(parameter: NSDictionary) {
        
        self.showLoader()
        UserHandler.nokri_jobDelete(parameter: parameter as NSDictionary, success: { (successResponse) in
            let hud = JGProgressHUD(style: .dark)
            hud.textLabel.text = successResponse.message
            hud.detailTextLabel.text = nil
            hud.indicatorView = JGProgressHUDSuccessIndicatorView()
            hud.position = .bottomCenter
            hud.show(in: self.view)
            hud.dismiss(afterDelay: 2.0)
            //self.view.makeToast("Deleted Successfully.", duration: 1.5, position: .center)
            self.nokri_activeJobData()
            self.tableView.reloadData()
            self.stopAnimating()
        }) { (error) in
            let alert = Constants.showBasicAlert(message: error.message)
            self.present(alert, animated: true, completion: nil)
            self.stopAnimating()
        }
    }
  
}
