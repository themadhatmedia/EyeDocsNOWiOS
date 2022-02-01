//
//  JobPostCustomViewController.swift
//  Nokri
//
//  Created by apple on 7/22/19.
//  Copyright © 2019 Furqan Nadeem. All rights reserved.
//

import UIKit
import Alamofire
import DropDown
import ActionSheetPicker_3_0
import JGProgressHUD

class JobPostCustomViewController: UIViewController,UITextFieldDelegate,UIScrollViewDelegate {
    
    
    //MARK:- IBOutlets
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var lblBasicInfoTitle: UILabel!
    @IBOutlet weak var lblJobName: UILabel!
    @IBOutlet weak var txtJobTitle: UITextField!
    @IBOutlet weak var viewJobCategory: UIView!
    @IBOutlet weak var lblJobCategoryKey: UILabel!
    @IBOutlet weak var lblJobCategoryValue: UILabel!
    @IBOutlet weak var iconDropDownJobCat: UIImageView!
    @IBOutlet weak var btnDropDownJobCategory: UIButton!
    @IBOutlet weak var viewJobCategoryTwo: UIView!
    @IBOutlet weak var viewJobCategoryThree: UIView!
    @IBOutlet weak var viewJobCategoryFour: UIView!
    @IBOutlet weak var lblJobCategoryKeyTwo: UILabel!
    @IBOutlet weak var lblJobCategoryKeyThree: UILabel!
    @IBOutlet weak var lblJobCategoryKeyFour: UILabel!
    @IBOutlet weak var dropDownViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var lblJobCategoryValueTwo: UILabel!
    @IBOutlet weak var lblJobCategoryValueThree: UILabel!
    @IBOutlet weak var lblJobCategoryValueFour: UILabel!
    @IBOutlet weak var iconDropDownJobCatTwo: UIImageView!
    @IBOutlet weak var iconDropDownJobCatThree: UIImageView!
    @IBOutlet weak var iconDropDownJobCatFour: UIImageView!
    @IBOutlet weak var btnDropDownJobCategoryTwo: UIButton!
    @IBOutlet weak var btnJobCategoryThree: UIButton!
    @IBOutlet weak var btnJobCategoryFour: UIButton!
    @IBOutlet weak var heightConstraintJobCategoryView: NSLayoutConstraint!
    @IBOutlet weak var lblJobDesc: UILabel!
    @IBOutlet weak var richEditor: UITextView!
    @IBOutlet weak var lblApplicationDeadlineKey: UILabel!
    @IBOutlet weak var lblApplicationDeadlineValue: UILabel!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var viewTxtName: UIView!
    @IBOutlet weak var viewDeadLine: UIView!
    @IBOutlet weak var topConst: NSLayoutConstraint!
    
