//
//  LandingViewController.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 4/8/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import UIKit

class LandingViewController: UIViewController {

    //MARK:- IBOutlets
    
    @IBOutlet weak var btnSignIn: UIButton!
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var imageViewLogo: UIImageView!
    
    //MARK:- Proporties
    
    var navBar: UINavigationBar = UINavigationBar()
    var activityData:LoginActivityData?
    var appColorNew = UserDefaults.standard.string(forKey: "app_Color")
    
    //MARK:- View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nokri_customeButtons()
        nokri_loginActivity()
       
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true
    }

    //MARK:- Custome Function
    
    func nokri_customeButtons(){
        btnSignIn.layer.cornerRadius = 22
        btnSignUp.layer.cornerRadius = 22
        btnSignUp.layer.borderWidth = 1
        btnSignUp.layer.borderColor = UIColor(hex:appColorNew!).cgColor
        btnSignIn.backgroundColor = UIColor(hex:appColorNew!)
        self.btnSignIn.backgroundColor = UIColor(hex:appColorNew!)
        btnSignUp.setTitleColor(UIColor(hex: appColorNew!), for: .normal)
        btnSignIn.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor
        btnSignIn.layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
        btnSignIn.layer.shadowOpacity = 0.7
        btnSignIn.layer.shadowRadius = 0.3
        btnSignIn.layer.masksToBounds = false
        btnSignUp.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor
        btnSignUp.layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
        btnSignUp.layer.shadowOpacity = 0.7
        btnSignUp.layer.shadowRadius = 0.3
        btnSignUp.layer.masksToBounds = false
    }
    
    func nokri_populateData(){
        btnSignIn.setTitle(activityData?.signin, for: .normal)
        btnSignUp.setTitle(activityData?.signup, for: .normal)
        let imageUrl = activityData?.logo
        if let url = URL(string:imageUrl!){
            imageViewLogo.sd_setImage(with: url, completed: nil)
        }
    }
    
    //MARK:- IBActions
    
    @IBAction func btnSignUpClicked(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CustomSignupViewController") as! CustomSignupViewController
        self.navigationController?.pushViewController(nextViewController, animated: true)
        UserDefaults.standard.set(false, forKey: "isNotSignIn")
    }
    
    @IBAction func btnSignInClicked(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SignInViewController") as! SignInViewController
        self.navigationController?.pushViewController(nextViewController, animated: true)
        UserDefaults.standard.set(false, forKey: "isNotSignIn")
    }
    
    //MARK:- API Calls
    
    func nokri_loginActivity() {
        self.btnSignIn.isHidden = true
        self.btnSignUp.isHidden = true
        self.showLoader()
        UserHandler.nokri_loginActivity(success: { (successResponse) in
           self.stopAnimating()
            if successResponse.success {
                self.btnSignIn.isHidden = false
                self.btnSignUp.isHidden = false
                DispatchQueue.main.async {
                    self.activityData = successResponse.data
                    self.nokri_populateData()
                }
            }
            else {
                self.btnSignIn.isHidden = true
                self.btnSignUp.isHidden = true
                let alert = Constants.showBasicAlert(message: successResponse.message)
                self.present(alert, animated: true, completion: nil)
            }
        }) { (error) in
            self.btnSignIn.isHidden = true
            self.btnSignUp.isHidden = true
            let alert = Constants.showBasicAlert(message: error.message)
            self.present(alert, animated: true, completion: nil)
            self.stopAnimating()
        }
    }
}
