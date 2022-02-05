//
//  JobPostViewController.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 4/20/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import UIKit
import DropDown
import ActionSheetPicker_3_0
import WSTagsField
import TextFieldEffects
import GoogleMaps
import GooglePlaces
import Alamofire
import SwiftCheckboxDialog
import UICheckbox_Swift
import JGProgressHUD
import TTSegmentedControl
import JGProgressHUD

class JobPostViewController: UIViewController,GMSMapViewDelegate,GMSAutocompleteViewControllerDelegate,CLLocationManagerDelegate,UITableViewDataSource,UITableViewDelegate,CheckboxDialogViewDelegate,UITextFieldDelegate,UITextViewDelegate,questionProto,DataEnteredDelegate {
   
    
    //,DataCountryDelegate
    //MARK:- IBOutlets
    
    @IBOutlet weak var txtVideoUrl: HoshiTextField!
    @IBOutlet weak var heightConsRichView: NSLayoutConstraint!
    @IBOutlet weak var lblJobName: UILabel!
    @IBOutlet weak var heightConstraintJobCategoryView: NSLayoutConstraint!
    @IBOutlet weak var lblBoostJob: UILabel!
    @IBOutlet weak var lblLocationOnMap: UILabel!
    @IBOutlet weak var lblBasicInfoTitle: UILabel!
    @IBOutlet weak var lblJobTag: UILabel!
    @IBOutlet weak var lblJobDescSecond: UILabel!
    @IBOutlet weak var lblJobDesc: UILabel!
    @IBOutlet weak var richEditor: UITextView!
    @IBOutlet weak var txtJobTitle: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var jobCategoryMainView: UIView!
    @IBOutlet weak var btnDropDownJobCategory: UIButton!
    @IBOutlet weak var btnDropDownJobCategoryTwo: UIButton!
    @IBOutlet weak var btnJobCategoryThree: UIButton!
    @IBOutlet weak var btnJobCategoryFour: UIButton!
    @IBOutlet weak var viewJobCategory: UIView!
    @IBOutlet weak var viewJobCategoryTwo: UIView!
    @IBOutlet weak var viewJobCategoryThree: UIView!
    @IBOutlet weak var viewJobCategoryFour: UIView!
    @IBOutlet weak var viewCountrry: UIView!
    @IBOutlet weak var viewState: UIView!
    @IBOutlet weak var viewCity: UIView!
    @IBOutlet weak var viewTown: UIView!
    @IBOutlet weak var lblJobCategoryKey: UILabel!
    @IBOutlet weak var lblJobCategoryKeyTwo: UILabel!
    @IBOutlet weak var lblJobCategoryKeyThree: UILabel!
    @IBOutlet weak var lblJobCategoryKeyFour: UILabel!
    @IBOutlet weak var dropDownViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var lblJobCategoryValue: UILabel!
    @IBOutlet weak var lblJobCategoryValueTwo: UILabel!
    @IBOutlet weak var lblJobCategoryValueThree: UILabel!
    @IBOutlet weak var lblJobCategoryValueFour: UILabel!
    @IBOutlet weak var btnApplicationDeadline: UIButton!
    @IBOutlet weak var dropDownJobQualification: UIButton!
    @IBOutlet weak var dropDownJopType: UIButton!
    @IBOutlet weak var dropDownSalaryType: UIButton!
    @IBOutlet weak var dropDownSalaryCurrency: UIButton!
    @IBOutlet weak var dropDownSallaryOffer: UIButton!
    @IBOutlet weak var dropDownJobExperience: UIButton!
    @IBOutlet weak var dropDownJobShift: UIButton!
    @IBOutlet weak var dropDownJobLevel: UIButton!
    @IBOutlet weak var dropDownJobPostT: UIButton!
    @IBOutlet weak var btnJobSkill: UIButton!
    @IBOutlet weak var dropDownCountry: UIButton!
    @IBOutlet weak var dropDownState: UIButton!
    @IBOutlet weak var dropDownCity: UIButton!
    @IBOutlet weak var dropDownTown: UIButton!
    @IBOutlet weak var lblApplicationDeadlineKey: UILabel!
    @IBOutlet weak var lblJobQualificationKey: UILabel!
    @IBOutlet weak var lblJobTypeKey: UILabel!
    @IBOutlet weak var lblSalaryTypeKey: UILabel!
    @IBOutlet weak var lblSalaryCurrencyKey: UILabel!
    @IBOutlet weak var lblSalaryOfferKey: UILabel!
    @IBOutlet weak var lblJobExperienceKey: UILabel!
    @IBOutlet weak var lblJobShiftKey: UILabel!
    @IBOutlet weak var lblJobLevelKey: UILabel!
    @IBOutlet weak var lblNumberOfPostKey: UILabel!
    @IBOutlet weak var lblJobSkillKey: UILabel!
    @IBOutlet weak var lblApplicationDeadlineValue: UILabel!
    @IBOutlet weak var lblJobQualificationValue: UILabel!
    @IBOutlet weak var lblJobTypeValue: UILabel!
    @IBOutlet weak var lblSalaryTypeValue: UILabel!
    @IBOutlet weak var lblSalaryCurrencyValue: UILabel!
    @IBOutlet weak var lblSalaryOfferValue: UILabel!
    @IBOutlet weak var lblJobExperienceValue: UILabel!
    @IBOutlet weak var lblJobShiftValue: UILabel!
    @IBOutlet weak var lblJobLevelValue: UILabel!
    @IBOutlet weak var lblJobPostType: UILabel!
    @IBOutlet weak var lblJobPostTypeValue: UILabel!
    @IBOutlet weak var txtNumberFieldValue: UITextField!
    @IBOutlet weak var lblJobSkillValue: UILabel!
    @IBOutlet weak var lblCountry: UILabel!
    @IBOutlet weak var lblState: UILabel!
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var lblTown: UILabel!
    @IBOutlet weak var txtLocation: UITextField!
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var txtLatitude: UITextField!
    @IBOutlet weak var txtLongitude: UITextField!
    @IBOutlet weak var tagsView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnPostJob: UIButton!
    @IBOutlet weak var lblSelectCountryCity: UILabel!
    @IBOutlet weak var lblCountryValue: UILabel!
    @IBOutlet weak var lblStateValue: UILabel!
    @IBOutlet weak var lblCityValue: UILabel!
    @IBOutlet weak var lblTownValue: UILabel!
    @IBOutlet weak var viewCountry: UIView!
    @IBOutlet weak var heightConstraintViewCountry: NSLayoutConstraint!
    @IBOutlet weak var heightConstraintTableView: NSLayoutConstraint!
    @IBOutlet weak var heightConstraintMainView: NSLayoutConstraint!
    @IBOutlet weak var heightConstraintMainSubView: NSLayoutConstraint!
    @IBOutlet weak var iconDropDownJobCat: UIImageView!
    @IBOutlet weak var iconDropDownJobCatTwo: UIImageView!
    @IBOutlet weak var iconDropDownJobCatThree: UIImageView!
    @IBOutlet weak var iconDropDownJobCatFour: UIImageView!
    @IBOutlet weak var iconDropDownQualification: UIImageView!
    @IBOutlet weak var iconDropDownJobType: UIImageView!
    @IBOutlet weak var iconDropDownSalaryType: UIImageView!
    @IBOutlet weak var iconDropDownSalCurrency: UIImageView!
    @IBOutlet weak var iconDropDownSalOffer: UIImageView!
    @IBOutlet weak var iconDropDownExp: UIImageView!
    @IBOutlet weak var iconDropdownJobShift: UIImageView!
    @IBOutlet weak var iconDropDownJobLevel: UIImageView!
    @IBOutlet weak var iconDropDownJobPostType: UIImageView!
    @IBOutlet weak var iconDropDownJobSkill: UIImageView!
    @IBOutlet weak var iconDropDownCountry: UIImageView!
    @IBOutlet weak var iconDropDownState: UIImageView!
    @IBOutlet weak var iconDropDownCity: UIImageView!
    @IBOutlet weak var iconDropDownTown: UIImageView!
    @IBOutlet weak var lblLat: UILabel!
    @IBOutlet weak var lblLong: UILabel!
    @IBOutlet weak var segmentedControl: TTSegmentedControl!
    @IBOutlet weak var lblAddQues: UILabel!
    @IBOutlet weak var heightConstraintJobPostType: NSLayoutConstraint!
    @IBOutlet weak var viewJobPostType: UIView!
    @IBOutlet weak var viewJobPostLink: UIView!
    @IBOutlet weak var heightConstViewJobPostLink: NSLayoutConstraint!
    @IBOutlet weak var lblJobPostLink: UILabel!
    @IBOutlet weak var txtJobPostLink: UITextField!
    @IBOutlet weak var separatorJobPostType: UIView!
    @IBOutlet weak var separatorJobPostLink: UIView!
    @IBOutlet weak var viewShowQuestion: UIView!
    @IBOutlet weak var heightConstrainAddQues: NSLayoutConstraint!
    
    //MARK:- Proporties
    
    var isFromLocation = false
    var jobIdNew:Any!
    var job_Id:Int?
    var isFromEdit:Int = 1
    var dropDownJobCategory = DropDown()
    var dropDownCategory2 = DropDown()
    var dropDownCategory3 = DropDown()
    var dropDownCategory4 = DropDown()
    var dropDownJobQualificatio = DropDown()
    var dropDownJopTyp = DropDown()
    var dropDownSalaryTyp = DropDown()
    var dropDownSalaryCurrenc = DropDown()
    var dropDownSallaryOffe = DropDown()
    var dropDownJobExperienc = DropDown()
    var dropDownJobShif = DropDown()
    var dropDownJobLeve = DropDown()
    var dropDownJobPostType = DropDown()
    var dropDownCountr = DropDown()
    var dropDownStat = DropDown()
    var dropDownCit = DropDown()
    var dropDownTow = DropDown()
    
    var qualificationArray = NSMutableArray()
    var jobTypeArray = NSMutableArray()
    var salaryArray = NSMutableArray()
    var salaryCurrencyArray = NSMutableArray()
    var salaryOfferArray = NSMutableArray()
    var jobExperienceArray = NSMutableArray()
    var jobShiftArray = NSMutableArray()
    var jobLevelArray = NSMutableArray()
    var jobPostTypeArray = NSMutableArray()
    var jobSkillArray = NSMutableArray()
    var premiumArray = NSMutableArray()
    var premiumKeyArr = [String]()
    var premiumValueArr = [String]()
    var premiumRemainigArr = [String]()
    var premiumUrgentArr = [Int]()
    var jobCategoreisArray = NSMutableArray()
    var jobSubCatArrat = NSMutableArray()
    var jobSubCatArrat2 = NSMutableArray()
    var jobSubCatArrat3 = NSMutableArray()
    var jobSubCatArrat4 = NSMutableArray()
    var countryArray = NSMutableArray()
    var statArray = NSMutableArray()
    var cityArray = NSMutableArray()
    var townArray = NSMutableArray()
    var tagsArr = [String]()
    var packagesValueArr = [Int]()
    var skilKeyArr = [String]()
    var tagsArray = [String]()
    
    var isShow2:Bool?
    var isShow:Bool?
    var isShowSecond:Bool?
    var isShowSec:Bool?
    var isShowThird:Bool?
    var isShowThi:Bool?
    var isCountryShow:Bool?
    var isCountrySh:Bool?
    var isStateShow:Bool?
    var isStateSh:Bool?
    var isCityShow:Bool?
    var isCitySh:Bool?
    var appColorNew = UserDefaults.standard.string(forKey: "app_Color")
    var isFromResumeRecv:Bool = false
    var isJobBoost = false
    var questionsArray = [String]()
    var is_show = 0
    var jobPostTypeValue = 0
    
    var checkboxDialogViewController: CheckboxDialogViewController!
    typealias TranslationTuple = (name: String, translated: String)
    typealias TranslationDictionary = [String : String]
    
    var withOutLogin = UserDefaults.standard.string(forKey: "aType")
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let tagsField = WSTagsField()
    var markerDict: [Int: GMSMarker] = [:]
    var zoom: Float = 15
    var locationManager = CLLocationManager()
    var jobCategory:Bool = false
    var slugJobPostType = ""
    var jobInExpire = 0
    var isTitleChange = true
    
    
    var sub : [String:Any] = [:]
    
    var isHideDescription = false
    @IBOutlet weak var heightConstDeadLine: NSLayoutConstraint!
    var isHideDeadline = false
    @IBOutlet weak var heightConstQuali: NSLayoutConstraint!
    var isHideQualification = false
    @IBOutlet weak var viewQuali: UIView!
    @IBOutlet weak var viewDeadLi: UIView!
    @IBOutlet weak var heightConstJobType: NSLayoutConstraint!
    @IBOutlet weak var viewJobType: UIView!
    var isJobType = false
    @IBOutlet weak var heightConstSalaryType: NSLayoutConstraint!
    @IBOutlet weak var viewSalryType: UIView!
    var isSalaryType = false
    @IBOutlet weak var heightConstSalaryCur: NSLayoutConstraint!
    @IBOutlet weak var viewSalryCur: UIView!
    var isSalaryCur = false
    @IBOutlet weak var heightConstSalaryOfr: NSLayoutConstraint!
    @IBOutlet weak var viewSalryOfr: UIView!
    var isSalaryOfr = false
    @IBOutlet weak var heightConstJobExp: NSLayoutConstraint!
    @IBOutlet weak var viewJobExp: UIView!
    var isJobExp = false
    @IBOutlet weak var heightConstShift: NSLayoutConstraint!
    @IBOutlet weak var viewShift: UIView!
    var isShift = false
    @IBOutlet weak var heightConstjobLevel: NSLayoutConstraint!
    @IBOutlet weak var viewjobLevel: UIView!
    var isJobLevel = false
    @IBOutlet weak var heightConstnumberOfPost: NSLayoutConstraint!
    @IBOutlet weak var viewNumberOfPost: UIView!
    var isNumberOfPost = false
    @IBOutlet weak var heightConstSkills: NSLayoutConstraint!
    @IBOutlet weak var viewSkills: UIView!
    var isSkills = false
    @IBOutlet weak var heightConstjobTags: NSLayoutConstraint!
    @IBOutlet weak var viewjobTags: UIView!
    var isJobTags = false
    @IBOutlet weak var iconCalendar: UIImageView!
    
    
    var noText = ""
    var yesText = ""
    var questionLbl = ""
    var questionPlaceholder = ""
    var questionText = ""
    var isShowQuestion = "0"
    var questionFromEdit = [String]()
    var catIdPost =  0
    //MARK:- View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nokri_viewHide()
        UserDefaults.standard.set("false", forKey: "custData")
      
        UserDefaults.standard.set("0", forKey: "s")
        UserDefaults.standard.set("0", forKey: "s1")
        UserDefaults.standard.set("0", forKey: "s2")
        
        tagsField.delegate = self
        txtJobTitle.delegate = self
        
        if let userData = UserDefaults.standard.object(forKey: "settingsData") {
            let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
            let dataTabs = SplashRoot(fromDictionary: objData)
            let obj = dataTabs.data.empTabs
            self.navigationController?.navigationBar.topItem?.title = obj?.postJob
        }
        
