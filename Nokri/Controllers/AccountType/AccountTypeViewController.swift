//
//  AccountTypeViewController.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 5/8/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import UIKit
import BetterSegmentedControl
import FBSDKCoreKit
import FBSDKLoginKit
import TTSegmentedControl


class AccountTypeViewController: UIViewController {

    //MARK:- IBOutlets
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSelectAcType: UILabel!
    @IBOutlet weak var segmentedControl: TTSegmentedControl!
    @IBOutlet weak var viewAlert: UIView!
    @IBOutlet weak var viewTop: UIView!
    @IBOutlet weak var btnContinue: UIButton!

    //MARK:- Proporties
    
    var userId:Int?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var appColorNew = UserDefaults.standard.string(forKey: "app_Color")
    var type = ""
    var tempId:Int = 0
    
    //MARK:- View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nokri_customeButtons()
        nokri_setAccountData()
        self.viewTop.backgroundColor = UIColor(hex:appColorNew!)
        self.btnContinue.backgroundColor = UIColor(hex:appColorNew!)
        let can = UserDefaults.standard.string(forKey: "cand")
        let com = UserDefaults.standard.string(forKey: "comp")
        lblTitle.text = can
        segmentedControl.itemTitles = [can,com] as! [String]
    }

    //MARK:- Custome Function
    
    func nokri_populateData() {
        if UserHandler.sharedInstance.objSetAccount != nil {
            guard let data = UserHandler.sharedInstance.objSetAccount else {
                return
            }
            if let desc = data.desc
            {
                lblSelectAcType.text = desc
            }
        }
        
        self.type = "0"
        segmentedControl.didSelectItemWith = { (index, title) -> () in
            print("Selected item \(index)")
            if index == 0{
                self.lblTitle.text = title
                self.type = "0"
            }else{
                self.lblTitle.text = title
                self.type = "1"
            }
        }
    }
    
    func nokri_customeButtons(){
        viewTop.backgroundColor = UIColor(hex: appColorNew!)
        btnContinue.layer.cornerRadius = 15
        segmentedControl.layer.borderWidth = 1
        segmentedControl.layer.borderColor = UIColor(hex:appColorNew!).cgColor
        segmentedControl.layer.cornerRadius = 3
        segmentedControl.thumbGradientColors = [UIColor(hex:appColorNew!), UIColor(hex:appColorNew!)]
        btnContinue.setTitleColor(UIColor.white, for: .normal)
    }
    
    //MARK:- IBActions
  
    @IBAction func btnDismissController(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnContinueClicked(_ sender: UIButton) {
     
        guard let data = UserHandler.sharedInstance.objFbUser else {
            return
        }
        
            let param: [String: Any] = [
                "user_type": self.type,
                "user_id": data.id!
            ]
            print(param)
            print(self.type)
            //UserDefaults.standard.set(self.type , forKey: "acountTypeafb") uncomment this
            self.nokri_setAccountPost(parameter: param as NSDictionary)
    }

    //MARK:- API Calls
    
    func nokri_setAccountData() {
        self.btnContinue.isHidden = true
        self.viewTop.isHidden = true
        self.showLoader()
        UserHandler.nokri_setAccount(success: { (successResponse) in
            self.stopAnimating()
            if successResponse.success {
                self.btnContinue.isHidden = false
                self.viewTop.isHidden = false
                UserHandler.sharedInstance.objSetAccount = successResponse.data
                self.btnContinue.setTitle(successResponse.data.continueField, for: .normal)
                self.nokri_populateData()
            }
            else {
                self.btnContinue.isHidden = true
                self.viewTop.isHidden = true
                let alert = Constants.showBasicAlert(message: successResponse.message)
                self.present(alert, animated: true, completion: nil)
                 self.dismiss(animated: true, completion: nil)
                self.stopAnimating()
            }
        }) { (error) in
            self.btnContinue.isHidden = true
            self.viewTop.isHidden = true
            let alert = Constants.showBasicAlert(message: error.message)
            self.present(alert, animated: true, completion: nil)
             self.stopAnimating()
        }
    }
    
    func nokri_setAccountPost(parameter: NSDictionary) {
        self.showLoader()
        UserHandler.nokri_setAccountPost(parameter: parameter as NSDictionary, success: { (successResponse) in
            self.stopAnimating()
            UserDefaults.standard.set(5, forKey: "loginCheck")
        
                if successResponse.success == true{
                    //self.appDelegate.nokri_moveToHome()
                    let isHome = UserDefaults.standard.string(forKey: "home")
                    if isHome == "1"{
                        self.appDelegate.nokri_moveToHome1()
                    }else{
                        self.appDelegate.nokri_moveToHome2()
                    }
                    guard let data = UserHandler.sharedInstance.objFbUser else {
                        return
                    }
                    self.tempId = data.id
                    UserDefaults.standard.set(self.type , forKey: "acountTypeafb")
                    print(self.type)
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
}
