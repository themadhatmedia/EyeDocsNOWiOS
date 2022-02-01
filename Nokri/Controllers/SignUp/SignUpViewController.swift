//
//  SignUpViewController.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 4/8/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import UIKit
import BetterSegmentedControl
//import UICheckbox_Swift
import NVActivityIndicatorView
import SDWebImage
import TTSegmentedControl
import JGProgressHUD

class SignUpViewController: UIViewController,UITextFieldDelegate {

    //MARK:- IBOutlets
    
    @IBOutlet weak var lblSignUp: UILabel!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var segmentedControl: TTSegmentedControl!
    @IBOutlet weak var btnCheckBox: UIButton!
    @IBOutlet weak var lblTermsText: UILabel!
    @IBOutlet weak var btnLoginText: UIButton!
    @IBOutlet weak var imageViewLogo: UIImageView!
    @IBOutlet weak var imageViewCheckBox: UIImageView!
    
    @IBOutlet weak var viewName: UIView!
    @IBOutlet weak var viewEmail: UIView!
    @IBOutlet weak var viewPhone: UIView!
    @IBOutlet weak var viewPass: UIView!
    @IBOutlet weak var viewBg: UIView!
    @IBOutlet weak var viewLine: UIView!
    @IBOutlet weak var imgName: UIImageView!
    @IBOutlet weak var imgEmail: UIImageView!
    @IBOutlet weak var imgPhone: UIImageView!
    @IBOutlet weak var imgPass: UIImageView!
    
    
    //MARK:- Proporties
    
    var withOutLogin = UserDefaults.standard.string(forKey: "aType")
    var appColorNew = UserDefaults.standard.string(forKey: "app_Color")
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var isSignin:Bool?
    var type = ""
    var candidate:String?
    var company:String?
    
    //MARK:- View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nokri_customeButtons()
        nokri_checkBoxAndOthers()
        nokri_ltrRtl()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    
        
