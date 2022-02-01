//
//  EditCompanySocialLinksViewController.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 4/17/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import UIKit
import TextFieldEffects
import Toast_Swift
import JGProgressHUD

class EditCompanySocialLinksViewController: UIViewController,UITextFieldDelegate {

    //MARK:- IBOutlets
    
    @IBOutlet weak var txtFacebookLink: UITextField!
    @IBOutlet weak var txtTwitterLink: UITextField!
    @IBOutlet weak var txtLinkedInLink: UITextField!
    @IBOutlet weak var txtGooglePlusLink: UITextField!
    @IBOutlet weak var btnSaveLinks: UIButton!
    @IBOutlet weak var viewTop: UIView!
    @IBOutlet weak var lblFacebbok: UILabel!
    @IBOutlet weak var lblTwitter: UILabel!
    @IBOutlet weak var lblLinkedIn: UILabel!
    @IBOutlet weak var lblGooglePlus: UILabel!
    @IBOutlet weak var lblStepNo: UILabel!
      
    //MARK:- Proporties
    
    var appColorNew = UserDefaults.standard.string(forKey: "app_Color")
    var socialArrayData = [SocialLinkData]()
    var socialArrayExtra = [SocialLinkExtra]()
    
    //MARK:- View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nokri_customeButton()
        nokri_socialLinkData()
        nokri_textFieldAddBorder()
       // adMob()
        self.btnSaveLinks.layer.borderColor = UIColor(hex:appColorNew!).cgColor
        self.viewTop.backgroundColor = UIColor(hex: appColorNew!)
        if let userData = UserDefaults.standard.object(forKey: "settingsData") {
            let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
            let dataTabs = SplashRoot(fromDictionary: objData)
            let obj = dataTabs.data.empEditTabs
            self.lblStepNo.text = obj?.social
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
         nokri_textFieldUpdateBottomBorderSize()
    }
    //MARK:- IBActions
    
    @IBAction func txtClicked(_ sender: UITextField) {
    }
    
    @IBAction func txtTwitterClicked(_ sender: UITextField) {
    }
    
    @IBAction func txtLinkedINClicked(_ sender: UITextField) {
    }
    
    @IBAction func txtGoogleClicked(_ sender: UITextField) {
    }
    
    @IBAction func btnSaveLinksClicked(_ sender: UIButton) {
        
        guard let fb = txtFacebookLink.text else {
            return
        }
        guard let linkedIn = txtLinkedInLink.text else {
            return
        }
        guard let twitter = txtTwitterLink.text else {
            return
        }
        guard let google = txtGooglePlusLink.text else {
            return
        }
        let param: [String: Any] = [
            "emp_fb": fb,
            "emp_twiter": twitter,
            "emp_linked": linkedIn,
            "emp_google": google
        ]
        print(param)
        self.nokri_socialLinkPost(parameter: param as NSDictionary)
    }
    
    
    //MARK:- Custome Functions
    
    func nokri_customeButton(){
        btnSaveLinks.layer.cornerRadius = 15
        btnSaveLinks.layer.borderWidth = 1
        btnSaveLinks.layer.borderColor = UIColor(hex:appColorNew!).cgColor
        //btnSaveLinks.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor
        //btnSaveLinks.layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
        //btnSaveLinks.layer.shadowOpacity = 0.7
        //btnSaveLinks.layer.shadowRadius = 0.3
        btnSaveLinks.layer.masksToBounds = false
        btnSaveLinks.backgroundColor = UIColor.white
        btnSaveLinks.setTitleColor(UIColor(hex: appColorNew!), for: .normal)
    }
    
    func nokri_populateData(){
        
        for obj in socialArrayData{
            if obj.fieldTypeName == "emp_fb" {
               lblFacebbok.text = obj.key
               txtFacebookLink.placeholder = obj.key
               txtFacebookLink.text = obj.value
            }
            if obj.fieldTypeName == "emp_twiter" {
                 lblTwitter.text = obj.key
                 txtTwitterLink.placeholder = obj.key
                 txtTwitterLink.text = obj.value
            }
            if obj.fieldTypeName == "emp_linked" {
                lblLinkedIn.text = obj.key
                txtLinkedInLink.placeholder = obj.key
                txtLinkedInLink.text = obj.value
            }
            if obj.fieldTypeName == "emp_google" {
                lblGooglePlus.text = obj.key
                txtGooglePlusLink.placeholder = obj.key
                txtGooglePlusLink.text = obj.value
            }
        }
        
        for obj in socialArrayExtra{
            if obj.fieldTypeName == "btn_txt" {
              self.btnSaveLinks.setTitle(obj.value, for: .normal)
            }
            if obj.fieldTypeName == "fb_txt" {
              txtFacebookLink.placeholder = obj.value
            }
            if obj.fieldTypeName == "tw_txt" {
               txtTwitterLink.placeholder = obj.value
            }
            if obj.fieldTypeName == "lk_txt" {
                txtLinkedInLink.placeholder = obj.value
            }
            if obj.fieldTypeName == "g+_txt" {
                txtGooglePlusLink.placeholder = obj.value
            }
        }
    }
    
