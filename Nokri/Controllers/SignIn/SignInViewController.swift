//
//  SignInViewController.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 4/8/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import GoogleSignIn
import Toast_Swift
import JGProgressHUD
import AuthenticationServices
import Security
import Foundation
import CryptoKit
import FirebaseAuth
import Firebase



class SignInViewController: UIViewController,UITextFieldDelegate,GIDSignInDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,ASAuthorizationControllerDelegate {
    
    //MARK:- IBOutlets
    
    @IBOutlet weak var viewLine: UIView!
    @IBOutlet weak var viewBg: UIView!
    @IBOutlet weak var viewPass: UIView!
    @IBOutlet weak var viewEmail: UIView!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnSignIn: UIButton!
    @IBOutlet weak var btnForgotPassword: UIButton!
    @IBOutlet weak var btnSighnUp: UIButton!
    @IBOutlet weak var imageViewLogo: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var imgEmail: UIImageView!
    @IBOutlet weak var imgPass: UIImageView!
    @IBOutlet weak var lblSignIn: UILabel!
    @IBOutlet weak var btnApple: UIButton!
    @IBOutlet weak var lblOr: UILabel!
    
    //MARK:- Proporties
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var appColorNew = UserDefaults.standard.string(forKey: "app_Color")
    var withOutLogin = UserDefaults.standard.string(forKey: "aType")
    var fbEmail:String?
    var email:String?
    var isSocial:Bool = false
    var googleText:String?
    var fbText:String?
    var linkedInText:String?
    var socialIconArr = [UIImage]()
    var webView = WKWebView()
    var iconClick = true
    
    //MARK:- View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        //GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = self
        self.navigationController?.navigationBar.isHidden = false
        nokri_customeButtons()
        nokri_loginData()
        self.navigationController?.navigationBar.backgroundColor = UIColor(hex:appColorNew!)
        self.btnSignIn.backgroundColor = UIColor(hex:appColorNew!)
        if let userData = UserDefaults.standard.object(forKey: "settingsData") {
            let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
            let dataTabs = SplashRoot(fromDictionary: objData)
            let obj3 = dataTabs.data.guestTabs
            self.title = obj3?.signin
            self.lblSignIn.text = obj3?.signin
        }
        txtEmail.delegate = self
        txtPassword.delegate = self
        txtEmail.nokri_addBottomBorder()
        txtPassword.nokri_addBottomBorder()
        viewBg.layer.cornerRadius = 15
        viewEmail.layer.cornerRadius = 20
        viewPass.layer.cornerRadius = 20
        viewEmail.layer.borderWidth = 1
        viewPass.layer.borderWidth = 1
        viewLine.backgroundColor = UIColor(hex: appColorNew!)
        viewEmail.layer.borderColor = UIColor.groupTableViewBackground.cgColor
        viewPass.layer.borderColor = UIColor.groupTableViewBackground.cgColor
        btnForgotPassword.setTitleColor(UIColor(hex: appColorNew!), for: .normal)
        txtEmail.layer.borderColor = UIColor.clear.cgColor
        txtPassword.layer.borderColor = UIColor.clear.cgColor
        
        imgPass.image = imgPass.image?.withRenderingMode(.alwaysTemplate)
        imgPass.tintColor = UIColor.lightGray
        imgEmail.image = imgEmail.image?.withRenderingMode(.alwaysTemplate)
        imgEmail.tintColor = UIColor.lightGray
        btnApple.isHidden = true
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
         //nokri_ltrRtl()
         addLeftBarButtonWithImage(#imageLiteral(resourceName: "menu"))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        //txtEmail.nokri_updateBottomBorderSize()
        //txtPassword.nokri_updateBottomBorderSize()
    }
    
    //MARK:- Custome Function
    
    @available(iOS 13.0, *)
      @objc func handleAppleIdRequest() {
          let appleIDProvider = ASAuthorizationAppleIDProvider()
          let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
          let authorizationController = ASAuthorizationController(authorizationRequests: [request])
          authorizationController.delegate = self
          authorizationController.performRequests()
      }
      
