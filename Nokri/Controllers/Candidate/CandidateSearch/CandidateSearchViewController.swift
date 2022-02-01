//
//  CandidateSearchViewController.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 7/9/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import UIKit
import Alamofire
import DropDown
import JGProgressHUD

class CandidateSearchViewController: UIViewController{

    //MARK:- IBOutlets
    
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var lblSearchNow: UILabel!
    @IBOutlet weak var viewSearchKeyWord: UIView!
    @IBOutlet weak var viewType: UIView!
    @IBOutlet weak var viewExperience: UIView!
    @IBOutlet weak var viewLevel: UIView!
    @IBOutlet weak var viewSkill: UIView!
    @IBOutlet weak var viewCCS: UIView!
    @IBOutlet weak var viewCountry: UIView!
    @IBOutlet weak var viewState: UIView!
    @IBOutlet weak var viewCity: UIView!
    @IBOutlet weak var viewTown: UIView!
    @IBOutlet weak var lblTypeKey: UILabel!
    @IBOutlet weak var lblTypeValue: UILabel!
    @IBOutlet weak var btnType: UIButton!
    @IBOutlet weak var lblExpKey: UILabel!
    @IBOutlet weak var lblExpValue: UILabel!
    @IBOutlet weak var btnExp: UIButton!
    @IBOutlet weak var lblLevelKey: UILabel!
    @IBOutlet weak var lblLevelValue: UILabel!
    @IBOutlet weak var btnLevel: UIButton!
    @IBOutlet weak var lblSkillKey: UILabel!
    @IBOutlet weak var lblSkillValue: UILabel!
    @IBOutlet weak var btnSkill: UIButton!
    @IBOutlet weak var txtSearchKeywordField: UITextField!
    @IBOutlet weak var btnSearchKeyWord: UIButton!
    @IBOutlet weak var lblCountryKey: UILabel!
    @IBOutlet weak var lblCountryValue: UILabel!
    @IBOutlet weak var btnCountry: UIButton!
    @IBOutlet weak var lblStateKey: UILabel!
    @IBOutlet weak var lblStateValue: UILabel!
    @IBOutlet weak var btnState: UIButton!
    @IBOutlet weak var lblCityKey: UILabel!
    @IBOutlet weak var lblCityValue: UILabel!
    @IBOutlet weak var btnCity: UIButton!
    @IBOutlet weak var lblTownKey: UILabel!
    @IBOutlet weak var lblTownValue: UILabel!
    @IBOutlet weak var btnTown: UIButton!
    @IBOutlet weak var btnSearchNow: UIButton!
    @IBOutlet weak var heightConstraintCCT: NSLayoutConstraint!
    @IBOutlet weak var heightConstraintView: NSLayoutConstraint!
    @IBOutlet weak var heightContraintMain: NSLayoutConstraint!
    
    //MARK:- Proporties

    var appColorNew = UserDefaults.standard.string(forKey: "app_Color")
    let dropDownType = DropDown()
    let dropDownExperience = DropDown()
    let dropDownLevel = DropDown()
    let dropDownSkills = DropDown()
    let dropDownCountry = DropDown()
    var dropDownState = DropDown()
    let dropDownCity = DropDown()
    let dropDownTown = DropDown()
   
    var searchField = [CandidateSearchField]()
    var valueArray = [CandidateSearchValue]()
    var extraArray = [CandidateSearchExtra]()
    var selectOption:String?
    
    var message:String?
    var candidateArray = NSMutableArray()
    var typeInt:Int?
    var expInt:Int?
    var levelInt:Int?
    var skillInt:Int?
    var countryInt:Int?
    var stateInt:Int?
    var cityInt:Int?
    var townInt:Int?
    
    var categoryArray = [String]()
    var statArray = NSMutableArray()
    var cityArray = NSMutableArray()
    var townArray = NSMutableArray()
    
    var isShow2:Bool?
    var isShow:Bool?
    var isShowSecond:Bool?
    var isShowSec:Bool?
    var isShowThird:Bool?
    var isShowThi:Bool?
    
    var isType:Bool = false
    var isExp:Bool = false
    var isLevel:Bool = false
    var isSkill:Bool = false
    var isCountry:Bool = false
    var isState:Bool = false
    var isCity:Bool = false
    var isTown:Bool = false
    