        if isFromLocation == false{
            mapView.delegate = self
            UserDefaults.standard.set(false, forKey: "selected")
            UserDefaults.standard.set(false, forKey: "selectedCo")
            nokri_boolChecks()
            nokri_delegate()
            //nokri_ltrRtl()
            addLeftBarButtonWithImage(#imageLiteral(resourceName: "menu"))
            nokri_locationManagerFunc()
            nokri_tagField()
            //nokri_map()
            nokri_buttonStyle()
            
            if withOutLogin == "5"{
                
                if let userData = UserDefaults.standard.object(forKey: "settingsData") {
                    let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
                    let dataTabs = SplashRoot(fromDictionary: objData)
                    let obj = dataTabs.data.extra
                    let hud = JGProgressHUD(style: .dark)
                    hud.textLabel.text = obj?.isLogin
                    hud.detailTextLabel.text = nil
                    hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                    hud.position = .bottomCenter
                    hud.show(in: self.view)
                    hud.dismiss(afterDelay: 2.0)
                    //self.view.makeToast(obj?.isLogin, duration: 1.5, position: .center)
                    view.isHidden = true
                }
                
                tableView.isHidden = true
                self.perform(#selector(self.nokri_showNavController2), with: nil, afterDelay: 2)
            }else{
                
                let type = UserDefaults.standard.integer(forKey: "usrTyp")
                
                if type == 1{
                    
                    if isFromEdit == 0 {
                        nokri_jobPostDataFromEdit()
                    }else{
                        nokri_jobPostData()
                    }
                }else{
                    
                    tableView.isHidden = true
                    view.isHidden = true
                    var login1 = ""
                    if let userData = UserDefaults.standard.object(forKey: "settingsData") {
                        let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
                        let dataTabs = SplashRoot(fromDictionary: objData)
                        let obj = dataTabs.data.extra
                        login1 = (obj?.isEmployerLogin)!
                    }
                    let hud = JGProgressHUD(style: .dark)
                    hud.textLabel.text = login1
                    hud.detailTextLabel.text = nil
                    hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                    hud.position = .bottomCenter
                    hud.show(in: self.view)
                    hud.dismiss(afterDelay: 2.0)
                    //self.view.makeToast(login1, duration: 1.5, position: .center)
                    self.perform(#selector(self.nokri_showNavController1), with: nil, afterDelay: 1.5)
                    
                }
                tableView.isHidden = false
            }
            //nokri_viewHide()
            nokri_tagFieldFunc()
            nokri_dropDownIcons()
        }else{
            print("Nothing...!")
        }
        
        self.segmentedControl.itemTitles = ["No","Yes"]
        self.segmentedControl.backgroundColor = UIColor(hex: appColorNew!)
        self.segmentedControl.tintColor = UIColor(hex: appColorNew!)
        self.segmentedControl.thumbColor = UIColor(hex: appColorNew!)
        self.segmentedControl.didSelectItemWith = { (index, title) -> () in
            print("Selected item \(index)")
            if index == 0{
                
            }else{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "AddQuestionairViewController") as? AddQuestionairViewController
                print(self.questionPlaceholder)
                
                vc?.qLblText = self.questionLbl
                vc?.qPlacehoderText = self.questionPlaceholder
                vc?.qTxt = self.questionText
                vc?.delegate = self
                vc?.questionsFromEdit = self.questionFromEdit
                vc?.isFromEdit = self.isFromEdit
                self.navigationController?.pushViewController(vc!, animated: true)
            }
        }
      
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        if isHideDescription == true{
            heightConsRichView.constant = 0
        }
        
        if isHideDeadline == true{
            heightConstDeadLine.constant -= 75
            heightConstraintMainSubView.constant -= 75
            heightConstraintMainView.constant -= 75
            viewDeadLi.isHidden = true
            lblApplicationDeadlineKey.isHidden = true
            lblApplicationDeadlineValue.isHidden = true
            iconCalendar.isHidden = true
        }
        if isHideQualification == true{
            heightConstQuali.constant -= 75
            heightConstraintMainSubView.constant -= 75
            heightConstraintMainView.constant -= 75
            viewQuali.isHidden = true
            lblJobQualificationKey.isHidden = true
            lblJobQualificationValue.isHidden = true
            iconDropDownQualification.isHidden = true
        }
        if isJobType == true{
            heightConstJobType.constant -= 75
            heightConstraintMainSubView.constant -= 75
            heightConstraintMainView.constant -= 75
            viewJobType.isHidden = true
            lblJobTypeKey.isHidden = true
            lblJobTypeValue.isHidden = true
            iconDropDownJobType.isHidden = true
        }
        if isSalaryType == true{
            heightConstSalaryType.constant -= 75
            heightConstraintMainSubView.constant -= 75
            heightConstraintMainView.constant -= 75
            viewSalryType.isHidden = true
            lblSalaryTypeKey.isHidden = true
            lblSalaryTypeValue.isHidden = true
            iconDropDownSalaryType.isHidden = true
        }
        if isSalaryCur == true{
            heightConstSalaryCur.constant -= 75
            heightConstraintMainSubView.constant -= 75
            heightConstraintMainView.constant -= 75
            viewSalryCur.isHidden = true
            lblSalaryCurrencyKey.isHidden = true
            lblSalaryCurrencyValue.isHidden = true
            iconDropDownSalCurrency.isHidden = true
        }
        if isSalaryOfr == true{
            heightConstSalaryOfr.constant -= 75
            heightConstraintMainSubView.constant -= 75
            heightConstraintMainView.constant -= 75
            viewSalryOfr.isHidden = true
            lblSalaryOfferKey.isHidden = true
            lblSalaryOfferValue.isHidden = true
            iconDropDownSalOffer.isHidden = true
        }
        if isJobExp == true{
            heightConstJobExp.constant -= 75
            heightConstraintMainSubView.constant -= 75
            heightConstraintMainView.constant -= 75
            viewJobExp.isHidden = true
            lblJobExperienceKey.isHidden = true
            lblJobExperienceValue.isHidden = true
            iconDropDownExp.isHidden = true
        }
        if isShift == true{
            heightConstShift.constant -= 75
            heightConstraintMainSubView.constant -= 75
            heightConstraintMainView.constant -= 75
            viewShift.isHidden = true
            lblJobShiftKey.isHidden = true
            lblJobShiftValue.isHidden = true
            iconDropdownJobShift.isHidden = true
        }
        if isJobLevel == true{
            heightConstjobLevel.constant -= 75
            heightConstraintMainSubView.constant -= 75
            heightConstraintMainView.constant -= 75
            viewjobLevel.isHidden = true
            lblJobLevelKey.isHidden = true
            lblJobLevelValue.isHidden = true
            iconDropDownJobLevel.isHidden = true
        }
        if isNumberOfPost == true{
            heightConstnumberOfPost.constant -= 75
            heightConstraintMainSubView.constant -= 75
            heightConstraintMainView.constant -= 75
            viewNumberOfPost.isHidden = true
            lblNumberOfPostKey.isHidden = true
            txtNumberFieldValue.isHidden = true
        }
        if isSkills == true{
            heightConstSkills.constant -= 75
            heightConstraintMainSubView.constant -= 75
            heightConstraintMainView.constant -= 75
            viewSkills.isHidden = true
            lblJobSkillKey.isHidden = true
            lblJobSkillValue.isHidden = true
        }
        if isJobTags == true{
            heightConstjobTags.constant -= 75
            heightConstraintMainSubView.constant -= 88
            heightConstraintMainView.constant -= 88
            viewjobTags.isHidden = true
            lblJobTag.isHidden = true
        }
        
        
    }
    
    @objc override func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
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
        
        
        let cotName  = UserDefaults.standard.string(forKey: "coName")
        let cot2Name  = UserDefaults.standard.string(forKey: "coName")
        let cot3Name  = UserDefaults.standard.string(forKey: "coName")
        let cot4Name  = UserDefaults.standard.string(forKey: "coName")
        let cotKey = UserDefaults.standard.integer(forKey: "coKey")
        let cot2Key = UserDefaults.standard.integer(forKey: "co2Key")
        let cot3Key = UserDefaults.standard.integer(forKey: "co3Key")
        let cot4Key = UserDefaults.standard.integer(forKey: "co4Key")
        dropDownCountr.tag = cotKey
        self.lblCountryValue.text = cotName
        dropDownStat.tag = cot2Key
        self.lblCountryValue.text = cot2Name
        dropDownCit.tag = cot3Key
        self.lblCountryValue.text = cot3Name
        dropDownTow.tag = cot4Key
        self.lblCountryValue.text = cot4Name
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        txtJobTitle.nokri_updateBottomBorderSize()
        txtLatitude.nokri_updateBottomBorderSize()
        txtLongitude.nokri_updateBottomBorderSize()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //self.heightConstraintTableView.constant = self.tableView.contentSize.height
    }
    
