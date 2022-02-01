//
//  FeedBackViewController.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 10/2/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import UIKit

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
        }else if txtSubject.text == ""{
            let alert = Constants.showBasicAlert(message: "Please Enter Subject.")
            self.present(alert, animated: true, completion: nil)
        } else if txtViewMsg.text == ""{
            let alert = Constants.showBasicAlert(message: "Please Enter Message.")
            self.present(alert, animated: true, completion: nil)
        }else{
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
        self.nokri_startActivityIndicator()
        UserHandler.nokri_FeedBackPost(parameter: parameter as NSDictionary, success: { (successResponse) in
            self.nokri_stopActivityIndicator()
            if successResponse.success == true{
                self.view.makeToast(successResponse.message, duration: 1.5, position: .center)
            }
            else {
                let alert = Constants.showBasicAlert(message: successResponse.message)
                self.present(alert, animated: true, completion: nil)
                self.nokri_stopActivityIndicator()
            }
        }) { (error) in
            let alert = Constants.showBasicAlert(message: error.message)
            self.present(alert, animated: true, completion: nil)
            self.nokri_stopActivityIndicator()
        }
    }
    
   
}
