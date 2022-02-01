//
//  HomeTabViewController.swift
//  Nokri
//
//  Created by Furqan Nadeem on 20/03/2019.
//  Copyright © 2019 Furqan Nadeem. All rights reserved.
//

import UIKit
import RangeSeekSlider
import DropDown
import CoreLocation
import Alamofire
import JGProgressHUD
import SwiftyStoreKit
import Firebase
import FirebaseMessaging
import UserNotifications
import FirebaseCore
import FirebaseInstanceID

class HomeTabViewController: UIViewController,UITextFieldDelegate,RangeSeekSliderDelegate {


    @IBOutlet weak var viewLine: UIView!
    @IBOutlet weak var viewBg: UIView!
    @IBOutlet weak var imageViewLogo: UIImageView!
    @IBOutlet weak var lblTextHead: UILabel!
    @IBOutlet weak var lblFindJob: UILabel!
    @IBOutlet weak var lblMiles: UILabel!
    @IBOutlet weak var lblNoMiles: UILabel!
    @IBOutlet weak var viewNoMiles: UIView!
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var viewKeyWord: UIView!
    @IBOutlet weak var textKeyWord: UITextField!
    @IBOutlet weak var viewCategory: UIView!
    @IBOutlet weak var txtCategory: UITextField!
    @IBOutlet weak var rangeSlider: RangeSeekSlider!
    @IBOutlet weak var iconSearch: UIImageView!
    @IBOutlet weak var iconCategory: UIImageView!
    @IBOutlet weak var imgBG: UIImageView!

    @IBOutlet weak var lblSub: UILabel!
    
    var defaults = UserDefaults.standard
    var barButtonItems = [UIBarButtonItem]()
    var withOutLogin = UserDefaults.standard.string(forKey: "aType")
    var appColorNew = UserDefaults.standard.string(forKey: "app_Color")
    var userType = UserDefaults.standard.string(forKey: "usrTyp")
    var maximumValue = ""
    var minimumValue = ""
    let dropDownCategory = DropDown()
    var lat = ""
    var long = ""
    var jobsArray = NSMutableArray()
    var message:String?
    var nextPage:Int?
    var hasNextPage:Bool?
    var isJobCat:Bool = false
    var jobCatInt = 0
    var radValue = ""
    var isCat = false
    var noOfJobs = ""
    