    var dropDownCategory2 = DropDown()
    var dropDownCategory3 = DropDown()
    var dropDownCategory4 = DropDown()
    var appColorNew = UserDefaults.standard.string(forKey: "app_Color")
    var isFromResumeRecv:Bool = false
    var jobSubCatArrat = NSMutableArray()
    var jobSubCatArrat2 = NSMutableArray()
    var jobSubCatArrat3 = NSMutableArray()
    var jobSubCatArrat4 = NSMutableArray()
    var customeDataArray = [JobPostCCustomData]()
    var descriptionText = ""
    var descriptionValue = ""
    var deadlineKey = ""
    var deadlineValue = ""
    var dropDownJobCategory = DropDown()
    var jobCategoreisArray = NSMutableArray()
    let catKey = UserDefaults.standard.integer(forKey: "caKey")
    let cat2Key = UserDefaults.standard.integer(forKey: "ca2Key")
    let cat3Key = UserDefaults.standard.integer(forKey: "ca3Key")
    let cat4Key = UserDefaults.standard.integer(forKey: "ca4Key")
    var jobTitle = ""
    var job_Id:Int = 1
    var isFromEdit:Int = 1
    var jobIdNew:Any!
    var jobInExpire = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        if isFromEdit == 0{
            UserDefaults.standard.set(true, forKey: "ed")
            nokri_jobPostDataEdit()
        }else{
            nokri_jobPostData()
        }
        nokri_dropDownIcons()
        nokri_viewHide()
        txtJobTitle.delegate = self
        let isRtl = UserDefaults.standard.string(forKey: "isRtl")
        if isRtl == "0"{
            self.addLeftBarButtonWithImage(#imageLiteral(resourceName: "menu"))
        }else{
            self.addRightBarButtonWithImage(#imageLiteral(resourceName: "menu"))
        }
        scrollView.delegate = self

        let catName  = UserDefaults.standard.string(forKey: "caName")
        let cat2Name  = UserDefaults.standard.string(forKey: "caName")
        let cat3Name  = UserDefaults.standard.string(forKey: "caName")
        let cat4Name  = UserDefaults.standard.string(forKey: "caName")
        dropDownJobCategory.tag = catKey
        self.lblJobCategoryValue.text = catName
        dropDownCategory2.tag = cat2Key
        self.lblJobCategoryValue.text = cat2Name
        dropDownCategory3.tag = cat3Key
        self.lblJobCategoryValue.text = cat3Name
        dropDownCategory4.tag = cat4Key
        self.lblJobCategoryValue.text = cat4Name
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        let catName  = UserDefaults.standard.string(forKey: "caName")
        let cat2Name  = UserDefaults.standard.string(forKey: "caName")
        let cat3Name  = UserDefaults.standard.string(forKey: "caName")
        let cat4Name  = UserDefaults.standard.string(forKey: "caName")
        let catKey = UserDefaults.standard.integer(forKey: "caKey")
        let cat2Key = UserDefaults.standard.integer(forKey: "ca2Key")
        let cat3Key = UserDefaults.standard.integer(forKey: "ca3Key")
        let cat4Key = UserDefaults.standard.integer(forKey: "ca4Key")
        dropDownJobCategory.tag = catKey
        self.lblJobCategoryValue.text = catName
        dropDownCategory2.tag = cat2Key
        self.lblJobCategoryValue.text = cat2Name
        dropDownCategory3.tag = cat3Key
        self.lblJobCategoryValue.text = cat3Name
        dropDownCategory4.tag = cat4Key
        self.lblJobCategoryValue.text = cat4Name
        
        let d = UserDefaults.standard.string(forKey: "custData")
        if d == "true"{
            let param: [String: Any] = [
                "job_id":job_Id,
                "cat_id": dropDownJobCategory.tag
            ]
            print(param)
            nokri_DynamicFieldsNew(param:param as NSDictionary)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        //txtJobTitle.nokri_updateBottomBorderSize()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.contentSize = CGSize(width: view.layer.frame.size.width, height: 1100)
    }
    
    @IBAction func btnNextClicked(_ sender: UIButton) {
        let ctrl = storyboard?.instantiateViewController(withIdentifier: "JobPostDynamicFieldViewController") as! JobPostDynamicFieldViewController
        print(customeDataArray)
        ctrl.customArray = customeDataArray
        ctrl.fieldsArray = customeDataArray
        ctrl.desText = descriptionText
        ctrl.desValue = richEditor.text
        ctrl.deadLineKe = deadlineKey
        ctrl.deadLineVa = lblApplicationDeadlineValue.text!
        ctrl.jobTitle = txtJobTitle.text!
        ctrl.jobCat = catKey
        
        if txtJobTitle.text == ""{
            viewTxtName.backgroundColor = UIColor.red
            let alert = Constants.showBasicAlert(message: "Please enter title")
            self.present(alert, animated: true, completion: nil)
        }else if lblApplicationDeadlineValue.text == ""{
            viewDeadLine.backgroundColor = UIColor.red
            let alert = Constants.showBasicAlert(message: "Please enter deadline")
            self.present(alert, animated: true, completion: nil)
        }
        else{
            self.navigationController?.pushViewController(ctrl, animated: true)
        }
    }
    
    //-->>> Text Field Delegate
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == txtJobTitle {
            txtJobTitle.nokri_updateBottomBorderColor(isTextFieldSelected: true)
        } else {
            //            txtJobTitle.nokri_updateBottomBorderColor(isTextFieldSelected: false)
        }
        return true
    }
    
    //MARK:- Custome Functions
    
    func nokri_viewHide(){
        viewJobCategoryTwo.isHidden = true
        viewJobCategoryThree.isHidden = true
        viewJobCategoryFour.isHidden = true
        heightConstraintJobCategoryView.constant -= 235
    }
    
    func nokri_dropDownIcons(){
        iconDropDownJobCat.image = iconDropDownJobCat.image?.withRenderingMode(.alwaysTemplate)
        iconDropDownJobCat.tintColor = UIColor(hex: appColorNew!)
    }
    
    func nokri_dropDownSetup(){
        
        var jobCatArr = [String]()
        var childArr = [Bool]()
        var keyArray = [Int]()
        var isJobCatSelected:Bool?
        let jobCategory = self.jobCategoreisArray as? [NSDictionary]
        for itemDict in jobCategory! {
            if let catObj = itemDict["value"] as? String{
                jobCatArr.append(catObj)
            }
            if let keyObj = itemDict["key"] as? Int{
                //catID = keyObj
                keyArray.append(keyObj)
            }
            if let hasChild = itemDict["has_child"] as? Bool{
                print(hasChild)
                childArr.append(hasChild)
            }
        }
        for itemDict in jobCategory! {
            if let selected = itemDict["selected"] as? Bool{
                isJobCatSelected = selected
                if isJobCatSelected == true{
                    if let keyObj = itemDict["key"] as? Int{
                        let param: [String: Any] = [
                            "cat_id": keyObj,
                            "job_id":job_Id
                        ]
                        print(param)
                        nokri_DynamicFieldsNew(param:param as NSDictionary)
                    }
                    break
                }
            }
        }
        DropDown.startListeningToKeyboard()
        DropDown.appearance().textColor = UIColor.black
        DropDown.appearance().textFont = UIFont.systemFont(ofSize: 12)
        DropDown.appearance().backgroundColor = UIColor.white
        DropDown.appearance().selectionBackgroundColor = UIColor(hex:appColorNew!)
        DropDown.appearance().cellHeight = 40
    }
    
    //MARK:- IBAction
    
    @IBAction func btnDropDownJobCategoryClicked(_ sender: UIButton) {
        //dropDownJobCategory.show()
        var jobCatArr = [String]()
        var childArr = [Bool]()
        var keyArray = [Int]()
        
        let jobCategory = self.jobCategoreisArray as? [NSDictionary]
        
        for itemDict in jobCategory! {
            if let catObj = itemDict["value"] as? String{
                jobCatArr.append(catObj)
            }
            if let keyObj = itemDict["key"] as? Int{
                keyArray.append(keyObj)
            }
            
            if let hasChild = itemDict["has_child"] as? Bool{
                print(hasChild)
                
                childArr.append(hasChild)
            }
        }
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "JobCatOneViewController") as? JobCatOneViewController
        vc!.jobCatArr = jobCatArr
        vc!.childArr = childArr
        vc!.keyArray = keyArray
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func btnDropDownJobCategoryTwoClicked(_ sender: UIButton) {
        dropDownCategory2.show()
    }
    
    @IBAction func btnDropDownJobCategoryThreeClicked(_ sender: UIButton) {
        dropDownCategory3.show()
    }
    
    @IBAction func btnDropDownJobCategoryFourClicked(_ sender: UIButton) {
        dropDownCategory4.show()
    }
    
    @IBAction func btnApplicationDeadlineClicked(_ sender: UIButton) {
        let datePicker = ActionSheetDatePicker(title: "Select Date:", datePickerMode: UIDatePicker.Mode.date, selectedDate: Date(), doneBlock: {
            picker, value, index in
            print("value = \(String(describing: value))")
            print("index = \(String(describing: index))")
            print("picker = \(String(describing: picker))")
            let fullName = "\(String(describing: value!))"
            let fullNameArr = fullName.components(separatedBy: " ")
            let name  = "\(fullNameArr[0])" + " " + "\(fullNameArr[1])"
            print(name)
            let dateFormatterGet = DateFormatter()
            dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let dateFormatterPrint = DateFormatter()
            //dateFormatterPrint.dateFormat = "MMM yyyy"
            dateFormatterPrint.dateFormat = "MM/dd/yyyy"
            if let date = dateFormatterGet.date(from:  name){
                print(dateFormatterPrint.string(from: date))
                self.lblApplicationDeadlineValue.text = dateFormatterPrint.string(from: date)
                self.viewDeadLine.backgroundColor = UIColor.groupTableViewBackground
            }
            else {
                print("There was an error decoding the string")
            }
            return
        }, cancel: { ActionStringCancelBlock in return }, origin: (sender as AnyObject).superview!?.superview)
       
        var secondsInWeek: TimeInterval = 0
        if jobInExpire == 0{
            secondsInWeek = 1500 * 24 * 60 * 60
        }else{
            secondsInWeek = TimeInterval(jobInExpire * 24 * 60 * 60)
        }   
        datePicker?.minimumDate = Date(timeInterval: 0, since: Date())
        datePicker?.maximumDate = Date(timeInterval: secondsInWeek, since: Date())
        datePicker?.minuteInterval = 20
        datePicker?.show()
    }
    
    //MARK:- API Calls
    
    func nokri_jobPostData(){
        
        var langCode = UserDefaults.standard.string(forKey: "langCode")
        if langCode == nil {
            langCode = "en"
        }
        
        self.showLoader()
        
        var email = ""
        var password = ""
        //var lati = ""
        //var longi = ""
        
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
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.jobPost, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    
                    guard let res = response.value else{return}
                    let responseData = res as! NSDictionary
                    let success = responseData["success"] as! Bool
                    let messageResponse = responseData["message"] as! String
                    
                    if success == true{
                        let data = responseData["data"] as! NSDictionary
                             
                        let job_id = data["job_id"]
                        UserDefaults.standard.set(job_id, forKey: "JobId")
                        print(job_id!)
                        
                        let basicInfo = data["basic_info"] as! NSDictionary
                        if let titleBasicInfo = basicInfo["key"]{
                            self.lblBasicInfoTitle.text = titleBasicInfo as? String
                        }
                        let jobTitle = data["job_title"] as! NSDictionary
                        if let jobTitle = jobTitle["key"]{
                            //self.txtJobTitle.text = jobTitle as? String
                            self.lblJobName.text = jobTitle as? String
                            self.txtJobTitle.placeholder = jobTitle as? String
                        }
                        let pageTitle = data["job_page_title"] as! NSDictionary
                        if let page = pageTitle["key"]{
                            self.title = page as? String
                            UserDefaults.standard.set(page as? String, forKey: "jobPost")
                            //self.navigationController?.navigationBar.topItem?.title = page as? String
                        }
                        let jobDescription = data["job_desc"] as! NSDictionary
                        if let jobDes = jobDescription["key"]{
                            self.lblJobDesc.text = jobDes as? String
                            self.descriptionText = (jobDes as? String)!
                        }
                        if let value = jobDescription["value"]{
                            self.richEditor.text = value as? String
                            self.descriptionValue = value as! String
                        }
                        let jobDeadline = data["job_deadline"] as! NSDictionary
                        if let deadline = jobDeadline["key"]{
                            self.lblApplicationDeadlineKey.text = deadline as? String
                            self.deadlineKey = (deadline as? String)!
                        }
                        if let deadlin = jobDeadline["value"]{
                            self.lblApplicationDeadlineValue.text = deadlin as? String
                            self.deadlineValue = (deadlin as? String)!
                        }
                        let jobCat = data["job_category"] as! NSDictionary
                        let jobCatKey = jobCat["key"] as! String
                        self.lblJobCategoryKey.text = jobCatKey
                        if let jobCatArr = jobCat["value"] as? NSArray {
                            self.nokri_jobCategoryDataParser(jobCatArr: jobCatArr)
                        }
                        let jobCatSub = data["job_sub_category"] as! NSDictionary
                        let jobCatSubKey = jobCatSub["key"] as! String
                        self.lblJobCategoryKeyTwo.text = jobCatSubKey
                        
                        let jobCatSub2 = data["job_sub_sub_category"] as! NSDictionary
                        let jobCatSubKey2 = jobCatSub2["key"] as! String
                        self.lblJobCategoryKeyThree.text = jobCatSubKey2
                        
                        let jobCatSub3 = data["job_sub_sub_sub_category"] as! NSDictionary
                        let jobCatSubKey3 = jobCatSub3["key"] as! String
                        self.lblJobCategoryKeyFour.text = jobCatSubKey3
                        self.nokri_dropDownSetup()
                        let jobExpireDays = data["expiry_limit"] as! NSDictionary
                        self.jobInExpire = jobExpireDays["value"] as! Int
                    }else{
                        let hud = JGProgressHUD(style: .dark)
                        hud.textLabel.text = messageResponse
                        hud.detailTextLabel.text = nil
                        hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                        hud.position = .bottomCenter
                        hud.show(in: self.view)
                        hud.dismiss(afterDelay: 2.0)
                        //self.view.makeToast(messageResponse, duration: 1.5, position: .center)
                        // self.perform(#selector(self.nokri_showBuyPackages), with: nil, afterDelay: 2)
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
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.jobPost, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    guard let res = response.value else{return}
                    let responseData = res as! NSDictionary
                    let success = responseData["success"] as! Bool
                    let messageResponse = responseData["message"] as! String
                    if success == true{
                        let data = responseData["data"] as! NSDictionary
                        
                        let job_id = data["job_id"]
                        UserDefaults.standard.set(job_id, forKey: "JobId")
                        print(job_id!)
                        
                        let basicInfo = data["basic_info"] as! NSDictionary
                        if let titleBasicInfo = basicInfo["key"]{
                            self.lblBasicInfoTitle.text = titleBasicInfo as? String
                        }
                        let jobTitle = data["job_title"] as! NSDictionary
                        if let jobTitle = jobTitle["key"]{
                            self.lblJobName.text = jobTitle as? String
                            //self.txtJobTitle.text = jobTitle as? String
                            self.txtJobTitle.placeholder = jobTitle as? String
                        }
                        
                        let jobDescription = data["job_desc"] as! NSDictionary
                        if let jobDes = jobDescription["key"]{
                            self.lblJobDesc.text = jobDes as? String
                            self.descriptionText = (jobDes as? String)!
                            
                        }
                        if let value = jobDescription["value"]{
                            self.richEditor.text = value as? String
                            self.descriptionValue = value as! String
                        }
                        
                        let jobDeadline = data["job_deadline"] as! NSDictionary
                        if let deadline = jobDeadline["key"]{
                            self.lblApplicationDeadlineKey.text = deadline as? String
                            self.deadlineKey = (deadline as? String)!
                        }
                        if let deadlin = jobDeadline["value"]{
                            self.lblApplicationDeadlineValue.text = deadlin as? String
                            self.deadlineValue = (deadlin as? String)!
                        }
                        
                        let pageTitle = data["job_page_title"] as! NSDictionary
                        if let page = pageTitle["key"]{
                            self.title = page as? String
                            UserDefaults.standard.set(page as? String, forKey: "jobPost")
                            //self.navigationController?.navigationBar.topItem?.title = page as? String
                            
                        }
                        
                        let jobCat = data["job_category"] as! NSDictionary
                        let jobCatKey = jobCat["key"] as! String
                        self.lblJobCategoryKey.text = jobCatKey
                        if let jobCatArr = jobCat["value"] as? NSArray {
                            self.nokri_jobCategoryDataParser(jobCatArr: jobCatArr)
                        }
                        
                        let jobCatSub = data["job_sub_category"] as! NSDictionary
                        let jobCatSubKey = jobCatSub["key"] as! String
                        self.lblJobCategoryKeyTwo.text = jobCatSubKey
                        
                        let jobCatSub2 = data["job_sub_sub_category"] as! NSDictionary
                        let jobCatSubKey2 = jobCatSub2["key"] as! String
                        self.lblJobCategoryKeyThree.text = jobCatSubKey2
                        
                        let jobCatSub3 = data["job_sub_sub_sub_category"] as! NSDictionary
                        let jobCatSubKey3 = jobCatSub3["key"] as! String
                        self.lblJobCategoryKeyFour.text = jobCatSubKey3
                        
                        self.nokri_dropDownSetup()
                        let jobExpireDays = data["expiry_limit"] as! NSDictionary
                        self.jobInExpire = jobExpireDays["value"] as! Int
                        
                    }else{
                        let hud = JGProgressHUD(style: .dark)
                        hud.textLabel.text = messageResponse
                        hud.detailTextLabel.text = nil
                        hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                        hud.position = .bottomCenter
                        hud.show(in: self.view)
                        hud.dismiss(afterDelay: 2.0)
                        //self.view.makeToast(messageResponse, duration: 1.5, position: .center)
                        //  self.perform(#selector(self.nokri_showBuyPackages), with: nil, afterDelay: 2)
                    }
                    
                    self.stopAnimating()
            }
        }
    }
    
    
    func nokri_jobPostDataEdit(){
        
        var langCode = UserDefaults.standard.string(forKey: "langCode")
        if langCode == nil {
            langCode = "en"
        }
        
        self.showLoader()
        
        var email = ""
        var password = ""
       // var lati = ""
       // var longi = ""
        
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
                "job_id":job_Id,
                "is_update":job_Id
            ]
            UserDefaults.standard.set(job_Id, forKey: "jobId")
            print(param)
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.postJobFromEdit, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                  
                    
