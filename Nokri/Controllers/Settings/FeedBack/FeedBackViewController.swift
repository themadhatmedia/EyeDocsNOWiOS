//
//  FeedBackViewController.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 10/2/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import UIKit
import JGProgressHUD

class FeedBackViewController: UIViewController,UITextFieldDelegate {

    //MARK:- IBOutlets
    
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtSubject: UITextField!
    @IBOutlet weak var txtViewMsg: UITextView!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnClose: UIButton!
    
    //MARK:- Proporties
    
    var appColorNew = UserDefaults.standard.string(forKey: "app_Color")
   
    //MARK:- View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        custombtn()
        txtEmail.delegate = self
        txtSubject.delegate = self
        txtEmail.nokri_addBottomBorder()
        txtSubject.nokri_addBottomBorder()
        lblTitle.text = "Feedback"
        nokri_populateData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        txtEmail.nokri_updateBottomBorderSize()
        txtSubject.nokri_updateBottomBorderSize()
    }

    @IBAction func btnCloseClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK:- Custome Function
    
    func custombtn(){
        viewHeader.backgroundColor = UIColor(hex: appColorNew!)
        btnSubmit.backgroundColor = UIColor(hex: appColorNew!)
        btnCancel.backgroundColor = UIColor(hex: appColorNew!)
        txtViewMsg.layer.borderWidth = 1.0
        txtViewMsg.layer.borderColor = UIColor.groupTableViewBackground.cgColor
    }
    
    func nokri_populateData(){
        if let userData = UserDefaults.standard.object(forKey: "settingsData") {
            let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
            let dataTabs = SplashRoot(fromDictionary: objData)
            txtEmail.placeholder = dataTabs.data.feedBackSaplash.data.email
            txtSubject.placeholder = dataTabs.data.feedBackSaplash.data.title
            txtViewMsg.text = "Write here"
            btnSubmit.setTitle(dataTabs.data.feedBackSaplash.data.btnSubmit, for: .normal)
            btnCancel.setTitle(dataTabs.data.feedBackSaplash.data.btnCancel, for: .normal)
        }
    }
    
    //MARK:- IBActions,

    @IBAction func btnSubmitClicked(_ sender: UIButton) {
        if txtEmail.text == ""{
            let alert = Constants.showBasicAlert(message: "Please Enter email.")
            self.present(alert, animated: true, completion: nil)
        }else if isValidEmail(testStr: txtEmail.text!) == false {
            let alert = Constants.showBasicAlert(message: "Please Enter Valid email.")
            self.present(alert, animated: true, completion: nil)
        }else if txtSubject.text == ""{
            let alert = Constants.showBasicAlert(message: "Please Enter Subject.")
            self.present(alert, animated: true, completion: nil)
        } else if txtViewMsg.text == ""{
            let alert = Constants.showBasicAlert(message: "Please Enter Message.")
            self.present(alert, animated: true, completion: nil)
        }
        else{
        let param: [String: Any] = [
            "email": txtEmail.text!,
            "subject": txtSubject.text!,
            "message": txtViewMsg.text!
            ]
        print(param)
        self.nokri_feedBackPost(parameter: param as NSDictionary)
        }
    }
    
    @IBAction func btnCancelClicked(_ sender: UIButton) {
      self.dismiss(animated: true, completion: nil)
    }
    
    //MARK:- Textfield Delegate
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == txtEmail {
            txtEmail.nokri_updateBottomBorderColor(isTextFieldSelected: true)
        } else {
            txtEmail.nokri_updateBottomBorderColor(isTextFieldSelected: false)
        }
        if textField == txtSubject {
            txtSubject.nokri_updateBottomBorderColor(isTextFieldSelected: true)
        } else {
            txtSubject.nokri_updateBottomBorderColor(isTextFieldSelected: false)
        }
        return true
    }
    
    //MARK:- Api Call
    
    func nokri_feedBackPost(parameter: NSDictionary) {
       self.showLoader()
        UserHandler.nokri_FeedBackPost(parameter: parameter as NSDictionary, success: { (successResponse) in
            self.stopAnimating()
            if successResponse.success == true{
                let hud = JGProgressHUD(style: .dark)
                hud.textLabel.text = successResponse.message
                hud.detailTextLabel.text = nil
                hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                hud.position = .bottomCenter
                hud.show(in: self.view)
                hud.dismiss(afterDelay: 2.0)
                //self.view.makeToast(successResponse.message, duration: 1.5, position: .center)
                self.perform(#selector(self.nokri_Dismiss), with: nil, afterDelay: 2)
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
    
    @objc func nokri_Dismiss(){
        self.dismiss(animated: true, completion: nil)
    }
    
    func isValidEmail(testStr:String) -> Bool {
        print("validate emilId: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: testStr)
        return result
    }
    
   
}
