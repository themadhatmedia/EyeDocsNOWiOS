//
//  EditCompanySpecializationViewController.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 4/17/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import UIKit
import TextFieldEffects
import MultiAutoCompleteTextSwift
import ActionSheetPicker_3_0
import Toast_Swift
import SwiftCheckboxDialog
import JGProgressHUD

class EditCompanySpecializationViewController: UIViewController,UITextFieldDelegate,CheckboxDialogViewDelegate {
  
    //MARK:- IBOutlets
    
    @IBOutlet weak var txtSkill: UITextField!
    @IBOutlet weak var txtNoOfEmploye: UITextField!
    @IBOutlet weak var btnSaveSection: UIButton!
    @IBOutlet weak var txtEstablishDate: UITextField!
    @IBOutlet weak var viewTop: UIView!
    @IBOutlet weak var lblSkill: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblNoOfEmployee: UILabel!
    @IBOutlet weak var lblStepNo: UILabel!
    
    //MARK:- Proporties
    
    var appColorNew = UserDefaults.standard.string(forKey: "app_Color")
    var skillSelectedArr = [AddSkillCandSkillSelected]()
    var skillArray = [UpdateSkillValue]()
    var extraArray = [UpdateSkillExtra]()
    var dataArray : UpdateSkillsData?
    var skilKeyArr = [String]()
    var checkboxDialogViewController: CheckboxDialogViewController!
    typealias TranslationTuple = (name: String, translated: String)
    typealias TranslationDictionary = [String : String]
    var skillAr = [String]()
    var skilIntKE = [Int]()
    
    //MARK:- View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nokri_customeButton()
        nokri_skillsData()
        self.btnSaveSection.layer.borderColor = UIColor(hex:appColorNew!).cgColor
        self.viewTop.backgroundColor = UIColor(hex:appColorNew!)
        txtSkill.delegate = self
        txtNoOfEmploye.delegate = self
        txtEstablishDate.delegate = self
        txtEstablishDate.nokri_addBottomBorder()
        txtNoOfEmploye.nokri_addBottomBorder()
        txtSkill.nokri_addBottomBorder()
       // adMob()
        if let userData = UserDefaults.standard.object(forKey: "settingsData") {
            let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
            let dataTabs = SplashRoot(fromDictionary: objData)
            let obj = dataTabs.data.empEditTabs
            self.lblStepNo.text = obj?.special
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        txtEstablishDate.nokri_updateBottomBorderSize()
        txtSkill.nokri_updateBottomBorderSize()
        txtNoOfEmploye.nokri_updateBottomBorderSize()
    }