                    guard let res = response.value else{return}
                    let responseData = res as! NSDictionary
                    let success = responseData["success"] as! Bool
                    let messageResponse = responseData["message"] as! String
                    
                    if success == true{
                        let data = responseData["data"] as! NSDictionary
   
                        if let job_id = data["job_id"] as? NSNumber {
                            UserDefaults.standard.set(job_id, forKey: "JobId")
                            print(job_id)
                            self.jobIdNew = job_id
                        }
                        else if let job_id = data["job_id"] {
                            
                            UserDefaults.standard.set(job_id, forKey: "JobId")
                            print(job_id)
                            self.jobIdNew = job_id as? String
                        }
                    
                        let basicInfo = data["basic_info"] as! NSDictionary
                        if let titleBasicInfo = basicInfo["key"]{
                            self.lblBasicInfoTitle.text = titleBasicInfo as? String
                        }
                        let jobTitle = data["job_title"] as! NSDictionary
                        if let jobTitleKey = jobTitle["key"]{
                            self.lblJobName.text = jobTitleKey as? String
                            self.txtJobTitle.placeholder = jobTitleKey as? String
                            if let jobTitleVal = jobTitle["value"]{
                                self.txtJobTitle.text = jobTitleVal as? String
                            }
                        }
                        let jobDescription = data["job_desc"] as! NSDictionary
                        if let jobDes = jobDescription["key"]{
                            self.lblJobDesc.text = jobDes as? String
                            self.descriptionText = (jobDes as? String)!
                        }
                        if let value = jobDescription["value"]{
                            self.richEditor.text = value as? String
                            self.descriptionValue = value as! String
                        }
                        let pageTitle = data["job_page_title"] as! NSDictionary
                        if let page = pageTitle["key"]{
                            self.title = page as? String
                            //self.navigationController?.navigationBar.topItem?.title = page as? String
                            
                        }
                        let jobDeadline = data["job_deadline"] as! NSDictionary
                        if let deadline = jobDeadline["key"]{
                            self.lblApplicationDeadlineKey.text = deadline as? String
                            self.deadlineKey = (deadline as? String)!
                        }
                        if let deadlin = jobDeadline["value"]{
                            self.lblApplicationDeadlineValue.text = deadlin as? String
                            self.deadlineValue = (deadlin as? String)!
                        }
                        let jobCat = data["job_category"] as! NSDictionary
                        let jobCatKey = jobCat["key"] as! String
                        self.lblJobCategoryKey.text = jobCatKey
                        if let jobCatArr = jobCat["value"] as? NSArray {
                            self.nokri_jobCategoryDataParser(jobCatArr: jobCatArr)
                        }
                        let jobCatSub = data["job_sub_category"] as! NSDictionary
                        let jobCatSubKey = jobCatSub["key"] as! String
                        self.lblJobCategoryKeyTwo.text = jobCatSubKey
                        
                        let jobCatSub2 = data["job_sub_sub_category"] as! NSDictionary
                        let jobCatSubKey2 = jobCatSub2["key"] as! String
                        self.lblJobCategoryKeyThree.text = jobCatSubKey2
                        
                        let jobCatSub3 = data["job_sub_sub_sub_category"] as! NSDictionary
                        let jobCatSubKey3 = jobCatSub3["key"] as! String
                        self.lblJobCategoryKeyFour.text = jobCatSubKey3
                        self.nokri_dropDownSetup()
                        
                        let jobExpireDays = data["expiry_limit"] as! NSDictionary
                        self.jobInExpire = jobExpireDays["value"] as! Int
                        
                        let isJobTitleChange = data["is_restrict"] as! Bool
                        
                        if isJobTitleChange == true{
                            self.txtJobTitle.isEnabled = true
                        }else{
                            self.txtJobTitle.isEnabled = false
                            self.lblJobName.textColor = UIColor.lightGray
                        }
                        
                    }else{
                        let hud = JGProgressHUD(style: .dark)
                        hud.textLabel.text = messageResponse
                        hud.detailTextLabel.text = nil
                        hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                        hud.position = .bottomCenter
                        hud.show(in: self.view)
                        hud.dismiss(afterDelay: 2.0)
                        //self.view.makeToast(messageResponse, duration: 1.5, position: .center)
                        // self.perform(#selector(self.nokri_showBuyPackages), with: nil, afterDelay: 2)
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
                "job_id": job_Id,
                "is_update":job_Id
            ]
            