    var categoryKeyArr = [Int]()
    var categoryvalueArr = [String]()
    
    
    //location manager
    lazy var locationManager: CLLocationManager = {
        var _locationManager = CLLocationManager()
        _locationManager.delegate = self
        _locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        _locationManager.activityType = .automotiveNavigation
        _locationManager.distanceFilter = 10.0  // Movement threshold for new events
        //  _locationManager.allowsBackgroundLocationUpdates = true // allow in background
        
        return _locationManager
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        subscribeToTopicMessage()
        
        locationManager.requestAlwaysAuthorization()
        print("did load")
        print(locationManager)
        locationManager.startUpdatingLocation()
        
        //tabBar.delegate = self

        txtCategory.delegate = self
        textKeyWord.delegate = self
        rangeSlider.delegate = self
        rangeSlider.disableRange = true
        rangeSlider.enableStep = true
        //rangeSlider.minValue = 0
        //rangeSlider.step = 5
        if let bgColor = UserDefaults.standard.string(forKey: "app_Color") {
            rangeSlider.tintColor = UIColor.lightGray //Constants.hexStringToUIColor(hex: bgColor)
            rangeSlider.minLabelColor = Constants.hexStringToUIColor(hex: bgColor)
            rangeSlider.maxLabelColor = Constants.hexStringToUIColor(hex: bgColor)
            rangeSlider.handleColor = Constants.hexStringToUIColor(hex: bgColor)
            rangeSlider.handleBorderColor = Constants.hexStringToUIColor(hex: bgColor)
            rangeSlider.colorBetweenHandles = Constants.hexStringToUIColor(hex: bgColor)
            rangeSlider.initialColor = Constants.hexStringToUIColor(hex: bgColor)
        }
        
        nokri_customeButtons()
        nokri_ltrRtl()
        showSearchButton()
        nokri_HomeDataTwo()
        
       
      
        
//        SwiftyStoreKit.retrieveProductsInfo(["com.st.111"]) { result in
//            if let product = result.retrievedProducts.first {
//                let priceString = product.localizedPrice!
//                print("Product: \(product.localizedDescription), price: \(priceString)")
//            }
//            else if let invalidProductId = result.invalidProductIDs.first {
//                print("Invalid product identifier: \(invalidProductId)")
//            }
//            else {
//                
//                print("Error: \(String(describing: result.error))")
//            }
//        }
        
        if withOutLogin != "5"{
            
            if userType != "1"{
                var fcmToken = ""
                if let token = defaults.value(forKey: "fcmToken") as? String {
                    fcmToken = token
                } else {
                    fcmToken = appDelegate.deviceFcmToken
                }
                
                let param: [String: Any] = [
                    "api_fcm_token": fcmToken
                ]
                print(param)
                self.nokri_sendFcmToken(parameter: param as NSDictionary)
            }
        }
        
    }
    
    
//    func showSearchButtonHome() {
//        self.hideBackButton()
//        let backButton = UIButton(type: .custom)
//        backButton.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
//        if UserDefaults.standard.bool(forKey: "isRtl") {
//            backButton.setBackgroundImage(UIImage(named: "searchWhite"), for: .normal)
//        } else {
//            backButton.setBackgroundImage(UIImage(named: "searchWhite"), for: .normal)
//        }
//        backButton.addTarget(self, action: #selector(onSearchButtonClciked), for: .touchUpInside)
//        let backBarButton = UIBarButtonItem(customView: backButton)
//        parent?.navigationItem.rightBarButtonItem = backBarButton
//
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    
        if let userData = UserDefaults.standard.object(forKey: "settingsData") {
            let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
            let dataTabs = SplashRoot(fromDictionary: objData)
            let obj = dataTabs.data.tabs
            self.navigationController?.navigationBar.topItem?.title = obj?.home
        }
    }

    func nokri_ltrRtl(){
        let isRtl = UserDefaults.standard.string(forKey: "isRtl")
        if isRtl == "0"{
            self.addLeftBarButtonWithImage(#imageLiteral(resourceName: "menu"))
        }else{
            self.addRightBarButtonWithImage(#imageLiteral(resourceName: "menu"))
        }
    }
    
    func subscribeToTopicMessage(){
     
           if withOutLogin != "5"{
               //Messaging.messaging().shouldEstablishDirectChannel = true
               Messaging.messaging().subscribe(toTopic: "global")
           }
       }

    func nokri_customeButtons(){
        textKeyWord.delegate = self
        txtCategory.delegate = self
        viewBg.layer.cornerRadius = 15
        viewKeyWord.layer.cornerRadius = 20
        viewCategory.layer.cornerRadius = 20
        viewNoMiles.layer.cornerRadius = 10
        viewKeyWord.layer.borderWidth = 1
        viewCategory.layer.borderWidth = 1
        viewNoMiles.layer.borderWidth = 1
        viewLine.backgroundColor = UIColor(hex: appColorNew!)
        viewKeyWord.layer.borderColor = UIColor.groupTableViewBackground.cgColor
        viewCategory.layer.borderColor = UIColor.groupTableViewBackground.cgColor
        viewNoMiles.layer.borderColor = UIColor.groupTableViewBackground.cgColor
        iconSearch.image = iconSearch.image?.withRenderingMode(.alwaysTemplate)
        iconSearch.tintColor = UIColor.lightGray
        iconCategory.image = iconCategory.image?.withRenderingMode(.alwaysTemplate)
        iconCategory.tintColor = UIColor.lightGray
        btnSearch.layer.cornerRadius = 22
        btnSearch.layer.masksToBounds = false
        btnSearch.backgroundColor = UIColor(hex: appColorNew!)
    }
    
    func nokri_dropDownSetup(){
        print(categoryKeyArr)
        dropDownCategory.dataSource = categoryvalueArr
        dropDownCategory.anchorView = txtCategory
        dropDownCategory.textColor = UIColor.black
        dropDownCategory.cornerRadius = 15
        dropDownCategory.direction  = .bottom
        //dropDownCategory.backgroundColor = UIColor.white
        dropDownCategory.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.jobCatInt =  self.categoryKeyArr[index]
            print(self.jobCatInt)
            self.txtCategory.text = item
            self.isCat = true
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == textKeyWord {
            viewKeyWord.layer.borderWidth = 1
            viewKeyWord.layer.borderColor = UIColor(hex: appColorNew!).cgColor
        } else {
            viewCategory.layer.borderWidth = 1
            viewCategory.layer.borderColor = UIColor.groupTableViewBackground.cgColor
        }
        if textField == txtCategory {
            viewKeyWord.layer.borderWidth = 1
            viewKeyWord.layer.borderColor = UIColor(hex: appColorNew!).cgColor
            
        } else {
            viewCategory.layer.borderWidth = 1
            viewCategory.layer.borderColor = UIColor.groupTableViewBackground.cgColor
        }
        return true
    }
   
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
         if textField == textKeyWord {
            viewCategory.layer.borderWidth = 1
            viewCategory.layer.borderColor = UIColor.groupTableViewBackground.cgColor
        }
            return true
    }
    
   
    @IBAction func btnSubmitClicked(_ sender: UIButton) {
        nokri_jobDataWithFilters()
    }
    
    
    @IBAction func btnCategoryClicked(_ sender: UIButton) {
        dropDownCategory.show()
        viewKeyWord.layer.borderWidth = 1
        viewKeyWord.layer.borderColor = UIColor.groupTableViewBackground.cgColor
    }

    func rangeSeekSlider(_ slider: RangeSeekSlider, didChange minValue: CGFloat, maxValue: CGFloat) {
        if slider === rangeSlider {
            print("Standard slider updated. Min Value: \(minValue) Max Value: \(maxValue)")
            let mxValue = maxValue
            self.maximumValue = "\(mxValue)"
            
            if let index = self.maximumValue.range(of: ".")?.lowerBound {
                let substring = self.maximumValue[..<index]
                let string = String(substring)
                print(string)
                self.maximumValue = string
            }
            
            let minValue = minValue
            self.minimumValue = "\(minValue)"
            if let index = self.minimumValue.range(of: ".")?.lowerBound {
                let substring = self.minimumValue[..<index]
                let string = String(substring)
                print(string)
                self.minimumValue = string
               
            }
            lblNoMiles.text = "\(maximumValue)"
            self.radValue = "\(maximumValue)"
            viewKeyWord.layer.borderWidth = 1
            viewKeyWord.layer.borderColor = UIColor.groupTableViewBackground.cgColor
        }
    }
    
    func didStartTouches(in slider: RangeSeekSlider) {
        print("did start touches")
    }
    
    func didEndTouches(in slider: RangeSeekSlider) {
        print("did end touches")
    }
    
}

