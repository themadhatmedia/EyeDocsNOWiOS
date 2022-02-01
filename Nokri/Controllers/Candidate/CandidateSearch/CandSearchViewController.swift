//
//  CandSearchViewController.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 7/11/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import UIKit
import DropDown
import Alamofire
import JGProgressHUD

class CandSearchViewController: UITableViewController {
    
    //MARK:- IBOutlets
    
    
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var lblSearchNow: UILabel!
    @IBOutlet weak var viewSearchKeyWord: UIView!
    @IBOutlet weak var viewType: UIView!
    @IBOutlet weak var viewExperience: UIView!
    @IBOutlet weak var viewLevel: UIView!
    @IBOutlet weak var viewSkill: UIView!
    @IBOutlet weak var viewGender: UIView!
    @IBOutlet weak var viewHeadline: UIView!
    @IBOutlet weak var viewQualification: UIView!
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
    @IBOutlet weak var btnGender: UIButton!
    @IBOutlet weak var btnQualification: UIButton!
    @IBOutlet weak var lblSkillKey: UILabel!
    @IBOutlet weak var lblSkillValue: UILabel!
    @IBOutlet weak var lblGenderKey: UILabel!
    @IBOutlet weak var lblGenderValue: UILabel!
    @IBOutlet weak var lblQualificationKey: UILabel!
    @IBOutlet weak var lblQualificationValue: UILabel!
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
    @IBOutlet weak var iconDropDownType: UIImageView!
    @IBOutlet weak var iconExperience: UIImageView!
    @IBOutlet weak var iconLevel: UIImageView!
    @IBOutlet weak var iconSkill: UIImageView!
    @IBOutlet weak var iconGender: UIImageView!
    @IBOutlet weak var iconQualification: UIImageView!
    @IBOutlet weak var iconCountry: UIImageView!
    @IBOutlet weak var iconState: UIImageView!
    @IBOutlet weak var iconCity: UIImageView!
    @IBOutlet weak var iconTown: UIImageView!
    @IBOutlet weak var txtHeadline: UITextField!
    
    //MARK:- Proporties
    
    let dropDownType = DropDown()
    let dropDownExperience = DropDown()
    let dropDownLevel = DropDown()
    let dropDownSkills = DropDown()
    let dropDownGender = DropDown()
    let dropDownHeadline = DropDown()
    let dropDownSalaryRange = DropDown()
    let dropDownSalaryType = DropDown()
    let dropDownSalaryCurrency = DropDown()
    let dropDownQualification = DropDown()
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
    var qualificationInt:Int?
    var salaryRangeInt:Int?
    var salaryTypeInt:Int?
    var salaryCurrencyInt:Int?
    var genderInt:Int?
    var headlineInt:Int?
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
    var isGender:Bool = false
    var isHeadline:Bool = false
    var isSalaryRange:Bool = false
    var isSalaryType:Bool = false
    var isSalaryCurrency:Bool = false
    var isQualification:Bool = false
    var isCountry:Bool = false
    var isState:Bool = false
    var isCity:Bool = false
    var isTown:Bool = false
    var nextPage:Int?
    var hasNextPage:Bool?
    var appColorNew = UserDefaults.standard.string(forKey: "app_Color")
    var countryArray = NSMutableArray()
    var selectOpt = ""
    