            print(param)
            UserDefaults.standard.set(job_Id, forKey: "jbId")
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.postJobFromEdit, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    guard let res = response.value else{return}
                    let responseData = res as! NSDictionary
                    let success = responseData["success"] as! Bool
                    let messageResponse = responseData["message"] as! String
                    if success == true{
                        let data = responseData["data"] as! NSDictionary
             
                        let pageTitle = data["job_page_title"] as! NSDictionary
                        if let page = pageTitle["key"]{
                            self.title = page as? String
                            //self.navigationController?.navigationBar.topItem?.title = page as? String
                            
                        }
                        
                        if let job_id = data["job_id"] as? NSNumber {
                            UserDefaults.standard.set(job_id, forKey: "JobId")
                            print(job_id)
                            self.jobIdNew = job_id
                        }
                        else if let job_id = data["job_id"] {
                            
                            UserDefaults.standard.set(job_id, forKey: "JobId")
                            print(job_id)
                            self.jobIdNew = job_id as? String
                        }
                        let basicInfo = data["basic_info"] as! NSDictionary
                        if let titleBasicInfo = basicInfo["key"]{
                            self.lblBasicInfoTitle.text = titleBasicInfo as? String
                        }
                        
                        let jobTitle = data["job_title"] as! NSDictionary
                        if let jobTitleKey = jobTitle["key"]{
                            self.lblJobName.text = jobTitleKey as? String
                            self.txtJobTitle.placeholder = jobTitleKey as? String
                            if let jobTitleVal = jobTitle["value"]{
                                self.txtJobTitle.text = jobTitleVal as? String
                            }
                        }
                        if let jobTitle = jobTitle["value"]{
                            self.lblJobName.text = jobTitle as? String
                            self.txtJobTitle.placeholder = jobTitle as? String
                        }
                        
                        let jobDescription = data["job_desc"] as! NSDictionary
                        if let jobDes = jobDescription["key"]{
                            self.lblJobDesc.text = jobDes as? String
                            self.descriptionText = (jobDes as? String)!
                            
                        }
                        if let value = jobDescription["value"]{
                            self.richEditor.text = value as? String
                            self.descriptionValue = value as! String
                        }
                        
                        let jobDeadline = data["job_deadline"] as! NSDictionary
                        if let deadline = jobDeadline["key"]{
                            self.lblApplicationDeadlineKey.text = deadline as? String
                            self.deadlineKey = (deadline as? String)!
                        }
                        if let deadlin = jobDeadline["value"]{
                            self.lblApplicationDeadlineValue.text = deadlin as? String
                            self.deadlineValue = (deadlin as? String)!
                        }
                        
                        let jobCat = data["job_category"] as! NSDictionary
                        let jobCatKey = jobCat["key"] as! String
                        self.lblJobCategoryKey.text = jobCatKey
                        if let jobCatArr = jobCat["value"] as? NSArray {
                            self.nokri_jobCategoryDataParser(jobCatArr: jobCatArr)
                        }
                        
                        let jobCatSub = data["job_sub_category"] as! NSDictionary
                        let jobCatSubKey = jobCatSub["key"] as! String
                        self.lblJobCategoryKeyTwo.text = jobCatSubKey
                        
                        let jobCatSub2 = data["job_sub_sub_category"] as! NSDictionary
                        let jobCatSubKey2 = jobCatSub2["key"] as! String
                        self.lblJobCategoryKeyThree.text = jobCatSubKey2
                        
                        let jobCatSub3 = data["job_sub_sub_sub_category"] as! NSDictionary
                        let jobCatSubKey3 = jobCatSub3["key"] as! String
                        self.lblJobCategoryKeyFour.text = jobCatSubKey3
                        self.nokri_dropDownSetup()
                        let jobExpireDays = data["expiry_limit"] as! NSDictionary
                        self.jobInExpire = jobExpireDays["value"] as! Int
                        
                        let isJobTitleChange = data["is_restrict"] as! Bool
                        
                        if isJobTitleChange == true{
                            self.txtJobTitle.isEnabled = true
                        }else{
                            self.txtJobTitle.isEnabled = false
                            self.lblJobName.textColor = UIColor.lightGray
                        }
                        
                    }else{
                        let hud = JGProgressHUD(style: .dark)
                        hud.textLabel.text = messageResponse
                        hud.detailTextLabel.text = nil
                        hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                        hud.position = .bottomCenter
                        hud.show(in: self.view)
                        hud.dismiss(afterDelay: 2.0)
                        //self.view.makeToast(messageResponse, duration: 1.5, position: .center)
                        //  self.perform(#selector(self.nokri_showBuyPackages), with: nil, afterDelay: 2)
                    }
                    