    func nokri_ltrRtl(){
        
        if (UserDefaults.standard.bool(forKey: "isNotSignIn") == false){
            let isRtl = UserDefaults.standard.string(forKey: "isRtl")
            if isRtl == "0"{
                addLeftBarButtonWithImage(#imageLiteral(resourceName: "menu"))
            }else{
                addRightBarButtonWithImage(#imageLiteral(resourceName: "menu"))
            }
       }
    }
    
    func isValidEmail(testStr:String) -> Bool {
        print("validate emilId: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: testStr)
        return result
    }
    
    func nokri_customeButtons(){
        btnSignIn.layer.cornerRadius = 22
        btnSignIn.layer.masksToBounds = false
        btnSighnUp.setTitleColor(UIColor(hex:appColorNew!), for: .normal)
    }
    
    func nokri_populateData() {
        if UserHandler.sharedInstance.objLoginUser != nil {
            guard let data = UserHandler.sharedInstance.objLoginUser else {
                return
            }
            
            if let email = data.emailPlaceholder
            {
                txtEmail.placeholder = email
            }
            
            if let password = data.passwordPlaceholder
            {
                txtPassword.placeholder = password
            }
            
            if let btnLogin = data.formBtn
            {
                btnSignIn.setTitle(btnLogin, for: .normal)
            }
            
            if let btnForgotText = data.forgotText
            {
                btnForgotPassword.setTitle(btnForgotText, for: .normal)
                UserDefaults.standard.set(btnForgotText, forKey: "forgot")
            }
            
            if let btnAppleText = data.appleBtn
            {
                btnApple.isHidden = false
                btnApple.layer.cornerRadius = 8
                btnApple.setTitle(btnAppleText, for: .normal)
            }
            
            if let txtOr = data.separator
            {
                self.lblOr.text = txtOr
            }
            
            if let btnSignUpText = data.registerText
            {
                if let btnSignUpText2 = data.registerText2{
                    let string1 = btnSignUpText
                    let string2 = btnSignUpText2
                    let att = NSMutableAttributedString(string: "\(string1)\(string2)");
                    btnSighnUp.setAttributedTitle(att, for: .normal)
                }
            }
            
            if let btnFacebookText = data.facebookBtn
            {
                fbText = btnFacebookText
                //socialIconArr.append(#imageLiteral(resourceName: "fb256"))
                if data.facebookSwitch != "0"{
                    socialIconArr.append(#imageLiteral(resourceName: "facebookCircle"))
                    
                }
            }
            
            if let btnGoogltext = data.googleBtn
            {
                googleText = btnGoogltext
                //socialIconArr.append(#imageLiteral(resourceName: "Google"))
                if data.googleSwitch != "0"{
                    socialIconArr.append(#imageLiteral(resourceName: "Google"))
                }
            }
            
            if let btnApple = data.appleBtn{
                print(btnApple)
                if data.appleSwitch == "0"{
                    //socialIconArr.append(UIImage(named: "company")!)
                    self.btnApple.isHidden = true
                }else{
                    self.btnApple.isHidden = false
                }
           }
            
            if let btnLinkedIn = data.linkedinBtn{
                linkedInText = btnLinkedIn
                if data.linkedinSwitch != "0"{
                    socialIconArr.append(#imageLiteral(resourceName: "linked256"))
                }
            }
            
            if data.appleSwitch == "0" && data.linkedinSwitch == "0" && data.googleSwitch == "0" && data.facebookSwitch == "0"{
                lblOr.isHidden = true
            }
            
            if let imgUrl = URL(string: data.logo) {
                self.imageViewLogo.sd_setImage(with: imgUrl, completed: nil)
                self.imageViewLogo.sd_setShowActivityIndicatorView(true)
                self.imageViewLogo.sd_setIndicatorStyle(.gray)
            }
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == txtEmail {
            
            viewEmail.layer.borderWidth = 1
            viewEmail.layer.borderColor = UIColor(hex: appColorNew!).cgColor
        } else {
            
            viewEmail.layer.borderWidth = 1
            viewEmail.layer.borderColor = UIColor.groupTableViewBackground.cgColor
        }
        if textField == txtPassword {
            viewPass.layer.borderWidth = 1
            viewPass.layer.borderColor = UIColor(hex: appColorNew!).cgColor
        } else {
            viewPass.layer.borderWidth = 1
            viewPass.layer.borderColor = UIColor.groupTableViewBackground.cgColor
        }
        return true
    }
    
    //MARK:- IBActions
    
    @IBAction func passHideShowClicked(_ sender: UIButton) {
        if(iconClick == true) {
            txtPassword.isSecureTextEntry = false
                imgPass.tintColor = UIColor(hex: appColorNew!)
        } else {
            txtPassword.isSecureTextEntry = true
            imgPass.tintColor = UIColor.lightGray
        }
        iconClick = !iconClick
    }
    
    @IBAction func btnAppleClicked(_ sender: UIButton) {
        
        if #available(iOS 13.0, *) {
            let request = ASAuthorizationAppleIDProvider().createRequest()
            request.requestedScopes = [.fullName,.email]
            let controller = ASAuthorizationController(authorizationRequests: [request])
            controller.delegate = self
            controller.presentationContextProvider = self
            controller.performRequests()
        } else {
            let alert = Constants.showBasicAlert(message: "Sign in with Apple is allowed on ios 13 and above devices, Thank you.")
            self.present(alert, animated: true, completion: nil)
        }
    
//        if #available(iOS 13.0, *) {
//            let appleIDProvider = ASAuthorizationAppleIDProvider()
//            let request = appleIDProvider.createRequest()
//            request.requestedScopes = [.fullName, .email]
//            let authorizationController = ASAuthorizationController(authorizationRequests: [request])
//            authorizationController.delegate = self
//            authorizationController.performRequests()
//
//
//            //startSignInWithAppleFlow()
//
//        } else {
//            // Fallback on earlier versions
//        }
        
        
        
    }
    
    @IBAction func btnSignInClicked(_ sender: UIButton) {
    
        var field:String = ""
        var validEmail:String = ""

        if let userData = UserDefaults.standard.object(forKey: "settingsData") {
            let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
            let dataTabs = SplashRoot(fromDictionary: objData)
            field = dataTabs.data.extra.allField
            validEmail = dataTabs.data.extra.validEmail
        }
        guard let email = txtEmail.text else {
            return
        }
        guard let password = txtPassword.text else {
            return
        }
        if email == "" {
            let alert = Constants.showBasicAlert(message: field)
            self.present(alert, animated: true, completion: nil)
        }
        else if password == "" {
            let alert = Constants.showBasicAlert(message: field)
            self.present(alert, animated: true, completion: nil)
        }
        else if isValidEmail(testStr: email) == false {
            let alert = Constants.showBasicAlert(message: validEmail)
            self.present(alert, animated: true, completion: nil)
        }
        else {
            let param: [String: Any] = [
                "email": email,
                "pass": password,
                ]
            print(param)
            UserDefaults.standard.set(email, forKey: "email")
            UserDefaults.standard.set(password, forKey: "password")
            UserDefaults.standard.synchronize()
            UserDefaults.standard.set(7, forKey: "aType")
            self.nokri_loginPost(parameter: param as NSDictionary)
        }
    }
  
    func stringToDictionary(text:String)->[String:Any]?{
        if let data = text.data(using: .utf8){
            do{
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]
                
            }catch{
                print(error.localizedDescription)
            }
        }
        return nil
    }
   
    @objc func btnSocialLoginClicked(_ sender: UIButton){
        if sender.tag == 1{
            nokri_fbCheckLogin()
        }else if sender.tag == 2{
            GIDSignIn.sharedInstance().delegate = self
            //GIDSignIn.sharedInstance().uiDelegate = self
            GIDSignIn.sharedInstance().signIn()
        }
        else{
           linkedInAuthVC()
        }
    }
    
    //MARK:- FBLogin
    
    func nokri_fbCheckLogin(){
         let loginManager = LoginManager()
             loginManager.logIn(permissions: ["email", "public_profile"], from: self) { (result, error) in
            if error != nil {
                print(error?.localizedDescription ?? "Nothing")
            }
            else if (result?.isCancelled)! {
                print("Cancel")
            }
            else if error == nil {
                //  let fbLoginResult: FBSDKLoginManagerLoginResult = result!
                self.nokri_userProfileDetails()
            } else {
            }
        }
    }
    
    func nokri_userProfileDetails() {
        if (AccessToken.current != nil) {
                   GraphRequest(graphPath: "/me", parameters: ["fields": "id, name, first_name, last_name, email, gender, picture.type(large)"]).start { (connection, result, error) in
                if error != nil {
                    print(error?.localizedDescription ?? "Nothing")
                    return
                }
                else {
                    guard let results = result as? NSDictionary else { return }
                    guard let facebookId = results["email"] as? String,
                        let email = results["email"] as? String else {
                            return
                    }
                    self.email = email
                    print("\(email), \(facebookId)")
                    let param: [String: Any] = [
                        "email": self.email!,
                        "type":"social"
                    ]
                    print(param)
                    self.isSocial = true
                    UserDefaults.standard.set(self.email, forKey: "email")
                    UserDefaults.standard.set(self.isSocial, forKey: "isSocial")
                    UserDefaults.standard.set("1122", forKey: "password")
                    UserDefaults.standard.set(7, forKey: "aType")
                    self.nokri_loginPostSocial(parameter: param as NSDictionary)
                }
            }
        }
    }
    
    //MARK:- Google SignIn
    
    func sign(inWillDispatch signIn: GIDSignIn!, error: Error!) {
    }
    
    func sign(_ signIn: GIDSignIn!,
              present viewController: UIViewController!) {
        self.present(viewController, animated: true, completion: nil)
    }
    
    func sign(_ signIn: GIDSignIn!,
              dismiss viewController: UIViewController!) {
        self.dismiss(animated: true, completion: nil)
    }
    
    public func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
                     withError error: Error!) {
        if (error == nil) {
            email = user.profile.email
            let param: [String: Any] = [
                "email":email!,
                "type":"social"
            ]
            print(param)
            self.isSocial = true
            UserDefaults.standard.set(self.email, forKey: "email")
            UserDefaults.standard.set(self.isSocial, forKey: "isSocial")
            UserDefaults.standard.set("1122", forKey: "password")
            
            self.nokri_loginPostSocial(parameter: param as NSDictionary)

        } else {
            print("\(error.localizedDescription)")
        }
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
    
    //MARK:- CollectionView
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return socialIconArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SocialLogCollectionViewCell", for: indexPath) as! SocialLogCollectionViewCell
        cell.btnSocialLogin.addTarget(self, action:  #selector(SignInViewController.btnSocialLoginClicked), for: .touchUpInside)
        let objArr = socialIconArr[indexPath.row]
        cell.imageViewIcon.image = objArr
        if objArr == #imageLiteral(resourceName: "facebookCircle"){
            cell.btnSocialLogin.tag = 1
        }
       if objArr == #imageLiteral(resourceName: "Google"){
            cell.btnSocialLogin.tag = 2
        }
        if objArr == UIImage(named: "company"){
            cell.btnSocialLogin.tag = 3
        }
        if objArr == #imageLiteral(resourceName: "linked256"){
             cell.btnSocialLogin.tag = 4
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 0
        let collectionViewSize = collectionView.frame.size.width - padding
        return CGSize(width: collectionViewSize/4, height:50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let totalCellWidth = 56 * socialIconArr.count
        let totalSpacingWidth = 5 * (socialIconArr.count - 1)
        let leftInset = (collectionView.frame.size.width - CGFloat(totalCellWidth + totalSpacingWidth)) / 3
        let rightInset = leftInset
        return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)
    }
    
    //MARK:- API Calls
    
    func nokri_loginData() {
        self.showLoader()
        self.btnSignIn.isHidden = true
        
        UserHandler.nokri_loginData(success: { (successResponse) in
            self.stopAnimating()
            if successResponse.success {
                self.btnSignIn.isHidden = false
                DispatchQueue.main.async {
                    UserHandler.sharedInstance.objLoginUser = successResponse.data
                    self.nokri_populateData()
                    self.collectionView.reloadData()
                }
            }
            else {
                self.btnSignIn.isHidden = true
                self.stopAnimating()
                let alert = Constants.showBasicAlert(message: successResponse.message)
                self.present(alert, animated: true, completion: nil)
            }
        }) { (error) in
            self.btnSignIn.isHidden = true
            let alert = Constants.showBasicAlert(message: error.message)
            self.present(alert, animated: true, completion: nil)
            self.stopAnimating()
        }
    }
    
    func nokri_loginPost(parameter: NSDictionary) {
        self.showLoader()
        UserHandler.nokri_loginUser(parameter: parameter as NSDictionary, success: { (successResponse) in
            self.stopAnimating()
            if successResponse.success == true{
                UserHandler.sharedInstance.objLoginPost = successResponse.data
                UserDefaults.standard.set(successResponse.data.id , forKey: "id")
                UserDefaults.standard.set(nil , forKey: "acountTypeafb")
                UserDefaults.standard.set(10, forKey: "signUp")
                UserDefaults.standard.set(5, forKey: "loginCheck")
                UserDefaults.standard.set(7, forKey: "aType")
                UserDefaults.standard.set(successResponse.data.userType, forKey: "usrTyp")
                //UserDefaults.standard.set(self.txtEmail.text, forKey: "remeberEmail")
                //UserDefaults.standard.set(self.txtPassword.text, forKey: "remeberPassword")
                UserDefaults.standard.set(false, forKey: "isSocial")
                //self.view.makeToast(successResponse.message, duration: 1.5, position: .bottom)
                let hud = JGProgressHUD(style: .dark)
                hud.textLabel.text = successResponse.message
                hud.detailTextLabel.text = nil
                hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                hud.position = .bottomCenter
                hud.show(in: self.view)
                hud.dismiss(afterDelay: 2.0)
                self.perform(#selector(self.nokri_showHome), with: nil, afterDelay: 2.2)
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
    
    @objc func nokri_showHome(){
        let isHome = UserDefaults.standard.string(forKey: "home")
        if isHome == "1"{
            appDelegate.nokri_moveToHome1()
        }else{
            appDelegate.nokri_moveToHome2()
        }
    }
    
    func nokri_loginPostSocial(parameter: NSDictionary) {
        self.showLoader()
        UserHandler.nokri_loginUserFb(parameter: parameter as NSDictionary, success: { (successResponse) in
            self.stopAnimating()
            if successResponse.success == true {
                
                if ((successResponse.data?.acountType) != nil) || ((successResponse.data?.displayName) != nil) || ((successResponse.data?.id) != nil) || ((successResponse.data?.phone) != nil) || (successResponse.data!.profileImg != nil) || successResponse.data.userEmail != nil {
                    UserHandler.sharedInstance.objFbUser = successResponse.data
                    UserDefaults.standard.set(successResponse.data.acountType , forKey: "acountTypeafb")
                    guard let data = UserHandler.sharedInstance.objFbUser else {
                        return
                    }
                    //print(data.acountType)
                    UserDefaults.standard.set(successResponse.data.userEmail, forKey: "email")
                    UserDefaults.standard.set(successResponse.data.id , forKey: "id")
                    UserDefaults.standard.set(7, forKey: "aType")
                    UserDefaults.standard.set(successResponse.data.acountType, forKey: "usrTyp")
                    UserDefaults.standard.synchronize()
                    if data.acountType == ""{
                        let controller = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "AccountTypeViewController") as! AccountTypeViewController
                        controller.modalPresentationStyle = .overCurrentContext
                        controller.modalTransitionStyle = .flipHorizontal
                        self.present(controller, animated: true, completion: nil)
                    }else{
                        UserDefaults.standard.set(5, forKey: "loginCheck")
                        //self.appDelegate.nokri_moveToHome()
                        let isHome = UserDefaults.standard.string(forKey: "home")
                        if isHome == "1"{
                            self.appDelegate.nokri_moveToHome1()
                        }else{
                            self.appDelegate.nokri_moveToHome2()
                        }
                    }
                }else{
                    let alert = Constants.showBasicAlert(message: successResponse.message)
                    self.present(alert, animated: true, completion: nil)
                    self.stopAnimating()
                }
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
    
    //MARK:- Linked in integration
       
    func linkedInAuthVC() {
        // Create linkedIn Auth ViewController
        let linkedInVC = UIViewController()
        // Create WebView
        let webView = WKWebView()
        webView.navigationDelegate = self
        linkedInVC.view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: linkedInVC.view.topAnchor),
            webView.leadingAnchor.constraint(equalTo: linkedInVC.view.leadingAnchor),
            webView.bottomAnchor.constraint(equalTo: linkedInVC.view.bottomAnchor),
            webView.trailingAnchor.constraint(equalTo: linkedInVC.view.trailingAnchor)
        ])
        
        let state = "linkedin\(Int(NSDate().timeIntervalSince1970))"
        
        let authURLFull = Constants.LinkedInConstants.AUTHURL + "?response_type=code&client_id=" + Constants.LinkedInConstants.CLIENT_ID + "&scope=" + Constants.LinkedInConstants.SCOPE + "&state=" + state + "&redirect_uri=" + Constants.LinkedInConstants.REDIRECT_URI
        
        
        let urlRequest = URLRequest.init(url: URL.init(string: authURLFull)!)
        webView.load(urlRequest)
        
        // Create Navigation Controller
        let navController = UINavigationController(rootViewController: linkedInVC)
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(self.cancelAction))
        linkedInVC.navigationItem.leftBarButtonItem = cancelButton
        let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(self.refreshAction))
        linkedInVC.navigationItem.rightBarButtonItem = refreshButton
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navController.navigationBar.titleTextAttributes = textAttributes
        linkedInVC.navigationItem.title = "linkedin.com"
        navController.navigationBar.isTranslucent = false
        navController.navigationBar.tintColor = UIColor.white
        // navController.navigationBar.barTintColor = UIColor.colorFromHex("#0072B1")
        navController.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        navController.modalTransitionStyle = .coverVertical
        
        self.present(navController, animated: true, completion: nil)
    }
    @objc func cancelAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func refreshAction() {
        self.webView.reload()
    }

    // Unhashed nonce.
    fileprivate var currentNonce: String?

    @available(iOS 13, *)
    func startSignInWithAppleFlow() {
      let nonce = randomNonceString()
      currentNonce = nonce
      let appleIDProvider = ASAuthorizationAppleIDProvider()
      let request = appleIDProvider.createRequest()
      request.requestedScopes = [.fullName, .email]
      request.nonce = sha256(nonce)

      let authorizationController = ASAuthorizationController(authorizationRequests: [request])
      authorizationController.delegate = self
      authorizationController.presentationContextProvider = self
      authorizationController.performRequests()
        
      
        
    }

    @available(iOS 13, *)
    private func sha256(_ input: String) -> String {
      let inputData = Data(input.utf8)
      let hashedData = SHA256.hash(data: inputData)
      let hashString = hashedData.compactMap {
        return String(format: "%02x", $0)
      }.joined()

      return hashString
    }
    
}

//@available(iOS 13.0, *)
//extension SignInViewController: ASAuthorizationControllerPresentationContextProviding {
//    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
//        return self.view.window!
//    }
//
//    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
//
//        if let appleIDCredential = authorization.credential as?  ASAuthorizationAppleIDCredential {
//
//            if let email = appleIDCredential.email{
//                print(email)
//            }
//            let userId = appleIDCredential.user
//            print(userId)
//
//        }
//
////        let userData = UserDefaults.standard.object(forKey: "settingsData")
////        let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
////        let dataTabs = SplashRoot(fromDictionary: objData)
////        let obj = dataTabs.data.extra
////
////
////        if let appleIDCredential = authorization.credential as?  ASAuthorizationAppleIDCredential {
////
////            let email = appleIDCredential.email
////            if email != nil{
////                UserDefaults.standard.set(email, forKey:"emailA")
////            }
////            let emApple = UserDefaults.standard.string(forKey: "emailA")
////            if emApple != nil{
////                let param: [String: Any] = [
////                    "email": emApple!,
////                    "type": "social"
////                ]
////                print(param)
////
////                self.isSocial = true
////                UserDefaults.standard.set(self.email, forKey: "email")
////                UserDefaults.standard.set(self.isSocial, forKey: "isSocial")
////                UserDefaults.standard.set("1122", forKey: "password")
////                self.nokri_loginPostSocial(parameter: param as NSDictionary)
////               // print(userIdentifier,fullName,email)
////            }else{
////                let alert = Constants.showBasicAlert(message: obj?.unable_to_get!)
////                self.present(alert, animated: true, completion: nil)
////            }
////
////        }
//
//
//        func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
//           if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
//             guard let nonce = currentNonce else {
//               fatalError("Invalid state: A login callback was received, but no login request was sent.")
//             }
//             guard let appleIDToken = appleIDCredential.identityToken else {
//               print("Unable to fetch identity token")
//               return
//             }
//             guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
//               print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
//               return
//             }
//             // Initialize a Firebase credential.
//             let credential = OAuthProvider.credential(withProviderID: "apple.com",
//                                                       idToken: idTokenString,
//                                                       rawNonce: nonce)
//             Auth.auth().signIn(with: credential) { (authResult, error) in
//                if (error != nil) {
//
//                    print(error!.localizedDescription)
//                 return
//               }
//             }
//           }
//         }
//
//         func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
//           print("Sign in with Apple errored: \(error)")
//         }
//
//    }
//
//}

extension SignInViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        RequestForCallbackURL(request: navigationAction.request)
        
        //Close the View Controller after getting the authorization code
        if let urlStr = navigationAction.request.url?.absoluteString {
            if urlStr.contains("?code=") {
                self.dismiss(animated: true, completion: nil)
            }
        }
        decisionHandler(.allow)
    }
    
    func RequestForCallbackURL(request: URLRequest) {
        // Get the authorization code string after the '?code=' and before '&state='
        let requestURLString = (request.url?.absoluteString)! as String
        if requestURLString.hasPrefix(Constants.LinkedInConstants.REDIRECT_URI) {
            if requestURLString.contains("?code=") {
                if let range = requestURLString.range(of: "=") {
                    let linkedinCode = requestURLString[range.upperBound...]
                    if let range = linkedinCode.range(of: "&state=") {
                        let linkedinCodeFinal = linkedinCode[..<range.lowerBound]
                        handleAuth(linkedInAuthorizationCode: String(linkedinCodeFinal))
                    }
                }
            }
        }
    }
    
    func handleAuth(linkedInAuthorizationCode: String) {
        linkedinRequestForAccessToken(authCode: linkedInAuthorizationCode)
    }
    
    func linkedinRequestForAccessToken(authCode: String) {
        let grantType = "authorization_code"
        
        // Set the POST parameters.
        let postParams = "grant_type=" + grantType + "&code=" + authCode + "&redirect_uri=" + Constants.LinkedInConstants.REDIRECT_URI + "&client_id=" + Constants.LinkedInConstants.CLIENT_ID + "&client_secret=" + Constants.LinkedInConstants.CLIENT_SECRET
        let postData = postParams.data(using: String.Encoding.utf8)
        let request = NSMutableURLRequest(url: URL(string: Constants.LinkedInConstants.TOKENURL)!)
        request.httpMethod = "POST"
        request.httpBody = postData
        request.addValue("application/x-www-form-urlencoded;", forHTTPHeaderField: "Content-Type")
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task: URLSessionDataTask = session.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
            let statusCode = (response as! HTTPURLResponse).statusCode
            if statusCode == 200 {
                let results = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [AnyHashable: Any]
                
                let accessToken = results?["access_token"] as! String
                print("accessToken is: \(accessToken)")
                
                let expiresIn = results?["expires_in"] as! Int
                print("expires in: \(expiresIn)")
                
                self.fetchLinkedInUserProfile(accessToken: accessToken)
            }
        }
        task.resume()
    }
    
    
    func fetchLinkedInUserProfile(accessToken: String) {
        let tokenURLFull = "https://api.linkedin.com/v2/me?projection=(id,firstName,lastName,profilePicture(displayImage~:playableStreams))&oauth2_access_token=\(accessToken)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let verify: NSURL = NSURL(string: tokenURLFull!)!
        let request: NSMutableURLRequest = NSMutableURLRequest(url: verify as URL)
        let task = URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
            if error == nil {
                let linkedInProfileModel = try? JSONDecoder().decode(LinkedInProfileModel.self, from: data!)
                
                print("LinkedIn Access Token: \(accessToken)")
                
                let linkedinId: String! = linkedInProfileModel?.id
                print("LinkedIn Id: \(linkedinId ?? "")")
                
                let linkedinFirstName: String! = linkedInProfileModel?.firstName.localized.enUS
                print("LinkedIn First Name: \(linkedinFirstName ?? "")")
                
                let linkedinLastName: String! = linkedInProfileModel?.lastName.localized.enUS
                print("LinkedIn Last Name: \(linkedinLastName ?? "")")
                
                let linkedinProfilePic: String!
              
                if let pictureUrls = linkedInProfileModel?.profilePicture.displayImage.elements[2].identifiers[0].identifier {
                    linkedinProfilePic = pictureUrls
                } else {
                    linkedinProfilePic = "Not exists"
                }
                print("LinkedIn Profile Avatar URL: \(linkedinProfilePic ?? "")")
                
                self.fetchLinkedInEmailAddress(accessToken: accessToken)
            }
        }
        task.resume()
    }
    
    func fetchLinkedInEmailAddress(accessToken: String) {
        let tokenURLFull = "https://api.linkedin.com/v2/emailAddress?q=members&projection=(elements*(handle~))&oauth2_access_token=\(accessToken)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let verify: NSURL = NSURL(string: tokenURLFull!)!
        let request: NSMutableURLRequest = NSMutableURLRequest(url: verify as URL)
        let task = URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
            if error == nil {
                let linkedInEmailModel = try? JSONDecoder().decode(LinkedInEmailModel.self, from: data!)
                let linkedinEmail: String! = linkedInEmailModel?.elements[0].elementHandle.emailAddress
                print("LinkedIn Email: \(linkedinEmail ?? "")")
                self.email = linkedinEmail
                
                DispatchQueue.main.async {
                    let param: [String: Any] = [
                        "email": linkedinEmail!,
                        "type": "social"
                    ]
                    print(param)
                    
                    self.isSocial = true
                    UserDefaults.standard.set(self.email, forKey: "email")
                    UserDefaults.standard.set(self.isSocial, forKey: "isSocial")
                    UserDefaults.standard.set("1122", forKey: "password")
                    UserDefaults.standard.set(7, forKey: "aType")
                    self.nokri_loginPostSocial(parameter: param as NSDictionary)
                    
                }
            }
        }
        task.resume()
    }

    private func randomNonceString(length: Int = 32) -> String {
      precondition(length > 0)
      let charset: Array<Character> =
          Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
      var result = ""
      var remainingLength = length

      while remainingLength > 0 {
        let randoms: [UInt8] = (0 ..< 16).map { _ in
          var random: UInt8 = 0
          let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
          if errorCode != errSecSuccess {
            fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
          }
          return random
        }

        randoms.forEach { random in
          if remainingLength == 0 {
            return
          }

          if random < charset.count {
            result.append(charset[Int(random)])
            remainingLength -= 1
          }
        }
      }

      return result
    }
    
}

let userAccount = "AuthenticatedUser"
let accessGroup = "SecuritySerivice"

let passwordKey = "KeyForPassword"

let kSecClassValue = NSString(format: kSecClass)
let kSecAttrAccountValue = NSString(format: kSecAttrAccount)
let kSecValueDataValue = NSString(format: kSecValueData)
let kSecClassGenericPasswordValue = NSString(format: kSecClassGenericPassword)
let kSecAttrServiceValue = NSString(format: kSecAttrService)
let kSecMatchLimitValue = NSString(format: kSecMatchLimit)
let kSecReturnDataValue = NSString(format: kSecReturnData)
let kSecMatchLimitOneValue = NSString(format: kSecMatchLimitOne)

public class KeychainService: NSObject {
  
