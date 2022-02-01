///
//  SaplashViewController.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 4/8/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import UIKit

class SaplashViewController: UIViewController {
    
    
    @IBOutlet weak var lblLoading: UILabel!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var isSignUp:Bool?
    var navBar: UINavigationBar = UINavigationBar()
    var navigationBarAppearace = UINavigationBar.appearance()
    var tabBarAppearence = UITabBar.appearance()
    var appColorNew = UserDefaults.standard.string(forKey: "app_Color")
    let login = UserDefaults.standard.string(forKey: "loginCheck")
    var adId = 0
    let isFirstTime = UserDefaults.standard.bool(forKey: "FirstTime")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nokri_signUpData()
        nokri_splashData()
        print(adId)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidDisappear(true)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
    }
    
    
    //MARK:- Custome Methods
    
    @objc func nokri_showNavController2(){
        let id = UserDefaults.standard.string(forKey: "id")
        let check = UserDefaults.standard.string(forKey: "loginCheck")
        if check == nil {
            UserDefaults.standard.set("5", forKey: "aType")
            UserDefaults.standard.set(nil, forKey: "loginCheck")
            let withOutLogin = UserDefaults.standard.string(forKey: "aType")
            if withOutLogin == "5"{
                appDelegate.nokri_moveToHome2()
            }
        }else{
            if id == "0" || id == nil{
                appDelegate.nokri_showLandingPage()
            }else{
                appDelegate.nokri_moveToHome2()
            }
        }
    }
    
    @objc func nokri_showNavController1(){
        let id = UserDefaults.standard.string(forKey: "id")
        let check = UserDefaults.standard.string(forKey: "loginCheck")
        if check == nil {
            UserDefaults.standard.set("5", forKey: "aType")
            UserDefaults.standard.set(nil, forKey: "loginCheck")
            let withOutLogin = UserDefaults.standard.string(forKey: "aType")
            if withOutLogin == "5"{
                //UserDefaults.standard.set("5", forKey: "aType")
                appDelegate.nokri_moveToHome1()
            }
        }else{
            if id == "0" || id == nil{
                appDelegate.nokri_showLandingPage()
            }else{
                appDelegate.nokri_moveToHome1()
            }
        }
    }
    
    func nokri_splashData(){
        
        UserHandler.nokri_saplashData(success: { (successResponse) in
            if successResponse.success {
                
                
                let fromNoti = UserDefaults.standard.bool(forKey: "isFromNoti")
                
                if fromNoti == false{
                    UserHandler.sharedInstance.objSaplash = successResponse.data
                    UserDefaults.standard.set(successResponse.data.isRtl, forKey: "isRtl")
                    UserDefaults.standard.set(successResponse.data.app_color, forKey: "app_Color")
                    self.nokri_appearance()
                    let appColorNew = UserDefaults.standard.string(forKey: "app_Color")
                    self.navigationBarAppearace.tintColor = UIColor.white
                    self.navigationBarAppearace.barTintColor = UIColor(hex:appColorNew!)
                    self.navigationBarAppearace.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
                    self.tabBarAppearence.barTintColor = UIColor(hex:appColorNew!)
                    self.tabBarAppearence.alpha = 1.0
                    let isRtl = UserDefaults.standard.string(forKey: "isRtl")
                    //isRtl = "1"
                    if isRtl == "0"{
                        UIView.appearance().semanticContentAttribute = .forceLeftToRight
                        //self.navigationBarAppearace.semanticContentAttribute = .forceLeftToRight
                    }else{
                        UIView.appearance().semanticContentAttribute = .forceRightToLeft
                        //self.navigationBarAppearace.semanticContentAttribute = .forceRightToLeft
                    }
                    UserDefaults.standard.set(successResponse.data.isBlog, forKey: "isBlog")
                    UserDefaults.standard.set(successResponse.data.home, forKey: "home")
                    
                    UserHandler.sharedInstance.languagesData = successResponse.data.langData
                    UserDefaults.standard.set(successResponse.data.extra.isPaidAlert, forKey: "isPaidAlert")
       
                    UserDefaults.standard.set(successResponse.data.isWpmlActive, forKey: "isWpmlActive")
                    
                    
                    if successResponse.data.isWpmlActive == true
                    {
                        if UserHandler.sharedInstance.languagesData.count != 0{
                        
                        if self.isFirstTime == false{
                            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LanguageViewController") as? LanguageViewController
                            
                            self.navigationController?.pushViewController(vc!, animated: true)
                        }else{
                            if successResponse.data.home == "1"{
                                self.perform(#selector(self.nokri_showNavController1), with: nil, afterDelay: 2)
                            }else{
                                self.perform(#selector(self.nokri_showNavController2), with: nil, afterDelay: 2)
                            }
                        }
                            
                        }else{
                            if successResponse.data.home == "1"{
                                self.perform(#selector(self.nokri_showNavController1), with: nil, afterDelay: 2)
                            }else{
                                self.perform(#selector(self.nokri_showNavController2), with: nil, afterDelay: 2)
                            }
                        }
                    }else{
                        if successResponse.data.home == "1"{
                            self.perform(#selector(self.nokri_showNavController1), with: nil, afterDelay: 2)
                        }else{
                            self.perform(#selector(self.nokri_showNavController2), with: nil, afterDelay: 2)
                        }
                    }
                    
                    UserDefaults.standard.set(successResponse.data.job_form, forKey: "job_form")
                    UserDefaults.standard.set(successResponse.data.extra.listStyle, forKey: "listStyle")
                    UserDefaults.standard.set(successResponse.data.extra.candMap, forKey: "candMap")
                    UserDefaults.standard.set(successResponse.data.extra.empMap, forKey: "empMap")
                    
                }else{
                    
                    UserHandler.sharedInstance.objSaplash = successResponse.data
                    //print(successResponse.data.isRtl)
                    UserDefaults.standard.set(successResponse.data.isRtl, forKey: "isRtl")
                    UserDefaults.standard.set(successResponse.data.app_color, forKey: "app_Color")
                    self.nokri_appearance()
                    let appColorNew = UserDefaults.standard.string(forKey: "app_Color")
                    self.navigationBarAppearace.tintColor = UIColor.white
                    self.navigationBarAppearace.barTintColor = UIColor(hex:appColorNew!)
                    self.navigationBarAppearace.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
                    self.tabBarAppearence.barTintColor = UIColor(hex:appColorNew!)
                    self.tabBarAppearence.alpha = 1.0
                    let isRtl = UserDefaults.standard.string(forKey: "isRtl")
                    
                    if isRtl == "0"{
                        UIView.appearance().semanticContentAttribute = .forceLeftToRight
                       
                    }else{
                        UIView.appearance().semanticContentAttribute = .forceRightToLeft
                    
                    }
                    UserDefaults.standard.set(successResponse.data.isBlog, forKey: "isBlog")
                    UserDefaults.standard.set(successResponse.data.home, forKey: "home")
                    
                    UserDefaults.standard.set(successResponse.data.job_form, forKey: "job_form")
                    UserDefaults.standard.set(successResponse.data.extra.listStyle, forKey: "listStyle")
                    UserDefaults.standard.set(successResponse.data.extra.candMap, forKey: "candMap")
                    UserDefaults.standard.set(successResponse.data.extra.empMap, forKey: "empMap")
                    
                    UserHandler.sharedInstance.languagesData = successResponse.data.langData
                    if self.adId == 0{
                        if successResponse.data.home == "1"{
                            self.perform(#selector(self.nokri_showNavController1), with: nil, afterDelay: 2)
                        }else{
                            self.perform(#selector(self.nokri_showNavController2), with: nil, afterDelay: 2)
                        }
                    }else{
                        self.perform(#selector(self.nokri_showNavController3), with: nil, afterDelay: 3)
                    }
                    
                    if successResponse.data.isWpmlActive == true{
                        
                        if UserHandler.sharedInstance.languagesData.count != 0{
                        
                        if self.isFirstTime == false{
                            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LanguageViewController") as? LanguageViewController
                            
                            self.navigationController?.pushViewController(vc!, animated: true)
                        }else{
                            if successResponse.data.home == "1"{
                                self.perform(#selector(self.nokri_showNavController1), with: nil, afterDelay: 2)
                            }else{
                                self.perform(#selector(self.nokri_showNavController2), with: nil, afterDelay: 2)
                            }
                        }
                            
                        }else{
                            if successResponse.data.home == "1"{
                                self.perform(#selector(self.nokri_showNavController1), with: nil, afterDelay: 2)
                            }else{
                                self.perform(#selector(self.nokri_showNavController2), with: nil, afterDelay: 2)
                            }
                        }
                    }else{
                        if successResponse.data.home == "1"{
                            self.perform(#selector(self.nokri_showNavController1), with: nil, afterDelay: 2)
                        }else{
                            self.perform(#selector(self.nokri_showNavController2), with: nil, afterDelay: 2)
                        }
                    }
                    
                }
                
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
    
    @objc func nokri_showNavController3(){
        self.appDelegate.nokri_moveToJobDetail()
    }
    
    func nokri_appearance(){
        var preferredStatusBarStyle: UIStatusBarStyle {
            return .lightContent
        }        //->> Tab bar
        UITabBarItem.appearance().titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 0)
        let colorNormal : UIColor = UIColor(hex: "101024 ")
        let colorSelected : UIColor = UIColor.white
        let titleFontNormal : UIFont = UIFont(name: "Helvetica", size: 12.0)!
        let titleFontSelected : UIFont = UIFont.boldSystemFont(ofSize: 15.0)
        let attributesNormal = [
            NSAttributedString.Key.foregroundColor : colorNormal,
            NSAttributedString.Key.font : titleFontNormal
        ]
        
        let attributesSelected = [
            NSAttributedString.Key.foregroundColor : colorSelected,
            NSAttributedString.Key.font : titleFontSelected
        ]
        
        UITabBarItem.appearance().setTitleTextAttributes(attributesNormal, for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes(attributesSelected, for: .selected)
        UITabBar.appearance().unselectedItemTintColor = .black
        //tabBarItem.image = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        
    }
    
    //MARK:- API Calls
    
    func nokri_signUpData() {
        UserHandler.nokri_signUpData(success: { (successResponse) in
            if successResponse.success {
                UserHandler.sharedInstance.objUser = successResponse.data
                UserDefaults.standard.set(UserHandler.sharedInstance.objUser?.switchCand, forKey: "cand")
                UserDefaults.standard.set(UserHandler.sharedInstance.objUser?.switchEmp, forKey: "comp")
                self.stopAnimating()
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
}
