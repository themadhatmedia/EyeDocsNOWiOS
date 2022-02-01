//
//  AddSocialLinkViewController.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 4/27/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import UIKit
import TextFieldEffects
import NVActivityIndicatorView
import JGProgressHUD

class AddSocialLinkViewController: UIViewController,UITextFieldDelegate {

    //MARK:- IBOutlets
    
    @IBOutlet weak var lblStepNo: UILabel!
    @IBOutlet weak var btnSaveLink: UIButton!
    @IBOutlet weak var txtFacebook: UITextField!
    @IBOutlet weak var txtTwitter: UITextField!
    @IBOutlet weak var txtLinkedIn: UITextField!
    @IBOutlet weak var txtGooglePlus: UITextField!
    @IBOutlet weak var viewStepNo: UIView!
    @IBOutlet weak var lblFb: UILabel!
    @IBOutlet weak var lblTwitter: UILabel!
    @IBOutlet weak var lblLinkedIn: UILabel!
    @IBOutlet weak var lblGoogle: UILabel!
    
    //MARK:- Proporties
    
    var appColorNew = UserDefaults.standard.string(forKey: "app_Color")
    var data = [CandSocialLinkkData]()
    var extra : CandSocilLinksExtra?
    
    //MARK:- View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nokri_customeButton()
        nokri_socialLinksData()
        self.navigationController?.navigationBar.isHidden = true
        viewStepNo.backgroundColor = UIColor(hex: appColorNew!)
        nokri_addBottomBorder()
        self.addLeftBarButtonWithImage(#imageLiteral(resourceName: "menu"))
        if let userData = UserDefaults.standard.object(forKey: "settingsData") {
            let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
            let dataTabs = SplashRoot(fromDictionary: objData)
            let obj = dataTabs.data.candTabs
            self.lblStepNo.text = obj?.socail
        }
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
         nokri_addBottomBorderSize()
    }
    
    //MARK:- Custome Functions
    
    func nokri_addBottomBorder(){
        txtFacebook.delegate = self
        txtTwitter.delegate = self
        txtLinkedIn.delegate = self
        txtGooglePlus.delegate = self
        txtFacebook.nokri_addBottomBorder()
        txtTwitter.nokri_addBottomBorder()
        txtLinkedIn.nokri_addBottomBorder()
        txtGooglePlus.nokri_addBottomBorder()
    }
    
    func nokri_addBottomBorderSize(){
        txtFacebook.nokri_updateBottomBorderSize()
        txtTwitter.nokri_updateBottomBorderSize()
        txtLinkedIn.nokri_updateBottomBorderSize()
        txtGooglePlus.nokri_updateBottomBorderSize()
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == txtFacebook {
            txtFacebook.nokri_updateBottomBorderColor(isTextFieldSelected: true)
        } else {
            txtFacebook.nokri_updateBottomBorderColor(isTextFieldSelected: false)
        }
        if textField == txtTwitter {
            txtTwitter.nokri_updateBottomBorderColor(isTextFieldSelected: true)
        } else {
            txtTwitter.nokri_updateBottomBorderColor(isTextFieldSelected: false)
        }
        if textField == txtLinkedIn {
            txtLinkedIn.nokri_updateBottomBorderColor(isTextFieldSelected: true)
        } else {
            txtLinkedIn.nokri_updateBottomBorderColor(isTextFieldSelected: false)
        }
        if textField == txtGooglePlus {
            txtGooglePlus.nokri_updateBottomBorderColor(isTextFieldSelected: true)
        } else {
            txtGooglePlus.nokri_updateBottomBorderColor(isTextFieldSelected: false)
        }
        
        return true
    }
   
    @IBAction func btnSaveLinksClicked(_ sender: UIButton) {
        
        guard let fb = txtFacebook.text else {
            return
        }
        guard let google = txtGooglePlus.text else {
            return
        }
        guard let linkedIn = txtLinkedIn.text else {
            return
        }
        guard let twitter = txtTwitter.text else {
            return
        }
            let param: [String: Any] = [
                "cand_fb": fb,
                "cand_google": google,
                "cand_linked": linkedIn,
                "cand_twiter": twitter
                ]
            print(param)
            self.nokri_socialLinksPost(parameter: param as NSDictionary)
    }
    