    //MARK:- View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let isRtl = UserDefaults.standard.string(forKey: "isRtl")
        if isRtl == "0"{
            self.addLeftBarButtonWithImage(#imageLiteral(resourceName: "menu"))
        }else{
            self.addRightBarButtonWithImage(#imageLiteral(resourceName: "menu"))
        }
        candidateSearchData()
        boolChecks()
        viewShadow()
        heightConstraintCCT.constant -= 180
    }

    //MARK:- Custome Functions

    
    func boolChecks(){
        
        isShow2 = true
        isShow = true
        isShowSec = true
        isShowSecond = true
        isShowThi = true
        isShowThird = true
        
    }
    
    func populateData(){
        
        for obj in extraArray{
            if obj.fieldTypeName == "cand_search_now"{
                lblSearchNow.text = obj.key
                btnSearchNow.setTitle(obj.key, for: .normal)

            }
            if obj.fieldTypeName == "cand_search_title"{
                self.title = obj.key
            }
            if obj.fieldTypeName == "country"{
                lblCountryKey.text = obj.key
            }
            if obj.fieldTypeName == "city"{
                lblCityKey.text = obj.key
            }
            if obj.fieldTypeName == "state"{
               lblStateKey.text = obj.key
            }
            if obj.fieldTypeName == "town"{
                lblTownKey.text = obj.key
            }
        }
        
    }
    
    func dropDownSetup(){
  
        var typeKey = [Int]()
        for obj in searchField{
            
            if obj.key == "Type"{
                lblTypeKey.text = obj.key
                selectOption = obj.column
                lblTypeValue.text = selectOption
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
        
        
        var expKey = [Int]()
        for obj in searchField{
            
            if obj.key == "Experience"{
                lblExpKey.text = obj.key
                lblExpValue.text = selectOption
                categoryArray.removeAll()
                valueArray = obj.valueAr
                for innerObj in valueArray{
                    categoryArray.append(innerObj.value)
                    expKey.append(innerObj.key)
                }
            }
            
        }
        
        dropDownExperience.dataSource =  categoryArray
        dropDownExperience.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.lblExpValue.text = item
            self.isExp = true
            self.expInt = expKey[index]
            
        }
        
        
        var levelKey = [Int]()
        for obj in searchField{
            
            if obj.key == "Level"{
                lblLevelKey.text = obj.key
                lblLevelValue.text = selectOption
                categoryArray.removeAll()
                valueArray = obj.valueAr
                for innerObj in valueArray{
                    categoryArray.append(innerObj.value)
                    levelKey.append(innerObj.key)
                }
            }
            
        }
        
        dropDownLevel.dataSource =  categoryArray
        dropDownLevel.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.lblLevelValue.text = item
            self.isLevel = true
            self.levelInt = levelKey[index]
            
        }
        
        var skillKey = [Int]()
        for obj in searchField{
            
            if obj.key == "Skills"{
                lblSkillKey.text = obj.key
                lblSkillValue.text = selectOption
                categoryArray.removeAll()
                valueArray = obj.valueAr
                for innerObj in valueArray{
                    categoryArray.append(innerObj.value)
                    skillKey.append(innerObj.key)
                }
            }
            
        }
        
        dropDownSkills.dataSource =  categoryArray
        dropDownSkills.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.lblSkillValue.text = item
            self.isSkill = true
            self.skillInt = skillKey[index]
            
        }
        
        var countryKey = [Int]()
        var childArr = [Bool]()
      
        for obj in searchField{
            
            if obj.key == "Location"{
                
                lblCountryValue.text = selectOption
                categoryArray.removeAll()
                valueArray = obj.valueAr
                for innerObj in valueArray{
                    categoryArray.append(innerObj.value)
                    countryKey.append(innerObj.key)
                    childArr.append(innerObj.hasChild)
                }
            }
            //categoryArray.removeAll()
        }
        
        dropDownCountry.dataSource =  categoryArray
        dropDownCountry.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            
            self.lblCountryValue.text = item
            self.dropDownCountry.tag = countryKey[index]
            self.isCountry = true
            self.countryInt = countryKey[index]
            if childArr[index] == true{
                self.countryCategories(id: countryKey[index])
                self.lblCountryValue.text = item
                if self.isShow == true{
                    
                    self.countryCategories(id: countryKey[index])
                    self.lblCountryValue.text = item
                    self.viewState.isHidden = false
                    self.heightConstraintCCT.constant += 58
                    //self.heightConstraintView.constant += 58
                    //self.heightContraintMain.constant += 58
                    self.view.frame.size.height += 58
                    //self.view.layer.frame.size.height += 58
                    self.viewMain.frame.size.height += 58
                    self.isShow2 = false
                    self.isShow = false
                    
                }
                
            }else{
                
                if self.viewState.isHidden == false && self.viewCity.isHidden == false && self.viewTown.isHidden == false{
                    
                    self.viewState.isHidden = true
                    self.viewCity.isHidden = true
                    self.viewTown.isHidden = true
                    self.heightConstraintCCT.constant -= 180
                    //self.heightConstraintView.constant -= 180
                    self.view.frame.size.height -= 180
                    //self.view.layer.frame.size.height -= 180
                    self.viewMain.frame.size.height -= 180
                    //self.heightContraintMain.constant -= 180
                    self.isShow2 = true
                    self.isShow = true
                    self.isShowThi = true
                    self.isShowThird = true
                    self.isShowSec = true
                    self.isShowSecond = true
                    
                }
                if self.viewCity.isHidden == false && self.viewState.isHidden == false{
                    
                    self.viewState.isHidden = true
                    self.viewCity.isHidden = true
                    self.heightConstraintCCT.constant -= 120
                    //self.heightConstraintView.constant -= 120
                    self.view.frame.size.height -= 120
                    //self.view.layer.frame.size.height -= 120
                    self.viewMain.frame.size.height -= 120
                    //self.heightContraintMain.constant -= 120
                    self.isShow2 = true
                    self.isShow = true
                    self.isShowThi = true
                    self.isShowThird = true
                    self.isShowSec = true
                    self.isShowSecond = true
                    
                }
                if self.isShow == false && self.isShow2 == false {
                    
                    self.isShow = true
                    self.isShow2 = true
                    self.heightConstraintCCT.constant -= 58
                    //self.heightConstraintView.constant -= 58
                    self.view.frame.size.height -= 58
                    self.view.layer.frame.size.height -= 58
                    self.viewMain.frame.size.height -= 58
                    //self.heightContraintMain.constant -= 58
                    self.viewState.isHidden = true
                    
                }
                
            }
            
        }
     
