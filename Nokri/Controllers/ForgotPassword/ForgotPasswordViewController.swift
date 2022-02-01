//
//  ForgotPasswordViewController.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 4/8/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController,UITextFieldDelegate {

    //MARK:- IBOutlets
    
    @IBOutlet weak var imgBack: UIImageView!
    @IBOutlet weak var viewBg: UIView!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var viewEmail: UIView!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var imageViewLogo: UIImageView!
    @IBOutlet weak var viewLine: UIView!
    @IBOutlet weak var lblForgot: UILabel!
    @IBOutlet weak var imgEmail: UIImageView!
    
    var appColorNew = UserDefaults.standard.string(forKey: "app_Color")
    
    //MARK:- View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        nokri_customeButtons()
        nokri_forgotData()
        self.btnSubmit.backgroundColor = UIColor(hex:appColorNew!)
        txtEmail.delegate = self
        txtEmail.nokri_addBottomBorder()
        
        viewBg.layer.cornerRadius = 15
        viewEmail.layer.cornerRadius = 20
        viewEmail.layer.borderWidth = 1
        viewLine.backgroundColor = UIColor(hex: appColorNew!)
        viewEmail.layer.borderColor = UIColor.groupTableViewBackground.cgColor
        txtEmail.layer.borderColor = UIColor.clear.cgColor
        let forgot = UserDefaults.standard.string(forKey: "forgot")
        lblForgot.text = forgot
        imgBack.image = imgBack.image?.withRenderingMode(.alwaysTemplate)
        imgBack.tintColor = UIColor(hex: appColorNew!)
        
        imgEmail.image = imgEmail.image?.withRenderingMode(.alwaysTemplate)
        imgEmail.tintColor = UIColor.lightGray
        self.showBackButton()
      
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
    //MARK:- Custome Function
    
    func nokri_isValidEmail(testStr:String) -> Bool {
        print("validate emilId: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: testStr)
        return result
    }
    
    func nokri_customeButtons(){
        btnSubmit.layer.cornerRadius = 22
        btnSubmit.layer.masksToBounds = false
    }

    func nokri_populateData() {
        if UserHandler.sharedInstance.objForgotUser != nil {
            guard let data = UserHandler.sharedInstance.objForgotUser else {
                return
            }
            if let email = data.forgotPlaceholder
            {
                txtEmail.attributedPlaceholder = NSAttributedString(string: email,
                                                                    attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
            }
            if let btnSub = data.btn
            {
                btnSubmit.setTitle(btnSub, for: .normal)
            }
            if let imgUrl = data.logo{
                imageViewLogo.sd_setImage(with: URL(string: imgUrl), completed: nil)
                imageViewLogo.sd_setShowActivityIndicatorView(true)
                imageViewLogo.sd_setIndicatorStyle(.gray)
            }

        }
        self.navigationController?.navigationBar.backgroundColor = UIColor(hex:appColorNew!)
    }
    
    
    //MARK:- TextField Delegate

    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return false
    }
    
    //MARK:- IBActions
    
    
    @IBAction func btnBackClicked(_ sender: UIButton) {
    self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSubmitClicked(_ sender: UIButton) {
        guard let email = txtEmail.text else {
            return
        }
        if email == "" {
            let alert = Constants.showBasicAlert(message: "Please Enter email.")
            self.present(alert, animated: true, completion: nil)
        }else if nokri_isValidEmail(testStr: email) == false {
            let alert = Constants.showBasicAlert(message: "Please Enter Valid email.")
            self.present(alert, animated: true, completion: nil)
        }
        else {
            let param: [String: Any] = [
                "email": email,
                ]
            print(param)
            self.nokri_forgotPost(parameter: param as NSDictionary)
        }
    }

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == txtEmail {
            
            viewEmail.layer.borderWidth = 1
            viewEmail.layer.borderColor = UIColor(hex: appColorNew!).cgColor
        }
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField == txtEmail {
            
            viewEmail.layer.borderWidth = 1
            viewEmail.layer.borderColor = UIColor.groupTableViewBackground.cgColor
        }
        return true
    }
    
    //MARK:- API Calls
    
    func nokri_forgotData() {
        self.btnSubmit.isHidden = true
        self.showLoader()
        UserHandler.nokri_forgotData(success: { (successResponse) in
            self.stopAnimating()
            if successResponse.success {
                self.btnSubmit.isHidden = false
                UserHandler.sharedInstance.objForgotUser = successResponse.data
                self.title = successResponse.data.forgot
                self.nokri_populateData()
            }
            else {
                self.btnSubmit.isHidden = true
                let alert = Constants.showBasicAlert(message: successResponse.message)
                self.present(alert, animated: true, completion: nil)
                self.stopAnimating()
            }
        }) { (error) in
            self.btnSubmit.isHidden = true
            let alert = Constants.showBasicAlert(message: error.message)
            self.present(alert, animated: true, completion: nil)
            self.stopAnimating()
        }
    }
    
    func nokri_forgotPost(parameter: NSDictionary) {
        self.showLoader()
        UserHandler.nokri_forgotPost(parameter: parameter as NSDictionary, success: { (successResponse) in
            if successResponse.success == true {
              self.stopAnimating()
            }
            else {
                let alert = Constants.showBasicAlert(message: successResponse.message)
                self.present(alert, animated: true, completion: nil)
                self.stopAnimating()
            }
            let alert = Constants.showBasicAlert(message: successResponse.message)
            self.present(alert, animated: true, completion: nil)
            self.stopAnimating()
            
        }) { (error) in
            let alert = Constants.showBasicAlert(message: error.message)
            self.present(alert, animated: true, completion: nil)
            self.stopAnimating()
        }
    }
}