    //-->> Custome Text Fields
    
    func nokri_textFieldAddBorder(){
        txtFacebookLink.delegate = self
        txtGooglePlusLink.delegate = self
        txtLinkedInLink.delegate = self
        txtTwitterLink.delegate = self
        txtFacebookLink.nokri_addBottomBorder()
        txtGooglePlusLink.nokri_addBottomBorder()
        txtLinkedInLink.nokri_addBottomBorder()
        txtTwitterLink.nokri_addBottomBorder()
    }
    
    func nokri_textFieldUpdateBottomBorderSize(){
        txtFacebookLink.nokri_updateBottomBorderSize()
        txtGooglePlusLink.nokri_updateBottomBorderSize()
        txtLinkedInLink.nokri_updateBottomBorderSize()
        txtTwitterLink.nokri_updateBottomBorderSize()
    }
    
    //MARK:- TextField Delegate
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == txtFacebookLink {
            txtFacebookLink.nokri_updateBottomBorderColor(isTextFieldSelected: true)
        } else {
            txtFacebookLink.nokri_updateBottomBorderColor(isTextFieldSelected: false)
        }
        if textField == txtGooglePlusLink {
            txtGooglePlusLink.nokri_updateBottomBorderColor(isTextFieldSelected: true)
        } else {
            txtGooglePlusLink.nokri_updateBottomBorderColor(isTextFieldSelected: false)
        }
        if textField == txtTwitterLink {
            txtTwitterLink.nokri_updateBottomBorderColor(isTextFieldSelected: true)
        } else {
            txtTwitterLink.nokri_updateBottomBorderColor(isTextFieldSelected: false)
        }
        if textField == txtLinkedInLink {
            txtLinkedInLink.nokri_updateBottomBorderColor(isTextFieldSelected: true)
        } else {
            txtLinkedInLink.nokri_updateBottomBorderColor(isTextFieldSelected: false)
        }
        return true
    }
    
    //MARK:- API Calls
    
    func nokri_socialLinkData() {
        self.showLoader()
        self.viewTop.isHidden = true
        self.btnSaveLinks.isHidden = true
        UserHandler.nokri_socialLinks(success: { (successResponse) in
            self.stopAnimating()
            if successResponse.success {
                self.viewTop.isHidden = false
                self.btnSaveLinks.isHidden = false
                self.socialArrayData = successResponse.data
                self.socialArrayExtra = successResponse.extras
                self.nokri_populateData()
            }
            else {
                self.viewTop.isHidden = true
                self.btnSaveLinks.isHidden = true
                let alert = Constants.showBasicAlert(message: successResponse.message)
                self.present(alert, animated: true, completion: nil)
            }
        }) { (error) in
            self.viewTop.isHidden = true
            self.btnSaveLinks.isHidden = true
            let alert = Constants.showBasicAlert(message: error.message)
            self.present(alert, animated: true, completion: nil)
            self.stopAnimating()
        }
    }
    
    func nokri_socialLinkPost(parameter: NSDictionary) {
        self.showLoader()
        UserHandler.nokri_socialLinksPost(parameter: parameter as NSDictionary, success: { (successResponse) in
           self.stopAnimating()
            if successResponse.success == true{
                let hud = JGProgressHUD(style: .dark)
                hud.textLabel.text = successResponse.message
                hud.detailTextLabel.text = nil
                hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                hud.position = .bottomCenter
                hud.show(in: self.view)
                hud.dismiss(afterDelay: 2.0)
               self.nokri_socialLinkData()
            }
            else {
                let alert = Constants.showBasicAlert(message: successResponse.message)
                self.present(alert, animated: true, completion: nil)
            }
        }) { (error) in
            let alert = Constants.showBasicAlert(message: error.message)
            self.present(alert, animated: true, completion: nil)
            self.stopAnimating()
        }
    }
    
    public func adMob() {
        if UserHandler.sharedInstance.objSaplash?.adMob != nil {
            let objData = UserHandler.sharedInstance.objSaplash?.adMob
            var isShowAd = false
            if let adShow = objData?.show {
                isShowAd = adShow
            }
            if isShowAd {
                var isShowBanner = false
                if let banner = objData?.is_show_banner {
                    isShowBanner = banner
                }
                if isShowBanner {
                    SwiftyAd.shared.setup(withBannerID: (objData?.banner_id)!, interstitialID: "", rewardedVideoID: "")
                    self.view.translatesAutoresizingMaskIntoConstraints = false
                    if objData?.position == "top" {
                        self.view.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100).isActive = true
                        SwiftyAd.shared.showBanner(from: self, at: .top)
                    }
                    else {
                        self.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 60).isActive = true
                        SwiftyAd.shared.showBanner(from: self, at: .bottom)
                    }
                }
            }
        }
    }
}