    @objc func nokri_showNavController1(){
        appDelegate.nokri_moveToHome2()
    }
    @objc func nokri_showNavController2(){
        appDelegate.nokri_moveToSignIn()
    }
    func sendCatId(catId: Int) {
        print(catId)
        catIdPost = catId
    }
    func nokri_ltrRtl(){
        if isFromResumeRecv == false{
            let isRtl = UserDefaults.standard.string(forKey: "isRtl")
            if isRtl == "0"{
                self.addLeftBarButtonWithImage(#imageLiteral(resourceName: "menu"))
            }else{
                self.addRightBarButtonWithImage(#imageLiteral(resourceName: "menu"))
            }
        }
    }
    
    /* Updated for Swift 4 */
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    func nokri_dropDownIcons(){
        iconDropDownJobCat.image = iconDropDownJobCat.image?.withRenderingMode(.alwaysTemplate)
        iconDropDownJobCat.tintColor = UIColor(hex: appColorNew!)
        iconDropDownJobCatTwo.image = iconDropDownJobCatTwo.image?.withRenderingMode(.alwaysTemplate)
        iconDropDownJobCatTwo.tintColor = UIColor(hex: appColorNew!)
        iconDropDownJobCatThree.image = iconDropDownJobCatThree.image?.withRenderingMode(.alwaysTemplate)
        iconDropDownJobCatThree.tintColor = UIColor(hex: appColorNew!)
        iconDropDownJobCatFour.image = iconDropDownJobCatFour.image?.withRenderingMode(.alwaysTemplate)
        iconDropDownJobCatFour.tintColor = UIColor(hex: appColorNew!)
        iconDropDownQualification.image = iconDropDownQualification.image?.withRenderingMode(.alwaysTemplate)
        iconDropDownQualification.tintColor = UIColor(hex: appColorNew!)
        
        iconDropDownJobType.image = iconDropDownJobType.image?.withRenderingMode(.alwaysTemplate)
        iconDropDownJobType.tintColor = UIColor(hex: appColorNew!)
        iconDropDownSalaryType.image = iconDropDownSalaryType.image?.withRenderingMode(.alwaysTemplate)
        iconDropDownSalaryType.tintColor = UIColor(hex: appColorNew!)
        iconDropDownSalCurrency.image = iconDropDownSalCurrency.image?.withRenderingMode(.alwaysTemplate)
        iconDropDownSalCurrency.tintColor = UIColor(hex: appColorNew!)
        iconDropDownSalOffer.image = iconDropDownSalOffer.image?.withRenderingMode(.alwaysTemplate)
        iconDropDownSalOffer.tintColor = UIColor(hex: appColorNew!)
        iconDropDownExp.image = iconDropDownExp.image?.withRenderingMode(.alwaysTemplate)
        iconDropDownExp.tintColor = UIColor(hex: appColorNew!)
        iconDropdownJobShift.image = iconDropdownJobShift.image?.withRenderingMode(.alwaysTemplate)
        iconDropdownJobShift.tintColor = UIColor(hex:appColorNew!)
        iconDropDownJobLevel.image = iconDropDownJobLevel.image?.withRenderingMode(.alwaysTemplate)
        iconDropDownJobLevel.tintColor = UIColor(hex: appColorNew!)
        iconDropDownJobPostType.image = iconDropDownJobPostType.image?.withRenderingMode(.alwaysTemplate)
        iconDropDownJobPostType.tintColor = UIColor(hex: appColorNew!)
        iconDropDownJobSkill.image = iconDropDownJobSkill.image?.withRenderingMode(.alwaysTemplate)
        iconDropDownJobSkill.tintColor = UIColor(hex: appColorNew!)
        iconDropDownCountry.image = iconDropDownCountry.image?.withRenderingMode(.alwaysTemplate)
        iconDropDownCountry.tintColor = UIColor(hex: appColorNew!)
        iconDropDownState.image = iconDropDownState.image?.withRenderingMode(.alwaysTemplate)
        iconDropDownState.tintColor = UIColor(hex: appColorNew!)
        iconDropDownCity.image = iconDropDownCity.image?.withRenderingMode(.alwaysTemplate)
        iconDropDownCity.tintColor = UIColor(hex: appColorNew!)
        iconDropDownTown.image = iconDropDownTown.image?.withRenderingMode(.alwaysTemplate)
        iconDropDownTown.tintColor = UIColor(hex: appColorNew!)
        
    }
    
    //MARK:- IBActions
    
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
        vc!.delegate = self
        
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
    
    @IBAction func dropDownJobQualificationClicked(_ sender: UIButton) {
        dropDownJobQualificatio.show()
    }
    
    @IBAction func dropDownJopTypClicked(_ sender: UIButton) {
        dropDownJopTyp.show()
    }
    
    @IBAction func dropDownSalaryTypClicked(_ sender: UIButton) {
        dropDownSalaryTyp.show()
    }
    
    @IBAction func dropDownSalaryCurrencClicked(_ sender: UIButton) {
        dropDownSalaryCurrenc.show()
    }
    
    @IBAction func dropDownSallaryOffeClicked(_ sender: UIButton) {
        dropDownSallaryOffe.show()
    }
    
    @IBAction func dropDownJobExperiencClicked(_ sender: UIButton) {
        dropDownJobExperienc.show()
    }
    
    @IBAction func dropDownJobShifClicked(_ sender: UIButton) {
        dropDownJobShif.show()
    }
    
    @IBAction func dropDownJobLeveClicked(_ sender: UIButton) {
        dropDownJobLeve.show()
    }
    
    @IBAction func dropDownJobPostTy(_ sender: UIButton) {
        dropDownJobPostType.show()
    }
    
    @IBAction func btnJobSkillClicked(_ sender: UIButton) {
        nokri_multiCheckBoxData()
    }
    
    func onCheckboxPickerValueChange(_ component: DialogCheckboxViewEnum, values: TranslationDictionary) {
        print(component)
        var allselectedString : String = "";
        print(values.keys)
        for value in values.keys {
            print("\(value)");
            skilKeyArr.append(value);
            lblJobSkillValue.text = value
        }
        for value in values.values {
            print("\(value)");
            allselectedString += "\(value),"
        }
        self.lblJobSkillValue.text = allselectedString
        
    }
    
    @IBAction func btnDropDownCountryClicked(_ sender: UIButton) {
        //dropDownCountr.show()
        
        
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
    
    @IBAction func btnDropDownStateClicked(_ sender: UIButton) {
        dropDownStat.show()
    }
    
    @IBAction func btnDropDownCityClicked(_ sender: UIButton) {
        dropDownCit.show()
    }
    
    @IBAction func btnDropDownTownClicked(_ sender: UIButton) {
        dropDownTow.show()
    }
    
    @IBAction func btnJobPostClicked(_ sender: UIButton) {
        
        for tag in tagsField.tags{
            print(tag.text)
            tagsArray.append(tag.text)
        }
        
        //   print(tagsField.tags.)
        print(packagesValueArr)
        
        //let tit = UserDefaults.standard.string(forKey: "title")
        //let des = UserDefaults.standard.string(forKey: "desc")
        //let numPost = UserDefaults.standard.string(forKey: "vacan")
        //let loc = UserDefaults.standard.string(forKey: "loc")
        //let skill = UserDefaults.standard.string(forKey: "skil")
        //let ta = UserDefaults.standard.string(forKey: "tag")
        
        
         let userData = UserDefaults.standard.object(forKey: "settingsData")
        let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
        let dataTabs = SplashRoot(fromDictionary: objData)
        let all = dataTabs.data.extra.allField
        
        
        
        guard let jobTitle = txtJobTitle.text else {
            return
        }
        guard let numberOfPosts = txtNumberFieldValue.text else {
            return
        }
        guard let location = txtLocation.text else {
            return
        }
        
        if jobTitle == "" {
            let alert = Constants.showBasicAlert(message: all!)
            self.present(alert, animated: true, completion: nil)
        }
        else if richEditor.text == "" {
            let alert = Constants.showBasicAlert(message: all!)
            self.present(alert, animated: true, completion: nil)
        }
        else if numberOfPosts == "" {
            let alert = Constants.showBasicAlert(message: all!)
            self.present(alert, animated: true, completion: nil)
        }
        else if location == "" {
            let alert = Constants.showBasicAlert(message: all!)
            self.present(alert, animated: true, completion: nil)
        }
        else if self.lblJobSkillValue.text == ""{
            let alert = Constants.showBasicAlert(message: all!)
            self.present(alert, animated: true, completion: nil)
        }
        else if tagsArray.count == 0{
            let alert = Constants.showBasicAlert(message: all!)
            self.present(alert, animated: true, completion: nil)
        }
        else{
            
            guard let jobTitle = txtJobTitle.text else {
                return
            }
            guard let numberOfPosts = txtNumberFieldValue.text else {
                return
            }
            guard let location = txtLocation.text else {
                return
            }
            guard let latitude = txtLatitude.text else {
                return
            }
            guard let longitude = txtLongitude.text else {
                return
            }
            
            let id = UserDefaults.standard.string(forKey: "JobId")
            print("Id Is: \(String(describing: id))")
            
            let tag = tagsArray.joined(separator:",")
            print(tag)
            //let fulTag = tag + tagsField.text!
            //tagsField.text = tag
            
            var  jobPostTypeParam = ""
            
            if jobPostTypeValue == 2{
                jobPostTypeParam = "external_link"
            }
            if jobPostTypeValue == 3{
                jobPostTypeParam = "external_email"
            }
            if jobPostTypeValue == 4{
                jobPostTypeParam = "whatsapp"
            }
            if jobPostTypeValue == 0{
                jobPostTypeParam = ""
            }
            // catIdPost
            
            let param: [String: Any] = [
                "is_update" : id!,
                "job_id" : id!,
                "job_title": jobTitle,
                "job_cat":  dropDownJobCategory.tag,
                "job_cat_second": dropDownCategory2.tag,
                "job_cat_third": dropDownCategory3.tag,
                "job_cat_forth": dropDownCategory4.tag,
                "job_description": richEditor.text!,
                "job_date": lblApplicationDeadlineValue.text!,
                "job_qualif": dropDownJobQualificatio.tag,
                "job_type": dropDownJopTyp.tag,
                "job_salary_type": dropDownSalaryTyp.tag,
                "job_currency": dropDownSalaryCurrenc.tag,
                "job_salary": dropDownSallaryOffe.tag,
                "job_experience": dropDownJobExperienc.tag,
                "job_shift": dropDownJobShif.tag,
                "job_level": dropDownJobLeve.tag,
                "job_posts": numberOfPosts,
                "job_tags": tag, //tagsField.text!,
                "job_skills": self.skilKeyArr,
                "job_country": dropDownCountr.tag,
                "job_cities": dropDownStat.tag,
                "job_states": dropDownCit.tag,
                "job_town": dropDownTow.tag,
                "job_address": location,
                "job_lat": latitude,
                "job_long": longitude,
                "class_type_value": packagesValueArr,
                "job_qstns": questionsArray + questionFromEdit,
                jobPostTypeParam : txtJobPostLink.text!
            ]
            print(param)
            nokri_joPost(parameter: param as NSDictionary)
        }
    }
    
    @IBAction func txtLocationClicked(_ sender: UITextField) {
        isFromLocation = true
        let autoComplete = GMSAutocompleteViewController()
        autoComplete.delegate = self
        autoComplete.primaryTextHighlightColor = UIColor(hex: appColorNew!)
        self.locationManager.startUpdatingLocation()
        let filter = GMSAutocompleteFilter()
        filter.type = .address
        autoComplete.autocompleteFilter = filter
        self.present(autoComplete, animated: true, completion: nil)
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == txtJobTitle {
            txtJobTitle.nokri_updateBottomBorderColor(isTextFieldSelected: true)
        } else {
            txtJobTitle.nokri_updateBottomBorderColor(isTextFieldSelected: false)
        }
        if textField == txtLatitude {
            txtLatitude.nokri_updateBottomBorderColor(isTextFieldSelected: true)
        } else {
            txtLatitude.nokri_updateBottomBorderColor(isTextFieldSelected: false)
        }
        if textField == txtLongitude {
            txtLongitude.nokri_updateBottomBorderColor(isTextFieldSelected: true)
        } else {
            txtLongitude.nokri_updateBottomBorderColor(isTextFieldSelected: false)
        }
        return true
    }
    
    //MARK:- Table View
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return premiumArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "JobPostTableViewCell", for: indexPath) as! JobPostTableViewCell
        
        
        let filterArr = self.premiumArray as? [NSDictionary]
        for itemDict in filterArr! {
            if let keyObj = itemDict["key"] as? String{
                premiumKeyArr.append(keyObj)
            }
            if let valueObj = itemDict["value"] as? String{
                premiumValueArr.append(valueObj)
            }
            if let fieldObj = itemDict["fieldname"] as? String{
                premiumRemainigArr.append(fieldObj)
            }
            if let fieldTypeNameObj = itemDict["field_type_name"] as? Int{
                premiumUrgentArr.append(fieldTypeNameObj)
            }
//            if let fieldObj = itemDict["is_required"] as? Bool{
//
//            }
        }
        
        cell.lblTitle.text = premiumKeyArr[indexPath.row]
        cell.lblRemaining.text = "\(premiumValueArr[indexPath.row] + " " + premiumRemainigArr[indexPath.row])"
        
        if indexPath.row % 2 == 0{
            cell.viewBg.backgroundColor = UIColor(hex:"EFEFF4")
        }else{
            cell.viewBg.backgroundColor = UIColor.white
        }
        cell.lblValue.text =  premiumValueArr[indexPath.row]
        cell.btnCheckBox.tag = indexPath.row
        cell.btnCheckBox.addTarget(self, action: #selector(nokri_btnCheckBoxClicked(_:)), for: .touchUpInside)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
  
    @objc func nokri_btnCheckBoxClicked(_ sender:UICheckbox){
        
        print(sender.tag)
        
        let filterArr = self.premiumArray as? [NSDictionary]
        for itemDict in filterArr! {
            if let keyObj = itemDict["key"] as? String{
                premiumKeyArr.append(keyObj)
                
            }
            if let valueObj = itemDict["value"] as? String{
                premiumValueArr.append(valueObj)
            }
            if let fieldObj = itemDict["fieldname"] as? String{
                premiumRemainigArr.append(fieldObj)
            }
            if let urgObj = itemDict["field_type_name"] as? Int{
                premiumUrgentArr.append(urgObj)
                
            }
            
        }
        print("\(premiumValueArr[sender.tag])")
        packagesValueArr.append(premiumUrgentArr[sender.tag])
    }
    
    //MARK:- Custome Functions
    
    func nokri_boolChecks(){
        isShow2 = true
        isShow = true
        isShowSecond = true
        isShowSec = true
        isShowThird = true
        isShowThi = true
        isCountryShow = true
        isCountrySh = true
        isStateShow = true
        isStateSh = true
        isCityShow = true
        isCitySh = true
    }
    
    func nokri_tagFieldFunc(){
        tagsField.frame = tagsView.bounds
        tagsView.backgroundColor = UIColor.white
        tagsView.addSubview(tagsField)
    }
    
    func nokri_locationManagerFunc(){
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.startMonitoringSignificantLocationChanges()
    }
    
    func nokri_delegate(){
        tableView.dataSource = self
        tableView.delegate = self
        txtJobTitle.delegate = self
        txtLatitude.delegate = self
        txtLongitude.delegate = self
        txtJobTitle.nokri_addBottomBorder()
        txtLatitude.nokri_addBottomBorder()
        txtLongitude.nokri_addBottomBorder()
    }
    
    func nokri_viewHide(){
        viewJobCategoryTwo.isHidden = true
        viewJobCategoryThree.isHidden = true
        viewJobCategoryFour.isHidden = true
        heightConstraintJobCategoryView.constant -= 235
        heightConstraintMainView.constant -= 380
        viewState.isHidden = true
        viewCity.isHidden = true
        viewTown.isHidden = true
        heightConstraintViewCountry.constant -= 235
    }
  
    func nokri_multiCheckBoxData(){
        
        //var tableData :[(name: String, translated: String)]?
        //var jobSkillArr = [String]()
        var jobData = [(name: String, translated: String)]();
        let jobSkill = self.jobSkillArray as? [NSDictionary]
        for itemDict in jobSkill! {
            if let jobSkillObj = itemDict["value"] as? String{
                //jobData.append((name: jobSkillObj, translated: jobSkillObj))
                if let jobskey = itemDict["key"] as? Int{
                    jobData.append((name: "\(jobskey)", translated: jobSkillObj))
                }
            }
        }
    
        let userData = UserDefaults.standard.object(forKey: "settingsData")
        let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
        let dataTabs = SplashRoot(fromDictionary: objData)
        self.checkboxDialogViewController = CheckboxDialogViewController()
        self.checkboxDialogViewController.titleDialog = dataTabs.data.extra.skillT
        self.checkboxDialogViewController.tableData = jobData
        self.checkboxDialogViewController.componentName = DialogCheckboxViewEnum.countries
        self.checkboxDialogViewController.delegateDialogTableView = self
        self.checkboxDialogViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        self.present(self.checkboxDialogViewController, animated: false, completion: nil)
        
    }
    
    
    func nokri_dropDownSetup(){
        
        var selectedSkills = [String]()
        var selectedSkillsKey = [Int]()
        
        let jobSkill = self.jobSkillArray as? [NSDictionary]
        for itemDict in jobSkill! {
            
            if let sel = itemDict["selected"] as? Bool{
                if sel == true{
                    if let jobSkillObj = itemDict["value"] as? String{
                        
                        selectedSkills.append(jobSkillObj)
                        
                    }
                    
                    if let jobSkillObj = itemDict["key"] as? Int{
                        
                        selectedSkillsKey.append(jobSkillObj)
                        
                    }
                }
                
            }
        }
        
        let skillsAre = selectedSkills.joined(separator:",")
        lblJobSkillValue.text = skillsAre
        
        let skillArrayStringK = selectedSkillsKey.map { String($0) }
        
        let skillsAreKey = skillArrayStringK.joined(separator:",")
        skilKeyArr.append(skillsAreKey)
        
        
        
        //        var jobCatArr = [String]()
        //        var childArr = [Bool]()
        //        var keyArray = [Int]()
        //        var isJobCatSelected:Bool?
        //
        //        let jobCategory = self.jobCategoreisArray as? [NSDictionary]
        //
        //        for itemDict in jobCategory! {
        //            if let catObj = itemDict["value"] as? String{
        //                jobCatArr.append(catObj)
        //            }
        //            if let keyObj = itemDict["key"] as? Int{
        //                //catID = keyObj
        //                keyArray.append(keyObj)
        //            }
        //
        //            if let hasChild = itemDict["has_child"] as? Bool{
        //                print(hasChild)
        //                childArr.append(hasChild)
        //            }
        //
        //        }
        //
        //        for itemDict in jobCategory! {
        //
        //            if let selected = itemDict["selected"] as? Bool{
        //                isJobCatSelected = selected
        //                if isJobCatSelected == true{
        //
        //                    break
        //                }
        //            }
        //        }
        
        
        //
        //        if isFromEdit == 0{
        //
        //            if isJobSubCatFourSelected == true{
        //            self.lblJobCategoryValue.text = txtJobSubCatFour
        //                //self.dropDownJobCategory.tag = subCatId
        //            }
        //
        //            if select == true{
        //                let item = UserDefaults.standard.string(forKey: "item")
        //                self.lblJobCategoryValue.text = item
        //            }
        //            if select1 == true{
        //                let item = UserDefaults.standard.string(forKey: "item1")
        //                self.lblJobCategoryValueTwo.text = item
        //            }
        //            if select2 == true{
        //                let item = UserDefaults.standard.string(forKey: "item2")
        //                self.lblJobCategoryValueThree.text = item
        //            }
        //            if select3 == true{
        //                let item = UserDefaults.standard.string(forKey: "item3")
        //                self.lblJobCategoryValueFour.text = item
        //            }
        //
        //        }else{
        //            //self.lblJobCategoryValueTwo.text = jobSubCatArr[0]
        //            //self.dropDownCategory2.tag = keyArray2[0]
        //            if select == true{
        //                let item = UserDefaults.standard.string(forKey: "item")
        //                self.lblJobCategoryValue.text = item
        //            }
        //            if select1 == true{
        //                let item = UserDefaults.standard.string(forKey: "item1")
        //                self.lblJobCategoryValueTwo.text = item
        //            }
        //            if select2 == true{
        //                let item = UserDefaults.standard.string(forKey: "item2")
        //                self.lblJobCategoryValueThree.text = item
        //            }
        //            if select3 == true{
        //                let item = UserDefaults.standard.string(forKey: "item3")
        //                self.lblJobCategoryValueFour.text = item
        //            }
        //        }
        //
        //        if select3 == true{
        //            let item = UserDefaults.standard.string(forKey: "item3")
        //            self.lblJobCategoryValueFour.text = item
        //        }
        //
        //        dropDownCategory4.dataSource = jobSubCatArrr4
        //        if isJobSubCatFourSelected == true{
        //            self.lblJobCategoryValue.text = txtJobSubCatFour
        //        }else{
        //            //self.lblJobCategoryValueFour.text = jobSubCatArrr4[0]
        //        }
        //      //  self.lblJobCategoryValueFour.text = jobSubCatArrr4[0]
        //        dropDownCategory4.selectionAction = { [unowned self] (index: Int, item: String) in
        //            self.dropDownCategory4.tag = keyArray4[index]
        //            print("Selected item: \(item) at index: \(index)")
        //            UserDefaults.standard.set(true, forKey: "selected3")
        //            UserDefaults.standard.set(item, forKey: "item3")
        //            self.lblJobCategoryValueFour.text = item
        //        }
        
        
        var qualificationArr = [String]()
        var qualificationKeyArr = [Int]()
        var isQualificationSelected:Bool?
        var txtQualification:String?
        var selKeyIs = 0
        let qualification = self.qualificationArray as? [NSDictionary]
        for itemDict in qualification! {
            if let filterObj = itemDict["value"] as? String{
                qualificationArr.append(filterObj)
            }
            if let keyObj = itemDict["key"] as? Int{
                qualificationKeyArr.append(keyObj)
            }
        }
        
        for itemDict in qualification! {
            
            if let selected = itemDict["selected"] as? Bool{
                isQualificationSelected = selected
                if isQualificationSelected == true{
                    
                    if let catObj = itemDict["value"] as? String{
                        txtQualification = catObj
                    }
                    if let selKeyOk = itemDict["key"] as? Int{
                        selKeyIs = selKeyOk
                    }
                    
                    break
                }
            }
        }
        
        dropDownJobQualificatio.dataSource = qualificationArr
        if isQualificationSelected == true{
            self.lblJobQualificationValue.text = txtQualification
            self.dropDownJobQualificatio.tag = selKeyIs
            print(self.dropDownJobQualificatio.tag)
        }else{
            self.lblJobQualificationValue.text = qualificationArr[0]
            self.dropDownJobQualificatio.tag = qualificationKeyArr[0]
            print(self.dropDownJobQualificatio.tag)
        }
        
        dropDownJobQualificatio.selectionAction = { [unowned self] (index: Int, item: String) in
            self.dropDownJobQualificatio.tag = qualificationKeyArr[index]
            print("Selected item: \(item) at index: \(index)")
            self.lblJobQualificationValue.text = item
            print(self.dropDownJobQualificatio.tag)
        }
        dropDownJobQualificatio.reloadAllComponents()
        
        var jobtypeArray = [String]()
        var jobTypeKeyArr = [Int]()
        var isJobTypeSelected:Bool?
        var txtJobType:String?
        let jobType = self.jobTypeArray as? [NSDictionary]
        var typeKeyIs = 0
        for itemDict in jobType! {
            if let jobObj = itemDict["value"] as? String{
                jobtypeArray.append(jobObj)
            }
            if let keyObj = itemDict["key"] as? Int{
                
                jobTypeKeyArr.append(keyObj)
            }
            
        }
        
        for itemDict in jobType! {
            
            if let selected = itemDict["selected"] as? Bool{
                isJobTypeSelected  = selected
                
                if isJobTypeSelected == true{
                    
                    if let catObj = itemDict["value"] as? String{
                        txtJobType = catObj
                    }
                    if let typeKeyOk = itemDict["key"] as? Int{
                        typeKeyIs = typeKeyOk
                    }
                   
                    break
                }
            }
        }
        
        dropDownJopTyp.dataSource = jobtypeArray
        if isJobTypeSelected == true{
            self.dropDownJopTyp.tag = typeKeyIs
            self.lblJobTypeValue.text = txtJobType
        }else{
            self.lblJobTypeValue.text = jobtypeArray[0]
            self.dropDownJopTyp.tag = jobTypeKeyArr[0]
        }
        
        dropDownJopTyp.selectionAction = { [unowned self] (index: Int, item: String) in
            self.dropDownJopTyp.tag = jobTypeKeyArr[index]
            print("Selected item: \(item) at index: \(index)")
            self.lblJobTypeValue.text = item
        }
        dropDownJopTyp.reloadAllComponents()
        
        
        var salaryTypeArr = [String]()
        var salaryTypeKeyArr = [Int]()
        var isSalaryTypeSelected:Bool?
        var txtSalaryType:String?
        var salKeyIs = 0
        let salaryType = self.salaryArray as? [NSDictionary]
        
        for itemDict in salaryType! {
            if let salaryObj = itemDict["value"] as? String{
                salaryTypeArr.append(salaryObj)
            }
            if let keyObj = itemDict["key"] as? Int{
                salaryTypeKeyArr.append(keyObj)
            }
        }
        
        for itemDict in salaryType! {
            
            if let selected = itemDict["selected"] as? Bool{
                isSalaryTypeSelected  = selected
                
                if isSalaryTypeSelected == true{
                    
                    if let catObj = itemDict["value"] as? String{
                        txtSalaryType = catObj
                    }
                    if let salTpKeyOk = itemDict["key"] as? Int{
                        salKeyIs = salTpKeyOk
                    }
                    
                    break
                }
            }
        }
        
        dropDownSalaryTyp.dataSource = salaryTypeArr
        if isSalaryTypeSelected == true{
            self.lblSalaryTypeValue.text = txtSalaryType
            self.dropDownSalaryTyp.tag = salKeyIs
            
        }else{
            self.lblSalaryTypeValue.text = salaryTypeArr[0]
            self.dropDownSalaryTyp.tag = salaryTypeKeyArr[0]
        }
        
        dropDownSalaryTyp.selectionAction = { [unowned self] (index: Int, item: String) in
            self.dropDownSalaryTyp.tag = salaryTypeKeyArr[index]
            print("Selected item: \(item) at index: \(index)")
            self.lblSalaryTypeValue.text = item
        }
        dropDownSalaryTyp.reloadAllComponents()
        
        
        var salaryCurrArr = [String]()
        var salaryCurrKeyArr = [Int]()
        var isSalaryCurrencySelected:Bool?
        var txtSalaryCurrency:String?
        let salaryCurrency = self.salaryCurrencyArray as? [NSDictionary]
        var salCurIs = 0
        for itemDict in salaryCurrency! {
            if let salaryCurrObj = itemDict["value"] as? String{
                salaryCurrArr.append(salaryCurrObj)
            }
            if let keyObj = itemDict["key"] as? Int{
                salaryCurrKeyArr.append(keyObj)
            }
            if let selected = itemDict["selected"] as? Bool{
                isSalaryCurrencySelected = selected
                if isSalaryCurrencySelected == true{
                    if let catObj = itemDict["value"] as? String{
                        txtSalaryCurrency = catObj
                        //break
                    }
                }
            }
        }
        
        
        for itemDict in salaryCurrency! {
            
            if let selected = itemDict["selected"] as? Bool{
                isSalaryCurrencySelected  = selected
                
                if isSalaryCurrencySelected == true{
                    
                    if let catObj = itemDict["value"] as? String{
                        txtSalaryCurrency = catObj
                    }
                    if let salcurKeyOk = itemDict["key"] as? Int{
                        salCurIs = salcurKeyOk
                    }
                    
                    break
                }
            }
        }
        
        dropDownSalaryCurrenc.dataSource = salaryCurrArr
        if isSalaryCurrencySelected == true{
            self.lblSalaryCurrencyValue.text = txtSalaryCurrency
            self.dropDownSalaryCurrenc.tag = salCurIs
        }else{
            self.lblSalaryCurrencyValue.text = salaryCurrArr[0]
            self.dropDownSalaryCurrenc.tag = salaryCurrKeyArr[0]
        }
        
        dropDownSalaryCurrenc.selectionAction = { [unowned self] (index: Int, item: String) in
            self.dropDownSalaryCurrenc.tag = salaryCurrKeyArr[index]
            print("Selected item: \(item) at index: \(index)")
            self.lblSalaryCurrencyValue.text = item
            
        }
        dropDownSalaryCurrenc.reloadAllComponents()
        
        var salaryOfferArr = [String]()
        var salaryOfferKeyArr = [Int]()
        var isSalaryOfferSelected:Bool?
        var txtSalaryOffer:String?
        var isSalOffer = 0
        let salaryOffer = self.salaryOfferArray as? [NSDictionary]
        
        for itemDict in salaryOffer! {
            if let salaryOfferObj = itemDict["value"] as? String{
                salaryOfferArr.append(salaryOfferObj)
            }
            if let keyObj = itemDict["key"] as? Int{
                salaryOfferKeyArr.append(keyObj)
            }
        }
        
        for itemDict in salaryOffer! {
            if let selected = itemDict["selected"] as? Bool{
                isSalaryOfferSelected  = selected
                if isSalaryOfferSelected == true{
                    if let catObj = itemDict["value"] as? String{
                        txtSalaryOffer = catObj
                    }
                    if let salcurKeyOk = itemDict["key"] as? Int{
                        isSalOffer = salcurKeyOk
                    }
                    break
                }
            }
        }
        
        dropDownSallaryOffe.dataSource = salaryOfferArr
        if isSalaryOfferSelected == true{
            self.lblSalaryOfferValue.text = txtSalaryOffer
            self.dropDownSallaryOffe.tag = isSalOffer
        }else{
            self.lblSalaryOfferValue.text = salaryOfferArr[0]
            self.dropDownSallaryOffe.tag = salaryOfferKeyArr[0]
        }
        
        dropDownSallaryOffe.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.dropDownSallaryOffe.tag = salaryOfferKeyArr[index]
            self.lblSalaryOfferValue.text = item
            
        }
        
        var jobExperienceArr = [String]()
        var jobExperKeyArr = [Int]()
        var isExperienceSelected:Bool?
        var txtExperience:String?
        let jobExperience = self.jobExperienceArray as? [NSDictionary]
        var isJobExp = 0
        for itemDict in jobExperience! {
            if let jobExperienceObj = itemDict["value"] as? String{
                jobExperienceArr.append(jobExperienceObj)
            }
            if let keyObj = itemDict["key"] as? Int{
                jobExperKeyArr.append(keyObj)
            }
        }
        
        for itemDict in jobExperience! {
            
            if let selected = itemDict["selected"] as? Bool{
                isExperienceSelected  = selected
                
                if isExperienceSelected == true{
                    
                    if let catObj = itemDict["value"] as? String{
                        txtExperience = catObj
                    }
                    if let salcurKeyOk = itemDict["key"] as? Int{
                        isJobExp = salcurKeyOk
                    }
                    
                    break
                }
            }
        }
        
        dropDownJobExperienc.dataSource = jobExperienceArr
        if isExperienceSelected == true{
            self.lblJobExperienceValue.text = txtExperience
            self.dropDownJobExperienc.tag = isJobExp
        }else{
            self.lblJobExperienceValue.text = jobExperienceArr[0]
            self.dropDownJobExperienc.tag = jobExperKeyArr[0]
        }
        dropDownJobExperienc.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.dropDownJobExperienc.tag = jobExperKeyArr[index]
            self.lblJobExperienceValue.text = item
        }
        
        var jobShiftArr = [String]()
        var jobShiftKeyArr = [Int]()
        var isJobShiftSelected:Bool?
        var txtJobShift:String?
        var isJobshift = 0
        let jobShift = self.jobShiftArray as? [NSDictionary]
        for itemDict in jobShift! {
            if let jobShiftObj = itemDict["value"] as? String{
                jobShiftArr.append(jobShiftObj)
            }
            if let keyObj = itemDict["key"] as? Int{
                jobShiftKeyArr.append(keyObj)
            }
            if let selected = itemDict["selected"] as? Bool{
                isJobShiftSelected = selected
                if isJobShiftSelected == true{
                    if let catObj = itemDict["value"] as? String{
                        txtJobShift = catObj
                        //break
                    }
                }
            }
        }
        
        for itemDict in jobShift! {
            if let selected = itemDict["selected"] as? Bool{
                isJobShiftSelected  = selected
                
                if isJobShiftSelected == true{
                    
                    if let catObj = itemDict["value"] as? String{
                        txtJobShift = catObj
                    }
                    if let salcurKeyOk = itemDict["key"] as? Int{
                        isJobshift = salcurKeyOk
                    }
                    
                    break
                }
            }
        }
        
        dropDownJobShif.dataSource = jobShiftArr
        if isJobShiftSelected == true{
            self.lblJobShiftValue.text = txtJobShift
            self.dropDownJobShif.tag = isJobshift
        }else{
            self.lblJobShiftValue.text = jobShiftArr[0]
            self.dropDownJobShif.tag = jobShiftKeyArr[0]
        }
        
        dropDownJobShif.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.dropDownJobShif.tag = jobShiftKeyArr[index]
            self.lblJobShiftValue.text = item
        }
        
        var jobLevelArr = [String]()
        var jobLevelKeyArr = [Int]()
        var isJobLevelSelected:Bool?
        var txtJobLevel:String?
        var isJobLeV = 0
        let jobLevel = self.jobLevelArray as? [NSDictionary]
        for itemDict in jobLevel! {
            if let jobLevelObj = itemDict["value"] as? String{
                jobLevelArr.append(jobLevelObj)
            }
            if let keyObj = itemDict["key"] as? Int{
                jobLevelKeyArr.append(keyObj)
            }
        }
        
        for itemDict in jobLevel! {
            
            if let selected = itemDict["selected"] as? Bool{
                isJobLevelSelected  = selected
                if isJobLevelSelected == true{
                    if let catObj = itemDict["value"] as? String{
                        txtJobLevel = catObj
                    }
                    if let salcurKeyOk = itemDict["key"] as? Int{
                        isJobLeV = salcurKeyOk
                    }
                    break
                }
            }
        }
        
        dropDownJobLeve.dataSource = jobLevelArr
        if isJobLevelSelected == true{
            self.lblJobLevelValue.text = txtJobLevel
            self.dropDownJobLeve.tag = isJobLeV
        }else{
            self.lblJobLevelValue.text = jobLevelArr[0]
            self.dropDownJobLeve.tag = jobLevelKeyArr[0]
        }
        
        dropDownJobLeve.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.dropDownJobLeve.tag = jobLevelKeyArr[index]
            self.lblJobLevelValue.text = item
        }
        
