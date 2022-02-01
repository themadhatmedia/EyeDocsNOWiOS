//
//  JobPostLocationViewController.swift
//  Nokri
//
//  Created by apple on 8/2/19.
//  Copyright © 2019 Furqan Nadeem. All rights reserved.
//

import UIKit
import DropDown
import Alamofire
import JGProgressHUD

class JobPostLocationViewController: UIViewController {

    
    @IBOutlet weak var btnBack: UIButton!
    
    
    @IBOutlet weak var viewCountry: UIView!
    @IBOutlet weak var viewCountrry: UIView!
    @IBOutlet weak var viewState: UIView!
    @IBOutlet weak var viewCity: UIView!
    @IBOutlet weak var viewTown: UIView!
    
    @IBOutlet weak var dropDownCountry: UIButton!
    @IBOutlet weak var dropDownState: UIButton!
    @IBOutlet weak var dropDownCity: UIButton!
    @IBOutlet weak var dropDownTown: UIButton!
    
    @IBOutlet weak var lblSelectCountryCity: UILabel!
    @IBOutlet weak var lblCountryValue: UILabel!
    @IBOutlet weak var lblStateValue: UILabel!
    @IBOutlet weak var lblCityValue: UILabel!
    @IBOutlet weak var lblTownValue: UILabel!
    
    @IBOutlet weak var lblCountry: UILabel!
    @IBOutlet weak var lblState: UILabel!
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var lblTown: UILabel!
    
    
    @IBOutlet weak var iconDropDownCountry: UIImageView!
    @IBOutlet weak var iconDropDownState: UIImageView!
    @IBOutlet weak var iconDropDownCity: UIImageView!
    @IBOutlet weak var iconDropDownTown: UIImageView!
    
    
    
    
    
    
    
    //MARK:- Poporties
    
    var footerView = UIView()
    var job_Id:Int?
    var countryArray = NSMutableArray()
    var statArray = NSMutableArray()
    var cityArray = NSMutableArray()
    var townArray = NSMutableArray()
    
    var isCountryShow:Bool?
    var isCountrySh:Bool?
    var isStateShow:Bool?
    var isStateSh:Bool?
    var isCityShow:Bool?
    var isCitySh:Bool?
    var appColorNew = UserDefaults.standard.string(forKey: "app_Color")
    
    var dropDownCountr = DropDown()
    var dropDownStat = DropDown()
    var dropDownCit = DropDown()
    var dropDownTow = DropDown()
    
    
    @IBOutlet weak var heightConstraintViewCountry: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

