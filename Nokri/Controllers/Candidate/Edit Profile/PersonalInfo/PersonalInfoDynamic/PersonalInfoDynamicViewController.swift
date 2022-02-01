//
//  PersonalInfoDynamicViewController.swift
//  Nokri
//
//  Created by apple on 3/3/20.
//  Copyright © 2020 Furqan Nadeem. All rights reserved.
//

import UIKit
import Alamofire
import JGProgressHUD

class PersonalInfoDynamicViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    //MARK:- IbOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK:- Proprties
    
    var saveInfoText = ""
    var btnDelText = ""
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var extraArray = [PersonalInfoExtra]()
    var dataArray = [PersonalInfoData]()
    var nameIs = ""
    var phoneIs = ""
    var professionIs = ""
    var dobIs = ""
    var eduIs = 0
    var salaryIs = 0
    var salaryTypeIs = 0
    var currencyIs = 0
    var genderIs = 0
    var levelIs = 0
    var typeIs = 0
    var expis = 0
    var setProis = 0
    var radioCellHeight = 0.0
    var txtAboutDes = ""
    
    var customArray = [JobPostCCustomData]()
    var fieldsArray = [JobPostCCustomData]()
    var customArraydata = [JobPostCCustomData]()
    
    
    //MARK:- View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nokri_personalInfoData()
        //let tabController = parent as? UITabBarController
        //tabController?.navigationItem.title = "ABC"
    }
    
    override func awakeFromNib() {
          super.awakeFromNib()
          if let userData = UserDefaults.standard.object(forKey: "settingsData") {
              let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
              let dataTabs = SplashRoot(fromDictionary: objData)
              let obj = dataTabs.data.candTabs
        
              self.tabBarController?.tabBar.items?[4].title = NSLocalizedString((obj?.certification)!, comment: "comment")
              self.tabBarController?.tabBar.items?[5].title = NSLocalizedString((obj?.skills)!, comment: "comment")
              self.tabBarController?.tabBar.items?[6].title = NSLocalizedString((obj?.portfolio)!, comment: "comment")
              self.tabBarController?.tabBar.items?[7].title = NSLocalizedString((obj?.socail)!, comment: "comment")
              self.tabBarController?.tabBar.items?[8].title = NSLocalizedString((obj?.loca)!, comment: "comment")
            
          }
      }
    
    
    //MARK:- TableView
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }else if section == 1{
            return fieldsArray.count
        }else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "PersonalInfoStaticTableViewCell", for: indexPath) as! PersonalInfoStaticTableViewCell
            
            cell.delegate = self
            
            return cell
        }
        else if indexPath.section == 1{
            
            if fieldsArray.count != 0{
            let objData = fieldsArray[indexPath.row]
            if objData.fieldType == "textfield"{
                let cell = tableView.dequeueReusableCell(withIdentifier: "UpdateInfoTextfieldTableViewCell", for: indexPath) as! UpdateInfoTextfieldTableViewCell
                
                cell.txtFieldValue.placeholder = objData.mainTitle
                cell.txtFieldValue.font = UIFont(name:"Openans-Regular",size: 20)
                cell.fieldName = objData.fieldTypeName
                cell.inde = indexPath.row
                cell.section = 2
                cell.delegate = self
                cell.lblKey.text = objData.mainTitle
                cell.txtFieldValue.text = objData.value
                
                return cell
            }else if objData.fieldType == "select"{
                let cell = tableView.dequeueReusableCell(withIdentifier: "UpdateInfoDropDownTableViewCell", for: indexPath) as! UpdateInfoDropDownTableViewCell
               
                for ob in objData.values {
                    print(cell.selectedValue)
                    if ob.selected == true{
                        cell.btnDropDown.titleLabel?.text = ob.name
                         cell.btnDropDown.setTitle(ob.name, for: .normal)
                        break
                    }else{
                        cell.btnDropDown.titleLabel?.text = objData.values[0].name
                        cell.btnDropDown.setTitle(objData.values[0].name, for: .normal)
                    }
                }

                cell.btnPopUpAction = { () in
                    cell.dropDownKeysArray = []
                    cell.dropDownValuesArray = []
                    cell.fieldTypeNameArray = []
                    for item in objData.values {
                        if item.value != nil{
                            cell.dropDownKeysArray.append(item.value)
                        }
                        cell.dropDownValuesArray.append(item.name)
                        cell.fieldTypeNameArray.append(objData.fieldTypeName)
                    }
                    cell.accountDropDown()
                    cell.valueDropDown.show()
                }
                cell.param = objData.fieldTypeName
                cell.indexP = indexPath.row
                cell.section = 2
                cell.fieldNam = objData.fieldTypeName
                cell.delegate = self
                cell.lblDropDownKey.text = objData.mainTitle
                return cell
            }else if objData.fieldType == "checkbox"{
                let cell = tableView.dequeueReusableCell(withIdentifier: "RegisterRadioTableViewCell", for: indexPath) as! RegisterRadioTableViewCell
                cell.indexP = indexPath.row
                cell.section = 2
                cell.fieldName = objData.fieldTypeName
                cell.delegate = self
                cell.fieldsArray = fieldsArray
                cell.isFromRegister = false
                for ob in objData.values{
                    cell.skilKeyArr.append(ob.name)
                    cell.selectedArr.append(ob.selected)
                }
                cell.heightConstraintRadioTable.constant = CGFloat(objData.values.count * 50)
                radioCellHeight = Double(objData.values.count * 50)
                return cell
            }else if objData.fieldType == "Number"{
                let cell = tableView.dequeueReusableCell(withIdentifier: "UpdateInfoNumberTableViewCell", for: indexPath) as! UpdateInfoNumberTableViewCell
                cell.txtFieldNumber.placeholder = objData.mainTitle
                cell.txtFieldNumber.font = UIFont(name:"Openans-Regular",size: 20)
                cell.fieldName = objData.fieldTypeName
                cell.inde = indexPath.row
                cell.section = 2
                cell.delegate = self
                cell.lblNumberKey.text = objData.mainTitle
                cell.txtFieldNumber.text = objData.value
                
                return cell
            }else if objData.fieldType == "Textarea"{
                let cell = tableView.dequeueReusableCell(withIdentifier: "PersonalInfoTextViewTableViewCell", for: indexPath) as! PersonalInfoTextViewTableViewCell
                cell.txtArea.text = objData.mainTitle
                cell.txtArea.font = UIFont(name:"Openans-Regular",size: 20)
                cell.fieldName = objData.fieldTypeName
                cell.inde = indexPath.row
                cell.section = 2
                cell.delegate = self
                cell.lblTxtViewkEY.text = objData.mainTitle
                cell.txtArea.text = objData.value
                return cell
                
            }else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "updateInfoDateTableViewCell", for: indexPath) as! updateInfoDateTableViewCell
                cell.btnDate.setTitle(objData.mainTitle, for: .normal)
                cell.fieldName = objData.fieldTypeName
                cell.inde = indexPath.row
                cell.section = 2
                cell.delegate = self
                cell.lblDateKey .text = objData.mainTitle
                cell.btnDate.setTitle(objData.value, for: .normal)
                return cell
            }
            
            }else{
                return UITableViewCell()
            }
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "UpdateInfoFooterTableViewCell", for: indexPath) as! UpdateInfoFooterTableViewCell
            cell.btnSaveInfo.setTitle(saveInfoText, for: .normal)
            cell.btnDeleteAcc.setTitle(btnDelText, for: .normal)
            cell.btnDeleteAcc.addTarget(self, action:  #selector(PersonalInfoDynamicViewController.nokri_btnDeleteClicked), for: .touchUpInside)
            cell.btnSaveInfo.addTarget(self, action:  #selector(PersonalInfoDynamicViewController.nokri_btnSaveInfoClicked), for: .touchUpInside)
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
       
        
        if indexPath.section == 0{
            return 1540
        }else if indexPath.section == 1{
            if fieldsArray.count != 0{
                let objData = fieldsArray[indexPath.row]
                if objData.fieldType == "textfield"{
                    return 88
                }else if objData.fieldType == "select"{
                    return 88
                }else if objData.fieldType == "checkbox"{
                    return CGFloat(radioCellHeight) + 15
                }else if objData.fieldType == "number"{
                    return 88
                }else if objData.fieldType == "Textarea"{
                    return 190
                }else{
                    return 88
                }
                
            }else{
                return 0
            }
        }
        else{
            return 114
        }
    }
    
    func nokri_populateData(){
        
        for obj in extraArray {
            if obj.fieldTypeName == "btn_name"{
                saveInfoText = obj.value
            }
            
            if obj.fieldTypeName == "del_acount"{
                btnDelText = obj.value
            }
        }
    }
    
    @objc func nokri_btnDeleteClicked(){
        let user_id = UserDefaults.standard.integer(forKey: "id")
        print(user_id)
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
        let Alert = UIAlertController(title:confirmString, message:"", preferredStyle: .alert)
        let okButton = UIAlertAction(title: btnOk, style: .default) { _ in
            
            let param: [String: Any] = [
                "user_id":user_id
            ]
            print(param)
            self.nokri_deleteAccount(parameter: param as NSDictionary)
        }
        let CancelButton = UIAlertAction(title: btnCncel, style: .cancel)
        Alert.addAction(okButton)
        Alert.addAction(CancelButton)
        self.present(Alert, animated: true, completion: nil)
        
    }
    
    @objc func nokri_btnSaveInfoClicked(){
        
        var customDictionary = [String: Any]()
        var pro = ""
        if setProis == 0{
            pro = "pub"
        }else{
            pro = "priv"
        }
        
        var param: [String: Any] = [
            "cand_name": nameIs,
            "cand_dob": dobIs,
            "cand_phone": phoneIs,
            "cand_headline": professionIs,
            "cand_last": eduIs ,
            "cand_level": levelIs ,
            "cand_type": typeIs ,
            "cand_experience": expis ,
            "cand_salary_range": salaryIs ,
            "cand_salary_type": salaryTypeIs ,
            "cand_salary_curren": currencyIs ,
            "cand_prof_stat" : pro,
            "cand_intro": txtAboutDes,
            "cand_gender":genderIs
        ]
        print(param)
        
        for ob in customArray{
            customDictionary[ob.fieldTypeName] = ob.fieldVal
        }
        print(customDictionary)
        let custom = Constants.json(from: customDictionary)
        print(custom! )
        let para: [String: Any] = ["custom_fields": custom!]
        param.merge(with: para)
        print(param)
        
        self.nokri_personalInfoPost(parameter: param as NSDictionary)
        
    }
    
    //MARK:- Api Calls
    
    func nokri_personalInfoPost(parameter: NSDictionary) {
        self.showLoader()
        UserHandler.nokri_personalInfoPost(parameter: parameter as NSDictionary, success: { (successResponse) in
            self.stopAnimating()
            if successResponse.success == true {
                let hud = JGProgressHUD(style: .dark)
                hud.textLabel.text = successResponse.message
                hud.detailTextLabel.text = nil
                hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                hud.position = .bottomCenter
                hud.show(in: self.tableView)
                hud.dismiss(afterDelay: 2.0)
                //self.nokri_Data()
                self.nokri_personalInfoData()
                UserDefaults.standard.set(10, forKey: "isUpdat")
            }
            else {
                let hud = JGProgressHUD(style: .dark)
                hud.textLabel.text = successResponse.message!
                hud.detailTextLabel.text = nil
                hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                hud.position = .bottomCenter
                hud.show(in: self.view)
                hud.dismiss(afterDelay: 2.0)
                //self.view.makeToast(successResponse.message, duration: 1.5, position: .bottom)
                self.stopAnimating()
            }
        }) { (error) in
            let alert = Constants.showBasicAlert(message: error.message)
            self.present(alert, animated: true, completion: nil)
            self.stopAnimating()
        }
    }
    
    func nokri_personalInfoData() {
        self.showLoader()
        UserHandler.nokri_candidatePersonalInfo(success: { (successResponse) in
            self.stopAnimating()
            if successResponse.success {
                self.tableView.delegate = self
                self.tableView.dataSource = self
                self.dataArray = successResponse.data
                self.extraArray = successResponse.extras
                self.fieldsArray = successResponse.customArr
                self.nokri_populateData()
                self.tableView.reloadData()
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
    
    func nokri_deleteAccount(parameter: NSDictionary) {
        self.showLoader()
        UserHandler.nokri_deleteAccount(parameter: parameter as NSDictionary, success: { (successResponse) in
            self.stopAnimating()
            if successResponse.success == true{
                UserDefaults.standard.set(false, forKey: "isSocial")
                UserDefaults.standard.set("0" , forKey: "id")
                UserDefaults.standard.set(nil , forKey: "email")
                // UserDefaults.standard.set(nil, forKey: "email")
                UserDefaults.standard.set(nil, forKey: "img")
                UserDefaults.standard.set("3" , forKey: "acountTypeafb")
                UserDefaults.standard.set(5, forKey: "aType")
                //self.appDelegate.nokri_moveToHome()
                let isHome = UserDefaults.standard.string(forKey: "home")
                if isHome == "1"{
                    self.appDelegate.nokri_moveToHome1()
                }else{
                    self.appDelegate.nokri_moveToHome2()
                }
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


extension PersonalInfoDynamicViewController:PersonalInfoStaticProt,registerTxtFieldPro,registerDateFieldPro,registerTxtAreaFieldPro,registerradioBoxValues,registerNumberFieldPro,registerSelectDropDown {
    
    func personalInfoStatic(name: String, phone: String, profession: String, dob: String, edu: Int, level: Int, type: Int, exp: Int,setPro:Int,txtAboutDes:String,salary:Int,salaryType:Int,currency:Int,gender:Int) {
        
        nameIs = name
        phoneIs = phone
        professionIs = profession
        dobIs = dob
        eduIs = edu
        levelIs = level
        typeIs = type
        expis = exp
        setProis = setPro
        self.txtAboutDes = txtAboutDes
        salaryIs = salary
        salaryTypeIs = salaryType
        currencyIs = currency
        genderIs = gender
        
    }
    
    func registerTxtfieldVal(value: String, indexPath: Int, fieldType: String, section: Int, fieldNam: String) {
        var obj = JobPostCCustomData()
        obj.fieldType = "textfield"
        obj.fieldVal = value
        obj.fieldTypeName = fieldNam
        self.fieldsArray[indexPath].fieldVal = value
        //self.dataArray.append(obj)
        self.fieldsArray.append(obj)
        self.customArraydata.append(obj)
        customArray.append(obj)
        print(obj)
    }
    
    func registertextValSelecrDrop(valueName: String, value: String, indexPath: Int, fieldType: String, section: Int, fieldName: String, isShow: Bool) {
          var obj = JobPostCCustomData()
                 obj.fieldType = "select"
                 obj.fieldVal = value
                 obj.fieldTypeName = fieldName
                 self.fieldsArray[indexPath].fieldVal = value
               //  self.dataArray.append(obj)
                 self.fieldsArray.append(obj)
                 self.customArraydata.append(obj)
                 //objArray.append(obj)
                 customArray.append(obj)
                 print(obj)
      }
    
    func registerDatefieldVal(value: String, indexPath: Int, fieldType: String, section: Int, fieldNam: String) {
          var obj = JobPostCCustomData()
          obj.fieldType = "date"
          obj.fieldVal = value
          obj.fieldTypeName = fieldNam
          self.fieldsArray[indexPath].fieldVal = value
          //self.dataArray.append(obj)
          self.fieldsArray.append(obj)
          self.customArraydata.append(obj)
          //objArray.append(obj)
          customArray.append(obj)
          print(obj)
        }
      
      
      func registerTxtAreafieldVal(value: String, indexPath: Int, fieldType: String, section: Int, fieldNam: String) {
          var obj = JobPostCCustomData()
          obj.fieldType = "Textarea"
          obj.fieldVal = value
          obj.fieldTypeName = fieldNam
          self.fieldsArray[indexPath].fieldVal = value
         // self.dataArray.append(obj)
          self.fieldsArray.append(obj)
          self.customArraydata.append(obj)
          //objArray.append(obj)
          customArray.append(obj)
          print(obj)
      }
      
      func registerradioValues(value: String, indexPath: Int, fieldType: String, section: Int, fieldName: String, isShow: Bool) {
          var obj = JobPostCCustomData()
          obj.fieldType = "checkbox"
          obj.fieldVal = String(value)
          obj.fieldTypeName = fieldName
          //isShowPrice = isShow
          self.fieldsArray[indexPath].fieldVal = value
          //self.dataArray.append(obj)
          self.fieldsArray.append(obj)
          self.customArray.append(obj)
          customArraydata.append(obj)
          print(obj)
       }
      
      func registerNumberfieldVal(value: String, indexPath: Int, fieldType: String, section: Int, fieldNam: String) {
          var obj = JobPostCCustomData()
          obj.fieldType = "number"
          obj.fieldVal = String(value)
          obj.fieldTypeName = fieldNam
          //isShowPrice = isShow
          self.fieldsArray[indexPath].fieldVal = value
          //self.dataArray.append(obj)
          self.fieldsArray.append(obj)
          self.customArray.append(obj)
          customArraydata.append(obj)
          print(obj)
      }
        
}


//["cand_phone": "09999999", "cand_headline": "Software Engineer", "cand_experience": 49, "cand_prof_stat": "pub", "cand_salary_curren": 55, "cand_name": "furqan Nadeem", "cand_dob": "Mar 1994", "cand_salary_type": 37, "cand_intro": "i am a software engineer graducated from universty of sargodha.", "cand_type": 19, "cand_salary_range": 29, "cand_level": 278, "cand_last": 105]