        var jobPostTypeArr = [String]()
        var jobPostTypeKeyArr = [Int]()
        var isPostTypeSelected:Bool?
        var txtPostType:String?
        var isJobPostType = 0
        var txtJobTypePost = ""
        let jobPostType = self.jobPostTypeArray as? [NSDictionary]
        for itemDict in jobPostType! {
            if let jobLevelObj = itemDict["value"] as? String{
                jobPostTypeArr.append(jobLevelObj)
            }
            if let keyObj = itemDict["key"] as? Int{
                jobPostTypeKeyArr.append(keyObj)
            }
        }
  
        if is_show == 2{
            viewJobPostType.isHidden = false
            self.viewJobPostLink.isHidden = true
            self.heightConstViewJobPostLink.constant = 0
        }else{
            viewJobPostType.isHidden = true
            heightConstraintJobPostType.constant = 0
            self.viewJobPostLink.isHidden = false
            self.heightConstViewJobPostLink.constant = 0
            self.lblJobPostLink.isHidden = true
            self.txtJobPostLink.isHidden = true
            self.separatorJobPostLink.isHidden = true
            self.separatorJobPostType.isHidden = true
            self.lblJobPostType.isHidden = true
            self.lblJobPostTypeValue.isHidden = true
        }
        
        for itemDict in jobPostType! {
            if let selected = itemDict["selected"] as? Bool{
                isPostTypeSelected  = selected
                if isPostTypeSelected == true{
                    if let catObj = itemDict["value"] as? String{
                        txtPostType = catObj
                    }
                    if let salcurKeyOk = itemDict["key"] as? Int{
                        isJobPostType = salcurKeyOk
                    }
                    if let catObj = itemDict["val"] as? String{
                        txtJobTypePost = catObj
                    }
                    if let salcurKeyOk = itemDict["slug"] as? String{
                        slugJobPostType = salcurKeyOk
                    }
                    break
                }
            }
        }
        