        nokri_signUpData()
        nokri_styling()
    
    }

    //MARK:- Custome Function
    
    func nokri_styling(){
        
        viewBg.layer.cornerRadius = 15
        viewEmail.layer.cornerRadius = 20
        viewPass.layer.cornerRadius = 20
        viewName.layer.cornerRadius = 20
        viewPhone.layer.cornerRadius = 20
        viewEmail.layer.borderWidth = 1
        viewPass.layer.borderWidth = 1
        viewPhone.layer.borderWidth = 1
        viewName.layer.borderWidth = 1
        viewLine.backgroundColor = UIColor(hex: appColorNew!)
        viewEmail.layer.borderColor = UIColor.groupTableViewBackground.cgColor
        viewPass.layer.borderColor = UIColor.groupTableViewBackground.cgColor
        viewPhone.layer.borderColor = UIColor.groupTableViewBackground.cgColor
        viewName.layer.borderColor = UIColor.groupTableViewBackground.cgColor
        txtEmail.layer.borderColor = UIColor.clear.cgColor
        txtPassword.layer.borderColor = UIColor.clear.cgColor
        txtPhone.layer.borderColor = UIColor.clear.cgColor
        txtName.layer.borderColor = UIColor.clear.cgColor
        
        imgName.image = imgName.image?.withRenderingMode(.alwaysTemplate)
        imgName.tintColor = UIColor.lightGray
        imgPass.image = imgPass.image?.withRenderingMode(.alwaysTemplate)
        imgPass.tintColor = UIColor.lightGray
        imgEmail.image = imgEmail.image?.withRenderingMode(.alwaysTemplate)
        imgEmail.tintColor = UIColor.lightGray
        imgPhone.image = imgPhone.image?.withRenderingMode(.alwaysTemplate)
        imgPhone.tintColor = UIColor.lightGray
    }
    
    func nokri_ltrRtl(){
        if (UserDefaults.standard.bool(forKey: "isNotSignIn") == true){
            let isRtl = UserDefaults.standard.string(forKey: "isRtl")
            if isRtl == "0"{
                //addLeftBarButtonWithImage(#imageLiteral(resourceName: "menu"))
            }else{
                addRightBarButtonWithImage(#imageLiteral(resourceName: "menu"))
            }
        }
    }
    
    func isValidEmail(testStr:String) -> Bool {
        print("validate emilId: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: testStr)
        return result
    }

    func nokri_checkBoxAndOthers(){
        self.imageViewCheckBox.image = imageViewCheckBox.image?.withRenderingMode(.alwaysTemplate)
        self.imageViewCheckBox.tintColor = UIColor(hex: appColorNew!)
        imageViewCheckBox.isHidden = true
        let can = UserDefaults.standard.string(forKey: "cand")
        let com = UserDefaults.standard.string(forKey: "comp")
        segmentedControl.itemTitles = [can,com] as! [String]
        self.navigationController?.navigationBar.isHidden = false
        if (UserDefaults.standard.bool(forKey: "isNotSignIn") == true){
            let isRtl = UserDefaults.standard.string(forKey: "isRtl")
            if isRtl == "0"{
                self.addLeftBarButtonWithImage(#imageLiteral(resourceName: "menu"))
            }else{
                self.addRightBarButtonWithImage(#imageLiteral(resourceName: "menu"))
            }
        }
        self.type = "0"
        UserDefaults.standard.set(self.type, forKey: "signUp")
        UserDefaults.standard.set(0, forKey: "candidate")
        segmentedControl.didSelectItemWith = { (index, title) -> () in
            print("Selected item \(index)")
            if index == 0{
                UserDefaults.standard.set(0, forKey: "candidate")
                self.type = "0"
                UserDefaults.standard.set("0", forKey: "signUp")
            }else{
                self.type = "1"
                UserDefaults.standard.set(1, forKey: "company")
                UserDefaults.standard.set("1", forKey: "signUp")
            }
        }
        
        btnCheckBox.layer.borderWidth = 2.0
        btnCheckBox.layer.borderColor = UIColor.lightGray.cgColor
        self.navigationController?.navigationBar.backgroundColor = UIColor(hex:appColorNew!)
        self.btnSignUp.backgroundColor = UIColor(hex:appColorNew!)
        if let userData = UserDefaults.standard.object(forKey: "settingsData") {
            let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
            let dataTabs = SplashRoot(fromDictionary: objData)
            let obj3 = dataTabs.data.guestTabs
            self.title = obj3?.signup
            self.lblSignUp.text = obj3?.signup
        }
        txtName.delegate = self
        txtEmail.delegate = self
        txtPassword.delegate = self
        txtPhone.delegate = self
        txtName.nokri_addBottomBorder()
        txtEmail.nokri_addBottomBorder()
        txtPassword.nokri_addBottomBorder()
        txtPhone.nokri_addBottomBorder()
    }
    
    func nokri_customeButtons(){
        btnLoginText.setTitleColor(UIColor(hex: appColorNew!), for: .normal)
        btnSignUp.layer.cornerRadius = 22
        btnSignUp.layer.masksToBounds = false
        segmentedControl.layer.cornerRadius = 3
        segmentedControl.thumbGradientColors = [UIColor(hex:appColorNew!), UIColor(hex:appColorNew!)]
    }
    
    func nokri_populateData() {
        if UserHandler.sharedInstance.objUser != nil {
            guard let data = UserHandler.sharedInstance.objUser else {
                return
            }
            if let imgUrl = URL(string: data.logo) {
             self.imageViewLogo.sd_setImage(with: imgUrl, completed: nil)
             self.imageViewLogo.sd_setShowActivityIndicatorView(true)
             self.imageViewLogo.sd_setIndicatorStyle(.gray)
            }
            if let name = data.namePlaceholder
            {
                txtName.placeholder = name
            }
            if let email = data.emailPlaceholder
            {
                txtEmail.placeholder = email
            }
            if let password = data.passwordPlaceholder
            {
                txtPassword.placeholder = password
            }
            if let phone = data.phonePlaceholder
            {
                txtPhone.placeholder = phone
            }
            if let signUp = data.formBtn
            {
                btnSignUp.setTitle(signUp, for:.normal)
            }
            if let loginText = data.loginText
            {
                btnLoginText.setTitle(loginText, for:.normal)
            }
            if let termsText = data.termsText
            {
              lblTermsText.text = termsText
            }
        }
        else {
            print("Else..!")
        }
    }
    
    func verifyUrl (urlString: String?) -> Bool {
        //Check for nil
        if let urlString = urlString {
            // create NSURL instance
            if let url = NSURL(string: urlString) {
                // check if your application can open the NSURL instance
                return UIApplication.shared.canOpenURL(url as URL)
            }
        }
        return false
    }
    //MARK:- IBActions
    
    @IBAction func btnCheckBoxClicked(_ sender: UIButton) {
        if imageViewCheckBox.isHidden == true{
            imageViewCheckBox.isHidden = false
        }else{
            imageViewCheckBox.isHidden = true
        }
    }
    
    
    @IBAction func btnTermCondClicked(_ sender: UIButton) {
        
        var inValidUrl:String = ""
        if let userData = UserDefaults.standard.object(forKey: "settingsData") {
            let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
            let dataTabs = SplashRoot(fromDictionary: objData)
            inValidUrl = dataTabs.data.extra.invalid_url
            
        }
        if #available(iOS 10.0, *) {
            if verifyUrl(urlString: "http://www.google.com") == false {
                let hud = JGProgressHUD(style: .dark)
                hud.textLabel.text = inValidUrl
                hud.detailTextLabel.text = nil
                hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                hud.position = .bottomCenter
                hud.show(in: self.view)
                hud.dismiss(afterDelay: 2.0)
                //self.view.makeToast(inValidUrl, duration: 2.5, position: .center)
            }else{
                UIApplication.shared.open(URL(string: "http://www.google.com")!, options: [:], completionHandler: nil)
            }
            
        } else {
            if verifyUrl(urlString: "http://www.google.com") == false {
                let hud = JGProgressHUD(style: .dark)
                hud.textLabel.text = inValidUrl
                hud.detailTextLabel.text = nil
                hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                hud.position = .bottomCenter
                hud.show(in: self.view)
                hud.dismiss(afterDelay: 2.0)
                //self.view.makeToast(inValidUrl, duration: 2.5, position: .center)
            }else{
                UIApplication.shared.openURL(URL(string: "http://www.google.com")!)
            }
        }
        
    }
    
    @IBAction func btnSignUpClicked(_ sender: UIButton) {
        if let userData = UserDefaults.standard.object(forKey: "settingsData") {
            let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
            let dataTabs = SplashRoot(fromDictionary: objData)
        guard let name = txtName.text else {
            return
        }
        guard let email = txtEmail.text else {
            return
        }
        guard let phone = txtPhone.text else {
            return
        }
        guard let password = txtPassword.text else {
            return
        }
        if name == "" {
            let alert = Constants.showBasicAlert(message: dataTabs.data.extra.allField)
            self.present(alert, animated: true, completion: nil)
        }
        else if email == "" {
            let alert = Constants.showBasicAlert(message: dataTabs.data.extra.allField)
            self.present(alert, animated: true, completion: nil)
        }
        else if isValidEmail(testStr: email) == false  {
            let alert = Constants.showBasicAlert(message: dataTabs.data.extra.validEmail)
            self.present(alert, animated: true, completion: nil)
        }
        else if phone == "" {
            let alert = Constants.showBasicAlert(message: dataTabs.data.extra.allField)
            self.present(alert, animated: true, completion: nil)
        }
        else if password == "" {
            let alert = Constants.showBasicAlert(message: dataTabs.data.extra.allField)
            self.present(alert, animated: true, completion: nil)
        }
//        else if txtPassword.text?.count == 7{
//            let passwordRuleDescription = "required: lower; required: upper; required: digit; minlength: 8; maxlength: 16;"
//            if #available(iOS 12.0, *) {
//                let passwordRules = UITextInputPasswordRules(descriptor: passwordRuleDescription)
//                txtPassword.passwordRules = passwordRules
//                print("ruk ja")
//                let alert = Constants.showBasicAlert(message: dataTabs.data.extra.allField)
//                self.present(alert, animated: true, completion: nil)
//
//            }else{
//                print("else ma ruk ja")
//                let alert = Constants.showBasicAlert(message: dataTabs.data.extra.allField)
//                self.present(alert, animated: true, completion: nil)
//
//            }
//        }
        else if type == "" {
            let alert = Constants.showBasicAlert(message: "Please select type.")
            self.present(alert, animated: true, completion: nil)
        }
        else if imageViewCheckBox.isHidden == true{
            let alert = Constants.showBasicAlert(message: "Please accept terms and conditions.")
            self.present(alert, animated: true, completion: nil)
        }
        else {
            let param: [String: Any] = [
                "name": name,
                "email": email,
                "phone": phone,
                "pass": password,
                "type": type
            ]
            print(param)
           // UserDefaults.standard.set(7, forKey: "signUp")
            self.nokri_signUpPost(parameter: param as NSDictionary)
            UserDefaults.standard.set("0", forKey: "sine")
            UserDefaults.standard.set(12, forKey: "aType")
            UserDefaults.standard.set(email, forKey: "email")
            UserDefaults.standard.set(password, forKey: "password")
        }
      }
    }
    
    //MARK:- TextField Delegate
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == txtName {
            //txtName.nokri_updateBottomBorderColor(isTextFieldSelected: true)
            viewName.layer.borderWidth = 1
            viewName.layer.borderColor = UIColor(hex: appColorNew!).cgColor
        } else {
            //txtName.nokri_updateBottomBorderColor(isTextFieldSelected: false)
            viewName.layer.borderWidth = 1
            viewName.layer.borderColor = UIColor.groupTableViewBackground.cgColor
        }
        if textField == txtEmail {
            //txtEmail.nokri_updateBottomBorderColor(isTextFieldSelected: true)
            viewEmail.layer.borderWidth = 1
            viewEmail.layer.borderColor = UIColor(hex: appColorNew!).cgColor
        } else {
            //txtEmail.nokri_updateBottomBorderColor(isTextFieldSelected: false)
            viewEmail.layer.borderWidth = 1
            viewEmail.layer.borderColor = UIColor.groupTableViewBackground.cgColor
        }
        if textField == txtPhone {
            viewPhone.layer.borderWidth = 1
            viewPhone.layer.borderColor = UIColor(hex: appColorNew!).cgColor
            //txtPhone.nokri_updateBottomBorderColor(isTextFieldSelected: true)
        } else {
            //txtPhone.nokri_updateBottomBorderColor(isTextFieldSelected: false)
            viewPhone.layer.borderWidth = 1
            viewPhone.layer.borderColor = UIColor.groupTableViewBackground.cgColor
        }
        if textField == txtPassword {
            viewPass.layer.borderWidth = 1
            viewPass.layer.borderColor = UIColor(hex: appColorNew!).cgColor
           
            //txtPassword.nokri_updateBottomBorderColor(isTextFieldSelected: true)
        } else {
            //txtPassword.nokri_updateBottomBorderColor(isTextFieldSelected: false)
            viewPass.layer.borderWidth = 1
            viewPass.layer.borderColor = UIColor.groupTableViewBackground.cgColor
        }
        return true
    }
   
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return false
    }
    
//    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
//        if textField == txtPassword{
//            let passwordRuleDescription = "required: lower; required: upper; required: digit; minlength: 8; maxlength: 16;"
//            if #available(iOS 12.0, *) {
//                let passwordRules = UITextInputPasswordRules(descriptor: passwordRuleDescription)
//                txtPassword.passwordRules = passwordRules
//
//            } else {
//                // Fallback on earlier versions
//            }
//
//        }
//    }
  
    //MARK:- API Calls
    
    func nokri_signUpData() {
       
       self.showLoader()
        self.btnSignUp.isHidden = true
        self.btnCheckBox.isHidden = true
        self.segmentedControl.isHidden = true
        UserHandler.nokri_signUpData(success: { (successResponse) in
            self.stopAnimating()
            if successResponse.success {
                self.btnSignUp.isHidden = false
                self.btnCheckBox.isHidden = false
                self.segmentedControl.isHidden = false
                UserHandler.sharedInstance.objUser = successResponse.data
                
                self.nokri_populateData()
                self.stopAnimating()
            }
            else {
                self.btnSignUp.isHidden = true
                self.btnCheckBox.isHidden = true
                self.segmentedControl.isHidden = true
                let alert = Constants.showBasicAlert(message: successResponse.message)
                self.present(alert, animated: true, completion: nil)
                self.stopAnimating()
            }
        }) { (error) in
            self.btnSignUp.isHidden = true
            self.btnCheckBox.isHidden = true
            self.segmentedControl.isHidden = true
            let alert = Constants.showBasicAlert(message: error.message)
            self.present(alert, animated: true, completion: nil)
            self.stopAnimating()
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
                UserDefaults.standard.set(self.txtEmail.text, forKey: "remeberEmail")
                UserDefaults.standard.set(self.txtPassword.text, forKey: "remeberPassword")
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
    @objc func nokri_showHome(){
      //self.appDelegate.nokri_moveToHome()
        let isHome = UserDefaults.standard.string(forKey: "home")
        if isHome == "1"{
            appDelegate.nokri_moveToHome1()
        }else{
            appDelegate.nokri_moveToHome2()
        }

    }
}
