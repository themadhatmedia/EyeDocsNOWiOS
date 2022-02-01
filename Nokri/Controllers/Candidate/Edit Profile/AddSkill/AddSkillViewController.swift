//
//  AddSkillViewController.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 4/27/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import UIKit
import MultiAutoCompleteTextSwift
import SwiftCheckboxDialog
import JGProgressHUD

class AddSkillViewController: UIViewController,CheckboxDialogViewDelegate,UITextFieldDelegate {

    //MARK:- IBoutlets
    
    @IBOutlet weak var lblStepNo: UILabel!
    @IBOutlet weak var txtAddSkill: UITextField!
    @IBOutlet weak var btnSaveSkill: UIButton!
    @IBOutlet weak var lblSelectSkill: UILabel!
    @IBOutlet weak var viewSkill: UIView!
    
    @IBOutlet weak var llbSelectSkillValue: UILabel!
    @IBOutlet weak var txtAddSkillValue: UITextField!
    
    @IBOutlet weak var lblSkills: UILabel!
    @IBOutlet weak var lblSkillsValues: UILabel!
    
    //MARK:- Proporties
    
    var appColorNew = UserDefaults.standard.string(forKey: "app_Color")
    var alertCheck:Int = 0
    var skills : AddSkillCandSkillField?
    //var skillValues = [String]()
    //var skillKeys = [Int]()
    var selectYourSkills:String?
    var skillArray = [AddSkillCandValue]()
    var skillsSelected = [AddSkillCandSkillSelected]()
    var skillsSelectedArr = [String]()
    var skillsSelectedArrValues = [Int]()

    var skilKeyArr = [String]()
    
    var selectYourSkillValue:String?
    var skillArrayValue = [AddSkillCandValue]()
    var skillsSelectedValue = [AddSkillCandSkillSelected]()
    var skillValues = [AddSkillCvalue]()
    var skillFieldVal:AddSkillCanFieldValue?
    
    var skilKeyArrValue = [String]()

    
    var checkboxDialogViewController: CheckboxDialogViewController!
    typealias TranslationTuple = (name: String, translated: String)
    typealias TranslationDictionary = [String : String]
    