        if isPostTypeSelected == true{
            if slugJobPostType == "External link"{
                self.viewJobPostLink.isHidden = false
                self.heightConstViewJobPostLink.constant = 75
                if let userData = UserDefaults.standard.object(forKey: "settingsData") {
                    let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
                    let dataTabs = SplashRoot(fromDictionary: objData)
                    let objExtraTxt = dataTabs.data.extra
                    self.lblJobPostLink.text = objExtraTxt?.external_link
                    self.txtJobPostLink.text = txtJobTypePost
                    self.lblJobPostTypeValue.text = txtPostType
                    
                }
                self.jobPostTypeValue =  2
            }else if slugJobPostType == "Email"{
                self.viewJobPostLink.isHidden = false
                self.heightConstViewJobPostLink.constant = 75
                
                if let userData = UserDefaults.standard.object(forKey: "settingsData") {
                    let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
                    let dataTabs = SplashRoot(fromDictionary: objData)
                    let objExtraTxt = dataTabs.data.extra
                    self.lblJobPostLink.text = objExtraTxt?.external_email_link
                    self.txtJobPostLink.text = txtJobTypePost
                    self.lblJobPostTypeValue.text = txtPostType
                }
                self.jobPostTypeValue = 3
            }else if slugJobPostType == "whatsapp"{
                self.viewJobPostLink.isHidden = false
                self.heightConstViewJobPostLink.constant = 75
                
                if let userData = UserDefaults.standard.object(forKey: "settingsData") {
                    let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
                    let dataTabs = SplashRoot(fromDictionary: objData)
                    let objExtraTxt = dataTabs.data.extra
                    self.lblJobPostLink.text = objExtraTxt?.external_email_link
                    self.txtJobPostLink.text = txtJobTypePost
                    self.lblJobPostTypeValue.text = txtPostType
                }
                self.jobPostTypeValue = 4
            }else{
                 self.lblJobPostTypeValue.text = txtPostType
                 self.jobPostTypeValue = 1
            }
        }
            dropDownJobPostType.dataSource = jobPostTypeArr
            if isPostTypeSelected == true{
                self.lblJobPostTypeValue.text = txtPostType
                self.dropDownJobPostType.tag = isJobPostType
            }else{
                self.lblJobPostTypeValue.text = jobPostTypeArr[0]
                self.dropDownJobPostType.tag = jobPostTypeKeyArr[0]
            }
            
            dropDownJobPostType.selectionAction = { [unowned self] (index: Int, item: String) in
                print("Selected item: \(item) at index: \(index)")
                self.dropDownJobPostType.tag = jobPostTypeKeyArr[index]
                self.lblJobPostTypeValue.text = item
                print(jobPostTypeKeyArr[index])
                
                if jobPostTypeKeyArr[index] == 1{
                    self.viewJobPostLink.isHidden = false
                    self.heightConstViewJobPostLink.constant = 0
                    self.lblJobPostLink.isHidden = true
                    self.txtJobPostLink.isHidden = true
                    self.separatorJobPostLink.isHidden = true
                    self.jobPostTypeValue = 0
                    
                }else if jobPostTypeKeyArr[index] == 2{
                    self.viewJobPostLink.isHidden = false
                    self.heightConstViewJobPostLink.constant = 75
                    if let userData = UserDefaults.standard.object(forKey: "settingsData") {
                        let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
                        let dataTabs = SplashRoot(fromDictionary: objData)
                        let objExtraTxt = dataTabs.data.extra
                        self.lblJobPostLink.text = objExtraTxt?.external_link
                        self.txtJobPostLink.placeholder = objExtraTxt?.external_link
                    }
                    self.jobPostTypeValue =  2
                    
                }else if jobPostTypeKeyArr[index] == 3 {
                    self.viewJobPostLink.isHidden = false
                    self.heightConstViewJobPostLink.constant = 75
                    
                    if let userData = UserDefaults.standard.object(forKey: "settingsData") {
                        let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
                        let dataTabs = SplashRoot(fromDictionary: objData)
                        let objExtraTxt = dataTabs.data.extra
                        self.lblJobPostLink.text = objExtraTxt?.external_email_link
                        self.txtJobPostLink.placeholder = objExtraTxt?.external_email_link
                        
                    }
                    self.jobPostTypeValue = 3
                    
                }else if jobPostTypeKeyArr[index] == 4 {
                    self.viewJobPostLink.isHidden = false
                    self.heightConstViewJobPostLink.constant = 75
                    
                    if let userData = UserDefaults.standard.object(forKey: "settingsData") {
                        let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
                        let dataTabs = SplashRoot(fromDictionary: objData)
                        let objExtraTxt = dataTabs.data.extra
                        self.lblJobPostLink.text = objExtraTxt?.whtsapp
                        self.txtJobPostLink.placeholder = objExtraTxt?.whtsapp
                        
                    }
                    self.jobPostTypeValue = 4
                    
                }else{
                    self.viewJobPostLink.isHidden = false
                    self.heightConstViewJobPostLink.constant = 0
                    self.lblJobPostLink.isHidden = true
                    self.txtJobPostLink.isHidden = true
                    self.separatorJobPostLink.isHidden = true
                }
                
            }
   