    public class func savePassword(token: NSString) {
        self.save(service: passwordKey as NSString, data: token)
    }
    
    public class func loadPassword() -> NSString? {
        return self.load(service: passwordKey as NSString)
    }
   
    private class func save(service: NSString, data: NSString) {
        let dataFromString: NSData = data.data(using: String.Encoding.utf8.rawValue, allowLossyConversion: false)! as NSData
        
        // Instantiate a new default keychain query
        let keychainQuery: NSMutableDictionary = NSMutableDictionary(objects: [kSecClassGenericPasswordValue, service, userAccount, dataFromString], forKeys: [kSecClassValue, kSecAttrServiceValue, kSecAttrAccountValue, kSecValueDataValue])
        
        SecItemDelete(keychainQuery as CFDictionary)
        
        SecItemAdd(keychainQuery as CFDictionary, nil)
    }
    
    private class func load(service: NSString) -> NSString? {
       
        let keychainQuery: NSMutableDictionary = NSMutableDictionary(objects: [kSecClassGenericPasswordValue, service, userAccount, kCFBooleanTrue!, kSecMatchLimitOneValue], forKeys: [kSecClassValue, kSecAttrServiceValue, kSecAttrAccountValue, kSecReturnDataValue, kSecMatchLimitValue])
        
        var dataTypeRef :AnyObject?
        
