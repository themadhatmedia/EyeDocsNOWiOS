//
//  CustomStaticeRegisterTableViewCell.swift
//  Nokri
//
//  Created by apple on 2/18/20.
//  Copyright © 2020 Furqan Nadeem. All rights reserved.
//

import UIKit
import TextFieldEffects
import TTSegmentedControl


protocol registerStaticHeader {
    func registerStaticHeader(txtName:String,txtEmail:String,txtPass:String,segmentValue:String,txtConfPass:String)
}

class CustomStaticeRegisterTableViewCell: UITableViewCell,UITextFieldDelegate {
    
    
    @IBOutlet weak var viewName: UIView!
    @IBOutlet weak var viewEmail: UIView!
    @IBOutlet weak var viewPassword: UIView!
    @IBOutlet weak var txtName: UITextField!{
        didSet{
            txtName.delegate = self
        }
    }
    @IBOutlet weak var txtEmail: UITextField!{
        didSet{
            txtEmail.delegate = self
        }
    }
    @IBOutlet weak var txtPassword: UITextField!{
        didSet{
            txtPassword.delegate = self
        }
    }
    @IBOutlet weak var segmentedControl: TTSegmentedControl!
    @IBOutlet weak var txtConfPass: UITextField!{
        didSet{
            txtConfPass.delegate = self
        }
    }
    @IBOutlet weak var imgPass: UIImageView!
    @IBOutlet weak var imgConfPass: UIImageView!
    @IBOutlet weak var viewConfPass: UIView!
    
    
    
    
    var delegate : registerStaticHeader?
    var appColorNew = UserDefaults.standard.string(forKey: "app_Color")
    var defSegmentVal = ""
    var iconClick = true
    var iconClick2 = true
    var passwordBool = false
    var passwordConfirmBool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        segmentedControl.itemTitles = ["Candidate","Company"]
        segmentedControl.layer.cornerRadius = 3
        segmentedControl.thumbGradientColors = [UIColor(hex:appColorNew!), UIColor(hex:appColorNew!)]
        UserDefaults.standard.set("0", forKey: "candidateV")
        segmentedControl.didSelectItemWith = { (index, title) -> () in
            print("Selected item \(index)")
            if index == 0{
                UserDefaults.standard.set("0", forKey: "candidateV")
                //self.type = "0"
                UserDefaults.standard.set("0", forKey: "signUp")
                self.delegate?.registerStaticHeader(txtName: self.txtName.text!, txtEmail: self.txtEmail.text!, txtPass: self.txtPassword.text!, segmentValue: "0",txtConfPass:self.txtConfPass.text!)
            }else{
                //self.type = "1"
                UserDefaults.standard.set("1", forKey: "candidateV")
                UserDefaults.standard.set("1", forKey: "signUp")
                self.delegate?.registerStaticHeader(txtName: self.txtName.text!, txtEmail: self.txtEmail.text!, txtPass: self.txtPassword.text!, segmentValue: "1",txtConfPass:self.txtConfPass.text!)
            }
        }
        viewEmail.layer.cornerRadius = 20
        viewPassword.layer.cornerRadius = 20
        viewConfPass.layer.cornerRadius = 20
        viewName.layer.cornerRadius = 20
        viewEmail.layer.borderWidth = 1
        viewPassword.layer.borderWidth = 1
        viewConfPass.layer.borderWidth = 1
        
        viewName.layer.borderWidth = 1
        viewEmail.layer.borderColor = UIColor.groupTableViewBackground.cgColor
        viewPassword.layer.borderColor = UIColor.groupTableViewBackground.cgColor
        viewConfPass.layer.borderColor = UIColor.groupTableViewBackground.cgColor
        viewName.layer.borderColor = UIColor.groupTableViewBackground.cgColor
        