                    self.stopAnimating()
            }
        }
    }
    
    
    func nokri_jobCategoryDataParser(jobCatArr:NSArray){
        self.jobCategoreisArray.removeAllObjects()
        for item in jobCatArr{
            self.jobCategoreisArray.add(item)
        }
    }
    
    func nokri_childCategories(id:Int){
        
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
                "cat_id": id,
            ]
            print(param)
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.childCat, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    let responseData = response.value as! NSArray
                    print(responseData)
                    self.nokri_jobSubCatDataParser(jobCatArr: responseData)
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
                "cat_id": id,
            ]
            print(param)
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.childCat, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    let responseData = response.value as! NSArray
                    print(responseData)
                    self.nokri_jobSubCatDataParser(jobCatArr: responseData)
                    self.nokri_dropDownSetup()
                    self.stopAnimating()
            }
        }
    }
    
    func nokri_jobSubCatDataParser(jobCatArr:NSArray){
        self.jobSubCatArrat.removeAllObjects()
        for item in jobCatArr{
            self.jobSubCatArrat.add(item)
        }
    }
    
    func nokri_DynamicFieldsNew(param: NSDictionary) {
        self.showLoader()
        UserHandler.nokri_PostJobCustome(parameter: param, success: { (successResponse) in
            self.stopAnimating()
            if successResponse.success {
                self.customeDataArray = successResponse.data
                //print(successResponse.data)
                for ob in successResponse.data{
                    print(ob)
                    //print(ob.hasCatTemplate)
                }
            }
            else {
                let alert = Constants.showBasicAlert(message: successResponse.message)
                self.present(alert, animated: true)
            }
        }) { (error) in
            self.stopAnimating()
            let alert = Constants.showBasicAlert(message: error.message)
            self.present(alert, animated: true)
        }
    }
    
    func nokri_DynamicFields(id:Int){
        
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
                "cat_id": id,
            ]
            print(param)
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.dynamicFields, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    
                    let responseData = response as! NSDictionary
                    print(responseData)
                    
                    let dynamicData = responseData["data"] as! NSArray
                    print(dynamicData)
                    
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
                "cat_id": id,
            ]
            print(param)
            
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.dynamicFields, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    print(response)
          
                    UserDefaults.standard.set("false", forKey: "custData")
                    self.nokri_dropDownSetup()
                    self.stopAnimating()
                    
            }
        }
    }
    
    @IBAction func txtJobNameEdit(_ sender: UITextField) {
        viewTxtName.backgroundColor = UIColor.groupTableViewBackground
        
    }
}