          nokri_jobPostData()
          nokri_dropDownIcons()
        
        
    }
    

    //MARK:- IBAction
    
    
    @IBAction func btnBackClicked(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    

    func nokri_dropDownIcons(){
    
        iconDropDownCountry.image = iconDropDownCountry.image?.withRenderingMode(.alwaysTemplate)
        iconDropDownCountry.tintColor = UIColor(hex: appColorNew!)
        iconDropDownState.image = iconDropDownState.image?.withRenderingMode(.alwaysTemplate)
        iconDropDownState.tintColor = UIColor(hex: appColorNew!)
        iconDropDownCity.image = iconDropDownCity.image?.withRenderingMode(.alwaysTemplate)
        iconDropDownCity.tintColor = UIColor(hex: appColorNew!)
        iconDropDownTown.image = iconDropDownTown.image?.withRenderingMode(.alwaysTemplate)
        iconDropDownTown.tintColor = UIColor(hex: appColorNew!)
        
    }
    
    
    @IBAction func btnDropDownCountryClicked(_ sender: UIButton) {
        dropDownCountr.show()
    }
    
    @IBAction func btnDropDownStateClicked(_ sender: UIButton) {
        dropDownStat.show()
    }
    
    @IBAction func btnDropDownCityClicked(_ sender: UIButton) {
        dropDownCit.show()
    }
    
    @IBAction func btnDropDownTownClicked(_ sender: UIButton) {
        dropDownTow.show()
    }
    
    
    
    
    func nokri_dropDownSetup(){
        
        var countrID:Int?
        var countryArr = [String]()
        var countryChildArr = [Bool]()
        var countryKeyArr = [Int]()
        //var isCountrySelected:Bool?
        //var txtCountry:String?
        let country = self.countryArray as? [NSDictionary]
        
        for itemDict in country! {
            if let catObj = itemDict["value"] as? String{
                if catObj == ""{
                    continue
                }
                countryArr.append(catObj)
            }
            if let keyObj = itemDict["key"] as? Int{
                countrID = keyObj
                dropDownCountr.tag = keyObj
                countryKeyArr.append(keyObj)
            }
            if let hasChild = itemDict["has_child"] as? Bool{
                print(hasChild)
                if hasChild == true {
                    // childCategories(id: catID!)
                }
                countryChildArr.append(hasChild)
            }
        
        }
        dropDownCountr.dataSource = countryArr
        self.lblCountryValue.text = countryArr[0]
        let selectCo = UserDefaults.standard.bool(forKey: "selectedCo")
        let itemCo = UserDefaults.standard.string(forKey: "itemCo")
        if selectCo == true{
            self.lblCountryValue.text = itemCo
        }
        self.dropDownCountr.tag = countryKeyArr[0]
        dropDownCountr.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            
            self.lblCountryValue.text = item
            self.dropDownCountr.tag = countryKeyArr[index]
            if countryChildArr[index] == true{
                UserDefaults.standard.set(true, forKey: "selectedCo")
                UserDefaults.standard.set(item, forKey: "itemCo")
                self.nokri_countryCategories(id: countryKeyArr[index])
                self.lblCountryValue.text = item
                
                if self.isCountryShow == true{
                    
                    self.nokri_countryCategories(id: countryKeyArr[index])
                    self.viewState.isHidden = false
                    self.heightConstraintViewCountry.constant += 75
                    //self.heightConstraintMainSubView.constant += 100
                    //self.heightConstraintMainView.constant += 100
                    self.isCountryShow = false
                    self.isCountrySh = false
                    
                }
                
            }
            else
            {
                if self.viewState.isHidden == false && self.viewCity.isHidden == false && self.viewTown.isHidden == false {
                    self.viewState.isHidden = true
                    self.viewCity.isHidden = true
                    self.viewTown.isHidden = true
                    self.heightConstraintViewCountry.constant -= 220
                    //self.heightConstraintMainView.constant -= 200
                    //self.heightConstraintMainSubView.constant -= 200
                    self.isCountryShow = true
                    self.isCountrySh = true
                    self.isStateSh = true
                    self.isStateShow = true
                }
                if self.isCountryShow == false && self.isCountrySh == false {
                    self.heightConstraintViewCountry.constant -= 150
                    //self.heightConstraintMainView.constant -= 75
                    //self.heightConstraintMainSubView.constant -= 75
                    self.viewState.isHidden = true
                    self.isCountryShow = true
                    self.isCountrySh = true
                    
                }
                
            }
        }
        
        var stateId:Int?
        var stateArr = [String]()
        var stateChildArr = [Bool]()
        var stateKeyArr = [Int]()
        var isStateSelected:Bool?
        var txtState:String?
        let state = self.statArray as? [NSDictionary]
        
        for itemDict in state! {
            if let catObj = itemDict["value"] as? String{
                if catObj == ""{
                    continue
                }
                stateArr.append(catObj)
            }
            if let keyObj = itemDict["key"] as? Int{
                stateId = keyObj
                dropDownStat.tag = keyObj
                stateKeyArr.append(keyObj)
            }
            if let hasChild = itemDict["has_child"] as? Bool{
                print(hasChild)
                if hasChild == true {
                    // childCategories(id: catID!)
                }
                stateChildArr.append(hasChild)
            }
            if let selected = itemDict["selected"] as? Bool{
                isStateSelected = selected
                if isStateSelected == true{
                    if let catObj = itemDict["value"] as? String{
                        txtState = catObj
                        break
                    }
                }
                
            }
        }
        dropDownStat.dataSource = stateArr
        // self.lblStateValue.text = stateArr[0]
        if isStateSelected == true{
            self.lblStateValue.text = txtState
        }else{
            //self.lblStateValue.text = stateArr[0]
        }
        
        dropDownStat.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.dropDownStat.tag = stateKeyArr[index]
            self.lblStateValue.text = item
            if stateChildArr[index] == true{
                self.nokri_cityCategories(id: stateKeyArr[index])
                if self.isStateShow == true{
                    
                    self.nokri_cityCategories(id: stateKeyArr[index])
                    self.viewCity.isHidden = false
                    self.heightConstraintViewCountry.constant += 75
                    //self.heightConstraintMainView.constant += 75
                    //self.heightConstraintMainSubView.constant += 90
                    self.isStateShow = false
                    self.isStateSh = false
                    
                    if self.isStateShow == false && self.isStateSh == false{
                        self.isStateShow = true
                        self.isStateSh = true
                    }
                    
                }
            }
            else
            {
                if  self.isStateShow == false && self.isStateSh == false {
                    self.heightConstraintViewCountry.constant -= 75
                    //self.heightConstraintMainView.constant -= 75
                    //self.heightConstraintMainSubView.constant -= 75
                    self.viewState.isHidden = true
                    self.isStateShow = true
                    self.isStateSh = true
                    
                }
                
            }
        }
        
        var cityId:Int?
        var cityArr = [String]()
        var cityChildArr = [Bool]()
        var cityKeyArr = [Int]()
        var isCitySelected:Bool?
        var txtCity:String?
        let city = self.cityArray as? [NSDictionary]
        
        for itemDict in city! {
            if let catObj = itemDict["value"] as? String{
                if catObj == ""{
                    continue
                }
                cityArr.append(catObj)
            }
            if let keyObj = itemDict["key"] as? Int{
                cityId = keyObj
                dropDownCit.tag = keyObj
                cityKeyArr.append(keyObj)
            }
            if let hasChild = itemDict["has_child"] as? Bool{
                print(hasChild)
                if hasChild == true {
                    // childCategories(id: catID!)
                }
                cityChildArr.append(hasChild)
            }
            if let selected = itemDict["selected"] as? Bool{
                isCitySelected = selected
                if isCitySelected == true{
                    if let catObj = itemDict["value"] as? String{
                        txtCity = catObj
                        break
                    }
                }
            }
        }
        
        dropDownCit.dataSource = cityArr
        //self.lblCityValue.text = cityArr[0]
        if isCitySelected == true{
            self.lblCityValue.text = txtCity
        }else{
            //self.lblCityValue.text = cityArr[0]
        }
        dropDownCit.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.dropDownCit.tag = cityKeyArr[index]
            self.nokri_townCategories(id: cityKeyArr[index])
            self.lblCityValue.text = item
            if cityChildArr[index] == true{
                
                if self.isStateShow == true{
                    self.nokri_cityCategories(id: cityKeyArr[index])
                    self.viewTown.isHidden = false
                    self.heightConstraintViewCountry.constant += 75
                    //self.heightConstraintMainSubView.constant += 75
                    self.isStateShow = false
                    self.isStateSh = false
                }
            }
            else
            {
                
                if  self.isStateShow == false && self.isStateSh == false {
                    self.heightConstraintViewCountry.constant -= 75
                    //self.heightConstraintMainSubView.constant -= 75
                    self.viewState.isHidden = true
                    self.isStateShow = true
                    self.isStateSh = true
                    
                }
                
            }
        }
        
        dropDownCit.dataSource = cityArr
        dropDownCit.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            
            self.dropDownCit.tag = cityKeyArr[index]
            self.lblCityValue.text = item
            if cityChildArr[index] == true{
                
                if self.isCityShow == true{
                    self.nokri_townCategories(id: cityKeyArr[index])
                    self.viewTown.isHidden = false
                    self.heightConstraintViewCountry.constant += 75
                    //self.heightConstraintMainSubView.constant += 75
                    self.isCityShow = false
                    self.isCitySh = false
                }
            }
            else
            {
                
                if  self.isCityShow == false && self.isCitySh == false {
                    self.heightConstraintViewCountry.constant -= 75
                    //self.heightConstraintMainSubView.constant -= 75
                    self.viewTown.isHidden = true
                    self.isCityShow = true
                    self.isCitySh = true
                    
                }
            }
        }
        
        var townId:Int?
        var townArr = [String]()
        var townChildArr = [Bool]()
        var townKeyArr = [Int]()
        var isTownSelected:Bool?
        var txtTown:String?
        let town = self.townArray as? [NSDictionary]
        
        for itemDict in town! {
            if let catObj = itemDict["value"] as? String{
                if catObj == ""{
                    continue
                }
                townArr.append(catObj)
            }
            if let keyObj = itemDict["key"] as? Int{
                townId = keyObj
                dropDownTow.tag = keyObj
                townKeyArr.append(keyObj)
            }
            if let hasChild = itemDict["has_child"] as? Bool{
                print(hasChild)
                if hasChild == true {
                    // childCategories(id: catID!)
                }
                townChildArr.append(hasChild)
            }
            if let selected = itemDict["selected"] as? Bool{
                isTownSelected = selected
                if isTownSelected == true{
                    if let catObj = itemDict["value"] as? String{
                        txtTown = catObj
                        break
                    }
                }
            }
        }
        dropDownTow.dataSource = townArr
        // self.lblTownValue.text = townArr[0]
        if isTownSelected == true{
            self.lblTownValue.text = txtTown
        }else{
            //self.lblTownValue.text = townArr[0]
        }
        dropDownTow.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.dropDownTow.tag = townKeyArr[index]
            self.lblTownValue.text = item
            if townChildArr[index] == true{
                
            }
            else
            {
                
            }
        }
        

        dropDownCountr.anchorView = dropDownCountry
        dropDownStat.anchorView = dropDownState
        dropDownCit.anchorView = dropDownCity
        dropDownTow.anchorView = dropDownTown
        
        
        DropDown.startListeningToKeyboard()
        DropDown.appearance().textColor = UIColor.black
        DropDown.appearance().textFont = UIFont.systemFont(ofSize: 12)
        DropDown.appearance().backgroundColor = UIColor.white
        DropDown.appearance().selectionBackgroundColor = UIColor(hex:appColorNew!)
        DropDown.appearance().cellHeight = 40
        
        
        
    }
    
    
    
    func nokri_countryCategories(id:Int){
        
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
                "country_id": id,
            ]
            print(param)
            
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.countryCat, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    
                    let responseData = response.value as! NSArray
                    print(responseData)
                    
                    self.nokri_stateDataParser(stateArr: responseData)
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
                "country_id": id,
            ]
            print(param)
            
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.countryCat, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    
                    let responseData = response.value as! NSArray
                    print(responseData)
                    
                    self.nokri_stateDataParser(stateArr: responseData)
                    self.nokri_dropDownSetup()
                    self.stopAnimating()
                    
            }
        }
        
        
    }
    
    func nokri_stateDataParser(stateArr:NSArray){
        
        self.statArray.removeAllObjects()
        for item in stateArr{
            self.statArray.add(item)
        }
        
    }
    
    func nokri_cityCategories(id:Int){
        
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
                "country_id": id,
            ]
            print(param)
            
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.countryCat, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    
                    let responseData = response.value as! NSArray
                    print(responseData)
                    
                    self.nokri_cityDataParser(cityArr: responseData)
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
                "country_id": id,
            ]
            print(param)
            
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.countryCat, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    
                    let responseData = response.value as! NSArray
                    print(responseData)
                    
                    self.nokri_cityDataParser(cityArr: responseData)
                    self.nokri_dropDownSetup()
                    self.stopAnimating()
                    
            }
        }
        
        
    }
    
    func nokri_cityDataParser(cityArr:NSArray){
        
        self.cityArray.removeAllObjects()
        for item in cityArr{
            self.cityArray.add(item)
        }
        
    }
    
    func nokri_townCategories(id:Int){
        
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
                "country_id": id,
            ]
            print(param)
            
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.countryCat, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    
                    let responseData = response.value as! NSArray
                    print(responseData)
                    
                    self.nokri_townDataParser(townArr: responseData)
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
                "country_id": id,
            ]
            print(param)
            
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.countryCat, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    
                    let responseData = response.value as! NSArray
                    print(responseData)
                    
                    self.nokri_townDataParser(townArr: responseData)
                    self.nokri_dropDownSetup()
                    self.stopAnimating()
                    
            }
            
        }
        
        
    }
    
    func nokri_townDataParser(townArr:NSArray){
        
        self.townArray.removeAllObjects()
        for item in townArr{
            self.townArray.add(item)
        }
        
    }
   
    func nokri_jobPostDataFromEdit(){
        
        var langCode = UserDefaults.standard.string(forKey: "langCode")
        if langCode == nil {
            langCode = "en"
        }
        
        self.showLoader()
        //var lati = ""
        //var longi = ""
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
                "job_id": job_Id!,
                "is_update": job_Id!
            ]
            print(param)
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.postJobFromEdit, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers)
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
                        let form = data["job_form"] as? Bool
                        if form == true{
                            print("Default...!")
                        }else{
                            let jobPostCustom = self.storyboard?.instantiateViewController(withIdentifier: "JobPostCustomViewController") as! JobPostCustomViewController
                            self.navigationController?.pushViewController(jobPostCustom, animated: false)
                            self.stopAnimating()
                            return
                        }
                 
             
                        