    //MARK:- View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //nokri_ltrRtl()
        addLeftBarButtonWithImage(#imageLiteral(resourceName: "menu"))
        nokri_candidateSearchData()
        nokri_boolChecks()
        nokri_viewShadow()
        nokri_dropDownIcons()
        nokri_jobLoctData()
       // heightConstraintCCT.constant -= 180
        if let userData = UserDefaults.standard.object(forKey: "settingsData") {
                   let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
                   let dataTabs = SplashRoot(fromDictionary: objData)
            let obj = dataTabs.data.extra
            selectOpt = obj?.select_opt as! String
        }
        showRefreshButton()
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
        txtSearchKeywordField.text! = ""
        txtHeadline.text = ""
        nokri_candidateSearchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
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
            btnCountry.tag = cotKey
            self.lblCountryValue.text = cot2Name
        }
        if cot3Key != 0{
            btnCountry.tag = cotKey
            self.lblCountryValue.text = cot3Name
        }
        if cot4Key != 0{
            btnCountry.tag = cotKey
            self.lblCountryValue.text = cot4Name
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
        iconExperience.image = iconExperience.image?.withRenderingMode(.alwaysTemplate)
        iconExperience.tintColor = UIColor(hex:  appColorNew!)
        iconSkill.image = iconSkill.image?.withRenderingMode(.alwaysTemplate)
        iconSkill.tintColor = UIColor(hex: appColorNew!)
        iconCountry.image = iconCountry.image?.withRenderingMode(.alwaysTemplate)
        iconCountry.tintColor = UIColor(hex: appColorNew!)
        iconState.image = iconState.image?.withRenderingMode(.alwaysTemplate)
        iconState.tintColor = UIColor(hex: appColorNew!)
        iconCity.image = iconCity.image?.withRenderingMode(.alwaysTemplate)
        iconCity.tintColor = UIColor(hex: appColorNew!)
        iconTown.image = iconTown.image?.withRenderingMode(.alwaysTemplate)
        iconTown.tintColor = UIColor(hex: appColorNew!)
        iconLevel.image = iconTown.image?.withRenderingMode(.alwaysTemplate)
        iconLevel.tintColor = UIColor(hex: appColorNew!)
        iconGender.image = iconGender.image?.withRenderingMode(.alwaysTemplate)
        iconGender.tintColor = UIColor(hex: appColorNew!)
        iconQualification.image = iconQualification.image?.withRenderingMode(.alwaysTemplate)
        iconQualification.tintColor = UIColor(hex: appColorNew!)
        
    }
    
    func nokri_boolChecks(){
        isShow2 = true
        isShow = true
        isShowSec = true
        isShowSecond = true
        isShowThi = true
        isShowThird = true
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
                self.navigationController?.navigationBar.topItem?.title = obj.key
            }
            if obj.fieldTypeName == "country"{
                lblCountryKey.text = obj.key
            }

        }
