//
//  CandidateContactTableViewCell.swift
//  Nokri
//
//  Created by Furqan Nadeem on 06/03/2019.
//  Copyright © 2019 Furqan Nadeem. All rights reserved.
//

import UIKit
import JGProgressHUD

class CandidateContactTableViewCell: UITableViewCell,UITextFieldDelegate {
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtSubject: UITextField!
    @IBOutlet weak var txtViewMsg: UITextView!
    @IBOutlet weak var btnSendMsg: UIButton!
    @IBOutlet weak var viewBg: UIView!
    
    var withOutLogin = UserDefaults.standard.string(forKey: "aType")
    var appColorNew = UserDefaults.standard.string(forKey: "app_Color")
    var recId = 0
    var recvName = ""
    var recvEmail = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        txtName.delegate = self
        txtEmail.delegate = self
        txtSubject.delegate = self
        txtViewMsg.layer.borderWidth = 0.5
        txtViewMsg.layer.borderColor = UIColor.lightGray.cgColor
        self.btnSendMsg.layer.cornerRadius = 15
        self.btnSendMsg.backgroundColor = UIColor(hex:appColorNew!)
//        txtName.nokri_updateBottomBorderSize()
//        txtEmail.nokri_updateBottomBorderSize()
//        txtSubject.nokri_updateBottomBorderSize()
//        txtName.nokri_addBottomBorder()
//        txtEmail.nokri_addBottomBorder()
//        txtSubject.nokri_addBottomBorder()
    }
    
//    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
//        if textField == txtName {
//            txtName.nokri_updateBottomBorderColor(isTextFieldSelected: true)
//        } else {
//            txtName.nokri_updateBottomBorderColor(isTextFieldSelected: false)
//        }
//        if textField == txtEmail {
//            txtEmail.nokri_updateBottomBorderColor(isTextFieldSelected: true)
//        } else {
//            txtEmail.nokri_updateBottomBorderColor(isTextFieldSelected: false)
//        }
//        if textField == txtSubject {
//            txtSubject.nokri_updateBottomBorderColor(isTextFieldSelected: true)
//        } else {
//            txtSubject.nokri_updateBottomBorderColor(isTextFieldSelected: false)
//        }
//
//        return true
//    }
    
    @IBAction func btnMsgClicked(_ sender: UIButton) {
      
        if  withOutLogin == "5"{
            self.viewBg.makeToast("Please Login First", duration: 1.5, position: .bottom)
        }else{
            if txtName.text == ""{
                let alert = Constants.showBasicAlert(message: "Please Enter Name")
                self.window?.rootViewController!.present(alert, animated: true, completion: nil)
                
            }else if txtEmail.text == ""{
                let alert = Constants.showBasicAlert(message: "Please Enter Email")
                
                self.window?.rootViewController!.present(alert, animated: true, completion: nil)
                
            }else if isValidEmail(testStr: txtEmail.text!) == false{
                let alert = Constants.showBasicAlert(message: "Please Enter Valid Email")
                
                self.window?.rootViewController!.present(alert, animated: true, completion: nil)
            }
            else if txtSubject.text == ""{
                let alert = Constants.showBasicAlert(message: "Please Enter Subject")
                self.window?.rootViewController!.present(alert, animated: true, completion: nil)
            }else if txtViewMsg.text == ""{
                let alert = Constants.showBasicAlert(message: "Please Enter Message")
                self.window?.rootViewController!.present(alert, animated: true, completion: nil)
            }else{
                
                let param: [String: Any] = [
                    "sender_name": txtName.text!,
                    "sender_email": txtEmail.text!,
                    "sender_subject": txtSubject.text!,
                    "sender_message": txtViewMsg.text!,
                    "receiver_id": recId,
                    "receiver_name": recvName,
                    "receiver_email":recvEmail,
                    ]
                print(param)
                self.nokri_ContactPost(parameter: param as NSDictionary)
            }
        }
    }
    
    
    func nokri_ContactPost(parameter: NSDictionary) {
        //self.showLoader()
        UserHandler.nokri_CandidateContactPost(parameter: parameter as NSDictionary, success: { (successResponse) in
           // self.stopAnimating()
            if successResponse.success == true{
                self.btnSendMsg.isEnabled = true
                let hud = JGProgressHUD(style: .dark)
                hud.textLabel.text = successResponse.message
                hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                hud.position = .bottomCenter
                hud.show(in: self.viewBg)
                hud.dismiss(afterDelay: 2.0)
            }
            else {
                let alert = Constants.showBasicAlert(message: successResponse.message)
                self.window?.rootViewController!.present(alert, animated: true, completion: nil)
                //self.stopAnimating()
            }
        }) { (error) in
            let alert = Constants.showBasicAlert(message: error.message)
            self.window?.rootViewController!.present(alert, animated: true, completion: nil)
            //self.stopAnimating()
        }
    }
    
    func isValidEmail(testStr:String) -> Bool {
        print("validate emilId: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: testStr)
        return result
    }
    
}
