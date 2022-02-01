//
//  ChangePasswordViewController.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 5/5/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import UIKit
import SDWebImage
import JGProgressHUD

class ChangePasswordViewController: UIViewController,UITextFieldDelegate {

    //MARK:- IBOutlets
    
    @IBOutlet weak var txtCurrentPass: UITextField!
    @IBOutlet weak var txtNewPass: UITextField!
    @IBOutlet weak var txtConfNewPass: UITextField!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    //MARK:- Proporties
    
    var appColorNew = UserDefaults.standard.string(forKey: "app_Color")
    var data:ResetPassword?
    var updatedPassword:String?
    
    //Mrk:- View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nokri_changePasswordData()
        txtCurrentPass.delegate = self
        txtNewPass.delegate = self
        txtConfNewPass.delegate = self
        txtConfNewPass.nokri_addBottomBorder()
        txtCurrentPass.nokri_addBottomBorder()
        txtNewPass.nokri_addBottomBorder()
        btnSubmit.backgroundColor = UIColor(hex: appColorNew!)
        btnCancel.backgroundColor = UIColor(hex: appColorNew!)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        txtCurrentPass.nokri_updateBottomBorderSize()
        txtNewPass.nokri_updateBottomBorderSize()
        txtConfNewPass.nokri_updateBottomBorderSize()
    }
    
    //MARK:- Custome Functions
    
    func nokri_populateData(){
        
        if let currnt = data?.oldPassword{
            txtCurrentPass.placeholder = currnt
        }
        if let new  = data?.newPassword{
            txtNewPass.placeholder = new
        }
        if let conNew  = data?.confirmPassword{
            txtConfNewPass.placeholder = conNew
        }
        if let logo  = data?.logo{
           imageView.sd_setImage(with: URL(string: logo), completed: nil)
        }

    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == txtCurrentPass {
            txtCurrentPass.nokri_updateBottomBorderColor(isTextFieldSelected: true)
        } else {
            txtCurrentPass.nokri_updateBottomBorderColor(isTextFieldSelected: false)
        }
        if textField == txtConfNewPass {
            txtConfNewPass.nokri_updateBottomBorderColor(isTextFieldSelected: true)
        } else {
            txtConfNewPass.nokri_updateBottomBorderColor(isTextFieldSelected: false)
        }
        if textField == txtConfNewPass {
            txtConfNewPass.nokri_updateBottomBorderColor(isTextFieldSelected: true)
        } else {
    
            txtConfNewPass.nokri_updateBottomBorderColor(isTextFieldSelected: false)
        }
        return true
    }
    
    //MARK:- IBActions
    
    @IBAction func btnDissMissControllerClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnCancelClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnSubmitClicked(_ sender: UIButton) {
        
        let oldPass = UserDefaults.standard.string(forKey: "password")
        print(oldPass!)
        //print(txtCurrentPass.text)
        
        guard let currentPass = txtCurrentPass.text else {
            return
        }
        guard let newPass = txtNewPass.text else {
            return
        }
        guard let conNewPass = txtConfNewPass.text else {
            return
        }
        if currentPass == "" {
            let alert = Constants.showBasicAlert(message: "Password Fields can not be empty.")
            self.present(alert, animated: true, completion: nil)
        }

        else if newPass == "" {
            let alert = Constants.showBasicAlert(message: (data?.newPassword)!)
            self.present(alert, animated: true, completion: nil)
        }
        else if conNewPass == "" {
            let alert = Constants.showBasicAlert(message: (data?.confirmPassword)!)
            self.present(alert, animated: true, completion: nil)
        }

        else {
            let param: [String: Any] = [
                "old_password": currentPass,
                "new_password": newPass,
                "confirm_password": conNewPass,
                ]
            print(param)
            self.nokri_changePasswordPost(parameter: param as NSDictionary)
        }
    }

    //MARK:- API Calls
    
    func nokri_changePasswordData() {
        
        self.showLoader()
        UserHandler.nokri_changePassword(success: { (successResponse) in
            self.stopAnimating()
            if successResponse.success {
                self.data = successResponse.data
                self.nokri_populateData()
            }
            else {
                let alert = Constants.showBasicAlert(message: successResponse.message)
                self.present(alert, animated: true, completion: nil)
            }
        }) { (error) in
            let alert = Constants.showBasicAlert(message: error.message)
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    func nokri_changePasswordPost(parameter: NSDictionary) {

        self.showLoader()
        UserHandler.nokri_changePasswordPost(parameter: parameter as NSDictionary, success: { (successResponse) in
            self.stopAnimating()
            let hud = JGProgressHUD(style: .dark)
            hud.textLabel.text = successResponse.message!
            hud.detailTextLabel.text = nil
            hud.indicatorView = JGProgressHUDSuccessIndicatorView()
            hud.position = .bottomCenter
            hud.show(in: self.view)
            hud.dismiss(afterDelay: 2.0)
            self.stopAnimating()
            UserDefaults.standard.set(self.txtConfNewPass.text, forKey: "password")
           
        }) { (error) in
            let alert = Constants.showBasicAlert(message: error.message)
            self.present(alert, animated: true, completion: nil)
            self.stopAnimating()
        }
    }

}
