//
//  CustomSignupViewController.swift
//  Nokri
//
//  Created by apple on 2/18/20.
//  Copyright © 2020 Furqan Nadeem. All rights reserved.
//

import UIKit
import Alamofire
import NVActivityIndicatorView
import JGProgressHUD

class CustomSignupViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    //MARK:- IBOutlets
    
    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var imgView: UIImageView!
    
    //MARK:- Proporties
    
    var appColorNew = UserDefaults.standard.string(forKey: "app_Color")
    var txtName:String = ""
    var txtEmail:String = ""
    var txtPass:String = ""
    var txtConfPass:String = ""
    var segmentValue:String = ""
    var customArray = [JobPostCCustomData]()
    var fieldsArray = [JobPostCCustomData]()
    var dataArray = [JobPostCCustomData]()
    var customArraydata = [JobPostCCustomData]()
    var radioCellHeight = 0.0
    var textFieldRequired : Bool = false
    var rowRequired = 1000
    var requiredText = ""
    var isOnlyCandRegister = "0"
    var passCheck = false
    var passConfCheck = false
    var chkPwdStrength = ""
    var passStrengthText = ""
    var newsboxShow = ""
    var newsLetterText = ""
    var subscribeData = ""
    //MARK:- View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewRound()
        btnLogin.backgroundColor = UIColor(hex: appColorNew!)
        if let userData = UserDefaults.standard.object(forKey: "settingsData") {
            let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
            let dataTabs = SplashRoot(fromDictionary: objData)
            let obj = dataTabs.data.extra
            btnLogin.setTitle(obj?.gotologin, for: .normal)
            self.title = dataTabs.data.guestTabs.signup
        }
        nokri_signUpData()
        nokri_ltrRtl()
      
    }
    
    //MARK:- Custom Functions
    
    func nokri_ltrRtl(){
        if (UserDefaults.standard.bool(forKey: "isNotSignIn") == true){
            let isRtl = UserDefaults.standard.string(forKey: "isRtl")
            if isRtl == "0"{
                addLeftBarButtonWithImage(#imageLiteral(resourceName: "menu"))
            }else{
                addRightBarButtonWithImage(#imageLiteral(resourceName: "menu"))
            }
        }
    }
    
    func viewRound(){
        viewContent.layer.cornerRadius = 15
    }
    
    //MARK:- TableView
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }else if section == 1{
            if fieldsArray.count == 0{
                return 0
            }else{
                return fieldsArray.count
            }
        }
        else{
            return 1
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            if indexPath.section == 0{
                let cell = tableView.dequeueReusableCell(withIdentifier: "CustomStaticeRegisterTableViewCell", for: indexPath) as! CustomStaticeRegisterTableViewCell
                cell.delegate = self
                cell.passwordBool = passCheck
                cell.passwordConfirmBool = passConfCheck
               
                return cell
            }
            else if indexPath.section == 1{
                let objData = fieldsArray[indexPath.row]
                if fieldsArray.count != 0{
                
                if objData.fieldType == "textfield"{
                    let cell = tableView.dequeueReusableCell(withIdentifier: "RegisterTxtFieldTableViewCell", for: indexPath) as! RegisterTxtFieldTableViewCell
                    
                    cell.txtField.placeholder = objData.mainTitle
                    cell.txtField.font = UIFont(name:"Openans-Regular",size: 20)
                    cell.fieldName = objData.fieldTypeName
                    cell.inde = indexPath.row
                    cell.section = 2
                    cell.delegate = self
                    
                    textFieldRequired = objData.isRequired
                    if objData.isRequired == true{
                        rowRequired = indexPath.row
                    }
                    
                    return cell
                } else if objData.fieldType == "date"{
                    let cell = tableView.dequeueReusableCell(withIdentifier: "RegisterDateTableViewCell", for: indexPath) as! RegisterDateTableViewCell
                    
                    cell.dateField.placeholder = objData.mainTitle
                    cell.dateField.font = UIFont(name:"Openans-Regular",size: 20)
                    cell.fieldName = objData.fieldTypeName
                    cell.inde = indexPath.row
                    cell.section = 2
                    cell.delegate = self
                    
                    return cell
                }else if objData.fieldType == "Textarea"{
                    let cell = tableView.dequeueReusableCell(withIdentifier: "RegisterTextAreaTableViewCell", for: indexPath) as! RegisterTextAreaTableViewCell
                    
                    cell.txtView.text = objData.mainTitle
                    cell.txtView.font = UIFont(name:"Openans-Regular",size: 20)
                    cell.fieldName = objData.fieldTypeName
                    cell.inde = indexPath.row
                    cell.section = 2
                    cell.delegate = self
                    
                    return cell
                }else if objData.fieldType == "select"{
                    
                    let cell = tableView.dequeueReusableCell(withIdentifier: "RegisterSelectTableViewCell", for: indexPath) as! RegisterSelectTableViewCell
                    //                for _ in objData.values {
                    //                    print(cell.selectedValue)
                    //                    cell.btnDropDown.titleLabel?.text = objData.values[0].name
                    //                    cell.btnDropDown.setTitle(objData.values[0].name, for: .normal)
                    //                }
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
                    
                    return cell
                }else if objData.fieldType == "checkbox"{
                    let cell = tableView.dequeueReusableCell(withIdentifier: "RegisterRadioTableViewCell", for: indexPath) as! RegisterRadioTableViewCell
                    
                    cell.indexP = indexPath.row
                    cell.section = 2
                    cell.fieldName = objData.fieldTypeName
                    cell.delegate = self
                    for ob in objData.values{
                        cell.skilKeyArr.append(ob.name)
                    }
                    cell.heightConstraintRadioTable.constant = CGFloat(objData.values.count * 50)
                    radioCellHeight = Double(objData.values.count * 50)
                    cell.isFromRegister = true
                    
                    return cell
                }
                else {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "RegisterNumberTableViewCell", for: indexPath) as! RegisterNumberTableViewCell
                    
                    cell.txtField.placeholder = objData.mainTitle
                    cell.txtField.font = UIFont(name:"Openans-Regular",size: 20)
                    cell.fieldName = objData.fieldTypeName
                    cell.inde = indexPath.row
                    cell.section = 2
                    cell.delegate = self
                    
                    return cell
                    }
                    
                }else{
                    return UITableViewCell()
                }
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "CustomRegisterStaticTableViewCell", for: indexPath) as! CustomRegisterStaticTableViewCell
                cell.showNewsLetter = self.newsboxShow
                cell.lblNewsletter.text = self.newsLetterText
                if cell.showNewsLetter == "1"{
                    cell.containerNewsLetter.isHidden = false
                    cell.imgNewsCheckBox.isHidden = true
                    cell.lblNewsletter.isHidden = false
                    
                }
                else{
                    cell.containerNewsLetter.isHidden = true
                    cell.imgNewsCheckBox.isHidden = true
                    cell.lblNewsletter.isHidden = true
                }
                self.subscribeData = cell.subscribeNow
//                subscribe_now
                cell.btnSignUp.addTarget(self, action:  #selector(CustomSignupViewController.btnSignUpClicked), for: .touchUpInside)
                return cell
            }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        if indexPath.section == 0{
            if isOnlyCandRegister == "0"{
                return 275
            }else{
                return 168
            }
        }else if indexPath.section == 1{
            
            if fieldsArray.count != 0{
                let objData = fieldsArray[indexPath.row]
                
                if objData.fieldType == "select"{
                    return 55
                }else if objData.fieldType == "textfield"{
                    return 55
                }else if objData.fieldType == "checkbox"{
                    return CGFloat(radioCellHeight) + 15
                }else if objData.fieldType == "multi_select"{
                    return 55
                }else if objData.fieldType == "Textarea"{
                    return 160
                }else if objData.fieldType == "date"{
                    return 55
                }else{
                    return 55
                }
            }else{
                return 0
            }
            
        }else{
            return 156
        }
    }
    
    @objc func btnSignUpClicked(){
        var customDictionary = [String: Any]()
        if let userData = UserDefaults.standard.object(forKey: "settingsData") {
            let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
            let dataTabs = SplashRoot(fromDictionary: objData)
            if isValidEmail(testStr: txtEmail) == false  {
                let alert = Constants.showBasicAlert(message: dataTabs.data.extra.validEmail)
                self.present(alert, animated: true, completion: nil)
            }else if txtName == ""{
                let alert = Constants.showBasicAlert(message: dataTabs.data.extra.allField)
                self.present(alert, animated: true, completion: nil)
            }else if txtEmail == ""{
                let alert = Constants.showBasicAlert(message: dataTabs.data.extra.allField)
                self.present(alert, animated: true, completion: nil)
            }else if txtPass == ""{
                let alert = Constants.showBasicAlert(message: dataTabs.data.extra.allField)
                self.present(alert, animated: true, completion: nil)
            }else if txtConfPass == ""{
                let alert = Constants.showBasicAlert(message: dataTabs.data.extra.allField)
                self.present(alert, animated: true, completion: nil)
            }else if txtPass != txtConfPass{
                let alert = Constants.showBasicAlert(message: dataTabs.data.extra.missMatch)
                self.present(alert, animated: true, completion: nil)
            }else if chkPwdStrength == "1"{

                if isValidPassword(testStr: txtPass) == false {
                    let alert = Constants.showBasicAlert(message: passStrengthText)
                    self.present(alert, animated: true, completion: nil)
                }
                else if isValidPassword(testStr: txtConfPass) == false {
                    let alert = Constants.showBasicAlert(message: passStrengthText )
                    self.present(alert, animated: true, completion: nil)
                }
                else{
                    
                    if isOnlyCandRegister != "0"{
                        segmentValue = "0"
                    }
                    
                    var param: [String: Any] = [
                        "name": txtName,
                        "email": txtEmail,
                        "pass": txtPass,
                        "type": segmentValue,
                        "subscribe_now": subscribeData
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
                    self.nokri_signUpPost(parameter: param as NSDictionary)
                }
            }
            else{
                
                if isOnlyCandRegister != "0"{
                    segmentValue = "0"
                }
                
                var param: [String: Any] = [
                    "name": txtName,
                    "email": txtEmail,
                    "pass": txtPass,
                    "type": segmentValue,
                    "subscribe_now": subscribeData
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
                self.nokri_signUpPost(parameter: param as NSDictionary)
            }
        }
    }
    
    func nokri_signUpPost(parameter: NSDictionary) {
        self.showLoader()
        UserHandler.nokri_signUpUser(parameter: parameter as NSDictionary, success: { (successResponse) in
            self.stopAnimating()
            if successResponse.success == true {
                let hud = JGProgressHUD(style: .dark)
                hud.textLabel.text = successResponse.message
                hud.detailTextLabel.text = nil
                hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                hud.show(in: self.view)
                hud.dismiss(afterDelay: 2.0)
                hud.position = .bottomCenter
                //self.view.makeToast(successResponse.message, duration: 1.5, position: .bottom)
                self.perform(#selector(self.nokri_showHome), with: nil, afterDelay: 2.5)
                self.stopAnimating()
                UserHandler.sharedInstance.objSignUpPost = successResponse.data
                UserDefaults.standard.set(4, forKey: "loginCheck")
                UserDefaults.standard.set(7, forKey: "aType")
                
                
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
    
    func nokri_signUpData() {
        self.showLoader()
        UserHandler.nokri_signUpData(success: { (successResponse) in
            self.stopAnimating()
            if successResponse.success {
                self.tableView.delegate = self
                self.tableView.dataSource = self
                UserHandler.sharedInstance.objUser = successResponse.data
                self.fieldsArray = successResponse.data.data
                if let imgUrl = URL(string: successResponse.data.logo) {
                    self.imgView.sd_setImage(with: imgUrl, completed: nil)
                    self.imgView.sd_setShowActivityIndicatorView(true)
                    self.imgView.sd_setIndicatorStyle(.gray)
                }
                self.isOnlyCandRegister = successResponse.data.adminCanPost
                self.chkPwdStrength = successResponse.data.checkPasswordStrengthBool
                self.passStrengthText = successResponse.data.passwordStrengthAlertMessage
                self.newsboxShow  = successResponse.data.newsLetterShow
                self.newsLetterText = successResponse.data.newsLetterText
                self.tableView.reloadData()
                self.stopAnimating()
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
    
    func isValidEmail(testStr:String) -> Bool {
        print("validate emilId: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: testStr)
        return result
    }
    func isValidPassword(testStr:String) -> Bool {
        print("validate Password: \(testStr)")

        guard testStr != nil else { return false }

        // at least one uppercase,
        // at least one digit
        // at least one lowercase
        // 8 characters total
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}")
        return passwordTest.evaluate(with: testStr)
    }
    
    @objc func nokri_showHome(){
        appDelegate.nokri_moveToSignIn()

//        let isHome = UserDefaults.standard.string(forKey: "home")
//        if isHome == "1"{
//            appDelegate.nokri_moveToHome1()
//        }else{
//            appDelegate.nokri_moveToHome2()
//        }
    }
}


extension CustomSignupViewController: registerTxtFieldPro,registerDateFieldPro,registerTxtAreaFieldPro,registerradioBoxValues,registerNumberFieldPro,registerStaticHeader,registerSelectDropDown {
    
    
    func registertextValSelecrDrop(valueName: String, value: String, indexPath: Int, fieldType: String, section: Int, fieldName: String, isShow: Bool) {
        var obj = JobPostCCustomData()
        obj.fieldType = "select"
        obj.fieldVal = value
        obj.fieldTypeName = fieldName
        self.fieldsArray[indexPath].fieldVal = value
        self.dataArray.append(obj)
        self.fieldsArray.append(obj)
        self.customArraydata.append(obj)
        //objArray.append(obj)
        customArray.append(obj)
        print(obj)
    }
    
    func registerStaticHeader(txtName: String, txtEmail: String, txtPass: String, segmentValue: String,txtConfPass:String) {
        self.txtName = txtName
        self.txtEmail = txtEmail
        self.txtPass = txtPass
        self.txtConfPass = txtConfPass
        self.segmentValue = segmentValue
    }
    
    
    func registerTxtfieldVal(value: String, indexPath: Int, fieldType: String, section: Int, fieldNam: String) {
        var obj = JobPostCCustomData()
        obj.fieldType = "textfield"
        obj.fieldVal = value
        obj.fieldTypeName = fieldNam
        self.fieldsArray[indexPath].fieldVal = value
        self.dataArray.append(obj)
        self.fieldsArray.append(obj)
        self.customArraydata.append(obj)
        //objArray.append(obj)
        customArray.append(obj)
        if rowRequired  == indexPath{
            requiredText = value
        }
        print(obj)
    }
    
    func registerDatefieldVal(value: String, indexPath: Int, fieldType: String, section: Int, fieldNam: String) {
        var obj = JobPostCCustomData()
        obj.fieldType = "date"
        obj.fieldVal = value
        obj.fieldTypeName = fieldNam
        self.fieldsArray[indexPath].fieldVal = value
        self.dataArray.append(obj)
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
        self.dataArray.append(obj)
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