//                        let location = data["job_location_head"] as! NSDictionary
//                        if let loc = location["key"]{
//                            self.lblLocationOnMap.text = loc as? String
//
//                        }
//                        let setLocation = data["job_loc"] as! NSDictionary
//                        if let setLoc = setLocation["key"]{
//                            self.txtLocation.placeholder = setLoc as? String
//
//                        }
//                        let latitude = data["job_lat"] as! NSDictionary
//                        if let lat = latitude["key"]{
//                            self.txtLatitude.text = lat as? String
//                            self.txtLatitude.placeholder = lat as? String
//                            self.lblLat.text = lat as? String
//                            lati = (lat as? String)!
//                        }
//                        let longitude = data["job_long"] as! NSDictionary
//                        if let long = longitude["key"]{
//                            self.txtLongitude.text = long as? String
//                            self.txtLongitude.placeholder = long as? String
//                            self.lblLong.text = long as? String
//                            longi = (long as? String)!
//
//                        }
                      

//                        if let premiumArray = data["premium_jobs"] as? NSArray {
//                            self.nokri_premiumJobParser(premArray: premiumArray)
//                        }
                        
                        
                        let jobLocation = data["job_location"] as! NSDictionary
                        let jobLocationKey = jobLocation["key"] as! String
                        self.lblSelectCountryCity.text = jobLocationKey
                        
                        
                        let jobCountry = data["job_country"] as! NSDictionary
                        let jobCountryKey = jobCountry["key"] as! String
                        self.lblCountry.text = jobCountryKey
                        if let countryArr = jobCountry["value"] as? NSArray {
                            self.nokri_countryDataParser(countryArr: countryArr)
                        }
                        
                        let state = data["job_state"] as! NSDictionary
                        let stateKey = state["key"] as! String
                        self.lblState.text = stateKey
                        
                        let city = data["job_city"] as! NSDictionary
                        let cityKey = city["key"] as! String
                        self.lblCity.text = cityKey
                        
                        let town = data["job_town"] as! NSDictionary
                        let townKey = town["key"] as! String
                        self.lblTown.text = townKey
                        
                        //self.nokri_map(lat: lati, long: longi)
                        self.nokri_dropDownSetup()
                    
                    }else{
                        let hud = JGProgressHUD(style: .dark)
                        hud.textLabel.text = messageResponse
                        hud.detailTextLabel.text = nil
                        hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                        hud.position = .bottomCenter
                        hud.show(in: self.view)
                        hud.dismiss(afterDelay: 2.0)

                        //self.view.makeToast(messageResponse, duration: 1.5, position: .center)
                        self.perform(#selector(self.nokri_showBuyPackages), with: nil, afterDelay: 2)
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
                "job_id": job_Id!,
                "is_update": job_Id!
            ]
            print(param)
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.postJobFromEdit, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    
                    guard let res = response.value else{return}
                    
                    let responseData = res as! NSDictionary
                    let success = responseData["success"] as! Bool
                    let messageResponse = responseData["message"] as! String
                    if success == true{
                        //var lat = ""
                        //var long = ""
                        let data = responseData["data"] as! NSDictionary
                        let job_id = data["job_id"]
                        UserDefaults.standard.set(job_id, forKey: "JobId")
                        print(job_id!)
                        
                        let form = data["job_form"] as? Bool
                        if form == true{
                            print("Default...!")
                        }else{
                            let jobPostCustom = self.storyboard?.instantiateViewController(withIdentifier: "JobPostCustomViewController") as! JobPostCustomViewController
                            self.navigationController?.pushViewController(jobPostCustom, animated: false)
                            self.stopAnimating()
                            return
                        }
             
                        
                        
                        
                        
//                        let location = data["job_location_head"] as! NSDictionary
//                        if let loc = location["key"]{
//                            self.lblLocationOnMap.text = loc as? String
//
//                        }
//                        let setLocation = data["job_loc"] as! NSDictionary
//                        if let setLoc = setLocation["key"]{
//                            self.txtLocation.placeholder = setLoc as? String
//
//                        }
//                        let latitude = data["job_lat"] as! NSDictionary
//                        if let lat = latitude["key"]{
//                            self.txtLatitude.text = lat as? String
//                            self.txtLatitude.placeholder = lat as? String
//                            self.lblLat.text = lat as? String
//                            lati = (lat as? String)!
//
//                        }
//                        let longitude = data["job_long"] as! NSDictionary
//                        if let long = longitude["key"]{
//                            self.txtLongitude.text = long as? String
//                            self.txtLongitude.placeholder = long as? String
//                            self.lblLong.text = long as? String
//                            longi = (long as? String)!
//
//                        }
                        
                        
                   
//                        if let premiumArray = data["premium_jobs"] as? NSArray {
//                            self.nokri_premiumJobParser(premArray: premiumArray)
//                        }
                        
                        
                     
                        let jobLocation = data["job_location"] as! NSDictionary
                        let jobLocationKey = jobLocation["key"] as! String
                        self.lblSelectCountryCity.text = jobLocationKey
                        
                        
                        let jobCountry = data["job_country"] as! NSDictionary
                        let jobCountryKey = jobCountry["key"] as! String
                        self.lblCountry.text = jobCountryKey
                        if let countryArr = jobCountry["value"] as? NSArray {
                            self.nokri_countryDataParser(countryArr: countryArr)
                        }
                        
                        let state = data["job_state"] as! NSDictionary
                        let stateKey = state["key"] as! String
                        self.lblState.text = stateKey
                        
                        let city = data["job_city"] as! NSDictionary
                        let cityKey = city["key"] as! String
                        self.lblCity.text = cityKey
                        
                        let town = data["job_town"] as! NSDictionary
                        let townKey = town["key"] as! String
                        self.lblTown.text = townKey
                        
                        //self.nokri_map(lat: lati, long: longi)
                        self.nokri_dropDownSetup()
                       
                        
                        
                    }else{
                        let hud = JGProgressHUD(style: .dark)
                        hud.textLabel.text = messageResponse
                        hud.detailTextLabel.text = nil
                        hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                        hud.position = .bottomCenter
                        hud.show(in: self.view)
                        hud.dismiss(afterDelay: 2.0)

                        //self.view.makeToast(messageResponse, duration: 1.5, position: .center)
                        self.perform(#selector(self.nokri_showBuyPackages), with: nil, afterDelay: 2)
                    }
                    
                    self.stopAnimating()
            }
        }
        
        
        
    }
    
    func nokri_countryDataParser(countryArr:NSArray){
        
        self.countryArray.removeAllObjects()
        for item in countryArr{
            self.countryArray.add(item)
        }
        
    }
    
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
                        
                        let form = data["job_form"] as? Bool
                        if form == true{
                            print("Default...!")
                        }else{
                            let jobPostCustom = self.storyboard?.instantiateViewController(withIdentifier: "JobPostCustomViewController") as! JobPostCustomViewController
                            self.navigationController?.pushViewController(jobPostCustom, animated: false)
                            self.stopAnimating()
                            return
                            
                        }
         
            