        populateData()
    }
    
    
    //MARK:- Custom Functions
    
    func populateData(){
        
        let userData = UserDefaults.standard.object(forKey: "settingsData")
        let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
        let dataTabs = SplashRoot(fromDictionary: objData)
        
        if UserHandler.sharedInstance.objUser != nil {
            guard let data = UserHandler.sharedInstance.objUser else {
                return
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
            if let confpassword = dataTabs.data.extra.pass_confirm
            {
                txtConfPass.placeholder = confpassword
            }
        
        }
        else {
            print("Else..!")
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
        
        if textField == txtPassword {
            viewPassword.layer.borderWidth = 1
            viewPassword.layer.borderColor = UIColor(hex: appColorNew!).cgColor
            //txtPassword.nokri_updateBottomBorderColor(isTextFieldSelected: true)
        } else {
            //txtPassword.nokri_updateBottomBorderColor(isTextFieldSelected: false)
            viewPassword.layer.borderWidth = 1
            viewPassword.layer.borderColor = UIColor.groupTableViewBackground.cgColor
        }
        
        if textField == txtConfPass {
            viewConfPass.layer.borderWidth = 1
            viewConfPass.layer.borderColor = UIColor(hex: appColorNew!).cgColor
            //txtPassword.nokri_updateBottomBorderColor(isTextFieldSelected: true)
        } else {
            //txtPassword.nokri_updateBottomBorderColor(isTextFieldSelected: false)
            viewConfPass.layer.borderWidth = 1
            viewConfPass.layer.borderColor = UIColor.groupTableViewBackground.cgColor
        }
        
        
        return true
    }
    
//    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
//        if textField == txtPassword{
//            if txtPassword.text?.count == 7{
//                let passwordRuleDescription = "required: lower; required: upper; required: digit; minlength: 8; maxlength: 16;"
//                if #available(iOS 12.0, *) {
//                    passwordBool = true
//
//                    let passwordRules = UITextInputPasswordRules(descriptor: passwordRuleDescription)
//                    txtPassword.passwordRules = passwordRules
//                    let alert = Constants.showBasicAlert(message: passwordRuleDescription)
//                    UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: false)
//                    print("saasas")
//                } else {
//                    // Fallback on earlier versions
//                    print("elsee")
//                }
//            }
//
//        }
//        if textField == txtConfPass{
//            if txtConfPass.text?.count == 7 {
//
//                let passwordRuleDescription = "required: lower; required: upper; required: digit; minlength: 8; maxlength: 16;"
//                    passwordConfirmBool = true
//
//                if #available(iOS 12.0, *) {
//                    let passwordRules = UITextInputPasswordRules(descriptor: passwordRuleDescription)
//                    txtConfPass.passwordRules = passwordRules
//                    let alert = Constants.showBasicAlert(message: passwordRuleDescription)
//
//                    UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: false)
//                    print("saasas")
//                } else {
//                    // Fallback on earlier versions
//                }
//
////                } else {
////                    // Fallback on earlier versions
////
////                    print("elsee")
////                }
//            }
//
//        }
//
//    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return false
    }
    
    @IBAction func hidePassClicked(_ sender: UIButton) {
        
        if(iconClick == true) {
            txtPassword.isSecureTextEntry = false
            imgPass.tintColor = UIColor(hex: appColorNew!)
        } else {
            txtPassword.isSecureTextEntry = true
            imgPass.tintColor = UIColor.lightGray
            
        }
        iconClick = !iconClick
        
    }
    
    @IBAction func hideConfPassClicked(_ sender: UIButton) {
        
        if(iconClick2 == true) {
            txtConfPass.isSecureTextEntry = false
            imgConfPass.tintColor = UIColor(hex: appColorNew!)
            
        } else {
            txtConfPass.isSecureTextEntry = true
            imgConfPass.tintColor = UIColor.lightGray
        }
        iconClick2 = !iconClick2
        
    }
    
    @IBAction func txtNameChanged(_ sender: Any) {
        let segVal = UserDefaults.standard.string(forKey: "candidateV")
        self.delegate?.registerStaticHeader(txtName: self.txtName.text!, txtEmail: self.txtEmail.text!, txtPass: self.txtPassword.text!, segmentValue: segVal!,txtConfPass:self.txtConfPass.text!)
    }
    
    @IBAction func txtEmailChanged(_ sender: Any) {
        let segVal = UserDefaults.standard.string(forKey: "candidateV")
        self.delegate?.registerStaticHeader(txtName: self.txtName.text!, txtEmail: self.txtEmail.text!, txtPass: self.txtPassword.text!, segmentValue: segVal!,txtConfPass:self.txtConfPass.text!)
    }
    
    @IBAction func txtPassChanged(_ sender: Any) {
        let segVal = UserDefaults.standard.string(forKey: "candidateV")
        self.delegate?.registerStaticHeader(txtName: self.txtName.text!, txtEmail: self.txtEmail.text!, txtPass: self.txtPassword.text!, segmentValue: segVal!,txtConfPass:self.txtConfPass.text!)
    }
    
    @IBAction func txtConfChanged(_ sender: UITextField) {
        let segVal = UserDefaults.standard.string(forKey: "candidateV")
        self.delegate?.registerStaticHeader(txtName: self.txtName.text!, txtEmail: self.txtEmail.text!, txtPass: self.txtPassword.text!, segmentValue: segVal!,txtConfPass:self.txtConfPass.text!)
        
    }
    
    
}