    //MARK:- Custome Function
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == txtSkill {
            txtSkill.nokri_updateBottomBorderColor(isTextFieldSelected: true)
        } else {
            txtSkill.nokri_updateBottomBorderColor(isTextFieldSelected: false)
        }
        if textField == txtNoOfEmploye {
            txtNoOfEmploye.nokri_updateBottomBorderColor(isTextFieldSelected: true)
        } else {
            txtNoOfEmploye.nokri_updateBottomBorderColor(isTextFieldSelected: false)
        }
        if textField == txtEstablishDate {
            txtEstablishDate.nokri_updateBottomBorderColor(isTextFieldSelected: true)
        } else {
            txtEstablishDate.nokri_updateBottomBorderColor(isTextFieldSelected: false)
        }
        return true
    }
    
    func nokri_populateData(){
//        var subSkillArr = [String]()
//        var tagArr = [Int]()
//        for skill in skillArray {
//            subSkillArr.append(skill.value)
//            tagArr.append(skill.key)
//            //txtSkill.tag = skill.key
//        }
  
//        txtSkill.autoCompleteStrings = subSkillArr
//        for tag in tagArr{
//            txtSkill.tag = tag
//        }
//        txtSkill.onSelect = {[weak self] str, indexPath in
//            //self?.inputText.text = "Selected word: \(str)"
//            print(self?.txtSkill.tag)
//            print(indexPath)
//            print(str)
//            }
        
        
     
        
        for obj in extraArray{
            if obj.fieldTypeName == "skill_txt"{
                lblSkill.text = obj.value
                txtSkill.placeholder = obj.key
                txtSkill.text = obj.value
            }
            if obj.fieldTypeName == "est_txt"{
                lblDate.text = obj.key
                txtEstablishDate.placeholder = obj.key
                //txtEstablishDate.text = obj.value
            }
            if obj.fieldTypeName == "section_name"{
                lblNoOfEmployee.text = obj.value
                txtNoOfEmploye.placeholder = obj.key
                txtNoOfEmploye.text = obj.value
            }
            if obj.fieldTypeName == "btn_name"{
                self.btnSaveSection.setTitle(obj.value, for: .normal)
            }
        }
        if dataArray?.establish.fieldTypeName == "emp_establish"{
            txtEstablishDate.text = dataArray?.establish.value
            lblDate.text = dataArray?.establish.key
        }
        if dataArray?.employesField.fieldTypeName == "emp_nos"{
            txtNoOfEmploye.text = dataArray?.employesField.value
        }
        
       
        
        for ob in skillSelectedArr{
            skillAr.append(ob.valueSkil)
            skilIntKE.append(ob.keySkil)
        }
        
        let stringArray = skilIntKE.map { String($0) }
        skilKeyArr = stringArray
        
        
        let formattedArray = (skillAr.map{String($0)}).joined(separator: ",")
        txtSkill.text = formattedArray
        
    }
    
    func nokri_multiCheckBoxData(){

        var jobData = [(name: String, translated: String)]();
        let jobSkill = self.skillArray
        for itemDict in jobSkill {
            if let jobSkillObj = itemDict.value{
                //jobData.append((name: jobSkillObj, translated: jobSkillObj))
                if let jobskey = itemDict.key{
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
    
    func onCheckboxPickerValueChange(_ component: DialogCheckboxViewEnum, values: TranslationDictionary) {
        print(component)
        skilIntKE.removeAll()
        skilKeyArr.removeAll()
        var allselectedString : String = "";
        print(values.keys)
        for value in values.keys {
            print("\(value)");
            skilKeyArr.append(value)
            txtSkill.text = value
           
        }
        for value in values.values {
            print("\(value)");
            allselectedString += "\(value),"
           
        }
        self.txtSkill.text = allselectedString
        
    }
    
    //MARK:- IBActions
    
    @IBAction func btnSkillClicked(_ sender: UIButton) {
        nokri_multiCheckBoxData()
    }
    @IBAction func btnSaveActionClicked(_ sender: Any) {
       
        guard let emp = txtNoOfEmploye.text else {
            return
        }
        guard let date = txtEstablishDate.text else {
            return
        }
        let intArray = skilKeyArr.map { Int($0)!}
    
            let param: [String: Any] = [
                "emp_skills": intArray,
                "emp_nos": emp,
                "emp_establish": date
            ]
            print(param)
            self.nokri_skilDataPost(parameter: param as NSDictionary)
    }
    
    @IBAction func txtEstablishDateClicked(_ sender: UITextField) {
   
    }
  
    @IBAction func btnEstablishDateClicked(_ sender: UIButton) {
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
            dateFormatterPrint.dateFormat = "MMM yyyy"
            if let date = dateFormatterGet.date(from:  name){
                print(dateFormatterPrint.string(from: date))
                self.txtEstablishDate.text = dateFormatterPrint.string(from: date)
            }
            else {
                print("There was an error decoding the string")
            }
            return
        }, cancel: { ActionStringCancelBlock in return }, origin: (sender as AnyObject).superview!?.superview)
        let secondsInWeek: TimeInterval = 15000 * 24 * 60 * 60;
        datePicker?.minimumDate = Date(timeInterval: -secondsInWeek, since: Date())
        datePicker?.maximumDate = Date(timeInterval: secondsInWeek, since: Date())
        datePicker?.minuteInterval = 20
        datePicker?.show()
    }

    @IBAction func txtNofEmplClicked(_ sender: UITextField) {
        
    }
    
    //MARK:- Custome Functions
    
    func nokri_customeButton(){
        btnSaveSection.layer.cornerRadius = 15
        btnSaveSection.layer.borderWidth = 1
        btnSaveSection.layer.borderColor = UIColor(hex:appColorNew!).cgColor
        //btnSaveSection.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor
        //btnSaveSection.layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
        //btnSaveSection.layer.shadowOpacity = 0.7
        //btnSaveSection.layer.shadowRadius = 0.3
        btnSaveSection.layer.masksToBounds = false
        btnSaveSection.backgroundColor = UIColor.white
        btnSaveSection.setTitleColor(UIColor(hex: appColorNew!), for: .normal)
    }
    
    //MARK:- API Calls
    
    public func adMob() {
        if UserHandler.sharedInstance.objSaplash?.adMob != nil {
            let objData = UserHandler.sharedInstance.objSaplash?.adMob
            var isShowAd = false
            if let adShow = objData?.show {
                isShowAd = adShow
            }
            if isShowAd {
                var isShowBanner = false
                // var isShowInterstital = false
                if let banner = objData?.is_show_banner {
                    isShowBanner = banner
                }
                //                if let intersitial = objData?.is_show_initial {
                //                    isShowInterstital = intersitial
                //                }
                if isShowBanner {
                    SwiftyAd.shared.setup(withBannerID: (objData?.banner_id)!, interstitialID: "", rewardedVideoID: "")
                    self.view.translatesAutoresizingMaskIntoConstraints = false
                    if objData?.position == "top" {
                        self.view.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100).isActive = true
                        SwiftyAd.shared.showBanner(from: self, at: .top)
                    }
                    else {
                        self.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 60).isActive = true
                        SwiftyAd.shared.showBanner(from: self, at: .bottom)
                    }
                }
                //                if isShowInterstital {
                //                    SwiftyAd.shared.setup(withBannerID: "", interstitialID: (objData?.interstitalId)!, rewardedVideoID: "")
                //                    SwiftyAd.shared.showInterstitial(from: self)
                //                }
            }
        }
    }
    
    func nokri_skillsData() {
        self.showLoader()
        UserHandler.nokri_specializationCompany(success: { (successResponse) in
            self.stopAnimating()
            if successResponse.success {
                self.skillArray = successResponse.data.skillsField.vaalue
                self.extraArray = successResponse.extras
                self.dataArray = successResponse.data
                self.skillSelectedArr = successResponse.data.skillsSelected
                self.nokri_populateData()
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
    
    func nokri_skilDataPost(parameter: NSDictionary) {
        self.showLoader()
        UserHandler.nokri_specializationCompanyPost(parameter: parameter as NSDictionary, success: { (successResponse) in
            self.stopAnimating()
            if successResponse.success == true{
                let hud = JGProgressHUD(style: .dark)
                hud.textLabel.text = successResponse.message
                hud.detailTextLabel.text = nil
                hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                hud.position = .bottomCenter
                hud.show(in: self.view)
                hud.dismiss(afterDelay: 2.0)
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
   
}