//                        let location = data["job_location_head"] as! NSDictionary
//                        if let loc = location["key"]{
//                            self.lblLocationOnMap.text = loc as? String
//
//                        }
//                        let setLocation = data["job_loc"] as! NSDictionary
//                        if let setLoc = setLocation["key"]{
//                            self.txtLocation.placeholder = setLoc as? String
//
//                        }
//                        let latitude = data["job_lat"] as! NSDictionary
//                        if let lat = latitude["key"]{
//                            self.txtLatitude.text = lat as? String
//                            self.txtLatitude.placeholder = lat as? String
//                            self.lblLat.text = lat as? String
//                            lati = (lat as? String)!
//                        }
//                        let longitude = data["job_long"] as! NSDictionary
//                        if let long = longitude["key"]{
//                            self.txtLongitude.text = long as? String
//                            self.txtLongitude.placeholder = long as? String
//                            self.lblLong.text = long as? String
//                            longi = (long as? String)!
//
//                        }
                        
                        
                 
//                        let job_boost = data["job_boost"] as! NSDictionary
//                        if let jobBost = job_boost["key"]{
//                            self.lblBoostJob.text = jobBost as? String
//
//                        }
//                        if let premiumArray = data["premium_jobs"] as? NSArray {
//                            self.nokri_premiumJobParser(premArray: premiumArray)
//                        }
                        
                        
                     
                        let jobLocation = data["job_location"] as! NSDictionary
                        let jobLocationKey = jobLocation["key"] as! String
                        self.lblSelectCountryCity.text = jobLocationKey
                        
                        
                        let jobCountry = data["job_country"] as! NSDictionary
                        let jobCountryKey = jobCountry["key"] as! String
                        self.lblCountry.text = jobCountryKey
                        if let countryArr = jobCountry["value"] as? NSArray {
                            self.nokri_countryDataParser(countryArr: countryArr)
                        }
                        
                        let state = data["job_state"] as! NSDictionary
                        let stateKey = state["key"] as! String
                        self.lblState.text = stateKey
                        
                        let city = data["job_city"] as! NSDictionary
                        let cityKey = city["key"] as! String
                        self.lblCity.text = cityKey
                        
                        let town = data["job_town"] as! NSDictionary
                        let townKey = town["key"] as! String
                        self.lblTown.text = townKey
                        
                        self.nokri_dropDownSetup()
    
                        
                        
                    }else{
                        let hud = JGProgressHUD(style: .dark)
                        hud.textLabel.text = messageResponse
                        hud.detailTextLabel.text = nil
                        hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                        hud.position = .bottomCenter
                        hud.show(in: self.view)
                        hud.dismiss(afterDelay: 2.0)

                        //self.view.makeToast(messageResponse, duration: 1.5, position: .center)
                        self.perform(#selector(self.nokri_showBuyPackages), with: nil, afterDelay: 2)
                    }
                    //self.nokri_map(lat: lati, long: longi)
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
                        
                        let form = data["job_form"] as? Bool
                        if form == false{
                            print("Default...!")
                        }else{
                            let jobPostCustom = self.storyboard?.instantiateViewController(withIdentifier: "JobPostCustomViewController") as! JobPostCustomViewController
                            self.navigationController?.pushViewController(jobPostCustom, animated: false)
                            self.stopAnimating()
                            return
                            
                        }
                        
                        
                      
//                        let location = data["job_location_head"] as! NSDictionary
//                        if let loc = location["key"]{
//                            self.lblLocationOnMap.text = loc as? String
//
//                        }
//                        let setLocation = data["job_loc"] as! NSDictionary
//                        if let setLoc = setLocation["key"]{
//                            self.txtLocation.placeholder = setLoc as? String
//
//                        }
//                        let latitude = data["job_lat"] as! NSDictionary
//                        if let lat = latitude["key"]{
//                            self.txtLatitude.text = lat as? String
//                            self.txtLatitude.placeholder = lat as? String
//                            self.lblLat.text = lat as? String
//                            lati = (lat as? String)!
//                        }
//                        let longitude = data["job_long"] as! NSDictionary
//                        if let long = longitude["key"]{
//                            self.txtLongitude.text = long as? String
//                            self.txtLongitude.placeholder = long as? String
//                            self.lblLong.text = long as? String
//                            longi = (long as? String)!
//
//                        }
                        
                        
                     
//                        let job_boost = data["job_boost"] as! NSDictionary
//                        if let jobBost = job_boost["key"]{
//                            self.lblBoostJob.text = jobBost as? String
//
//                        }
//                        if let premiumArray = data["premium_jobs"] as? NSArray {
//                            self.nokri_premiumJobParser(premArray: premiumArray)
//                        }
                        
                        
                      
                        let jobLocation = data["job_location"] as! NSDictionary
                        let jobLocationKey = jobLocation["key"] as! String
                        self.lblSelectCountryCity.text = jobLocationKey
                        
                        
                        let jobCountry = data["job_country"] as! NSDictionary
                        let jobCountryKey = jobCountry["key"] as! String
                        self.lblCountry.text = jobCountryKey
                        if let countryArr = jobCountry["value"] as? NSArray {
                            self.nokri_countryDataParser(countryArr: countryArr)
                        }
                        
                        let state = data["job_state"] as! NSDictionary
                        let stateKey = state["key"] as! String
                        self.lblState.text = stateKey
                        
                        let city = data["job_city"] as! NSDictionary
                        let cityKey = city["key"] as! String
                        self.lblCity.text = cityKey
                        
                        let town = data["job_town"] as! NSDictionary
                        let townKey = town["key"] as! String
                        self.lblTown.text = townKey
                        
                        self.nokri_dropDownSetup()
                     
                    }else{
                        let hud = JGProgressHUD(style: .dark)
                        hud.textLabel.text = messageResponse
                        hud.detailTextLabel.text = nil
                        hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                        hud.position = .bottomCenter
                        hud.show(in: self.view)
                        hud.dismiss(afterDelay: 2.0)

                        //self.view.makeToast(messageResponse, duration: 1.5, position: .center)
                        self.perform(#selector(self.nokri_showBuyPackages), with: nil, afterDelay: 2)
                    }
                    //self.nokri_map(lat: lati, long: longi)
                    self.stopAnimating()
            }
            
        }
        
        
    }
    
    @objc func nokri_showBuyPackages(){
        let buyPkgController = self.storyboard?.instantiateViewController(withIdentifier: "PackagesViewController") as! PackagesViewController
        self.navigationController?.pushViewController(buyPkgController, animated: true)
    }
    
    
    
}