    //MARK:- View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nokri_customeButton()
        nokri_candSkillsData()
        viewSkill.backgroundColor = UIColor(hex:appColorNew!)
        self.navigationController?.navigationBar.isHidden = true
        self.addLeftBarButtonWithImage(#imageLiteral(resourceName: "menu"))
        //nokri_addBottomBorder()
        if let userData = UserDefaults.standard.object(forKey: "settingsData") {
            let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
            let dataTabs = SplashRoot(fromDictionary: objData)
            let obj = dataTabs.data.candTabs
            self.lblStepNo.text = obj?.skills
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        //nokri_addBottomBorderSize()
    }
    
    //MARK:- IBActions
    
    @IBAction func btnSaveSkillClicked(_ sender: UIButton) {
        
        let intArray = skilKeyArr.map { Int($0)!}
        let intValueArray = skilKeyArrValue.map { Int($0)!}
    
     
        let param: [String: Any] = [
            "cand_skills": intArray,
            "cand_skills_values" : intValueArray
            
     ]
        
        print(param)
        self.nokri_skilDataPost(parameter: param as NSDictionary)
        
    }

    @IBAction func btnSkillClicked(_ sender: UIButton) {
        alertCheck = 1
        txtAddSkill.text = " "
        nokri_multiCheckBoxData()
    }
    
    @IBAction func btnSkillValueClicked(_ sender: UIButton) {
        alertCheck = 0
        txtAddSkillValue.text = " "
        
        nokri_multiCheckBoxData()
    }
    
    //MARK:- Custome Functions
    
    func nokri_addBottomBorder(){
        txtAddSkill.delegate = self
        txtAddSkillValue.delegate = self
        txtAddSkill.nokri_addBottomBorder()
        txtAddSkillValue.nokri_addBottomBorder()
    }
    
    func nokri_addBottomBorderSize(){
        txtAddSkill.nokri_updateBottomBorderSize()
        txtAddSkillValue.nokri_updateBottomBorderSize()
    }
    
    func nokri_populateData(){
        lblSelectSkill.text = "Select Skills"   //skills?.key
        llbSelectSkillValue.text = "Select Your skill values"
//        for obj in (skills?.values)!{
//            skillValues.append(obj.value)
//            skillKeys.append(obj.key)
//        }
//        let words = skillValues
//        txtAddSkill.autoCompleteStrings = words
//
        for obj in skillsSelected {
            if obj.key != nil{
                skillsSelectedArr.append(obj.key)
            }
            if obj.value != nil{
                skillsSelectedArrValues.append(obj.value)
                
            }
        }
        let joined = skillsSelectedArr.joined(separator: ", ")
        lblSkills.text = joined
       
        let stringArray = skillsSelectedArrValues.map { String($0) }
        let joinedValues = stringArray.joined(separator: ", ")
        lblSkillsValues.text = joinedValues
        //txtAddSkill.maximumAutoCompleteCount = 50
//        //txtAddSkill.autoCompleteTableView?.se
    }
    
    func nokri_customeButton(){
        btnSaveSkill.layer.cornerRadius = 15
        btnSaveSkill.layer.borderWidth = 1
        btnSaveSkill.layer.borderColor = UIColor(hex:appColorNew!).cgColor
        btnSaveSkill.setTitleColor(UIColor(hex: appColorNew!), for: .normal)
        //btnSaveSkill.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor
        //btnSaveSkill.layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
        //btnSaveSkill.layer.shadowOpacity = 0.7
        //btnSaveSkill.layer.shadowRadius = 0.3
        btnSaveSkill.layer.masksToBounds = false
        btnSaveSkill.backgroundColor = UIColor.white
    }
    
    func nokri_multiCheckBoxData(){
        if alertCheck == 1 {
        //var tableData :[(name: String, translated: String)]?
        //var jobSkillArr = [String]()
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
            
        }else{
            //var tableData :[(name: String, translated: String)]?
            //var jobSkillArr = [String]()
            var jobData = [(name: String, translated: String)]();
            let jobSkill = self.skillValues
            
            for itemDict in jobSkill {
                if let jobSkillObj = itemDict.value{
                    //jobData.append((name: jobSkillObj, translated: jobSkillObj))
                    if let jobskey = itemDict.value{
                        jobData.append((name: "\(jobskey)", translated: jobSkillObj))
                    }
                }
                
            }
            print (jobData)
            self.checkboxDialogViewController = CheckboxDialogViewController()
            self.checkboxDialogViewController.titleDialog = (skillFieldVal?.key)!
            self.checkboxDialogViewController.tableData = jobData
            self.checkboxDialogViewController.componentName = DialogCheckboxViewEnum.countries
            self.checkboxDialogViewController.delegateDialogTableView = self
            self.checkboxDialogViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            self.present(self.checkboxDialogViewController, animated: false, completion: nil)
            
        }
        
    }
    
    func onCheckboxPickerValueChange(_ component: DialogCheckboxViewEnum, values: TranslationDictionary) {
        print(component)
       
        if alertCheck == 1{
        var allselectedString : String = "";
        print(values.keys)
        for value in values.keys {
            print("\(value)");
            skilKeyArr.append(value)
            lblSkills.text = value
        }
            for value in values.values {
                print("\(value)");
                allselectedString += "\(value),"
            }
            if allselectedString != ""{
                self.lblSkills.text = allselectedString
            }
            
        }else{
            var allselectedString : String = "";
            print(values.keys)
            for value in values.keys {
                print("\(value)");
                skilKeyArrValue.append(value)
                lblSkillsValues.text = value
            }
            for value in values.values {
                print("\(value)");
                allselectedString += "\(value),"
            }
            if allselectedString != ""{
            self.lblSkillsValues.text = allselectedString
            }
        }
        
    }
    
    //MARK:- API Calls
    
    func nokri_candSkillsData() {
        self.btnSaveSkill.isHidden = true
        self.viewSkill.isHidden = true
        self.showLoader()
        UserHandler.nokri_candidateSkill(success: { (successResponse) in
            self.stopAnimating()
            if successResponse.success {
                self.btnSaveSkill.isHidden = false
                self.viewSkill.isHidden = false
                self.skillArray = successResponse.data.skillsField.values
                self.skillsSelected = successResponse.data.skillsSelected
                self.skillValues = successResponse.data.skillsFieldValues.values
                self.skillFieldVal = successResponse.data.skillsFieldValues
                self.nokri_populateData()
            }
            else {
                self.btnSaveSkill.isHidden = true
                self.viewSkill.isHidden = true
                let alert = Constants.showBasicAlert(message: successResponse.message)
                self.present(alert, animated: true, completion: nil)
            }
        }) { (error) in
            self.btnSaveSkill.isHidden = true
            self.viewSkill.isHidden = true
            let alert = Constants.showBasicAlert(message: error.message)
            self.present(alert, animated: true, completion: nil)
            self.stopAnimating()
        }
    }
    
    func nokri_skilDataPost(parameter: NSDictionary) {
        self.showLoader()
        UserHandler.nokri_CandSkillsPost(parameter: parameter as NSDictionary, success: { (successResponse) in
            self.stopAnimating()
            if successResponse.success == true{
                //self.view.makeToast(successResponse.message, duration: 1.5, position: .center)
                let hud = JGProgressHUD(style: .dark)
                hud.textLabel.text = successResponse.message!
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