// MARK: - CLLocationManagerDelegate
extension HomeTabViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        for location in locations {
            lat = " \(location.coordinate.latitude)"
            long = "\(location.coordinate.longitude)"
            print("**********************")
            print("Long \(location.coordinate.longitude)")
            print("Lati \(location.coordinate.latitude)")
            print("Alt \(location.altitude)")
            print("Sped \(location.speed)")
            print("Accu \(location.horizontalAccuracy)")
            print("**********************")
        }
        print(lat)
        print(long)
    
    }
    
    

    func nokri_HomeDataTwo() {
        self.showLoader()
        UserHandler.nokri_HomeTwo(success: { (successResponse) in
            self.stopAnimating()
            if successResponse.success {
                let data = successResponse.data
                DispatchQueue.main.async {
                    if let imgUrl = URL(string: data!.img) {
                        self.imgBG.sd_setImage(with: imgUrl, completed: nil)
                        self.imgBG.sd_setShowActivityIndicatorView(true)
                        self.imgBG.sd_setIndicatorStyle(.gray)
                    }
                    if let imgUrl = URL(string: data!.logo) {
                        self.imageViewLogo.sd_setImage(with: imgUrl, completed: nil)
                        self.imageViewLogo.sd_setShowActivityIndicatorView(true)
                        self.imageViewLogo.sd_setIndicatorStyle(.gray)
                    }
                    
                    self.lblTextHead.text = data?.tagline
                    self.lblFindJob.text = data?.heading
                    self.lblSub.text = data?.keyWrdHeadng
                    self.textKeyWord.placeholder = data?.keyWrdPlc
                    self.txtCategory.placeholder = data?.catPlc
                    self.lblMiles.text = data?.radiusText
                    self.lblNoMiles.text = data?.radiusValue  //self.maximumValue
                    self.rangeSlider.maxValue = CGFloat((data?.radiusValue! as! NSString).floatValue)
                  
                    for ob in (data?.categories.value)!{
                         self.categoryvalueArr.append(ob.value)
                        self.categoryKeyArr.append(ob.key)
                    }
                    self.nokri_dropDownSetup()
                    
                }
            }
            else {
                self.stopAnimating()
                let alert = Constants.showBasicAlert(message: successResponse.message)
                self.present(alert, animated: true, completion: nil)
            }
        }) { (error) in
          
            let alert = Constants.showBasicAlert(message: error.message)
            self.present(alert, animated: true, completion: nil)
            self.stopAnimating()
        }
    }
    
    
    
    func nokri_jobDataWithFilters(){
        
        var langCode = UserDefaults.standard.string(forKey: "langCode")
        if langCode == nil {
            langCode = "en"
        }
        
        var isTimeOut = false
        self.showLoader()
        
        var email = ""
        var password = ""
        
        if UserDefaults.standard.bool(forKey: "isSocial") == true {
            if let userEmail = UserDefaults.standard.string(forKey: "email") {
                email = userEmail
            }
            if let userPassword = UserDefaults.standard.string(forKey: "password") {
                password = userPassword
            }
            
            let emailPass = "\(email):\(password)"
            let encodedString = emailPass.data(using: String.Encoding.utf8)!
            let base64String = encodedString.base64EncodedString(options: [])
            
            let headers = [
                "Content-Type":Constants.customCodes.contentType,
                "Authorization" : "Basic \(base64String)",
                "Purchase-Code" : Constants.customCodes.purchaseCode,
                "Custom-Security": Constants.customCodes.securityCode,
                "Nokri-Request-From" : Constants.customCodes.requestFrom,
                "Nokri-Login-Type" : "social",
                "Nokri-Lang-Locale" : "\(langCode!)"
            ]
            
            var params : [String:Any] = [:]
            if isCat == true{
                params["job_category"] = jobCatInt
            }else{
                params["job_category"] = nil
            }
            params["e_lat"] = lat
            params["e_long"] = long
            params["job_title"] = textKeyWord.text
            params["e_distance"] = radValue
            params["page_number"] = "1"
            
            
            print(params)
            
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.advanceSearch, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    
                    guard let res = response.value else{return}
                    
                    let responseData = res as! NSDictionary
                    self.message = responseData["message"] as? String
                    
                    let success = responseData["success"] as! Bool
                    if success == true{
                        
                        isTimeOut = true
                        var pageTitle:String?
                        let data = responseData["data"] as! NSDictionary
                        if let page = data["page_title"]  as? String{
                            pageTitle = page
                        }
                        if let noOfJob = data["no_txt"]  as? String{
                            self.noOfJobs = noOfJob
                        }
                        if let JobArr = data["jobs"] as? NSArray {
                            self.nokri_jobDataParserWithFilters(jobsArr: JobArr)
                        }
                        if let pagination = responseData["pagination"] as? NSDictionary{
                            self.hasNextPage = pagination["has_next_page"] as? Bool
                            self.nextPage = pagination["next_page"] as? Int
                        }
                        if self.hasNextPage == true{
                            print(self.hasNextPage!)
                            //self.btnLoadMore.isHidden = false
                        }
                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SearchedJobViewController") as! SearchedJobViewController
                        nextViewController.jobsArray = self.jobsArray
                        nextViewController.message = self.message
                        nextViewController.pageTitle = pageTitle
                        nextViewController.hasNextPage = self.hasNextPage!
                        nextViewController.nextPage = self.nextPage
                        nextViewController.isfromFilter = true
                        nextViewController.isJobCat = self.isJobCat
                        nextViewController.noOfJobText = self.noOfJobs
                       
                        self.navigationController?.pushViewController(nextViewController, animated: true)
                    }else{
                        let hud = JGProgressHUD(style: .dark)
                        hud.textLabel.text = self.message
                        hud.detailTextLabel.text = nil
                        hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                        hud.position = .bottomCenter
                        hud.show(in: self.view)
                        hud.dismiss(afterDelay: 2.0)
                        //self.view.makeToast(self.message, duration: 1.5, position: .center)
                    }
                    
                    self.stopAnimating()
                    if isTimeOut == false{
                        DispatchQueue.main.asyncAfter(deadline: .now() + 30) {
                            self.stopAnimating()
                            let hud = JGProgressHUD(style: .dark)
                                          hud.textLabel.text = "Network Time Out"
                                            hud.detailTextLabel.text = nil
                                            hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                                            hud.position = .bottomCenter
                                            hud.show(in: self.view)
                                            hud.dismiss(afterDelay: 2.0)
                            //self.view.makeToast("Network Time out", duration: 1.5, position: .center)
                        }
                        
                    }
                    
            }
            
        }else{
            if let userEmail = UserDefaults.standard.string(forKey: "email") {
                email = userEmail
            }
            if let userPassword = UserDefaults.standard.string(forKey: "password") {
                password = userPassword
            }
            
            let emailPass = "\(email):\(password)"
            
            let encodedString = emailPass.data(using: String.Encoding.utf8)!
            let base64String = encodedString.base64EncodedString(options: [])
            
            let headers = [
                "Content-Type":Constants.customCodes.contentType,
                "Authorization" : "Basic \(base64String)",
                "Purchase-Code" : Constants.customCodes.purchaseCode,
                "Custom-Security": Constants.customCodes.securityCode,
                "Nokri-Request-From" : Constants.customCodes.requestFrom,
                "Nokri-Lang-Locale" : "\(langCode!)"
            ]
            
            var params : [String:Any] = [:]
            if isCat == true{
                params["job_category"] = jobCatInt
                
            }else{
                params["job_category"] = nil
                
            }
            params["e_lat"] = lat
            params["e_long"] = long
            params["job_title"] = textKeyWord.text
            params["e_distance"] = radValue
            params["page_number"] = "1"
        
            
            //params["page_number"] = "1"
            
            print(params)
            
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.advanceSearch, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    
                    guard let res = response.value else{return}
                    
                    let responseData = res as! NSDictionary
                    self.message = responseData["message"] as? String
                    
                    let success = responseData["success"] as! Bool
                    if success == true{
                        
                        isTimeOut = true
                        var pageTitle:String?
                        let data = responseData["data"] as! NSDictionary
                        if let page = data["page_title"]  as? String{
                            pageTitle = page
                        }
                        if let noOfJob = data["no_txt"]  as? String{
                            self.noOfJobs = noOfJob
                        }
                        if let JobArr = data["jobs"] as? NSArray {
                            self.nokri_jobDataParserWithFilters(jobsArr: JobArr)
                        }
                        if let pagination = responseData["pagination"] as? NSDictionary{
                            self.hasNextPage = pagination["has_next_page"] as? Bool
                            self.nextPage = pagination["next_page"] as? Int
                        }
                        if self.hasNextPage == true{
                            print(self.hasNextPage!)
                            //self.btnLoadMore.isHidden = false
                        }
                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SearchedJobViewController") as! SearchedJobViewController
                        nextViewController.jobsArray = self.jobsArray
                        nextViewController.message = self.message
                        nextViewController.pageTitle = pageTitle
                        nextViewController.hasNextPage = self.hasNextPage!
                        nextViewController.nextPage = self.nextPage
                        nextViewController.isfromFilter = true
                        nextViewController.isJobCat = self.isJobCat
                        nextViewController.noOfJobText = self.noOfJobs
                        self.navigationController?.pushViewController(nextViewController, animated: true)
                    }else{
                        self.view.makeToast(self.message, duration: 1.5, position: .center)
                    }
                    
                    self.stopAnimating()
                    if isTimeOut == false{
                        DispatchQueue.main.asyncAfter(deadline: .now() + 30) {
                            self.stopAnimating()
                            self.view.makeToast("Network Time out", duration: 1.5, position: .center)
                        }
                        
                    }
                    
            }
            
        }

    }
    
    
    func nokri_jobDataParserWithFilters(jobsArr:NSArray){
        
        self.jobsArray.removeAllObjects()
        for item in jobsArr{
            print(item)
            var arrayOfDictionaries = [NSDictionary]();
            if let innerArray = item as? NSArray{
                for innerItem in innerArray{
                    print(innerItem);
                    if let innerDictionary = innerItem as? NSDictionary{
                        arrayOfDictionaries.append(innerDictionary);
                    }
                }
            }
            self.jobsArray.add(arrayOfDictionaries);
        }
    }
    
    
    
    func nokri_sendFcmToken(parameter: NSDictionary) {
        self.showLoader()
        UserHandler.nokri_homePost(parameter: parameter as NSDictionary, success: { (successResponse) in
            
            if successResponse.success == true {
                print("Token sent to server...!!!!!!!")            }
            
        }) { (error) in
            let alert = Constants.showBasicAlert(message: error.message)
            self.present(alert, animated: true, completion: nil)
            self.stopAnimating()
        }
    }
    

    
}