//        lblTypeValue.text = selectOption
//        lblStateValue.text = selectOption
//        lblExpValue.text = selectOption
//        lblLevelValue.text = selectOption
//        lblSkillValue.text = selectOption
//        lblCountryValue.text = selectOption
//        lblCityValue.text = selectOption
//        lblTownValue.text = selectOption
    }
    
    func nokri_dropDownSetup(){
        var typeKey = [Int]()
        for obj in searchField{
            if obj.fieldTypeName == "cand_type"{
                lblTypeKey.text = obj.key
                //selectOption = obj.column
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
        
        var expKey = [Int]()
        for obj in searchField{
            if obj.fieldTypeName == "cand_experience"{
                lblExpKey.text = obj.key
                lblExpValue.text = selectOpt
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
            if obj.fieldTypeName == "cand_level"{
                lblLevelKey.text = obj.key
                lblLevelValue.text = selectOpt
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
            if obj.fieldTypeName == "cand_skills"{
                lblSkillKey.text = obj.key
                lblSkillValue.text = selectOpt
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
        
        var salaryRangeKey = [Int]()
        for obj in searchField{
            if obj.fieldTypeName == "cand_salary_range"{
                lblStateKey.text = obj.key
                lblStateValue.text = selectOpt
                categoryArray.removeAll()
                valueArray = obj.valueAr
                for innerObj in valueArray{
                    categoryArray.append(innerObj.value)
                    salaryRangeKey.append(innerObj.key)
                }
            }
        }
        
        dropDownSalaryRange.dataSource =  categoryArray
        dropDownSalaryRange.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.lblStateValue.text = item
            self.isSalaryRange = true
            self.salaryRangeInt = salaryRangeKey[index]
        }
        
        var salaryTypeKey = [Int]()
        for obj in searchField{
            if obj.fieldTypeName == "cand_salary_type"{
                lblCityKey.text = obj.key
                lblCityValue.text = selectOpt
                categoryArray.removeAll()
                valueArray = obj.valueAr
                for innerObj in valueArray{
                    categoryArray.append(innerObj.value)
                    salaryTypeKey.append(innerObj.key)
                }
            }
        }
        
        dropDownSalaryType.dataSource =  categoryArray
        dropDownSalaryType.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.lblCityValue.text = item
            self.isSalaryType = true
            self.salaryTypeInt = salaryTypeKey[index]
        }
        
        var salaryCurrencyKey = [Int]()
        for obj in searchField{
            if obj.fieldTypeName == "cand_salary_curr"{
                lblTownKey.text = obj.key
                print(selectOpt)
                lblTownValue.text = selectOpt
                categoryArray.removeAll()
                valueArray = obj.valueAr
                for innerObj in valueArray{
                    categoryArray.append(innerObj.value)
                    salaryCurrencyKey.append(innerObj.key)
                }
            }
        }
        
        dropDownSalaryCurrency.dataSource =  categoryArray
        dropDownSalaryCurrency.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.lblTownValue.text = item
            self.isSalaryCurrency = true
            self.salaryCurrencyInt = salaryCurrencyKey[index]
        }
        
        
        var genderKey = [Int]()
        for obj in searchField{
            if obj.fieldTypeName == "cand_gender"{
                lblGenderKey.text = obj.key
                categoryArray.removeAll()
                valueArray = obj.valueAr
                lblGenderValue.text = selectOpt
                for innerObj in valueArray{
                    categoryArray.append(innerObj.value)
                    genderKey.append(innerObj.key)
                }
            }
        }
        
        dropDownGender.dataSource =  categoryArray
        dropDownGender.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.lblGenderValue.text = item
            self.isGender = true
            self.genderInt = genderKey[index]
        }
        
        var headlineKey = [Int]()
        for obj in searchField{
            if obj.fieldTypeName == "cand_head"{
                txtHeadline.placeholder = obj.key
                categoryArray.removeAll()
                valueArray = obj.valueAr
                for innerObj in valueArray{
                    categoryArray.append(innerObj.value)
                    headlineKey.append(innerObj.key)
                }
            }
        }
        
        
        
        dropDownHeadline.dataSource =  categoryArray
        dropDownHeadline.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            //self.lblHeadlineValue.text = item
            self.isHeadline = true
            self.headlineInt = headlineKey[index]
        }
        
        var qualificationKey = [Int]()
        for obj in searchField{
            if obj.fieldTypeName == "cand_qualification"{
                lblQualificationKey.text = obj.key
                categoryArray.removeAll()
                valueArray = obj.valueAr
                lblQualificationValue.text = selectOpt
                for innerObj in valueArray{
                    categoryArray.append(innerObj.value)
                    qualificationKey.append(innerObj.key)
                }
            }
        }
        
        dropDownQualification.dataSource =  categoryArray
        dropDownQualification.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.lblQualificationValue.text = item
            self.isQualification = true
            self.qualificationInt = headlineKey[index]
        }
        
        
        //        var countryKey = [Int]()
        //        var childArr = [Bool]()
        //        for obj in searchField{
        //            if obj.key == "Location"{
        //                categoryArray.removeAll()
        //                valueArray = obj.valueAr
        //                for innerObj in valueArray{
        //                    categoryArray.append(innerObj.value)
        //                    countryKey.append(innerObj.key)
        //                    childArr.append(innerObj.hasChild)
        //                }
        //            }
        //            //categoryArray.removeAll()
        //        }
        //
        //        dropDownCountry.dataSource =  categoryArray
        //        dropDownCountry.selectionAction = { [unowned self] (index: Int, item: String) in
        //            print("Selected item: \(item) at index: \(index)")
        //            self.lblCountryValue.text = item
        //            self.dropDownCountry.tag = countryKey[index]
        //            self.isCountry = true
        //            self.countryInt = countryKey[index]
        //            if childArr[index] == true{
        //                //self.lblCountryValue.text = item
        //                self.nokri_countryCategories(id: countryKey[index])
        //                if self.isShow == true{
        //                    self.tableView.rowHeight += 58
        //                    self.nokri_countryCategories(id: countryKey[index])
        //                    //self.lblCountryValue.text = item
        //                    self.viewState.isHidden = false
        //                    self.heightConstraintCCT.constant += 58
        //                    self.isShow2 = false
        //                    self.isShow = false
        //                }
        //            }else{
        //                if self.viewState.isHidden == false && self.viewCity.isHidden == false && self.viewTown.isHidden == false{
        //                    self.viewState.isHidden = true
        //                    self.viewCity.isHidden = true
        //                    self.viewTown.isHidden = true
        //                    self.heightConstraintCCT.constant -= 180
        //                    self.tableView.rowHeight -= 180
        //                    self.isShow2 = true
        //                    self.isShow = true
        //                    self.isShowThi = true
        //                    self.isShowThird = true
        //                    self.isShowSec = true
        //                    self.isShowSecond = true
        //                }
        //                if self.viewCity.isHidden == false && self.viewState.isHidden == false{
        //                    self.viewState.isHidden = true
        //                    self.viewCity.isHidden = true
        //                    self.heightConstraintCCT.constant -= 120
        //                    self.tableView.rowHeight -= 120
        //                    self.isShow2 = true
        //                    self.isShow = true
        //                    self.isShowThi = true
        //                    self.isShowThird = true
        //                    self.isShowSec = true
        //                    self.isShowSecond = true
        //                }
        //                if self.isShow == false && self.isShow2 == false {
        //                    self.isShow = true
        //                    self.isShow2 = true
        //                    self.heightConstraintCCT.constant -= 58
        //                    self.tableView.rowHeight -= 58
        //                    //self.heightContraintMain.constant -= 58
        //                    self.viewState.isHidden = true
        //                }
        //            }
        //        }
        //
        //        var statValue = [String]()
        //        var stateKey = [Int]()
        //        var stateChildArr = [Bool]()
        //        let subCategory = self.statArray as? [NSDictionary]
        //        for itemDict in subCategory! {
        //            if let catObj = itemDict["value"] as? String{
        //                if catObj == ""{
        //                    continue
        //                }
        //                statValue.append(catObj)
        //            }
        //            if let keyObj = itemDict["key"] as? Int{
        //                stateKey.append(keyObj)
        //            }
        //            if let hasChild = itemDict["has_child"] as? Bool{
        //                print(hasChild)
        //                if hasChild == true {
        //
        //                }
        //                stateChildArr.append(hasChild)
        //            }
        //        }
        //
        //        dropDownState.dataSource = statValue
        //        dropDownState.selectionAction = { [unowned self] (index: Int, item: String) in
        //            print("Selected item: \(item) at index: \(index)")
        //            self.isState = true
        //            self.lblStateValue.text = item
        //            self.dropDownState.tag = stateKey[index]
        //            self.countryInt = stateKey[index]
        //            if stateChildArr[index] == true{
        //                // self.lblStateValue.text = item
        //                self.nokri_cityCategories(id: stateKey[index])
        //                if self.isShowSecond == true{
        //                    //self.lblStateValue.text = item
        //                    self.nokri_cityCategories(id: stateKey[index])
        //                    self.viewCity.isHidden = false
        //                    self.heightConstraintCCT.constant += 62
        //                    self.tableView.rowHeight += 62
        //                    self.isShowSec = false
        //                    self.isShowSecond = false
        //                }
        //            }else{
        //                if self.viewCity.isHidden == false && self.viewTown.isHidden == false {
        //                    self.viewCity.isHidden = true
        //                    self.viewTown.isHidden = true
        //                    self.heightConstraintCCT.constant -= 60
        //                    self.tableView.rowHeight -= 60
        //                    self.isShowSec = true
        //                    self.isShowSecond = true
        //                }
        //                if self.isShowSecond == false && self.isShowSec == false{
        //                    self.heightConstraintCCT.constant -= 62
        //                    self.tableView.rowHeight -= 62
        //                    self.viewCity.isHidden = true
        //                    self.isShowSec = true
        //                    self.isShowSecond = true
        //                    //                  self.isShowThird = true
        //                    //                  self.isShowThi = true
        //
        //                }
        //            }
        //        }
        //
        //        var cityValue = [String]()
        //        var cityKey = [Int]()
        //        var cityChildArr = [Bool]()
        //        let citybCategory = self.cityArray as? [NSDictionary]
        //        for itemDict in citybCategory! {
        //            if let catObj = itemDict["value"] as? String{
        //                if catObj == ""{
        //                    continue
        //                }
        //                cityValue.append(catObj)
        //            }
        //            if let keyObj = itemDict["key"] as? Int{
        //                cityKey.append(keyObj)
        //            }
        //            if let hasChild = itemDict["has_child"] as? Bool{
        //                print(hasChild)
        //                if hasChild == true {
        //
        //                }
        //                cityChildArr.append(hasChild)
        //            }
        //        }
        //        dropDownCity.dataSource = cityValue
        //        dropDownCity.selectionAction = { [unowned self] (index: Int, item: String) in
        //            print("Selected item: \(item) at index: \(index)")
        //            self.isCity = true
        //            self.lblCityValue.text = item
        //            self.dropDownCity.tag = cityKey[index]
        //            self.countryInt = cityKey[index]
        //            if cityChildArr[index] == true{
        //                // self.lblCityValue.text = item
        //                self.nokri_townCategories(id: cityKey[index])
        //                if self.isShowThird == true{
        //                    // self.lblCityValue.text = item
        //                    self.nokri_townCategories(id: cityKey[index])
        //                    self.viewTown.isHidden = false
        //                    self.heightConstraintCCT.constant += 62
        //                    self.tableView.rowHeight += 62
        //                    self.isShowThird = false
        //                    self.isShowThi = false
        //                }
        //            }else{
        //                if self.isShowThird == false && self.isShowThi == false{
        //                    self.heightConstraintCCT.constant -= 62
        //                    self.tableView.rowHeight -= 62
        //                    self.viewCity.isHidden = true
        //                    self.isShowThird = true
        //                    self.isShowThi = true
        //                }
        //            }
        //        }
        //
        //        var townValue = [String]()
        //        var townKey = [Int]()
        //        var townChildArr = [Bool]()
        //        let townCategory = self.townArray as? [NSDictionary]
        //        for itemDict in townCategory! {
        //            if let catObj = itemDict["value"] as? String{
        //                if catObj == ""{
        //                    continue
        //                }
        //                townValue.append(catObj)
        //            }
        //            if let keyObj = itemDict["key"] as? Int{
        //                townKey.append(keyObj)
        //
        //                if let hasChild = itemDict["has_child"] as? Bool{
        //                    print(hasChild)
        //                    if hasChild == true {
        //
        //                    }
        //                    townChildArr.append(hasChild)
        //                }
        //            }
        //        }
        //        self.lblTownValue.text = selectOption
        //        dropDownTown.dataSource = townValue
        //        dropDownTown.selectionAction = { [unowned self] (index: Int, item: String) in
        //            print("Selected item: \(item) at index: \(index)")
        //            self.countryInt = townKey[index]
        //            self.isTown = true
        //            self.lblTownValue.text = item
        //            self.dropDownTown.tag = townKey[index]
        //            self.isShow2 = false
        //            self.isShow = false
        //            self.isShowThi = false
        //            self.isShowThird = false
        //            self.isShowSec = false
        //            self.isShowSecond = false
        //
        //        }
        
        
        dropDownType.anchorView = btnType
        dropDownLevel.anchorView = btnLevel
        dropDownSkills.anchorView = btnSkill
        dropDownExperience.anchorView = btnExp
        dropDownCountry.anchorView = btnCountry
        dropDownState.anchorView = btnState
        dropDownCity.anchorView = btnCity
        dropDownTown.anchorView = btnTown
        dropDownSalaryRange.anchorView = btnState
        dropDownSalaryCurrency.anchorView = btnCity
        dropDownSalaryType.anchorView = btnCity
       // dropDownHeadline.anchorView = btnHeadline
        dropDownGender.anchorView = btnGender
        dropDownExperience.anchorView = btnExp
        DropDown.startListeningToKeyboard()
        DropDown.appearance().textColor = UIColor.black
        DropDown.appearance().textFont = UIFont.systemFont(ofSize: 12)
        DropDown.appearance().backgroundColor = UIColor.white
        DropDown.appearance().selectionBackgroundColor = UIColor(hex:appColorNew!)
        DropDown.appearance().cellHeight = 40
        //DropDown.appearance().textAlign = 300
        
        
    }
    
    func nokri_viewShadow(){
        
        viewType.layer.borderColor = UIColor.gray.cgColor
        viewType.layer.cornerRadius = 0
        viewType.layer.shadowColor = UIColor(white: 0.0, alpha: 0.3).cgColor
        viewType.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        viewType.layer.shadowOpacity = 0.6
        viewType.layer.shadowRadius = 2
        
        viewExperience.layer.borderColor = UIColor.gray.cgColor
        viewExperience.layer.cornerRadius = 0
        viewExperience.layer.shadowColor = UIColor(white: 0.0, alpha: 0.3).cgColor
        viewExperience.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        viewExperience.layer.shadowOpacity = 0.6
        viewExperience.layer.shadowRadius = 2
        
        viewSkill.layer.borderColor = UIColor.gray.cgColor
        viewSkill.layer.cornerRadius = 0
        viewSkill.layer.shadowColor = UIColor(white: 0.0, alpha: 0.3).cgColor
        viewSkill.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        viewSkill.layer.shadowOpacity = 0.6
        viewSkill.layer.shadowRadius = 2
        
        viewLevel.layer.borderColor = UIColor.gray.cgColor
        viewLevel.layer.cornerRadius = 0
        viewLevel.layer.shadowColor = UIColor(white: 0.0, alpha: 0.3).cgColor
        viewLevel.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        viewLevel.layer.shadowOpacity = 0.6
        viewLevel.layer.shadowRadius = 2
        
        viewCountry.layer.borderColor = UIColor.gray.cgColor
        viewCountry.layer.cornerRadius = 0
        viewCountry.layer.shadowColor = UIColor(white: 0.0, alpha: 0.3).cgColor
        viewCountry.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        viewCountry.layer.shadowOpacity = 0.6
        viewCountry.layer.shadowRadius = 2
        
        viewState.layer.borderColor = UIColor.gray.cgColor
        viewState.layer.cornerRadius = 0
        viewState.layer.shadowColor = UIColor(white: 0.0, alpha: 0.3).cgColor
        viewState.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        viewState.layer.shadowOpacity = 0.6
        viewState.layer.shadowRadius = 2
        
        viewCity.layer.borderColor = UIColor.gray.cgColor
        viewCity.layer.cornerRadius = 0
        viewCity.layer.shadowColor = UIColor(white: 0.0, alpha: 0.3).cgColor
        viewCity.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        viewCity.layer.shadowOpacity = 0.6
        viewCity.layer.shadowRadius = 2
        
        viewTown.layer.borderColor = UIColor.gray.cgColor
        viewTown.layer.cornerRadius = 0
        viewTown.layer.shadowColor = UIColor(white: 0.0, alpha: 0.3).cgColor
        viewTown.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        viewTown.layer.shadowOpacity = 0.6
        viewTown.layer.shadowRadius = 2
        
        viewGender.layer.borderColor = UIColor.gray.cgColor
        viewGender.layer.cornerRadius = 0
        viewGender.layer.shadowColor = UIColor(white: 0.0, alpha: 0.3).cgColor
        viewGender.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        viewGender.layer.shadowOpacity = 0.6
        viewGender.layer.shadowRadius = 2
        
        viewHeadline.layer.borderColor = UIColor.gray.cgColor
        viewHeadline.layer.cornerRadius = 0
        viewHeadline.layer.shadowColor = UIColor(white: 0.0, alpha: 0.3).cgColor
        viewHeadline.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        viewHeadline.layer.shadowOpacity = 0.6
        viewHeadline.layer.shadowRadius = 2
        
        viewQualification.layer.borderColor = UIColor.gray.cgColor
        viewQualification.layer.cornerRadius = 0
        viewQualification.layer.shadowColor = UIColor(white: 0.0, alpha: 0.3).cgColor
        viewQualification.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        viewQualification.layer.shadowOpacity = 0.6
        viewQualification.layer.shadowRadius = 2
        
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
    
    @IBAction func btnStateClicked(_ sender: UIButton) {
        //dropDownState.show()
        dropDownSalaryRange.show()
    }
    
    @IBAction func btnCityClicked(_ sender: UIButton) {
        // dropDownCity.show()
        dropDownSalaryType.show()
    }
    
    @IBAction func btnTownClicked(_ sender: UIButton) {
        //dropDownTown.show()
        dropDownSalaryCurrency.show()
    }
    
    @IBAction func btnSearchNowClicked(_ sender: UIButton) {
        nokri_canDataWithFilters()
    
    
    }
    
    @IBAction func btnSearchKeywordClicked(_ sender: UIButton) {
        nokri_canData()
    }
    
    
    @IBAction func btnGenderClicked(_ sender: UIButton) {
        dropDownGender.show()
    }
    
    
    @IBAction func btnQualificationClicked(_ sender: UIButton) {
        dropDownQualification.show()
    }
    
    //MARK:- Api Calls
    
    func nokri_candidateSearchData() {
        self.showLoader()
        UserHandler.nokri_candidateSearch(success: { (successResponse) in
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
                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CandidateSearchedViewController") as! CandidateSearchedViewController
                        nextViewController.canArray = self.candidateArray
                        nextViewController.message = self.message
                        nextViewController.pageTitle = pageTitle
                        nextViewController.hasNextPage = self.hasNextPage
                        nextViewController.nextPage = self.nextPage
                        nextViewController.searchedText = self.txtSearchKeywordField.text
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
                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CandidateSearchedViewController") as! CandidateSearchedViewController
                        nextViewController.canArray = self.candidateArray
                        nextViewController.message = self.message
                        nextViewController.pageTitle = pageTitle
                        nextViewController.hasNextPage = self.hasNextPage
                        nextViewController.nextPage = self.nextPage
                        nextViewController.searchedText = self.txtSearchKeywordField.text
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
            if isSalaryRange == true{
                params["cand_salaryrange"] = salaryRangeInt
            }
            if isSalaryCurrency == true{
                params["cand_salarycurrency"] = salaryCurrencyInt
            }
            if isSalaryType == true{
                params["cand_salarytype"] = salaryTypeInt
            }
            if isGender == true{
                params["cand_gender"] = genderInt
            }
            if isHeadline == true{
                params["cand_headline"] = txtHeadline.text
            }
            if isQualification == true{
                params["cand_qualification"] = qualificationInt
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
                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CandidateSearchedViewController") as! CandidateSearchedViewController
                        nextViewController.isFromFilter = true
                        nextViewController.canArray = self.candidateArray
                        nextViewController.isLevel = self.isLevel
                        nextViewController.isSkill = self.isSkill
                        nextViewController.isExp = self.isExp
                        nextViewController.isCountry = self.isCountry
                        nextViewController.typeInt = self.typeInt
                        nextViewController.levelInt = self.levelInt
                        nextViewController.skillInt = self.skillInt
                        nextViewController.expInt = self.expInt
                        nextViewController.countryInt = self.countryInt
                        nextViewController.hasNextPage = self.hasNextPage!
                        nextViewController.nextPage = self.nextPage
                        nextViewController.pageTitle = pageTitle
                        nextViewController.message = self.message
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
            if isSalaryRange == true{
                params["cand_salaryrange"] = salaryRangeInt
            }
            if isSalaryCurrency == true{
                params["cand_salarycurrency"] = salaryCurrencyInt
            }
            if isSalaryType == true{
                params["cand_salarytype"] = salaryTypeInt
            }
            if isGender == true{
                params["cand_gender"] = genderInt
            }
            if isHeadline == true{
                params["cand_headline"] = txtHeadline.text
            }
            if isQualification == true{
                params["cand_qualification"] = qualificationInt
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
                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CandidateSearchedViewController") as! CandidateSearchedViewController
                        nextViewController.isFromFilter = true
                        nextViewController.canArray = self.candidateArray
                        nextViewController.isLevel = self.isLevel
                        nextViewController.isSkill = self.isSkill
                        nextViewController.isExp = self.isExp
                        nextViewController.isCountry = self.isCountry
                        nextViewController.typeInt = self.typeInt
                        nextViewController.levelInt = self.levelInt
                        nextViewController.skillInt = self.skillInt
                        nextViewController.expInt = self.expInt
                        nextViewController.countryInt = self.countryInt
                        nextViewController.hasNextPage = self.hasNextPage!
                        nextViewController.nextPage = self.nextPage
                        nextViewController.pageTitle = pageTitle
                        nextViewController.message = self.message
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

//extension DropDownCell {
//    override open func awakeFromNib()
//    {
//        super.awakeFromNib()
//        optionLabel.textAlignment = .right
//    }
//}
