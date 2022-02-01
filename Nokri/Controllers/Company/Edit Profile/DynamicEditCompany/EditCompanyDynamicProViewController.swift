//
//  EditCompanyDynamicProViewController.swift
//  Nokri
//
//  Created by apple on 3/9/20.
//  Copyright © 2020 Furqan Nadeem. All rights reserved.
//

import UIKit
import Alamofire
import JGProgressHUD


class EditCompanyDynamicProViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    //MARK:- IbOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK:- Proprties
    
    var saveInfoText = ""
    var btnDelText = ""
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var appColorNew = UserDefaults.standard.string(forKey: "app_Color")
    var extraArray = [PersonalInfoExtra]()
    var dataArray = [PersonalInfoData]()
    var emailIs = ""
    var nameIs = ""
    var phoneIs = ""
    var professionIs = ""
    var dobIs = ""
    var webIs = ""
    var eduIs = 0
    var levelIs = 0
    var typeIs = 0
    var expis = 0
    var setProis = 0
    var setStaus = ""
    var radioCellHeight = 0.0
    var st = ""
    var customArray = [JobPostCCustomData]()
    var fieldsArray = [JobPostCCustomData]()
    var customArraydata = [JobPostCCustomData]()
    
    
    //MARK:- View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nokri_basicInfoData()
        self.tabBarController?.tabBar.barTintColor =  UIColor(hex: appColorNew!)
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
        
        let objData = fieldsArray[indexPath.row]
        
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "EditCompanyDynamicStaticTableViewCell", for: indexPath) as! EditCompanyDynamicStaticTableViewCell
            
            cell.delegate = self
            nameIs = cell.txtName.text!
            phoneIs = cell.txtPhone.text!
            professionIs = cell.txtHeadline.text!
            dobIs = cell.richEditor.text
            webIs = cell.txtWeb.text!
            setStaus = cell.btnSetPro.currentTitle!
            if setStaus == "Public"{
                st = "pub"
                
            }else{
                st = "priv"
            }
            emailIs = cell.txtEmail.text!
            print(nameIs)
            print(phoneIs)
            print(phoneIs)
            
            return cell
        }
        else if indexPath.section == 1{
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
                for ob in objData.values{
                    cell.skilKeyArr.append(ob.name)
                    cell.selectedArr.append((ob.selected != nil))
                }
                cell.heightConstraintRadioTable.constant = CGFloat(objData.values.count * 50)
                radioCellHeight = Double(objData.values.count * 50)
                //cell.lblDropDownKey.text = objData.mainTitle
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
        
        let objData = fieldsArray[indexPath.row]
        
        if indexPath.section == 0{
            return 880
        }else if indexPath.section == 1{
            
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
        }
        else{
            return 88
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
        
        for ab in dataArray{
            
            if ab.fieldTypeName == "emp_dp" {
//                lblImage.text = ab.key
//                txtImage.placeholder = ab.key
//                txtImage.text = ab.key
                
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
        
        
        if setStaus == "Public"{
            st = "pub"
        }else{
            st = "priv"
        }
        
        var param: [String: Any] = [
            "email" : emailIs,
            "emp_name": nameIs,
            "emp_phone": phoneIs,
            "emp_headline": professionIs,
            "emp_intro": dobIs ,
            "emp_web": webIs ,
            "emp_prof_stat" : st,
            
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
        UserHandler.nokri_updateBasiInfoPost(parameter: parameter as NSDictionary, success: { (successResponse) in
            self.stopAnimating()
            if successResponse.success == true {
                let hud = JGProgressHUD(style: .dark)
                hud.textLabel.text = successResponse.message
                hud.detailTextLabel.text = nil
                hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                hud.position = .bottomCenter
                hud.show(in: self.tableView)
                hud.dismiss(afterDelay: 2.0)
                self.perform(#selector(self.nokri_showData), with: nil, afterDelay: 2.2)
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
    
    @objc func nokri_showData(){
            self.nokri_basicInfoData()
       }
    
    func nokri_basicInfoData() {
        self.showLoader()
        //self.imageViewBasicInfo.isHidden = true
        UserHandler.nokri_updateBasiInfoDynamic(success: { (successResponse) in
            self.stopAnimating()
            if successResponse.success{
                //self.imageViewBasicInfo.isHidden = false
                self.tableView.dataSource = self
                self.tableView.delegate = self
                self.dataArray = successResponse.data
                self.dataArray =  successResponse.data
                self.extraArray = successResponse.extras
                self.fieldsArray = successResponse.customArr
                self.nokri_populateData()
                self.tableView.reloadData()
                self.stopAnimating()
            }
            else {
                //self.imageViewBasicInfo.isHidden = true
                let alert = Constants.showBasicAlert(message: successResponse.message)
                self.present(alert, animated: true, completion: nil)
                self.stopAnimating()
            }
        }) { (error) in
            //self.imageViewBasicInfo.isHidden = true
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

extension EditCompanyDynamicProViewController:registerTxtFieldPro,registerDateFieldPro,registerTxtAreaFieldPro,registerradioBoxValues,registerNumberFieldPro,registerSelectDropDown,companyStaticProtocol {
    
    func companyStaticValues(emplName: String, empPhone: String, empHeadline: String, empIntro: String, empWeb: String, empStatus: String) {
        
        nameIs = emplName
        phoneIs = empPhone
        professionIs = empHeadline
        dobIs = empIntro
        webIs = empWeb
        setStaus = empStatus
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