            dropDownJobCategory.anchorView = btnDropDownJobCategory
            dropDownCategory2.anchorView = btnDropDownJobCategoryTwo
            dropDownCategory3.anchorView = btnJobCategoryThree
            dropDownCategory4.anchorView = btnJobCategoryFour
            dropDownJobQualificatio.anchorView = dropDownJobQualification
            dropDownJopTyp.anchorView = dropDownJopType
            dropDownSalaryTyp.anchorView = dropDownSalaryType
            dropDownSalaryCurrenc.anchorView = dropDownSalaryCurrency
            dropDownSallaryOffe.anchorView = dropDownSallaryOffer
            dropDownJobExperienc.anchorView = dropDownJobExperience
            dropDownJobShif.anchorView = dropDownJobShift
            dropDownJobLeve.anchorView = dropDownJobLevel
            dropDownCountr.anchorView = dropDownCountry
            dropDownStat.anchorView = dropDownState
            dropDownCit.anchorView = dropDownCity
            dropDownTow.anchorView = dropDownTown
            dropDownJobPostType.anchorView = dropDownJobPostT
            
            
            DropDown.startListeningToKeyboard()
            DropDown.appearance().textColor = UIColor.black
            DropDown.appearance().textFont = UIFont.systemFont(ofSize: 12)
            DropDown.appearance().backgroundColor = UIColor.white
            DropDown.appearance().selectionBackgroundColor = UIColor(hex:appColorNew!)
            DropDown.appearance().cellHeight = 40
            
        }
        
        func nokri_buttonStyle(){
            
            btnPostJob.layer.cornerRadius = 18
            btnPostJob.backgroundColor = UIColor(hex:appColorNew!)
            
        }
        
        //MARK:- Tag Field
        
        func nokri_tagField(){
            
            tagsField.delegate = self
            tagsField.spaceBetweenTags = 3
            tagsField.layoutMargins = UIEdgeInsets(top: 0, left: 3, bottom: 2, right: 3)
            tagsField.placeholder = "Enter a tag"
            tagsField.font = .systemFont(ofSize: 12.0)
            tagsField.backgroundColor = .white
            tagsField.returnKeyType = .next
            tagsField.delimiter = ","
            tagsField.maxHeight = 55
            tagsField.enableScrolling = false
            nokri_textFieldEvents()
            //tagsField.isDelimiterVisible = true
            
        }
        
        func nokri_textFieldEvents() {
            tagsField.onDidAddTag = { _, _ in
                print("onDidAddTag")
                
            }
            
            tagsField.onDidRemoveTag = { _, _ in
                print("onDidRemoveTag")
                
            }
            
            tagsField.onDidChangeText = { _, text in
                print("onDidChangeText")
            }
            
            tagsField.onDidChangeHeightTo = { _, height in
                
                print("HeightTo \(height)")
            }
            
            tagsField.onDidSelectTagView = { _, tagView in
                print("Select \(tagView)")
            }
            
            tagsField.onDidUnselectTagView = { _, tagView in
                print("Unselect \(tagView)")
            }
        }
        
        
        //MARK:- Map
        
        struct Place {
            let id: Int
            let name: String
            let lat: CLLocationDegrees
            let lng: CLLocationDegrees
            let icon: String
        }
        
        func nokri_map(lat:String,long:String){
            let camera = GMSCameraPosition.camera(withLatitude: (lat as NSString).doubleValue, longitude: (long as NSString).doubleValue, zoom: 12)
            // mapView.delegate = self
            mapView.isMyLocationEnabled = true
            mapView.settings.myLocationButton = true
            self.mapView.camera = camera
            
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2DMake((lat as NSString).doubleValue, (long as NSString).doubleValue)
            marker.appearAnimation = GMSMarkerAnimation.pop
            marker.title = txtLocation.text
            marker.snippet = txtLocation.text
            marker.infoWindowAnchor = CGPoint(x:0.5 , y: 0)
            marker.icon = UIImage(named: "marker")
            marker.map = self.mapView
            
        }
        
        //MARK:- CLLocation Manager Delegate
        
        func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            
            print("Error While get locations \(error)")
        }
        
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            let locations = locations.last
            let camera = GMSCameraPosition.camera(withLatitude: (locations?.coordinate.latitude)!, longitude: (locations?.coordinate.longitude)!, zoom: 17.0)
            self.mapView.animate(to: camera)
            self.locationManager.stopUpdatingLocation()
            
        }
        
        //MARK:- GMSAutocomplete Delegate
        
        func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
            
            let camera = GMSCameraPosition.camera(withLatitude: (place.coordinate.latitude), longitude: (place.coordinate.longitude), zoom: 17.0)
            self.mapView.animate(to: camera)
            
            //let autoComplete = GMSAutocompleteViewController()
            txtLatitude.text = "\(place.coordinate.latitude)"
            txtLongitude.text = "\(place.coordinate.longitude)"
            txtLocation.text = place.formattedAddress
            self.dismiss(animated: true, completion: nil)
            
        }
        
        func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
            
            print("Error Auto Complete \(error)")
        }
        
        func wasCancelled(_ viewController: GMSAutocompleteViewController) {
            
            self.dismiss(animated: true, completion: nil)
        }
        
        func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        }
        
        func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
        
        //MARK:- GMSMapViewDelegate
        
        func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
            
            self.mapView.isMyLocationEnabled = true
            
        }
        
        func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
            
            self.mapView.isMyLocationEnabled = true
            if (gesture){
                mapView.selectedMarker = nil
            }
            
        }
        
        func didTapMyLocationButton(for mapView: GMSMapView) -> Bool {
            
            txtLatitude.text = "\((mapView.myLocation?.coordinate.latitude)!)"
            txtLongitude.text = "\((mapView.myLocation?.coordinate.longitude)!)"
            
            let camera = GMSCameraPosition.camera(withLatitude: (mapView.myLocation?.coordinate.latitude)!, longitude: (mapView.myLocation?.coordinate.longitude)!, zoom: 12)
            
            mapView.isMyLocationEnabled = true
            mapView.settings.myLocationButton = true
            self.mapView.camera = camera
            
            
            let geoCoder = CLGeocoder()
            let location = CLLocation(latitude: (mapView.myLocation?.coordinate.latitude)!, longitude: (mapView.myLocation?.coordinate.longitude)!)
            geoCoder.reverseGeocodeLocation(location, completionHandler:
                {
                    placemarks, error -> Void in
                    
                    // Place details
                    guard let placeMark = placemarks!.first else { return }
                    var streetName = ""
                    var countryName = ""
                    // Location name
                    if let locationName = placeMark.location {
                        print(locationName)
                    }
                    // Street address
                    if let street = placeMark.thoroughfare {
                        print(street)
                        streetName = "\(street)"
                    }
                    // City
                    if let city = placeMark.subAdministrativeArea {
                        print(city)
                    }
                    // Zip code
                    if let zip = placeMark.isoCountryCode {
                        print(zip)
                    }
                    // Country
                    if let country = placeMark.country {
                        print(country)
                        countryName = "\(country)"
                    }
                    
                    self.txtLocation.text = "\(streetName)" + ", \(countryName)"
            })
            
            return true
        }
        
        
        //MARK:- API Calls
        
        
        func nokri_jobPostDataFromEdit(){
            
            
            var langCode = UserDefaults.standard.string(forKey: "langCode")
            if langCode == nil {
                langCode = "en"
            }
            
            self.showLoader()
            var lati = ""
            var longi = ""
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
  
                            let jobQues = data["job_questions"] as? NSArray
                            self.questionFromEdit = jobQues as! [String]
                            
                            let questionInfo = data["questionnair_sec"] as! NSDictionary
                            if let questionLbl = questionInfo["question_lable"]{
                                self.questionLbl = (questionLbl as? String)!
                            }
                            if let questionPlace = questionInfo["question_plc"]{
                                self.questionPlaceholder = (questionPlace as? String)!
                            }
                            if let qText = questionInfo["sec_heading"]{
                                self.questionText = (qText as? String)!
                                self.lblAddQues.text = qText as? String
                            }
                            if let noText = questionInfo["btn_no"]{
                                self.noText = (noText as? String)!
                            }
                            if let yesText = questionInfo["btn_yes"]{
                                self.yesText = (yesText as? String)!
                            }
                            if let isShowQuestion = questionInfo["questionnaire_switch"]{
                                self.isShowQuestion = (isShowQuestion as? String)!
                            }
                            
                            if self.isShowQuestion == "0"{
                                self.viewShowQuestion.isHidden = true
                                self.heightConstrainAddQues.constant = 0
                                self.lblAddQues.isHidden = true
                                self.segmentedControl.isHidden = true
                                
                            }else{
                                self.viewShowQuestion.isHidden = false
                                self.heightConstrainAddQues.constant += 50
                                self.lblAddQues.isHidden = false
                                self.segmentedControl.isHidden = false
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
                            if let jobTitle = jobTitle["key"]{
                                //self.txtJobTitle.text = jobTitle as? String
                                self.lblJobName.text = jobTitle as? String
                                self.txtJobTitle.placeholder = jobTitle as? String
                            }
                            if let jobTitle = jobTitle["value"]{
                                self.txtJobTitle.text = jobTitle as? String
                            }
                            let jobDescription = data["job_desc"] as! NSDictionary
                            if let jobDes = jobDescription["key"]{
                                self.lblJobDesc.text = jobDes as? String
                                self.lblJobDescSecond.text = jobDes as? String
                                
                            }
                            if let value = jobDescription["value"]{
                                self.richEditor.text = value as? String
                                //heightConsRichView.constant =
                            }
                            let jobDeadline = data["job_deadline"] as! NSDictionary
                            if let deadline = jobDeadline["key"]{
                                self.lblApplicationDeadlineKey.text = deadline as? String
                                
                            }
                            if let deadlin = jobDeadline["value"]{
                                self.lblApplicationDeadlineValue.text = deadlin as? String
                                
                            }
                            let jobQualificaton = data["job_qualifications"] as! NSDictionary
                            let keyJobQualification = jobQualificaton["key"] as! String
                            self.lblJobQualificationKey.text = keyJobQualification
                            if let qualificationArr = jobQualificaton["value"] as? NSArray {
                                self.nokri_qualificationDataParser(qualificationArr: qualificationArr)
                            }
                            let jobType = data["job_type"] as! NSDictionary
                            let jobTypeKey = jobType["key"] as! String
                            self.lblJobTypeKey.text = jobTypeKey
                            if let jobTypeArray = jobType["value"] as? NSArray {
                                self.nokri_jobTypeDataParser(jobtypeArr: jobTypeArray)
                            }
                            let salary = data["salary_type"] as! NSDictionary
                            let salaryKey = salary["key"] as! String
                            self.lblSalaryTypeKey.text = salaryKey
                            if let salaryTypeArray = salary["value"] as? NSArray {
                                self.nokri_salaryTypeDataParser(salTypeArr: salaryTypeArray)
                            }
                            let salaryCurrency = data["salary_currency"] as! NSDictionary
                            let salaryCurrencyKey = salaryCurrency["key"] as! String
                            self.lblSalaryCurrencyKey.text = salaryCurrencyKey
                            if let salaryCurrencyArr = salaryCurrency["value"] as? NSArray {
                                self.nokri_salaryCurrencyDataParser(salCurrAr: salaryCurrencyArr)
                            }
                            let salaryOffer = data["salary_offer"] as! NSDictionary
                            let salaryOfferKey = salaryOffer["key"] as! String
                            self.lblSalaryOfferKey.text = salaryOfferKey
                            if let salaryOfferArr = salaryOffer["value"] as? NSArray {
                                self.nokri_salaryOfferDataParser(salOfferAr: salaryOfferArr)
                            }
                            let jobExperience = data["job_experience"] as! NSDictionary
                            let jobExperienceKey = jobExperience["key"] as! String
                            self.lblJobExperienceKey.text = jobExperienceKey
                            if let jobExperieneArr = jobExperience["value"] as? NSArray {
                                self.nokri_jobExperienceDataParser(jobExpArr: jobExperieneArr)
                            }
                            let jobShift = data["job_shift"] as! NSDictionary
                            let jobShiftKey = jobShift["key"] as! String
                            self.lblJobShiftKey.text = jobShiftKey
                            if let jobShiftArr = jobShift["value"] as? NSArray {
                                self.nokri_jobShiftDataParser(jobShiftArr: jobShiftArr)
                            }
                            let jobLevel = data["job_level"] as! NSDictionary
                            let jobLevelKey = jobLevel["key"] as! String
                            self.lblJobLevelKey.text = jobLevelKey
                            if let jobLevelArr = jobLevel["value"] as? NSArray {
                                self.nokri_jobLevelDataParser(jobLevelArr: jobLevelArr)
                            }
                            let jobPostTpe = data["job_apply_with"] as! NSDictionary
                            if let keyObj = jobPostTpe["is_show"] as? Int{
                                self.is_show = keyObj
                            }
                            let jobPostTypeKey = jobPostTpe["key"] as! String
                            self.lblJobPostType.text = jobPostTypeKey
                            
                            if let jobLevelArr = jobPostTpe["value"] as? NSArray {
                                self.nokri_jobPostTypeDataParser(jobPostTypeArr: jobLevelArr)
                            }
                            
                            let noOfPosition = data["job_no_pos"] as! NSDictionary
                            if let noTitle = noOfPosition["key"]{
                                self.lblNumberOfPostKey.text = noTitle as? String
                                self.txtNumberFieldValue.placeholder = noTitle as? String
                            }
                            if let noTitle = noOfPosition["value"]{
                                self.txtNumberFieldValue.text = noTitle as? String
                            }
                            let jobSkill = data["job_skills"] as! NSDictionary
                            let jobSkillKey = jobSkill["key"] as! String
                            self.lblJobSkillKey.text = jobSkillKey
                            if let jobSkillArr = jobSkill["value"] as? NSArray {
                                self.nokri_jobSkillDataParser(jobSkillArr: jobSkillArr)
                            }
                            let jobTags = data["job_tags"] as! NSDictionary
                            if let jobTag = jobTags["key"]{
                                self.lblJobTag.text = jobTag as? String
                                
                            }
                            
                            if let jobTag = jobTags["value"]{
                                // self.tagsField.text = jobTag as? String
                                let arr = (jobTag as AnyObject).components(separatedBy: ",")
                                for ob in arr{
                                    self.tagsField.addTag(ob)
                                }
                                //self.tagsArray.append((jobTag as? String)!)
                            }
                            
                            let location = data["job_location_head"] as! NSDictionary
                            if let loc = location["key"]{
                                self.lblLocationOnMap.text = loc as? String
                            }
                            
                            let setLocation = data["job_loc"] as! NSDictionary
                            if let setLoc = setLocation["key"]{
                                self.txtLocation.placeholder = setLoc as? String
                                if let setLocVal = setLocation["value"]{
                                    self.txtLocation.text = setLocVal as? String
                                }
                            }
                            
                            let latitude = data["job_lat"] as! NSDictionary
                            if let lat = latitude["key"]{
                                //self.txtLatitude.text = lat as? String
                                self.txtLatitude.placeholder = lat as? String
                                self.lblLat.text = lat as? String
                                lati = (lat as? String)!
                                
                                if let latVal = latitude["value"]{
                                    self.txtLatitude.text = latVal as? String
                                }
                            }
                            
                            let longitude = data["job_long"] as! NSDictionary
                            if let long = longitude["key"]{
                                // self.txtLongitude.text = long as? String
                                self.txtLongitude.placeholder = long as? String
                                self.lblLong.text = long as? String
                                longi = (long as? String)!
                                if let loVal = longitude["value"]{
                                    self.txtLongitude.text = loVal as? String
                                }
                            }
                            //let pageTitle = data["job_page_title"] as! NSDictionary
//                            if let page = pageTitle["key"]{
//                                //self.title = page as? String
//
//                            }
                            //                    let job_boost = data["job_boost"] as! NSDictionary
                            //                    if let jobBost = job_boost["key"]{
                            //                        self.lblBoostJob.text = jobBost as? String
                            //
                            //                    }
                            
                            if let premiumArray = data["premium_jobs"] as? NSArray {
                                self.nokri_premiumJobParser(premArray: premiumArray)
                                let job_boost = data["job_boost"] as! NSDictionary
                                if let jobBost = job_boost["key"]{
                                    self.lblBoostJob.text = jobBost as? String
                                }
                                if let isShowBoost = job_boost["is_show"]{
                                    self.isJobBoost = isShowBoost as! Bool
                                }
                                
                            }
                            
                            if self.premiumArray.count == 0{
                                self.tableView.isHidden = true
                            }
                            
                            //                        if let premiumArray = data["premium_jobs"] as? NSArray {
                            //                            self.nokri_premiumJobParser(premArray: premiumArray)
                            //                        }
                            
                            let jobCat = data["job_category"] as! NSDictionary
                            let jobCatKey = jobCat["key"] as! String
                            self.lblJobCategoryKey.text = jobCatKey
                            if let jobCatArr = jobCat["value"] as? NSArray {
                                self.nokri_jobCategoryDataParser(jobCatArr: jobCatArr)
                            }
                            
                            let jobCatSub = data["job_sub_category"] as! NSDictionary
                            let jobCatSubKey = jobCatSub["key"] as! String
                            self.lblJobCategoryKeyTwo.text = jobCatSubKey
                            if let jobCatArr2 = jobCatSub["value"] as? NSArray {
                                self.nokri_jobSubCatDataParser(jobCatArr: jobCatArr2)
                            }
                            
                            let jobCatSub2 = data["job_sub_sub_category"] as! NSDictionary
                            let jobCatSubKey2 = jobCatSub2["key"] as! String
                            self.lblJobCategoryKeyThree.text = jobCatSubKey2
//                            if let jobCatArr = jobCatSub2["value"] as? NSArray {
//                                // self.nokri_jobCategoryDataParser(jobCatArr: jobCatArr)
//
//                            }
                            if let jobCatArr3 = jobCatSub2["value"] as? NSArray {
                                self.nokri_jobSubCatDataParser2(jobCatArr2: jobCatArr3)
                            }
                            
                            
                            let jobCatSub3 = data["job_sub_sub_sub_category"] as! NSDictionary
                            let jobCatSubKey3 = jobCatSub3["key"] as! String
                            self.lblJobCategoryKeyFour.text = jobCatSubKey3
                            if let jobCatArr = jobCatSub3["value"] as? NSArray {
                                self.nokri_jobCategoryDataParser(jobCatArr: jobCatArr)
                            }
                            if let jobCatArr3 = jobCatSub3["value"] as? NSArray {
                                self.nokri_jobSubCatDataParser3(jobCatArr3: jobCatArr3)
                            }
                            
                            
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
                            if let countryArr = state["value"] as? NSArray {
                                self.nokri_stateDataParser(stateArr: countryArr)
                            }
                            
                            let city = data["job_city"] as! NSDictionary
                            let cityKey = city["key"] as! String
                            self.lblCity.text = cityKey
                            if let countryArr = city["value"] as? NSArray {
                                self.nokri_cityDataParser(cityArr: countryArr)
                            }
                            
                            
                            let town = data["job_town"] as! NSDictionary
                            let townKey = town["key"] as! String
                            self.lblTown.text = townKey
                            if let countryArr = town["value"] as? NSArray {
                                self.nokri_townDataParser(townArr: countryArr)
                            }
                            
                            let jobExpireDays = data["expiry_limit"] as! NSDictionary
                            self.jobInExpire = jobExpireDays["value"] as! Int
                            
                            let isJobTitleChange = data["is_restrict"] as! Bool
                            
                            if isJobTitleChange == false{
                                self.txtJobTitle.isEnabled = true
                            }else{
                                self.txtJobTitle.isEnabled = false
                                self.lblJobName.textColor = UIColor.lightGray
                            }
                     
                            self.nokri_dropDownSetup()
                            self.tableView.reloadData()
                            
                            
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
                            _ = ""
                            _ = ""
                            let data = responseData["data"] as! NSDictionary
                            //let job_id = data["job_id"] as! String

                            
                            let questionInfo = data["questionnair_sec"] as! NSDictionary
                            if let questionLbl = questionInfo["question_lable"]{
                                self.questionLbl = (questionLbl as? String)!
                            }
                            if let questionPlace = questionInfo["question_plc"]{
                                self.questionPlaceholder = (questionPlace as? String)!
                            }
                            if let qText = questionInfo["sec_heading"]{
                                self.questionText = (qText as? String)!
                                self.lblAddQues.text = qText as? String
                            }
                            if let noText = questionInfo["btn_no"]{
                                self.noText = (noText as? String)!
                            }
                            if let yesText = questionInfo["btn_yes"]{
                                self.yesText = (yesText as? String)!
                            }
                            if let isShowQuestion = questionInfo["questionnaire_switch"]{
                                self.isShowQuestion = (isShowQuestion as? String)!
                            }
                            
                            if self.isShowQuestion == "0"{
                                self.viewShowQuestion.isHidden = true
                                self.heightConstrainAddQues.constant = 0
                                self.lblAddQues.isHidden = true
                                self.segmentedControl.isHidden = true
                                
                            }else{
                                self.viewShowQuestion.isHidden = false
                                self.heightConstrainAddQues.constant += 50
                                self.lblAddQues.isHidden = false
                                self.segmentedControl.isHidden = false
                            }
                            
                            
                            let jobQues = data["job_questions"] as? NSArray
                            self.questionFromEdit = jobQues as! [String]
                            
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
                            if let jobTitle = jobTitle["key"]{
                                //self.txtJobTitle.text = jobTitle as? String
                                self.lblJobName.text = jobTitle as? String
                                self.txtJobTitle.placeholder = jobTitle as? String
                            }
                            if let jobTitle = jobTitle["value"]{
                                self.txtJobTitle.text = jobTitle as? String
                            }
                            let jobDescription = data["job_desc"] as! NSDictionary
                            if let jobDes = jobDescription["key"]{
                                self.lblJobDesc.text = jobDes as? String
                                self.lblJobDescSecond.text = jobDes as? String
                            }
                            if let value = jobDescription["value"]{
                                self.richEditor.text = (value as! String)
                                //heightConsRichView.constant =
                            }
                            let jobDeadline = data["job_deadline"] as! NSDictionary
                            if let deadline = jobDeadline["key"]{
                                self.lblApplicationDeadlineKey.text = deadline as? String
                            }
                            if let deadlin = jobDeadline["value"]{
                                self.lblApplicationDeadlineValue.text = deadlin as? String
                            }
                            let jobQualificaton = data["job_qualifications"] as! NSDictionary
                            let keyJobQualification = jobQualificaton["key"] as! String
                            self.lblJobQualificationKey.text = keyJobQualification
                            if let qualificationArr = jobQualificaton["value"] as? NSArray {
                                self.nokri_qualificationDataParser(qualificationArr: qualificationArr)
                            }
                            let jobType = data["job_type"] as! NSDictionary
                            let jobTypeKey = jobType["key"] as! String
                            self.lblJobTypeKey.text = jobTypeKey
                            if let jobTypeArray = jobType["value"] as? NSArray {
                                self.nokri_jobTypeDataParser(jobtypeArr: jobTypeArray)
                            }
                            let salary = data["salary_type"] as! NSDictionary
                            let salaryKey = salary["key"] as! String
                            self.lblSalaryTypeKey.text = salaryKey
                            if let salaryTypeArray = salary["value"] as? NSArray {
                                self.nokri_salaryTypeDataParser(salTypeArr: salaryTypeArray)
                            }
                            let salaryCurrency = data["salary_currency"] as! NSDictionary
                            let salaryCurrencyKey = salaryCurrency["key"] as! String
                            self.lblSalaryCurrencyKey.text = salaryCurrencyKey
                            if let salaryCurrencyArr = salaryCurrency["value"] as? NSArray {
                                self.nokri_salaryCurrencyDataParser(salCurrAr: salaryCurrencyArr)
                            }
                            let salaryOffer = data["salary_offer"] as! NSDictionary
                            let salaryOfferKey = salaryOffer["key"] as! String
                            self.lblSalaryOfferKey.text = salaryOfferKey
                            if let salaryOfferArr = salaryOffer["value"] as? NSArray {
                                self.nokri_salaryOfferDataParser(salOfferAr: salaryOfferArr)
                            }
                            let jobExperience = data["job_experience"] as! NSDictionary
                            let jobExperienceKey = jobExperience["key"] as! String
                            self.lblJobExperienceKey.text = jobExperienceKey
                            if let jobExperieneArr = jobExperience["value"] as? NSArray {
                                self.nokri_jobExperienceDataParser(jobExpArr: jobExperieneArr)
                            }
                            let jobShift = data["job_shift"] as! NSDictionary
                            let jobShiftKey = jobShift["key"] as! String
                            self.lblJobShiftKey.text = jobShiftKey
                            if let jobShiftArr = jobShift["value"] as? NSArray {
                                self.nokri_jobShiftDataParser(jobShiftArr: jobShiftArr)
                            }
                            let jobLevel = data["job_level"] as! NSDictionary
                            let jobLevelKey = jobLevel["key"] as! String
                            self.lblJobLevelKey.text = jobLevelKey
                            if let jobLevelArr = jobLevel["value"] as? NSArray {
                                self.nokri_jobLevelDataParser(jobLevelArr: jobLevelArr)
                            }
                            
                            let jobPostTpe = data["job_apply_with"] as! NSDictionary
                            
                            if let keyObj = jobPostTpe["is_show"] as? Int{
                                self.is_show = keyObj
                            }
                            
                            
                            let jobPostTypeKey = jobPostTpe["key"] as! String
                            self.lblJobPostType.text = jobPostTypeKey
                            if let jobLevelArr = jobPostTpe["value"] as? NSArray {
                                self.nokri_jobPostTypeDataParser(jobPostTypeArr: jobLevelArr)
                            }
                            
                            let noOfPosition = data["job_no_pos"] as! NSDictionary
                            if let noTitle = noOfPosition["key"]{
                                self.lblNumberOfPostKey.text = noTitle as? String
                                self.txtNumberFieldValue.placeholder = noTitle as? String
                            }
                            if let noTitle = noOfPosition["value"]{
                                self.txtNumberFieldValue.text = noTitle as? String
                            }
                            let jobSkill = data["job_skills"] as! NSDictionary
                            let jobSkillKey = jobSkill["key"] as! String
                            self.lblJobSkillKey.text = jobSkillKey
                            if let jobSkillArr = jobSkill["value"] as? NSArray {
                                self.nokri_jobSkillDataParser(jobSkillArr: jobSkillArr)
                            }
                            let jobTags = data["job_tags"] as! NSDictionary
                            if let jobTag = jobTags["key"]{
                                self.lblJobTag.text = jobTag as? String
                            }
                            if let jobTag = jobTags["value"]{
                                //self.tagsField.text = jobTag as? String
                                // self.tagsField.addTag((jobTag as? String)!)
                                //self.tagsArray.append((jobTag as? String)!)
                                let arr = (jobTag as AnyObject).components(separatedBy: ",")
                                for ob in arr{
                                    self.tagsField.addTag(ob)
                                }
                            }
                            
                            let location = data["job_location_head"] as! NSDictionary
                            if let loc = location["key"]{
                                self.lblLocationOnMap.text = loc as? String
                            }
                            let setLocation = data["job_loc"] as! NSDictionary
                            if let setLoc = setLocation["key"]{
                                self.txtLocation.placeholder = setLoc as? String
                                if let setLocVal = setLocation["value"]{
                                    self.txtLocation.text = setLocVal as? String
                                }
                            }
                            
                            let latitude = data["job_lat"] as! NSDictionary
                            if let lat = latitude["key"]{
                                //self.txtLatitude.text = lat as? String
                                self.txtLatitude.placeholder = lat as? String
                                self.lblLat.text = lat as? String
                                lati = (lat as? String)!
                                if let latVal = latitude["value"]{
                                    self.txtLatitude.text = latVal as? String
                                }
                            }
                            
                            let longitude = data["job_long"] as! NSDictionary
                            if let long = longitude["key"]{
                                // self.txtLongitude.text = long as? String
                                self.txtLongitude.placeholder = long as? String
                                self.lblLong.text = long as? String
                                longi = (long as? String)!
                                if let loVal = longitude["value"]{
                                    self.txtLongitude.text = loVal as? String
                                }
                            }
                            let pageTitle = data["job_page_title"] as! NSDictionary
                            if let page = pageTitle["key"]{
                                //self.title = page as? String
                                self.navigationController?.navigationBar.topItem?.title = page as? String
                                
                            }
                        
                            
                            if let premiumArray = data["premium_jobs"] as? NSArray {
                                self.nokri_premiumJobParser(premArray: premiumArray)
                                let job_boost = data["job_boost"] as! NSDictionary
                                if let jobBost = job_boost["key"]{
                                    self.lblBoostJob.text = jobBost as? String
                                }
                                if let isShowBoost = job_boost["is_show"]{
                                    self.isJobBoost = isShowBoost as! Bool
                                }
                            }
                            
                            if self.premiumArray.count == 0{
                                self.tableView.isHidden = true
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
                            if let jobCatArr2 = jobCatSub["value"] as? NSArray {
                                self.nokri_jobSubCatDataParser(jobCatArr: jobCatArr2)
                            }
                            
                            let jobCatSub2 = data["job_sub_sub_category"] as! NSDictionary
                            let jobCatSubKey2 = jobCatSub2["key"] as! String
                            self.lblJobCategoryKeyThree.text = jobCatSubKey2
//                            if let jobCatArr = jobCat["value"] as? NSArray {
//                                // self.nokri_jobCategoryDataParser(jobCatArr: jobCatArr)
//
//                            }
                            if let jobCatArr3 = jobCatSub2["value"] as? NSArray {
                                self.nokri_jobSubCatDataParser2(jobCatArr2: jobCatArr3)
                            }
                            
                            let jobCatSub3 = data["job_sub_sub_sub_category"] as! NSDictionary
                            let jobCatSubKey3 = jobCatSub3["key"] as! String
                            self.lblJobCategoryKeyFour.text = jobCatSubKey3
                            if let jobCatArr = jobCatSub3["value"] as? NSArray {
                                self.nokri_jobCategoryDataParser(jobCatArr: jobCatArr)
                            }
                            if let jobCatArr3 = jobCatSub3["value"] as? NSArray {
                                self.nokri_jobSubCatDataParser3(jobCatArr3: jobCatArr3)
                            }
                     
                            
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
                            if let countryArr = state["value"] as? NSArray {
                                self.nokri_stateDataParser(stateArr: countryArr)
                            }
                            
                            let city = data["job_city"] as! NSDictionary
                            let cityKey = city["key"] as! String
                            self.lblCity.text = cityKey
                            if let countryArr = city["value"] as? NSArray {
                                self.nokri_cityDataParser(cityArr: countryArr)
                            }
                            
                            let town = data["job_town"] as! NSDictionary
                            let townKey = town["key"] as! String
                            self.lblTown.text = townKey
                            if let countryArr = town["value"] as? NSArray {
                                self.nokri_townDataParser(townArr: countryArr)
                            }
                            
                            let jobExpireDays = data["expiry_limit"] as! NSDictionary
                            self.jobInExpire = jobExpireDays["value"] as! Int
                            
                            let isJobTitleChange = data["is_restrict"] as! Bool
                            
                            if isJobTitleChange == false{
                                self.txtJobTitle.isEnabled = true
                            }else{
                                self.txtJobTitle.isEnabled = false
                                self.lblJobName.textColor = UIColor.lightGray
                            }
                           
                            self.nokri_map(lat: lati, long: longi)
                            self.nokri_dropDownSetup()
                            self.tableView.reloadData()
                            
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
        
        func nokri_jobPostData(){
            
            
            var langCode = UserDefaults.standard.string(forKey: "langCode")
            if langCode == nil {
                langCode = "en"
            }
            
            self.showLoader()
            
            var email = ""
            var password = ""
            var lati = ""
            var longi = ""
            
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
                            
                            let questionInfo = data["questionnair_sec"] as! NSDictionary
                            if let questionLbl = questionInfo["question_lable"]{
                                self.questionLbl = (questionLbl as? String)!
                            }
                            if let questionPlace = questionInfo["question_plc"]{
                                self.questionPlaceholder = (questionPlace as? String)!
                            }
                            if let qText = questionInfo["sec_heading"]{
                                self.questionText = (qText as? String)!
                                self.lblAddQues.text = qText as? String
                            }
                            if let noText = questionInfo["btn_no"]{
                                self.noText = (noText as? String)!
                            }
                            if let yesText = questionInfo["btn_yes"]{
                                self.yesText = (yesText as? String)!
                            }
                            if let isShowQuestion = questionInfo["questionnaire_switch"]{
                                self.isShowQuestion = (isShowQuestion as? String)!
                            }
                            
                            if self.isShowQuestion == "0"{
                                self.viewShowQuestion.isHidden = true
                                self.heightConstrainAddQues.constant = 0
                                self.lblAddQues.isHidden = true
                                self.segmentedControl.isHidden = true
                                
                            }else{
                                self.viewShowQuestion.isHidden = false
                                self.heightConstrainAddQues.constant += 50
                                self.lblAddQues.isHidden = false
                                self.segmentedControl.isHidden = false
                            }
                            
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
                            let jobDescription = data["job_desc"] as! NSDictionary
                            if let jobDes = jobDescription["key"]{
                                self.lblJobDesc.text = jobDes as? String
                                self.lblJobDescSecond.text = jobDes as? String
                                
                            }
                            let jobDeadline = data["job_deadline"] as! NSDictionary
                            if let deadline = jobDeadline["key"]{
                                self.lblApplicationDeadlineKey.text = deadline as? String
                                
                            }
                            if let deadlin = jobDeadline["value"]{
                                self.lblApplicationDeadlineValue.text = deadlin as? String
                                
                            }
                            if let deadline = jobDeadline["value"]{
                                self.lblApplicationDeadlineValue.text = deadline as? String
                                
                            }
                            let jobQualificaton = data["job_qualifications"] as! NSDictionary
                            let keyJobQualification = jobQualificaton["key"] as! String
                            self.lblJobQualificationKey.text = keyJobQualification
                            if let qualificationArr = jobQualificaton["value"] as? NSArray {
                                self.nokri_qualificationDataParser(qualificationArr: qualificationArr)
                            }
                            let jobType = data["job_type"] as! NSDictionary
                            let jobTypeKey = jobType["key"] as! String
                            self.lblJobTypeKey.text = jobTypeKey
                            if let jobTypeArray = jobType["value"] as? NSArray {
                                self.nokri_jobTypeDataParser(jobtypeArr: jobTypeArray)
                            }
                            let salary = data["salary_type"] as! NSDictionary
                            let salaryKey = salary["key"] as! String
                            self.lblSalaryTypeKey.text = salaryKey
                            if let salaryTypeArray = salary["value"] as? NSArray {
                                self.nokri_salaryTypeDataParser(salTypeArr: salaryTypeArray)
                            }
                            let salaryCurrency = data["salary_currency"] as! NSDictionary
                            let salaryCurrencyKey = salaryCurrency["key"] as! String
                            self.lblSalaryCurrencyKey.text = salaryCurrencyKey
                            if let salaryCurrencyArr = salaryCurrency["value"] as? NSArray {
                                self.nokri_salaryCurrencyDataParser(salCurrAr: salaryCurrencyArr)
                            }
                            let salaryOffer = data["salary_offer"] as! NSDictionary
                            let salaryOfferKey = salaryOffer["key"] as! String
                            self.lblSalaryOfferKey.text = salaryOfferKey
                            if let salaryOfferArr = salaryOffer["value"] as? NSArray {
                                self.nokri_salaryOfferDataParser(salOfferAr: salaryOfferArr)
                            }
                            let jobExperience = data["job_experience"] as! NSDictionary
                            let jobExperienceKey = jobExperience["key"] as! String
                            self.lblJobExperienceKey.text = jobExperienceKey
                            if let jobExperieneArr = jobExperience["value"] as? NSArray {
                                self.nokri_jobExperienceDataParser(jobExpArr: jobExperieneArr)
                            }
                            let jobShift = data["job_shift"] as! NSDictionary
                            let jobShiftKey = jobShift["key"] as! String
                            self.lblJobShiftKey.text = jobShiftKey
                            if let jobShiftArr = jobShift["value"] as? NSArray {
                                self.nokri_jobShiftDataParser(jobShiftArr: jobShiftArr)
                            }
                            let jobLevel = data["job_level"] as! NSDictionary
                            let jobLevelKey = jobLevel["key"] as! String
                            self.lblJobLevelKey.text = jobLevelKey
                            if let jobLevelArr = jobLevel["value"] as? NSArray {
                                self.nokri_jobLevelDataParser(jobLevelArr: jobLevelArr)
                            }
                            
                            let jobPostTpe = data["job_apply_with"] as! NSDictionary
                            if let keyObj = jobPostTpe["is_show"] as? Int{
                                self.is_show = keyObj
                            }
                            
                            let jobPostTypeKey = jobPostTpe["key"] as! String
                            self.lblJobPostType.text = jobPostTypeKey
                            if let jobLevelArr = jobPostTpe["value"] as? NSArray {
                                self.nokri_jobPostTypeDataParser(jobPostTypeArr: jobLevelArr)
                            }
                            
                            let noOfPosition = data["job_no_pos"] as! NSDictionary
                            if let noTitle = noOfPosition["key"]{
                                self.lblNumberOfPostKey.text = noTitle as? String
                                self.txtNumberFieldValue.placeholder = noTitle as? String
                            }
                            let jobSkill = data["job_skills"] as! NSDictionary
                            let jobSkillKey = jobSkill["key"] as! String
                            self.lblJobSkillKey.text = jobSkillKey
                            if let jobSkillArr = jobSkill["value"] as? NSArray {
                                self.nokri_jobSkillDataParser(jobSkillArr: jobSkillArr)
                            }
                            let jobTags = data["job_tags"] as! NSDictionary
                            if let jobTag = jobTags["key"]{
                                self.lblJobTag.text = jobTag as? String
                                
                            }
                            let location = data["job_location_head"] as! NSDictionary
                            if let loc = location["key"]{
                                self.lblLocationOnMap.text = loc as? String
                                
                            }
                            let setLocation = data["job_loc"] as! NSDictionary
                            if let setLoc = setLocation["key"]{
                                self.txtLocation.placeholder = setLoc as? String
                                
                            }
                            let latitude = data["job_lat"] as! NSDictionary
                            if let lat = latitude["key"]{
                                self.txtLatitude.text = lat as? String
                                self.txtLatitude.placeholder = lat as? String
                                self.lblLat.text = lat as? String
                                lati = (lat as? String)!
                            }
                            let longitude = data["job_long"] as! NSDictionary
                            if let long = longitude["key"]{
                                self.txtLongitude.text = long as? String
                                self.txtLongitude.placeholder = long as? String
                                self.lblLong.text = long as? String
                                longi = (long as? String)!
                                
                            }
                            let pageTitle = data["job_page_title"] as! NSDictionary
                            if let page = pageTitle["key"]{
                                //self.title = page as? String
                                self.navigationController?.navigationBar.topItem?.title = page as? String
                                
                            }
                            //                        let job_boost = data["job_boost"] as! NSDictionary
                            //                        if let jobBost = job_boost["key"]{
                            //                            self.lblBoostJob.text = jobBost as? String
                            //
                            //                        }
                            
                            if let premiumArray = data["premium_jobs"] as? NSArray {
                                self.nokri_premiumJobParser(premArray: premiumArray)
                                let job_boost = data["job_boost"] as! NSDictionary
                                if let jobBost = job_boost["key"]{
                                    self.lblBoostJob.text = jobBost as? String
                                }
                                
                                if let isShowBoost = job_boost["is_show"]{
                                    self.isJobBoost = isShowBoost as! Bool
                                }
                            }
                            
                            if self.premiumArray.count == 0{
                                self.tableView.isHidden = true
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
                            
                            let jobExpireDays = data["expiry_limit"] as! NSDictionary
                            self.jobInExpire = jobExpireDays["value"] as! Int
                            
                            
                            self.segmentedControl.itemTitles = [self.noText,self.yesText]
                            self.segmentedControl.didSelectItemWith = { (index, title) -> () in
                                print("Selected item \(index)")
                                if index == 0{
                                    
                                }else{
                                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "AddQuestionairViewController") as? AddQuestionairViewController
                                    
                                    vc?.qLblText = self.questionLbl
                                    vc?.qPlacehoderText = self.questionPlaceholder
                                    vc?.qTxt = self.questionText
                                    vc?.delegate = self
                                    vc?.questionsFromEdit = self.questionFromEdit
                                    vc?.isFromEdit = self.isFromEdit
                                    self.navigationController?.pushViewController(vc!, animated: true)
                                }
                            }
                            self.nokri_dropDownSetup()
                            self.tableView.reloadData()                            
                        }else{
                            let hud = JGProgressHUD(style: .dark)
                            hud.textLabel.text = messageResponse
                            hud.detailTextLabel.text = nil
                            hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                            hud.position = .bottomCenter
                            hud.show(in: self.view)
                            hud.dismiss(afterDelay: 2.0)
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
                print(emailPass)
                
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
                           // print(job_id)
                            self.jobIdNew = job_id
                        
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
                            
                            let questionInfo = data["questionnair_sec"] as! NSDictionary
                            if let questionLbl = questionInfo["question_lable"]{
                                self.questionLbl = (questionLbl as? String)!
                            }
                            if let questionPlace = questionInfo["question_plc"]{
                                self.questionPlaceholder = (questionPlace as? String)!
                            }
                            if let qText = questionInfo["sec_heading"]{
                                self.questionText = (qText as? String)!
                                self.lblAddQues.text = qText as? String
                            }
                            if let noText = questionInfo["btn_no"]{
                                self.noText = (noText as? String)!
                            }
                            if let yesText = questionInfo["btn_yes"]{
                                self.yesText = (yesText as? String)!
                            }
                            if let isShowQuestion = questionInfo["questionnaire_switch"]{
                                self.isShowQuestion = (isShowQuestion as? String)!
                            }
                            
                            if self.isShowQuestion == "0"{
                                self.viewShowQuestion.isHidden = true
                                self.heightConstrainAddQues.constant = 0
                                self.lblAddQues.isHidden = true
                                self.segmentedControl.isHidden = true
                                
                            }else{
                                self.viewShowQuestion.isHidden = false
                                self.heightConstrainAddQues.constant += 50
                                self.lblAddQues.isHidden = false
                                self.segmentedControl.isHidden = false
                            }
                            
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
                            let jobDescription = data["job_desc"] as! NSDictionary
                            if let jobDes = jobDescription["key"]{
                                self.lblJobDesc.text = jobDes as? String
                                self.lblJobDescSecond.text = jobDes as? String
                                
                            }
                            let jobDeadline = data["job_deadline"] as! NSDictionary
                            if let deadline = jobDeadline["key"]{
                                self.lblApplicationDeadlineKey.text = deadline as? String
                                
                            }
                            if let deadlin = jobDeadline["value"]{
                                self.lblApplicationDeadlineValue.text = deadlin as? String
                                
                            }
                            if let deadline = jobDeadline["value"]{
                                self.lblApplicationDeadlineValue.text = deadline as? String
                                
                            }
                            let jobQualificaton = data["job_qualifications"] as! NSDictionary
                            let keyJobQualification = jobQualificaton["key"] as! String
                            self.lblJobQualificationKey.text = keyJobQualification
                            if let qualificationArr = jobQualificaton["value"] as? NSArray {
                                self.nokri_qualificationDataParser(qualificationArr: qualificationArr)
                            }
                            let jobType = data["job_type"] as! NSDictionary
                            let jobTypeKey = jobType["key"] as! String
                            self.lblJobTypeKey.text = jobTypeKey
                            if let jobTypeArray = jobType["value"] as? NSArray {
                                self.nokri_jobTypeDataParser(jobtypeArr: jobTypeArray)
                            }
                            let salary = data["salary_type"] as! NSDictionary
                            let salaryKey = salary["key"] as! String
                            self.lblSalaryTypeKey.text = salaryKey
                            if let salaryTypeArray = salary["value"] as? NSArray {
                                self.nokri_salaryTypeDataParser(salTypeArr: salaryTypeArray)
                            }
                            let salaryCurrency = data["salary_currency"] as! NSDictionary
                            let salaryCurrencyKey = salaryCurrency["key"] as! String
                            self.lblSalaryCurrencyKey.text = salaryCurrencyKey
                            if let salaryCurrencyArr = salaryCurrency["value"] as? NSArray {
                                self.nokri_salaryCurrencyDataParser(salCurrAr: salaryCurrencyArr)
                            }
                            let salaryOffer = data["salary_offer"] as! NSDictionary
                            let salaryOfferKey = salaryOffer["key"] as! String
                            self.lblSalaryOfferKey.text = salaryOfferKey
                            if let salaryOfferArr = salaryOffer["value"] as? NSArray {
                                self.nokri_salaryOfferDataParser(salOfferAr: salaryOfferArr)
                            }
                            let jobExperience = data["job_experience"] as! NSDictionary
                            let jobExperienceKey = jobExperience["key"] as! String
                            self.lblJobExperienceKey.text = jobExperienceKey
                            if let jobExperieneArr = jobExperience["value"] as? NSArray {
                                self.nokri_jobExperienceDataParser(jobExpArr: jobExperieneArr)
                            }
                            let jobShift = data["job_shift"] as! NSDictionary
                            let jobShiftKey = jobShift["key"] as! String
                            self.lblJobShiftKey.text = jobShiftKey
                            if let jobShiftArr = jobShift["value"] as? NSArray {
                                self.nokri_jobShiftDataParser(jobShiftArr: jobShiftArr)
                            }
                            let jobLevel = data["job_level"] as! NSDictionary
                            let jobLevelKey = jobLevel["key"] as! String
                            self.lblJobLevelKey.text = jobLevelKey
                            if let jobLevelArr = jobLevel["value"] as? NSArray {
                                self.nokri_jobLevelDataParser(jobLevelArr: jobLevelArr)
                            }
                            
                            let jobPostTpe = data["job_apply_with"] as! NSDictionary
                            if let keyObj = jobPostTpe["is_show"] as? Int{
                                self.is_show = keyObj
                            }
                            
                            let jobPostTypeKey = jobPostTpe["key"] as! String
                            self.lblJobPostType.text = jobPostTypeKey
                            if let jobLevelArr = jobPostTpe["value"] as? NSArray {
                                self.nokri_jobPostTypeDataParser(jobPostTypeArr: jobLevelArr)
                            }
                            
                            let noOfPosition = data["job_no_pos"] as! NSDictionary
                            if let noTitle = noOfPosition["key"]{
                                self.lblNumberOfPostKey.text = noTitle as? String
                                self.txtNumberFieldValue.placeholder = noTitle as? String
                            }
                            let jobSkill = data["job_skills"] as! NSDictionary
                            let jobSkillKey = jobSkill["key"] as! String
                            self.lblJobSkillKey.text = jobSkillKey
                            if let jobSkillArr = jobSkill["value"] as? NSArray {
                                self.nokri_jobSkillDataParser(jobSkillArr: jobSkillArr)
                            }
                            let jobTags = data["job_tags"] as! NSDictionary
                            if let jobTag = jobTags["key"]{
                                self.lblJobTag.text = jobTag as? String
                                
                            }
                            let location = data["job_location_head"] as! NSDictionary
                            if let loc = location["key"]{
                                self.lblLocationOnMap.text = loc as? String
                                
                            }
                            let setLocation = data["job_loc"] as! NSDictionary
                            if let setLoc = setLocation["key"]{
                                self.txtLocation.placeholder = setLoc as? String
                                
                            }
                            let latitude = data["job_lat"] as! NSDictionary
                            if let lat = latitude["key"]{
                                self.txtLatitude.text = lat as? String
                                self.txtLatitude.placeholder = lat as? String
                                self.lblLat.text = lat as? String
                                lati = (lat as? String)!
                            }
                            let longitude = data["job_long"] as! NSDictionary
                            if let long = longitude["key"]{
                                self.txtLongitude.text = long as? String
                                self.txtLongitude.placeholder = long as? String
                                self.lblLong.text = long as? String
                                longi = (long as? String)!
                                
                            }
                            if let premiumArray = data["premium_jobs"] as? NSArray {
                                self.nokri_premiumJobParser(premArray: premiumArray)
                                let job_boost = data["job_boost"] as! NSDictionary
                                if let jobBost = job_boost["key"]{
                                    self.lblBoostJob.text = jobBost as? String
                                }
                                if let isShowBoost = job_boost["is_show"]{
                                    self.isJobBoost = isShowBoost as! Bool
                                }
                                if self.premiumArray.count == 0{
                                    self.tableView.isHidden = true
                                }
                                
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
                            
                            let jobExpireDays = data["expiry_limit"] as! NSDictionary
                            self.jobInExpire = jobExpireDays["value"] as! Int
                            
                            
                            self.segmentedControl.itemTitles = [self.noText,self.yesText]
                            self.segmentedControl.didSelectItemWith = { (index, title) -> () in
                                print("Selected item \(index)")
                                if index == 0{
                                    
                                }else{
                                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "AddQuestionairViewController") as? AddQuestionairViewController
                                    vc?.qLblText = self.questionLbl
                                    vc?.qPlacehoderText = self.questionPlaceholder
                                    vc?.qTxt = self.questionText
                                    vc?.delegate = self
                                    vc?.questionsFromEdit = self.questionFromEdit
                                    vc?.isFromEdit = self.isFromEdit
                                    self.navigationController?.pushViewController(vc!, animated: true)
                                }
                                
                            }
                            
                            
                            self.nokri_dropDownSetup()
                            self.tableView.reloadData()
                            
                            
                        }else{
//                            let hud = JGProgressHUD(style: .dark)
//                            hud.textLabel.text = messageResponse
//                            hud.detailTextLabel.text = nil
//                            hud.indicatorView = JGProgressHUDSuccessIndicatorView()
//                            hud.position = .bottomCenter
//                            hud.show(in: self.view)
//                            hud.dismiss(afterDelay: 2.0)
                            //self.view.makeToast(messageResponse, duration: 1.5, position: .center)
                            self.perform(#selector(self.nokri_showBuyPackages), with: nil, afterDelay: 2)
                        }
                        self.nokri_map(lat: lati, long: longi)
                        self.stopAnimating()
                }
                
            }
            
            
        }
        
        @objc func nokri_showBuyPackages(){
//            let buyPkgController = self.storyboard?.instantiateViewController(withIdentifier: "PackagesViewController") as! PackagesViewController
//            self.navigationController?.pushViewController(buyPkgController, animated: true)
        }
        
        func nokri_qualificationDataParser(qualificationArr:NSArray){
            
            self.qualificationArray.removeAllObjects()
            for item in qualificationArr{
                self.qualificationArray.add(item)
            }
            
        }
        
        func nokri_jobTypeDataParser(jobtypeArr:NSArray){
            
            self.jobTypeArray.removeAllObjects()
            for item in jobtypeArr{
                self.jobTypeArray.add(item)
            }
            
        }
        
        func nokri_salaryTypeDataParser(salTypeArr:NSArray){
            
            self.salaryArray.removeAllObjects()
            for item in salTypeArr{
                self.salaryArray.add(item)
            }
            
        }
        
        func nokri_salaryCurrencyDataParser(salCurrAr:NSArray){
            
            self.salaryCurrencyArray.removeAllObjects()
            for item in salCurrAr{
                self.salaryCurrencyArray.add(item)
            }
            
        }
        
        func nokri_salaryOfferDataParser(salOfferAr:NSArray){
            
            self.salaryOfferArray.removeAllObjects()
            for item in salOfferAr{
                self.salaryOfferArray.add(item)
            }
            
        }
        
        func nokri_jobExperienceDataParser(jobExpArr:NSArray){
            
            self.jobExperienceArray.removeAllObjects()
            for item in jobExpArr{
                self.jobExperienceArray.add(item)
            }
            
        }
        
        func nokri_jobShiftDataParser(jobShiftArr:NSArray){
            
            self.jobShiftArray.removeAllObjects()
            for item in jobShiftArr{
                self.jobShiftArray.add(item)
            }
            
        }
        
        func nokri_jobLevelDataParser(jobLevelArr:NSArray){
            
            self.jobLevelArray.removeAllObjects()
            for item in jobLevelArr{
                self.jobLevelArray.add(item)
            }
            
        }
        
        func nokri_jobPostTypeDataParser(jobPostTypeArr:NSArray){
            
            self.jobPostTypeArray.removeAllObjects()
            for item in jobPostTypeArr{
                self.jobPostTypeArray.add(item)
            }
            
        }
        
        func nokri_jobSkillDataParser(jobSkillArr:NSArray){
            
            self.jobSkillArray.removeAllObjects()
            for item in jobSkillArr{
                self.jobSkillArray.add(item)
            }
            
        }
        
        func nokri_premiumJobParser(premArray:NSArray){
            
            self.premiumArray.removeAllObjects()
            for item in premArray{
                self.premiumArray.add(item)
            }
            
        }
        
        func nokri_jobCategoryDataParser(jobCatArr:NSArray){
            
            self.jobCategoreisArray.removeAllObjects()
            for item in jobCatArr{
                self.jobCategoreisArray.add(item)
            }
            
        }
        
        func nokri_countryDataParser(countryArr:NSArray){
            
            
            self.countryArray.removeAllObjects()
            for item in countryArr{
                self.countryArray.add(item)
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
        
        func nokri_childCategories2(id:Int){
            
            
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
                        
                        self.nokri_jobSubCatDataParser2(jobCatArr2: responseData)
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
                    "Nokri-Request-From" : Constants.customCodes.requestFrom
                ]
                
                let param: [String: Any] = [
                    "cat_id": id,
                ]
                print(param)
                
                Alamofire.request(Constants.URL.baseUrl+Constants.URL.childCat, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers)
                    .responseJSON { response in
                        
                        let responseData = response.value as! NSArray
                        print(responseData)
                        
                        self.nokri_jobSubCatDataParser2(jobCatArr2: responseData)
                        self.nokri_dropDownSetup()
                        self.stopAnimating()
                        
                }
            }
            
            
        }
        
        func nokri_jobSubCatDataParser2(jobCatArr2:NSArray){
            
            self.jobSubCatArrat2.removeAllObjects()
            for item in jobCatArr2{
                self.jobSubCatArrat2.add(item)
            }
            
        }
        
        func nokri_childCategories3(id:Int){
            
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
                        
                        self.nokri_jobSubCatDataParser3(jobCatArr3: responseData)
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
                        self.nokri_jobSubCatDataParser3(jobCatArr3: responseData)
                        self.nokri_dropDownSetup()
                        self.stopAnimating()
                }
            }
        }
        
        func nokri_jobSubCatDataParser3(jobCatArr3:NSArray){
            self.jobSubCatArrat3.removeAllObjects()
            for item in jobCatArr3{
                self.jobSubCatArrat3.add(item)
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
    
        func questionDat(question: [String]) {
            questionsArray = question
            print(questionsArray)
        }
        
        func nokri_joPost(parameter: NSDictionary) {
            self.showLoader()
            UserHandler.nokri_PostJob(parameter: parameter as NSDictionary, success: { (successResponse) in
                self.stopAnimating()
                if successResponse.success == true{
                    let hud = JGProgressHUD(style: .dark)
                    hud.textLabel.text = successResponse.message
                    hud.detailTextLabel.text = nil
                    hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                    hud.position = .bottomCenter
                    hud.show(in: self.view)
                    hud.dismiss(afterDelay: 2.0)
                    self.perform(#selector(self.nokri_showJobDetail), with: nil, afterDelay: 2)
                }
                else {
                    let alert = Constants.showBasicAlert(message: successResponse.message)
                    self.present(alert, animated: true, completion: nil)
                    self.stopAnimating()
                }
            }) { (error) in
                let alert = Constants.showBasicAlert(message: error.message)
                self.present(alert, animated: true, completion: nil)
                self.stopAnimating()
            }
        }
        
        @objc func nokri_showJobDetail(){
            print("Job id: \(String(describing: jobIdNew))" )
            let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "JobDetailViewController") as! JobDetailViewController
            if let quantity = jobIdNew as? NSNumber {
                nextViewController.jobId =  Int(truncating: quantity) //Int(totalfup)
                nextViewController.isFromAllJob = false
                isFromLocation = false
                nextViewController.isfromJobPost = true
                self.navigationController?.pushViewController(nextViewController, animated: true)
            }
            else if let quantity = jobIdNew  as? String{
                nextViewController.jobId =  Int(quantity)!  //Int(totalfup)
                nextViewController.isFromAllJob = false
                isFromLocation = false
                nextViewController.isfromJobPost = true
                self.navigationController?.pushViewController(nextViewController, animated: true)
            
            }
             UserDefaults.standard.set(false, forKey: "isFromNoti")
        }
    }