        var statValue = [String]()
        var stateKey = [Int]()
        var stateChildArr = [Bool]()
        
        let subCategory = self.statArray as? [NSDictionary]
        for itemDict in subCategory! {
            if let catObj = itemDict["value"] as? String{
                if catObj == ""{
                    continue
                }
                statValue.append(catObj)
            }
            if let keyObj = itemDict["key"] as? Int{
                stateKey.append(keyObj)
            }
            if let hasChild = itemDict["has_child"] as? Bool{
                print(hasChild)
                if hasChild == true {
                    
                }
                stateChildArr.append(hasChild)
            }
        }
        self.lblStateValue.text = selectOption
        dropDownState.dataSource = statValue
        dropDownState.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
        
            self.isState = true
            self.lblStateValue.text = item
            self.dropDownState.tag = stateKey[index]
            self.countryInt = stateKey[index]
            if stateChildArr[index] == true{
                
                self.lblStateValue.text = item
                self.cityCategories(id: stateKey[index])
                if self.isShowSecond == true{
                   
                    self.lblStateValue.text = item
                    self.cityCategories(id: stateKey[index])
                    self.viewCity.isHidden = false
                    self.heightConstraintCCT.constant += 62
                    //self.heightConstraintView.constant += 62
                    self.view.frame.size.height += 62
                    //self.view.layer.frame.size.height += 62
                    self.viewMain.frame.size.height += 62
                    //self.heightContraintMain.constant += 62
                    self.isShowSec = false
                    self.isShowSecond = false
                    
                }
            }else{
                
                if self.viewCity.isHidden == false && self.viewTown.isHidden == false {
                    
                    self.viewCity.isHidden = true
                    self.viewTown.isHidden = true
                    self.heightConstraintCCT.constant -= 60
                    //self.heightConstraintView.constant -= 60
                    self.view.frame.size.height -= 60
                    //self.view.layer.frame.size.height -= 60
                    self.viewMain.frame.size.height -= 60
                    //self.heightContraintMain.constant -= 60
                    self.isShowSec = true
                    self.isShowSecond = true
                    
                }
                
                if self.isShowSecond == false && self.isShowSec == false{
                    
                    self.heightConstraintCCT.constant -= 62
                    //self.heightConstraintView.constant -= 62
                    self.view.frame.size.height -= 62
                    //self.view.layer.frame.size.height -= 62
                    self.viewMain.frame.size.height -= 62
                    //self.heightContraintMain.constant -= 62
                    self.viewCity.isHidden = true
                    self.isShowSec = true
                    self.isShowSecond = true
//                  self.isShowThird = true
//                  self.isShowThi = true
                    
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
        self.lblCityValue.text = selectOption
        dropDownCity.dataSource = cityValue
        dropDownCity.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.isCity = true
            self.lblCityValue.text = item
            self.dropDownCity.tag = cityKey[index]
            self.countryInt = cityKey[index]
            if cityChildArr[index] == true{
                self.lblCityValue.text = item
                self.townCategories(id: cityKey[index])
                if self.isShowThird == true{
                    self.lblCityValue.text = item
                    self.townCategories(id: cityKey[index])
                    self.viewTown.isHidden = false
                    self.heightConstraintCCT.constant += 62
                    //self.heightConstraintView.constant += 62
                    self.view.frame.size.height += 62
                    //self.view.layer.frame.size.height += 62
                    self.viewMain.frame.size.height += 62
                    //self.heightContraintMain.constant += 62
                    self.isShowThird = false
                    self.isShowThi = false
                }
            }else{
                
                
                if self.isShowThird == false && self.isShowThi == false{
                    
                    self.heightConstraintCCT.constant -= 62
                    //self.heightConstraintView.constant -= 62
                    self.view.frame.size.height -= 62
                    //self.view.layer.frame.size.height -= 62
                    self.viewMain.frame.size.height -= 62
                    //self.heightContraintMain.constant -= 62
                    self.viewCity.isHidden = true
                    self.isShowThird = true
                    self.isShowThi = true
                    
                }
            }
        }
        
        var townValue = [String]()
        var townKey = [Int]()
        var townChildArr = [Bool]()
        
        let townCategory = self.townArray as? [NSDictionary]
        for itemDict in townCategory! {
            if let catObj = itemDict["value"] as? String{
                if catObj == ""{
                    continue
                }
                townValue.append(catObj)
            }
            if let keyObj = itemDict["key"] as? Int{
                townKey.append(keyObj)

            if let hasChild = itemDict["has_child"] as? Bool{
                print(hasChild)
                if hasChild == true {
                    
                }
                townChildArr.append(hasChild)
            }
        }
        }
        self.lblTownValue.text = selectOption
        dropDownTown.dataSource = townValue
        dropDownTown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.countryInt = townKey[index]
            self.isTown = true
            self.lblTownValue.text = item
            self.dropDownTown.tag = townKey[index]
            self.isShow2 = true
            self.isShow = true
            self.isShowThi = true
            self.isShowThird = true
            self.isShowSec = true
            self.isShowSecond = true
            
        }
        
