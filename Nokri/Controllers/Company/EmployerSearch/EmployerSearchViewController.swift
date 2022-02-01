//
//  EmployerSearchViewController.swift
//  Nokri
//
//  Created by Furqan Nadeem on 01/06/2020.
//  Copyright © 2020 Furqan Nadeem. All rights reserved.
//

import UIKit
import DropDown
import Alamofire
import JGProgressHUD

class EmployerSearchViewController: UITableViewController {

   //MARK:- IBOutlets
        
        
        @IBOutlet weak var viewMain: UIView!
        @IBOutlet weak var lblSearchNow: UILabel!
        @IBOutlet weak var viewSearchKeyWord: UIView!
        @IBOutlet weak var viewType: UIView!
      
        @IBOutlet weak var viewCCS: UIView!
        @IBOutlet weak var viewCountry: UIView!
        @IBOutlet weak var lblTypeKey: UILabel!
        @IBOutlet weak var lblTypeValue: UILabel!
        @IBOutlet weak var btnType: UIButton!
        @IBOutlet weak var txtSearchKeywordField: UITextField!
        @IBOutlet weak var btnSearchKeyWord: UIButton!
        @IBOutlet weak var lblCountryKey: UILabel!
        @IBOutlet weak var lblCountryValue: UILabel!
        @IBOutlet weak var btnCountry: UIButton!
        @IBOutlet weak var btnSearchNow: UIButton!
        @IBOutlet weak var heightConstraintCCT: NSLayoutConstraint!
        @IBOutlet weak var iconDropDownType: UIImageView!
        @IBOutlet weak var iconCountry: UIImageView!
        
        //MARK:- Proporties
        
        let dropDownType = DropDown()
        let dropDownCountry = DropDown()
        var searchField = [CandidateSearchField]()
        var valueArray = [CandidateSearchValue]()
        var extraArray = [CandidateSearchExtra]()
        var selectOption:String?
        var message:String?
        var candidateArray = NSMutableArray()
        var typeInt:Int?
        var categoryArray = [String]()
        var isType = false
        var nextPage:Int?
        var hasNextPage:Bool?
        var appColorNew = UserDefaults.standard.string(forKey: "app_Color")
        var countryArray = NSMutableArray()
        var selectOpt = ""
        var pageTitle = ""
        
    
    var isSpecliaztion = false
    
        //MARK:- View Life Cycle
        