    //MARK:- Custome Functions
    
    func nokri_populateData(){
        for obj in data{
            if obj.fieldTypeName == "cand_fb"{
                lblFb.text = obj.key
                txtFacebook.placeholder = extra?.fbTxt
                txtFacebook.text = obj.value
            }
            if obj.fieldTypeName == "cand_twiter"{
                lblTwitter.text = obj.key
                txtTwitter.placeholder = extra?.twTxt
                txtTwitter.text = obj.value
            }
            if obj.fieldTypeName == "cand_linked"{
                lblLinkedIn.text = obj.key
                txtLinkedIn.placeholder = extra?.lkTxt
                txtLinkedIn.text = obj.value
            }
            if obj.fieldTypeName == "cand_google"{
                lblGoogle.text = obj.key
                txtGooglePlus.placeholder = extra?.gTxt
                txtGooglePlus.text = obj.value
            }
        }
        self.title = extra?.pageTitle
        btnSaveLink.setTitle(extra?.btnTxt, for: .normal)
    }
    
    func nokri_customeButton(){
        btnSaveLink.layer.cornerRadius = 15
        btnSaveLink.layer.borderWidth = 1
        btnSaveLink.layer.borderColor = UIColor(hex:appColorNew!).cgColor
        btnSaveLink.setTitleColor(UIColor(hex:appColorNew!), for: .normal)
        //btnSaveLink.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor
        //btnSaveLink.layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
        //btnSaveLink.layer.shadowOpacity = 0.7
        //btnSaveLink.layer.shadowRadius = 0.3
        btnSaveLink.layer.masksToBounds = false
        btnSaveLink.backgroundColor = UIColor.white
    }
    
    //MARK:- API Calls

    func nokri_socialLinksData() {
        self.viewStepNo.isHidden = true
        self.btnSaveLink.isHidden = true
        showLoader()
        UserHandler.nokri_candidateSocialLinksGet(success: { (successResponse) in
            self.stopAnimating()
            if successResponse.success {
                self.btnSaveLink.isHidden = false
                self.viewStepNo.isHidden = false
                self.data = successResponse.data
                self.extra = successResponse.extras
                self.nokri_populateData()
            }
            else {
                self.btnSaveLink.isHidden = true
                self.viewStepNo.isHidden = true
                let alert = Constants.showBasicAlert(message: successResponse.message)
                self.present(alert, animated: true, completion: nil)
            }
        }) { (error) in
            self.btnSaveLink.isHidden = true
            self.viewStepNo.isHidden = true
            let alert = Constants.showBasicAlert(message: error.message)
            self.present(alert, animated: true, completion: nil)
            self.stopAnimating()
        }
    }
    
    func nokri_socialLinksPost(parameter: NSDictionary) {
         showLoader()
        UserHandler.nokri_candidateSocialLinksPost(parameter: parameter as NSDictionary, success: { (successResponse) in
            self.stopAnimating()
            if successResponse.success == true{
                //self.view.makeToast(successResponse.message, duration: 1.5, position: .center)
                let hud = JGProgressHUD(style: .dark)
                hud.textLabel.text = successResponse.message!
                hud.detailTextLabel.text = nil
                hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                hud.position = .bottomCenter
                hud.show(in: self.view)
                hud.dismiss(afterDelay: 2.0)
            }
            else {
                let hud = JGProgressHUD(style: .dark)
                hud.textLabel.text = successResponse.message!
                hud.detailTextLabel.text = nil
                hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                hud.position = .bottomCenter
                hud.show(in: self.view)
                hud.dismiss(afterDelay: 2.0)
                 //self.view.makeToast(successResponse.message, duration: 1.5, position: .center)
//                let alert = Constants.showBasicAlert(message: successResponse.message)
//                self.present(alert, animated: true, completion: nil)
                self.stopAnimating()
            }
        }) { (error) in
            let alert = Constants.showBasicAlert(message: error.message)
            self.present(alert, animated: true, completion: nil)
            self.stopAnimating()
        }
    }
}