        let status: OSStatus = SecItemCopyMatching(keychainQuery, &dataTypeRef)
        var contentsOfKeychain: NSString? = nil
        
        if status == errSecSuccess {
            if let retrievedData = dataTypeRef as? NSData {
                contentsOfKeychain = NSString(data: retrievedData as Data, encoding: String.Encoding.utf8.rawValue)
            }
        } else {
            print("Nothing was retrieved from the keychain. Status code \(status)")
        }
        
        return contentsOfKeychain
    }
}




@available(iOS 13.0, *)
extension SignInViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization)
    {
        switch authorization.credential {

        case let credentials as ASAuthorizationAppleIDCredential:
            DispatchQueue.main.async {

                if "\(credentials.user)" != "" {

                    UserDefaults.standard.set("\(credentials.user)", forKey: "User_AppleID")
                }
                if credentials.email != nil {

                    UserDefaults.standard.set("\(credentials.email!)", forKey: "User_Email")
                }
                if credentials.fullName!.givenName != nil {

                    UserDefaults.standard.set("\(credentials.fullName!.givenName!)", forKey: "User_FirstName")
                }
                if credentials.fullName!.familyName != nil {

                    UserDefaults.standard.set("\(credentials.fullName!.familyName!)", forKey: "User_LastName")
                }
                UserDefaults.standard.synchronize()
                self.setupUserInfoAndOpenView()


            }

        case let credentials as ASPasswordCredential:
            DispatchQueue.main.async {

                if "\(credentials.user)" != "" {

                    UserDefaults.standard.set("\(credentials.user)", forKey: "User_AppleID")
                }
                if "\(credentials.password)" != "" {

                    UserDefaults.standard.set("\(credentials.password)", forKey: "User_Password")
                }
                UserDefaults.standard.synchronize()
                self.setupUserInfoAndOpenView()
            }
        case let credentials as ASAuthorizationAppleIDProvider:
            DispatchQueue.main.async {
                credentials.getCredentialState(forUserID: "\(UserDefaults.standard.value(forKey: "User_AppleID")!)") { (credentialState, error) in

                    switch credentialState {
                    case .authorized:
                        self.setupUserInfoAndOpenView()
                        break
                    default:
                        break
                    }
                }
            }


        default :
            let alert: UIAlertController = UIAlertController(title: "Apple Sign In", message: "Something went wrong with your Apple Sign In!", preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))

            self.present(alert, animated: true, completion: nil)
            break
        }
    }


    func setupUserInfoAndOpenView()
    {
        DispatchQueue.main.async {

            if "\(UserDefaults.standard.value(forKey: "User_FirstName")!)" != "" || "\(UserDefaults.standard.value(forKey: "User_LastName")!)" != "" || "\(UserDefaults.standard.value(forKey: "User_Email")!)" != "" {
                let emApple = UserDefaults.standard.value(forKey: "User_Email")!
                if emApple != nil{
                    let param: [String: Any] = [
                        "email": emApple,
                        "type": "social"
                    ]
                    print(param)
                    UserDefaults.standard.set(emApple, forKey: "email")
                    UserDefaults.standard.set("1122", forKey: "password")
                    UserDefaults.standard.set(true, forKey: "isSocial")
                    UserDefaults.standard.synchronize()
                    UserDefaults.standard.set("true", forKey: "apple")
                    self.nokri_loginPostSocial(parameter: param as NSDictionary)

                }

            } else {
                let emApple = UserDefaults.standard.value(forKey: "User_AppleID")!
                if emApple != nil{
                    let param: [String: Any] = [
                        "email": emApple,
                        "type": "social"
                    ]
                    print(param)
                    
                    UserDefaults.standard.set(emApple, forKey: "email")
                    UserDefaults.standard.set("1122", forKey: "password")
                    UserDefaults.standard.set(true, forKey: "isSocial")
                    UserDefaults.standard.synchronize()
                    UserDefaults.standard.set("true", forKey: "apple")
                    self.nokri_loginPostSocial(parameter: param as NSDictionary)
                }

            }

        }
    }

    func checkStatusOfAppleSignIn()
    {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        appleIDProvider.getCredentialState(forUserID: "\(UserDefaults.standard.value(forKey: "User_AppleID")!)") { (credentialState, error) in

            switch credentialState {
            case .authorized:
                self.setupUserInfoAndOpenView()
                break
            default:
                break
            }
        }
    }
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error)
    {
        let alert: UIAlertController = UIAlertController(title: "Error", message: "\(error.localizedDescription)", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))

        self.present(alert, animated: true, completion: nil)
    }

}