        override func viewDidLoad() {
            super.viewDidLoad()
           // nokri_ltrRtl()
            addLeftBarButtonWithImage(#imageLiteral(resourceName: "menu"))
            nokri_candidateSearchData()
            nokri_viewShadow()
            nokri_dropDownIcons()
            nokri_jobLoctData()
            heightConstraintCCT.constant -= 180
            if let userData = UserDefaults.standard.object(forKey: "settingsData") {
                let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
                let dataTabs = SplashRoot(fromDictionary: objData)
                let obj = dataTabs.data.extra
                selectOpt = obj?.select_opt as! String
            }
            showRefreshButton()
        }
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(true)
            let isLocation = UserDefaults.standard.bool(forKey: "locationSelected")
            if isLocation == true{
            self.txtSearchKeywordField.text! = ""
            let cotName  = UserDefaults.standard.string(forKey: "coName")
            let cot2Name  = UserDefaults.standard.string(forKey: "coName")
            let cot3Name  = UserDefaults.standard.string(forKey: "coName")
            let cot4Name  = UserDefaults.standard.string(forKey: "coName")
            let cotKey = UserDefaults.standard.integer(forKey: "coKey")
            let cot2Key = UserDefaults.standard.integer(forKey: "co2Key")
            let cot3Key = UserDefaults.standard.integer(forKey: "co3Key")
            let cot4Key = UserDefaults.standard.integer(forKey: "co4Key")
            
            if cotKey != 0{
                btnCountry.tag = cotKey
                self.lblCountryValue.text = cotName
            }
            if cot2Key != 0{
                btnCountry.tag = cot2Key
                self.lblCountryValue.text = cot2Name
            }
            if cot3Key != 0{
                btnCountry.tag = cot3Key
                self.lblCountryValue.text = cot3Name
            }
            if cot4Key != 0{
                btnCountry.tag = cot4Key
                self.lblCountryValue.text = cot4Name
            }
          }
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
        
        func nokri_dropDownIcons(){
            iconDropDownType.image = iconDropDownType.image?.withRenderingMode(.alwaysTemplate)
            iconDropDownType.tintColor = UIColor(hex: appColorNew!)
        }
        
        func nokri_populateData(){
            for obj in extraArray{
                if obj.fieldTypeName == "cand_search_now"{
                    lblSearchNow.text = obj.key
                    btnSearchNow.setTitle(obj.key, for: .normal)
                }
                if obj.fieldTypeName == "cand_search_name"{
                    txtSearchKeywordField.placeholder = obj.key
                }
                if obj.fieldTypeName == "cand_search_title"{
                    self.title = obj.key
                    pageTitle = obj.key
                }
                if obj.fieldTypeName == "country"{
                    lblCountryKey.text = obj.key
                }

            }
        }
        
        func nokri_dropDownSetup(){
            var typeKey = [Int]()
            for obj in searchField{
                if obj.fieldTypeName == "cand_skills"{
                    lblTypeKey.text = obj.key
                    selectOption = obj.column
                    lblTypeValue.text = selectOpt
                    categoryArray.removeAll()
                    valueArray = obj.valueAr
                    for innerObj in valueArray{
                        categoryArray.append(innerObj.value)
                        typeKey.append(innerObj.key)
                    }
                }
            }
            dropDownType.dataSource =  categoryArray
            dropDownType.selectionAction = { [unowned self] (index: Int, item: String) in
                print("Selected item: \(item) at index: \(index)")
                self.lblTypeValue.text = item
                self.isType = true
                self.typeInt = typeKey[index]
            }
           
            dropDownType.anchorView = btnType
            DropDown.startListeningToKeyboard()
            DropDown.appearance().textColor = UIColor.black
            DropDown.appearance().textFont = UIFont.systemFont(ofSize: 12)
            DropDown.appearance().backgroundColor = UIColor.white
            DropDown.appearance().selectionBackgroundColor = UIColor(hex:appColorNew!)
            DropDown.appearance().cellHeight = 40
            //DropDown.appearance().textAlign = 300
         
        }
        
        func nokri_viewShadow(){
            
            //viewType.layer.borderColor = UIColor.gray.cgColor
            //viewType.layer.cornerRadius = 0
            //viewType.layer.shadowColor = UIColor(white: 0.0, alpha: 0.3).cgColor
            //viewType.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
            //viewType.layer.shadowOpacity = 0.6
            //viewType.layer.shadowRadius = 2
            
            viewSearchKeyWord.layer.borderWidth = 1
            viewSearchKeyWord.layer.borderColor = UIColor.lightGray.cgColor
            
            viewCountry.layer.borderColor = UIColor.gray.cgColor
            viewCountry.layer.cornerRadius = 0
            viewCountry.layer.shadowColor = UIColor(white: 0.0, alpha: 0.3).cgColor
            viewCountry.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
            viewCountry.layer.shadowOpacity = 0.6
            viewCountry.layer.shadowRadius = 2
           
            btnSearchKeyWord.backgroundColor = UIColor(hex: appColorNew!)
            btnSearchNow.backgroundColor = UIColor(hex: appColorNew!)
            
        }
    
    
    func showRefreshButton() {
           self.hideBackButton()
           let backButton = UIButton(type: .custom)
           backButton.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
           if UserDefaults.standard.bool(forKey: "isRtl") {
               backButton.setBackgroundImage(UIImage(named: "refresh"), for: .normal)
           } else {
               backButton.setBackgroundImage(UIImage(named: "refresh"), for: .normal)
           }
           backButton.addTarget(self, action: #selector(onRefreshButtonClciked), for: .touchUpInside)
           let backBarButton = UIBarButtonItem(customView: backButton)
           self.navigationItem.rightBarButtonItem = backBarButton
       }
      
       @objc func onRefreshButtonClciked() {
            txtSearchKeywordField.text = ""
            nokri_candidateSearchData()
       }
        
        //MARK:- IBActions
        
        @IBAction func btnTypeClicked(_ sender: UIButton) {
            dropDownType.show()
        }
      
        @IBAction func btnCountryClicked(_ sender: UIButton) {
            //dropDownCountry.show()
            
            var countryArr = [String]()
            var countryChildArr = [Bool]()
            var countryKeyArr = [Int]()
            let country = self.countryArray as? [NSDictionary]
            for itemDict in country! {
                if let catObj = itemDict["value"] as? String{
                    if catObj == ""{
                        continue
                    }
                    countryArr.append(catObj)
                }
                if let keyObj = itemDict["key"] as? Int{
                    
                    countryKeyArr.append(keyObj)
                }
                if let hasChild = itemDict["has_child"] as? Bool{
                    print(hasChild)
                    
                    countryChildArr.append(hasChild)
                }
            }
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "JobPostCountryViewController") as? JobPostCountryViewController
            vc!.jobCatArr = countryArr
            vc!.childArr = countryChildArr
            vc!.keyArray = countryKeyArr
            self.navigationController?.pushViewController(vc!, animated: true)
            
            
        }
      
        @IBAction func btnSearchNowClicked(_ sender: UIButton) {
            nokri_canDataWithFilters()
        }
        
        @IBAction func btnSearchKeywordClicked(_ sender: UIButton) {
            nokri_canData()
        }
        
        
        //MARK:- Api Calls
        
        func nokri_candidateSearchData() {
            self.showLoader()
            UserHandler.nokri_employerSearch(success: { (successResponse) in
                self.stopAnimating()
                if successResponse.success {
                    self.searchField = successResponse.data.searchFields
                    self.extraArray = successResponse.extra
                    self.nokri_dropDownSetup()
                    self.nokri_populateData()
                }
                else {
                    // let alert = Constants.showBasicAlert(message: successResponse.message)
                    // self.present(alert, animated: true, completion: nil)
                }
            }) { (error) in
                let alert = Constants.showBasicAlert(message: error.message)
                self.present(alert, animated: true, completion: nil)
                self.stopAnimating()
            }
        }
                      
        func nokri_canData(){
            
            var langCode = UserDefaults.standard.string(forKey: "langCode")
            if langCode == nil {
                langCode = "en"
            }
            
            var isTimeOut = false
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
                    "page_number" : "1",
                    "emp_title" : txtSearchKeywordField.text!
                ]
                print(param)
                Alamofire.request(Constants.URL.baseUrl+Constants.URL.employerSearch, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers)
                    .responseJSON { response in
                        guard let res = response.value else{return}
                        let responseData = res as! NSDictionary
                        self.message = responseData["message"] as? String
                        let success = responseData["success"] as! Bool
                        if success == true{
                            isTimeOut = true
                            var pageTitle:String?
                            let data = responseData["data"] as! NSDictionary
                            let extra = responseData["extra"] as! NSDictionary
                            if let page = extra["page_title"]  as? String{
                                pageTitle = page
                            }
                            if let JobArr = data["candidates"] as? NSArray {
                                self.nokri_jobDataParser(jobsArr: JobArr)
                            }
                            if let pagination = responseData["pagination"] as? NSDictionary{
                                self.hasNextPage = pagination["has_next_page"] as? Bool
                                self.nextPage = pagination["next_page"] as? Int
                            }
                            if self.hasNextPage == true{
                                print(self.hasNextPage!)
                                //self.btnLoadMore.isHidden = false
                            }
                            print(self.nextPage!)
                            
                            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "EmployerSearchedViewController") as! EmployerSearchedViewController
                            nextViewController.canArray = self.candidateArray
                            nextViewController.message = self.message
                            nextViewController.pageTitle = pageTitle
                            nextViewController.hasNextPage = self.hasNextPage
                            nextViewController.nextPage = self.nextPage
                            nextViewController.searchedText = self.txtSearchKeywordField.text
                            nextViewController.pageTitle = self.pageTitle
                           
                            self.navigationController?.pushViewController(nextViewController, animated: true)
                        }else{
                            let hud = JGProgressHUD(style: .dark)
                            hud.textLabel.text = self.message!
                            hud.detailTextLabel.text = nil
                            hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                            hud.position = .bottomCenter
                            hud.show(in: self.view)
                            hud.dismiss(afterDelay: 2.0)
                            //self.view.makeToast(self.message, duration: 1.5, position: .center)
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
                let param: [String: Any] = [
                    "page_number" : "1",
                    "emp_title" : txtSearchKeywordField.text!
                ]
                print(param)
                Alamofire.request(Constants.URL.baseUrl+Constants.URL.employerSearch, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers)
                    .responseJSON { response in
                        guard let res = response.value else{return}
                        let responseData = res as! NSDictionary
                        self.message = responseData["message"] as? String
                        let success = responseData["success"] as! Bool
                        if success == true{
                            isTimeOut = true
                            var pageTitle:String?
                            let data = responseData["data"] as! NSDictionary
                            let extra = responseData["extra"] as! NSDictionary
                            if let page = extra["page_title"]  as? String{
                                pageTitle = page
                            }
                            if let JobArr = data["candidates"] as? NSArray {
                                self.nokri_jobDataParser(jobsArr: JobArr)
                            }
                            if let pagination = responseData["pagination"] as? NSDictionary{
                                self.hasNextPage = pagination["has_next_page"] as? Bool
                                self.nextPage = pagination["next_page"] as? Int
                            }
                            if self.hasNextPage == true{
                                print(self.hasNextPage!)
                                //self.btnLoadMore.isHidden = false
                            }
                            print(self.nextPage!)
                            
                            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "EmployerSearchedViewController") as! EmployerSearchedViewController
                            nextViewController.canArray = self.candidateArray
                            nextViewController.message = self.message
                            nextViewController.pageTitle = pageTitle
                            nextViewController.hasNextPage = self.hasNextPage
                            nextViewController.nextPage = self.nextPage
                            nextViewController.searchedText = self.txtSearchKeywordField.text
                            
                            nextViewController.pageTitle = self.pageTitle
                            self.navigationController?.pushViewController(nextViewController, animated: true)
                        }else{
                            let hud = JGProgressHUD(style: .dark)
                            hud.textLabel.text = self.message!
                            hud.detailTextLabel.text = nil
                            hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                            hud.position = .bottomCenter
                            hud.show(in: self.view)
                            hud.dismiss(afterDelay: 2.0)
                            //self.view.makeToast(self.message, duration: 1.5, position: .center)
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
        
        func nokri_jobDataParser(jobsArr:NSArray){
            self.candidateArray.removeAllObjects()
            for item in jobsArr{
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
                self.candidateArray.add(arrayOfDictionaries);
            }
        }
        
        func nokri_canDataWithFilters(){
            
            var langCode = UserDefaults.standard.string(forKey: "langCode")
            if langCode == nil {
                langCode = "en"
            }
            
            var isTimeOut = false
            self.showLoader()
            var email = ""
            var password = ""
            let isLocation = UserDefaults.standard.bool(forKey: "locationSelected")
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
                var params : [String:Any] = [:]
                if isType == true{
                    params["emp_skills"] = typeInt
                }
                if isLocation == true{
                     params["emp_location"] = btnCountry.tag
                }
                params["emp_title"] = txtSearchKeywordField.text!
                params["page_number"] = "1"
                print(params)
                Alamofire.request(Constants.URL.baseUrl+Constants.URL.employerSearch, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
                    .responseJSON { response in
                        guard let res = response.value else{return}
                        let responseData = res as! NSDictionary
                        self.message = responseData["message"] as? String
                        let success = responseData["success"] as! Bool
                        if success == true{
                            isTimeOut = true
                            var pageTitle:String?
                            
                            let data = responseData["data"] as! NSDictionary
                            if let page = data["page_title"]  as? String{
                                pageTitle = page
                            }
                            if let JobArr = data["candidates"] as? NSArray {
                                self.nokri_jobDataParserWithFilters(jobsArr: JobArr)
                            }
                            if let pagination = responseData["pagination"] as? NSDictionary{
                                self.hasNextPage = pagination["has_next_page"] as? Bool
                                self.nextPage = pagination["next_page"] as? Int
                            }
                            if self.hasNextPage == true{
                                print(self.hasNextPage!)
                                //self.btnLoadMore.isHidden = false
                            }
                            print(self.nextPage!)
                            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "EmployerSearchedViewController") as! EmployerSearchedViewController
                            nextViewController.isFromFilter = true
                            nextViewController.canArray = self.candidateArray
                            nextViewController.typeInt = self.typeInt
                            nextViewController.countryInt = self.btnCountry.tag
                            nextViewController.hasNextPage = self.hasNextPage!
                            nextViewController.nextPage = self.nextPage
                            nextViewController.pageTitle = pageTitle
                            nextViewController.message = self.message
                            nextViewController.pageTitle = self.pageTitle
                            self.navigationController?.pushViewController(nextViewController, animated: true)
                            
                            
                        }else{
                            let hud = JGProgressHUD(style: .dark)
                            hud.textLabel.text = self.message!
                            hud.detailTextLabel.text = nil
                            hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                            hud.position = .bottomCenter
                            hud.show(in: self.view)
                            hud.dismiss(afterDelay: 2.0)
                            //self.view.makeToast(self.message, duration: 1.5, position: .center)
                        }
                        self.stopAnimating()
                        if isTimeOut == false{
                            DispatchQueue.main.asyncAfter(deadline: .now() + 30) {
                                self.stopAnimating()
                                self.view.makeToast("Network Time out", duration: 1.5, position: .center)
                            }
                        }
                }
                UserDefaults.standard.set(false, forKey: "locationSelected")
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
                var params : [String:Any] = [:]
                if isType == true{
                    params["emp_skills"] = typeInt
                }
                if isLocation == true{
                    params["emp_location"] = btnCountry.tag
                }
                params["emp_title"] = txtSearchKeywordField.text!
                params["page_number"] = "1"
                print(params)
                Alamofire.request(Constants.URL.baseUrl+Constants.URL.employerSearch, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
                    .responseJSON { response in
                        guard let res = response.value else{return}
                        let responseData = res as! NSDictionary
                        self.message = responseData["message"] as? String
                        let success = responseData["success"] as! Bool
                        if success == true{
                            isTimeOut = true
                            var pageTitle:String?
                            
                            let data = responseData["data"] as! NSDictionary
                            if let page = data["page_title"]  as? String{
                                pageTitle = page
                            }
                            if let JobArr = data["candidates"] as? NSArray {
                                self.nokri_jobDataParserWithFilters(jobsArr: JobArr)
                            }
                            if let pagination = responseData["pagination"] as? NSDictionary{
                                self.hasNextPage = pagination["has_next_page"] as? Bool
                                self.nextPage = pagination["next_page"] as? Int
                            }
                            if self.hasNextPage == true{
                                print(self.hasNextPage!)
                                //self.btnLoadMore.isHidden = false
                            }
                            print(self.nextPage!)
                            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "EmployerSearchedViewController") as! EmployerSearchedViewController
                            nextViewController.isFromFilter = true
                            nextViewController.canArray = self.candidateArray
                            nextViewController.typeInt = self.typeInt
                            nextViewController.hasNextPage = self.hasNextPage!
                            nextViewController.countryInt = self.btnCountry.tag
                            nextViewController.nextPage = self.nextPage
                            nextViewController.pageTitle = pageTitle
                            nextViewController.message = self.message
                            nextViewController.pageTitle = self.pageTitle
                            self.navigationController?.pushViewController(nextViewController, animated: true)
                            
                        }else{
                            let hud = JGProgressHUD(style: .dark)
                            hud.textLabel.text = self.message!
                            hud.detailTextLabel.text = nil
                            hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                            hud.position = .bottomCenter
                            hud.show(in: self.view)
                            hud.dismiss(afterDelay: 2.0)
                            //self.view.makeToast(self.message, duration: 1.5, position: .center)
                        }
                        self.stopAnimating()
                        if isTimeOut == false{
                            DispatchQueue.main.asyncAfter(deadline: .now() + 30) {
                                self.stopAnimating()
                                self.view.makeToast("Network Time out", duration: 1.5, position: .center)
                            }
                        }
                }
                UserDefaults.standard.set(false, forKey: "locationSelected")
            }
        }
        
        func nokri_jobDataParserWithFilters(jobsArr:NSArray){
            self.candidateArray.removeAllObjects()
            for item in jobsArr{
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
                self.candidateArray.add(arrayOfDictionaries);
            }
        }
      
        func nokri_jobLoctData(){
            
            var langCode = UserDefaults.standard.string(forKey: "langCode")
            if langCode == nil {
                langCode = "en"
            }
            
            var email = ""
            var password = ""
            
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
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.location, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    
                    guard let res = response.value else{return}
                    let responseData = res as! NSDictionary
                    let success = responseData["success"] as! Bool
                    if success == true{
                        let customLocation = responseData["custom_location"] as! NSDictionary
                        let jobCountry = customLocation["job_country"] as! NSDictionary
                        let jobCountryKey = jobCountry["key"] as! String
                        self.lblCountryKey.text = jobCountryKey
                        if let countryArr = jobCountry["value"] as? NSArray {
                            self.nokri_countryDataParser(countryArr: countryArr)
                        }
                    }else{
                    }
                    self.stopAnimating()
            }
        }
        
        func nokri_countryDataParser(countryArr:NSArray){
            self.countryArray.removeAllObjects()
            for item in countryArr{
                self.countryArray.add(item)
            }
        }
        
    }
