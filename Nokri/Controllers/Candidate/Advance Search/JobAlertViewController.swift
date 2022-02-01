//
//  JobAlertViewController.swift
//  Nokri
//
//  Created by apple on 3/25/20.
//  Copyright © 2020 Furqan Nadeem. All rights reserved.
//

import UIKit
import DropDown
import Alamofire
import JGProgressHUD

class JobAlertViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    //MARK:- IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    
    //MARK:- Proporties
    
    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
    var appColorNew = UserDefaults.standard.string(forKey: "app_Color")
    var followerArray = NSMutableArray();
    var btnText:String?
    var pageTitle:String?
    var message:String?
    var nextPage:Int?
    var hasNextPage:Bool?
    var searchField = [AdvanceSearchField]()
    var jobFrequencyKey = [Int]()
    var jobFrequencyValue = [String]()
    var barButtonItems = [UIBarButtonItem]()
    var jobExpKeyArr = [Int]()
    var jobExpValArr = [String]()
    var jobExpTxt = ""
    var jobTypeText = ""
    var valueArray = [AdvanceValue]()
    var jobtypeKey = [Int]()
    var jobtypeValuerr = [String]()
    var categoryArray = [String]()
    var statArray = NSMutableArray()
    var cityArray = NSMutableArray()
    var townArray = NSMutableArray()
    
    var isAlertShow = "true"
    var isShowJobCat = "true"
    var isShowJobType = "true"
    var isShowJobExp = "true"
    var extraArray = [AdvanceSearchExtra]()
    
    
    
    
    //MARK:- View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        addLeftBarButtonWithImage(#imageLiteral(resourceName: "menu"))
        showBAlertButn()
        nokri_jobAlert()
        if let userData = UserDefaults.standard.object(forKey: "settingsData") {
            let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
            let dataTabs = SplashRoot(fromDictionary: objData)
            
            let objExtraTxt = dataTabs.data.extra
            self.title = objExtraTxt?.jobalert
        }
        nokri_advanceSearchData()
    }
    
    func showBAlertButn() {
        
        var barButtonItems = [UIBarButtonItem]()
        let type = UserDefaults.standard.string(forKey: "usrTyp")
        
        if type == "0"{
        let button2 = UIButton(type: .custom)
        button2.setBackgroundImage(#imageLiteral(resourceName: "notification"), for: .normal)
        if #available(iOS 11, *) {
            button2.widthAnchor.constraint(equalToConstant: 20).isActive = true
            button2.heightAnchor.constraint(equalToConstant: 20).isActive = true
        }
        else {
            button2.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        }
        button2.addTarget(self, action: #selector(btnAlertClick), for: .touchUpInside)
        
        let barButton2 = UIBarButtonItem(customView: button2)
        barButtonItems.append(barButton2)
        }
       
         self.navigationItem.rightBarButtonItems = barButtonItems
        
      
    }
    @objc func btnAlertClick() {
        
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "JobAlertTableViewController") as! JobAlertTableViewController
        
        var jobCatArr = [String]()
        var keyArray = [Int]()
        var childArr = [Bool]()
        for obj in searchField{
            if obj.fieldTypeName == "job_category"{
                valueArray = obj.valueAr
                for innerObj in valueArray{
                    jobCatArr.append(innerObj.value)
                    keyArray.append(innerObj.key)
                    childArr.append(innerObj.hasChild)
                }
            }
        }
        
        nextViewController.jobCatArr = jobCatArr
        nextViewController.childArr = childArr
        nextViewController.keyArray = keyArray
        nextViewController.jobFrequencyKey = jobFrequencyKey
        nextViewController.jobFrequencyValue = jobFrequencyValue
        nextViewController.jobtypeKey = jobtypeKey
        nextViewController.jobtypeValuerr = jobtypeValuerr
        nextViewController.jobExpKeyArr = jobExpKeyArr
        nextViewController.jobExpValArr = jobExpValArr
        nextViewController.jobExpText = jobExpTxt
        nextViewController.jobTypeText = jobTypeText
        nextViewController.isShowExp = isShowJobExp
        nextViewController.isShowjobType = isShowJobType
        nextViewController.isShowCategory = isShowJobCat
        
        
        var countryKey = [Int]()
               var childArrr = [Bool]()
               for obj in searchField{
                   if obj.fieldTypeName == "job_location"{
                       categoryArray.removeAll()
                       valueArray = obj.valueAr
                       for innerObj in valueArray{
                           categoryArray.append(innerObj.value)
                           countryKey.append(innerObj.key)
                           childArrr.append(innerObj.hasChild)
                       }
                   }
                   //categoryArray.removeAll()
               }
        
        nextViewController.jobCatArr2 = categoryArray
        nextViewController.childArr2 = childArrr
        nextViewController.keyArray2 = countryKey
        
        
        self.navigationController?.pushViewController(nextViewController, animated: true)
        
    }

    func nokri_populateData(){
    
        for obj in extraArray{
           
          
            if obj.fieldTypeName == "is_job_alert"{
                isAlertShow = obj.value
            }
            if obj.fieldTypeName == "job_alerts_exp"{
                isShowJobExp = obj.value
            }
            if obj.fieldTypeName == "job_alerts_type"{
                isShowJobType = obj.value
            }
            if obj.fieldTypeName == "job_alerts_cat"{
                isShowJobCat = obj.value
            }
        }
    }

    func nokri_dropDownSetup(){
        
        var jobCat = [String]()
        var keyArray = [Int]()
        var childArr = [Bool]()
        for obj in searchField{
            if obj.fieldTypeName == "job_category"{
               
                valueArray = obj.valueAr
                for innerObj in valueArray{
                    jobCat.append(innerObj.value)
                    keyArray.append(innerObj.key)
                    childArr.append(innerObj.hasChild)
                    if innerObj.hasChild == true{
                
                    }
                }
            }
        }
       
        
       
        
       
       
        var qualificationKey = [Int]()
        for obj in searchField{
            
            if obj.fieldTypeName == "job_qualifications"{
                jobCat.removeAll()
                valueArray = obj.valueAr
                for innerObj in valueArray{
                    jobCat.append(innerObj.value)
                    qualificationKey.append(innerObj.key)
                }
            }
        }
      
        //var jobTypeKey = [Int]()
        for obj in searchField{
            
               if obj.fieldTypeName == "job_type"{
                jobTypeText = obj.key
                //lblJobTypeValue.text = selectOption
                jobCat.removeAll()
                valueArray = obj.valueAr
                for innerObj in valueArray{
                    jobtypeValuerr.append(innerObj.value)
                    jobtypeKey.append(innerObj.key)
                }
            }
        }
        
        
      
        
       
        var jobSkillKey = [Int]()
        for obj in searchField{
            if obj.fieldTypeName == "job_tags"{
                jobCat.removeAll()
                valueArray = obj.valueAr
                for innerObj in valueArray{
                    jobCat.append(innerObj.value)
                    jobSkillKey.append(innerObj.key)
                }
            }
        }
      
      
        var cityValue = [String]()
        var cityKey = [Int]()
        var cityChildArr = [Bool]()
        let citybCategory = self.cityArray as? [NSDictionary]
        for itemDict in citybCategory! {
            if let catObj = itemDict["value"] as? String{
                if catObj == ""{
                    continue
                }
                cityValue.append(catObj)
            }
            if let keyObj = itemDict["key"] as? Int{
                cityKey.append(keyObj)
            }
            if let hasChild = itemDict["has_child"] as? Bool{
                print(hasChild)
                if hasChild == true {
                    
                }
                cityChildArr.append(hasChild)
            }
        }
    
       
        for obj in searchField{
            
            if obj.fieldTypeName == "email_freq"{
                valueArray = obj.valueAr
                for innerObj in valueArray{
                    jobFrequencyValue.append(innerObj.value)
                    jobFrequencyKey.append(innerObj.key)
                }
            }
            
            if obj.fieldTypeName == "job_experience"{
               // lblJoblevelKey.text = obj.key
                jobExpTxt = obj.key
               // lblJoblevelValue.text = selectOption
                jobCat.removeAll()
                   valueArray = obj.valueAr
                for innerObj in valueArray{
                    jobExpValArr.append(innerObj.value)
                    jobExpKeyArr.append(innerObj.key)
                }
            }
            
       
        }
    
    
    }
    
    //MARK:- TableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return followerArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "JobAlertTableViewCell", for: indexPath) as! JobAlertTableViewCell
        let selectedFollower = self.followerArray[indexPath.row] as? [NSDictionary];
        for itemDict in selectedFollower! {
            let innerDict = itemDict ;
            if let field_type_name = innerDict["field_type_name"] as? String{
                if field_type_name == "alert_name" {
                    if let value = innerDict["value"] as? String {
                        cell.lblName.text = value;
                    }
                }
                if field_type_name == "alert_category" {
                    if let value = innerDict["value"] as? String {
                        cell.lblRole.text = value;
                    }
                }
                if field_type_name == "alert_frequency" {
                    if let value = innerDict["value"] as? String {
                        cell.lblFreq.text = value;
                    }
                }
                
                if field_type_name == "alert_key" {
                    if let value = innerDict["value"] as? String {
                        cell.btnRemove.setTitle(value, for: .normal)
                    }
                }
           
            }
        }
        
        if let userData = UserDefaults.standard.object(forKey: "settingsData") {
            let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
            let dataTabs = SplashRoot(fromDictionary: objData)
            cell.lblDelete.text = dataTabs.data.extra.remove_resume
        }
        
        
        cell.btnRemove.addTarget(self, action: #selector(SaveResumeViewController.nokri_btnRemoveClicked(_:)), for: .touchUpInside)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
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
    
    
    
    @objc func nokri_btnRemoveClicked(_ sender: UIButton){
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
            let follower_id = sender.currentTitle
            //print(follower_id)
            let param: [String: Any] = [
                "alert_id": follower_id!
            ]
            print(param)
            self.nokri_removeAlert(parameter: param as NSDictionary)
        }
        let cancel = UIAlertAction(title: btnCncel, style: .cancel) { (cancel) in
        }
        alert.addAction(ok)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
    
    func nokri_ltrRtl(){
        let isRtl = UserDefaults.standard.string(forKey: "isRtl")
        if isRtl == "0"{
            self.addLeftBarButtonWithImage(#imageLiteral(resourceName: "menu"))
        }else{
            self.addRightBarButtonWithImage(#imageLiteral(resourceName: "menu"))
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
    
    func nokri_jobAlert(){
        
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
                Alamofire.request(Constants.URL.baseUrl+Constants.URL.jobAlert, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers)
                    .responseJSON { response in
                        print(response.request as Any)  // original URL request
                        print(response.response as Any) // URL response
                        print(response.result.value as Any)
                        let responseData = response.value as! NSDictionary
                        self.message = responseData["message"] as? String
                        let data = responseData["data"] as! NSDictionary
                        print(data)
                        if let array = data["alerts"] as? NSArray {
                            self.nokri_companydataParser(companyDataArray: array)
                        }
                        self.tableView.delegate = self
                        self.tableView.dataSource = self
                        self.stopAnimating()
                }
            }
        }else{
            if let userEmail = UserDefaults.standard.string(forKey: "email") {
                email = userEmail
            }
            if let userPassword = UserDefaults.standard.string(forKey: "password") {
                password = userPassword
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
                Alamofire.request(Constants.URL.baseUrl+Constants.URL.jobAlert, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers)
                    .responseJSON { response in
                        print(response.debugDescription as Any)  // original URL request
                        print(response.response as Any) // URL response
                        print(response.result.value as Any)
                        let responseData = response.value as! NSDictionary
                        self.message = responseData["message"] as? String
                        let data = responseData["data"] as! NSDictionary
                        print(data)
                       
                        if let pageTitle = data["page_title"]  as? String{
                            self.title = pageTitle
                        }
                        if let array = data["alerts"] as? NSArray {
                            self.nokri_companydataParser(companyDataArray: array)
                        }
                        self.tableView.delegate = self
                        self.tableView.dataSource = self
                        self.stopAnimating()
                }
            }
        }
    }
    
    func nokri_companydataParser(companyDataArray:NSArray){
        self.followerArray.removeAllObjects()
        for item in companyDataArray{
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
            self.followerArray.add(arrayOfDictionaries);
        }
        if companyDataArray.count == 0{
            nokri_tableViewHelper()
            self.tableView.reloadData()
        }else{
            nokri_tableViewHelper2()
        }
        print("\(self.followerArray.count)");
        self.tableView.reloadData()
    }
    
    func nokri_removeAlert(parameter: NSDictionary) {
        self.showLoader()
        UserHandler.nokri_RemoveAlert(parameter: parameter as NSDictionary, success: { (successResponse) in
            let hud = JGProgressHUD(style: .dark)
            hud.textLabel.text = successResponse.message!
            hud.detailTextLabel.text = nil
            hud.indicatorView = JGProgressHUDSuccessIndicatorView()
            hud.position = .bottomCenter
            hud.show(in: self.view)
            hud.dismiss(afterDelay: 2.0)
            self.nokri_jobAlert()
            self.tableView.reloadData()
            self.stopAnimating()
        }) { (error) in
            let alert = Constants.showBasicAlert(message: error.message)
            self.present(alert, animated: true, completion: nil)
            self.stopAnimating()
        }
    }
    
    func nokri_advanceSearchData() {
        
       
        UserHandler.nokri_advanceSearch(success: { (successResponse) in
            
            if successResponse.success {
              
                self.searchField = successResponse.data.searchFields
                self.extraArray = successResponse.extra
                self.nokri_dropDownSetup()
                self.nokri_populateData()
                
            }
            else {
                
            }
        }) { (error) in
           
            let alert = Constants.showBasicAlert(message: error.message)
            self.present(alert, animated: true, completion: nil)
            self.stopAnimating()
        }
        
    }
    
    
}