            dropDownType.anchorView = btnType
            dropDownLevel.anchorView = btnLevel
            dropDownSkills.anchorView = btnSkill
            dropDownExperience.anchorView = btnExp
            dropDownCountry.anchorView = btnCountry
            dropDownState.anchorView = btnState
            dropDownCity.anchorView = btnCity
            dropDownTown.anchorView = btnTown
            
            DropDown.startListeningToKeyboard()
            DropDown.appearance().textColor = UIColor.black
            DropDown.appearance().textFont = UIFont.systemFont(ofSize: 12)
            DropDown.appearance().backgroundColor = UIColor.white
            DropDown.appearance().selectionBackgroundColor = UIColor(hex:appColorNew!)
            DropDown.appearance().cellHeight = 40
    
    }
   
    func viewShadow(){
        
        viewSearchKeyWord.layer.borderColor = UIColor.gray.cgColor
        viewSearchKeyWord.layer.cornerRadius = 0
        viewSearchKeyWord.layer.shadowColor = UIColor(white: 0.0, alpha: 0.5).cgColor
        viewSearchKeyWord.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        viewSearchKeyWord.layer.shadowOpacity = 0.8
        viewSearchKeyWord.layer.shadowRadius = 2
        
        viewType.layer.borderColor = UIColor.gray.cgColor
        viewType.layer.cornerRadius = 0
        viewType.layer.shadowColor = UIColor(white: 0.0, alpha: 0.5).cgColor
        viewType.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        viewType.layer.shadowOpacity = 0.8
        viewType.layer.shadowRadius = 2
        
        viewExperience.layer.borderColor = UIColor.gray.cgColor
        viewExperience.layer.cornerRadius = 0
        viewExperience.layer.shadowColor = UIColor(white: 0.0, alpha: 0.5).cgColor
        viewExperience.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        viewExperience.layer.shadowOpacity = 0.8
        viewExperience.layer.shadowRadius = 2
        
        viewSkill.layer.borderColor = UIColor.gray.cgColor
        viewSkill.layer.cornerRadius = 0
        viewSkill.layer.shadowColor = UIColor(white: 0.0, alpha: 0.5).cgColor
        viewSkill.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        viewSkill.layer.shadowOpacity = 0.8
        viewSkill.layer.shadowRadius = 2
        
        viewLevel.layer.borderColor = UIColor.gray.cgColor
        viewLevel.layer.cornerRadius = 0
        viewLevel.layer.shadowColor = UIColor(white: 0.0, alpha: 0.5).cgColor
        viewLevel.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        viewLevel.layer.shadowOpacity = 0.8
        viewLevel.layer.shadowRadius = 2
        
        viewCountry.layer.borderColor = UIColor.gray.cgColor
        viewCountry.layer.cornerRadius = 0
        viewCountry.layer.shadowColor = UIColor(white: 0.0, alpha: 0.5).cgColor
        viewCountry.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        viewCountry.layer.shadowOpacity = 0.8
        viewCountry.layer.shadowRadius = 2
        
        viewState.layer.borderColor = UIColor.gray.cgColor
        viewState.layer.cornerRadius = 0
        viewState.layer.shadowColor = UIColor(white: 0.0, alpha: 0.5).cgColor
        viewState.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        viewState.layer.shadowOpacity = 0.8
        viewState.layer.shadowRadius = 2
        
        viewCity.layer.borderColor = UIColor.gray.cgColor
        viewCity.layer.cornerRadius = 0
        viewCity.layer.shadowColor = UIColor(white: 0.0, alpha: 0.5).cgColor
        viewCity.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        viewCity.layer.shadowOpacity = 0.8
        viewCity.layer.shadowRadius = 2
        
        viewTown.layer.borderColor = UIColor.gray.cgColor
        viewTown.layer.cornerRadius = 0
        viewTown.layer.shadowColor = UIColor(white: 0.0, alpha: 0.5).cgColor
        viewTown.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        viewTown.layer.shadowOpacity = 0.8
        viewTown.layer.shadowRadius = 2
        
        btnSearchKeyWord.backgroundColor = UIColor(hex: appColorNew!)
        btnSearchNow.backgroundColor = UIColor(hex: appColorNew!)
        
    }
    
    //MARK:- IBActions

    @IBAction func btnTypeClicked(_ sender: UIButton) {
        dropDownType.show()
    }
    
    @IBAction func btnExpClicked(_ sender: UIButton) {
        dropDownExperience.show()
    }
    
    
    @IBAction func btnLevelClicked(_ sender: UIButton) {
        dropDownLevel.show()
    }
    
    @IBAction func btnSkillsClicked(_ sender: UIButton) {
        dropDownSkills.show()
    }
    
    @IBAction func btnCountryClicked(_ sender: UIButton) {
        dropDownCountry.show()
    }
    
    @IBAction func btnStateClicked(_ sender: UIButton) {
        dropDownState.show()
    }
    
    @IBAction func btnCityClicked(_ sender: UIButton) {
         dropDownCity.show()
    }
    
    @IBAction func btnTownClicked(_ sender: UIButton) {
        dropDownTown.show()
    }
    
    @IBAction func btnSearchNowClicked(_ sender: UIButton) {
        canDataWithFilters()
    }
    
    @IBAction func btnSearchKeywordClicked(_ sender: UIButton) {
        canData()
    }
    
    //MARK:- Api Calls
    
    func candidateSearchData() {
        
        self.showLoader()
        UserHandler.nokri_candidateSearch(success: { (successResponse) in
            
            self.stopAnimating()
            if successResponse.success {
                
                self.searchField = successResponse.data.searchFields
                self.extraArray = successResponse.extra
                self.dropDownSetup()
                self.populateData()
               
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
    
    func countryCategories(id:Int){
        
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
                    
                    self.stateDataParser(stateArr: responseData)
                    self.dropDownSetup()
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
                    
                    self.stateDataParser(stateArr: responseData)
                    self.dropDownSetup()
                    self.stopAnimating()
                    
                    
            }
        }
        
       
    }
    
    func stateDataParser(stateArr:NSArray){
        
        self.statArray.removeAllObjects()
        for item in stateArr{
            self.statArray.add(item)
        }
        
    }
    
    func cityCategories(id:Int){
        
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
                    
                    self.cityDataParser(cityArr: responseData)
                    self.dropDownSetup()
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
                    
                    self.cityDataParser(cityArr: responseData)
                    self.dropDownSetup()
                    self.stopAnimating()
                    
            }
            
        }
        
       
    }
    
    func cityDataParser(cityArr:NSArray){
        
        self.cityArray.removeAllObjects()
        for item in cityArr{
            self.cityArray.add(item)
        }
        
    }
    
    func townCategories(id:Int){
        
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
                    
                    self.townDataParser(townArr: responseData)
                    self.dropDownSetup()
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
                    
                    self.townDataParser(townArr: responseData)
                    self.dropDownSetup()
                    self.stopAnimating()
                    
            }
        }
        
     
    }
    
    func townDataParser(townArr:NSArray){
        
        self.townArray.removeAllObjects()
        for item in townArr{
            self.townArray.add(item)
        }
        
    }
    
    func canData(){
        
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
                "cand_title" : txtSearchKeywordField.text!
                
            ]
            print(param)
            
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.candidateSearch, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers)
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
                            self.jobDataParser(jobsArr: JobArr)
                        }
                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CandidateSearchedViewController") as! CandidateSearchedViewController
                        nextViewController.canArray = self.candidateArray
                        nextViewController.message = self.message
                        nextViewController.pageTitle = pageTitle
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
                "cand_title" : txtSearchKeywordField.text!
                
            ]
            print(param)
            
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.candidateSearch, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers)
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
                            self.jobDataParser(jobsArr: JobArr)
                        }
                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CandidateSearchedViewController") as! CandidateSearchedViewController
                        nextViewController.canArray = self.candidateArray
                        nextViewController.message = self.message
                        nextViewController.pageTitle = pageTitle
                        self.navigationController?.pushViewController(nextViewController, animated: true)
                    }else{
                        
                        let hud = JGProgressHUD(style: .dark)
                        hud.textLabel.text = self.message
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
    
    func jobDataParser(jobsArr:NSArray){
        
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
    
    
    func canDataWithFilters(){
        
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
            
            var params : [String:Any] = [:]
            
            if isType == true{
                params["cand_type"] = typeInt
            }
            
            if isLevel == true{
                params["cand_level"] = levelInt
            }
            if isSkill == true{
                params["cand_skills"] = skillInt
            }
            if isExp == true{
                params["cand_experience"] = expInt
            }
            if isCountry == true{
                params["cand_location"] = countryInt
            }
            
            
            params["page_number"] = "1"
            
            
            print(params)
            
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.candidateSearch, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
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
                            self.jobDataParserWithFilters(jobsArr: JobArr)
                        }
                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CandidateSearchedViewController") as! CandidateSearchedViewController
                        nextViewController.canArray = self.candidateArray
                        nextViewController.message = self.message
                        nextViewController.pageTitle = pageTitle
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
            
            var params : [String:Any] = [:]
            
            if isType == true{
                params["cand_type"] = typeInt
            }
            
            if isLevel == true{
                params["cand_level"] = levelInt
            }
            if isSkill == true{
                params["cand_skills"] = skillInt
            }
            if isExp == true{
                params["cand_experience"] = expInt
            }
            if isCountry == true{
                params["cand_location"] = countryInt
            }
            
            
            params["page_number"] = "1"
            
            
            print(params)
            
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.candidateSearch, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
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
                            self.jobDataParserWithFilters(jobsArr: JobArr)
                        }
                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CandidateSearchedViewController") as! CandidateSearchedViewController
                        nextViewController.canArray = self.candidateArray
                        nextViewController.message = self.message
                        nextViewController.pageTitle = pageTitle
                        self.navigationController?.pushViewController(nextViewController, animated: true)
                    }else{
                        let hud = JGProgressHUD(style: .dark)
                        hud.textLabel.text = self.message
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
    
    func jobDataParserWithFilters(jobsArr:NSArray){
        
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
