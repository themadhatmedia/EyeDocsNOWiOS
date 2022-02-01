//
//  JobPostLocationTableViewController.swift
//  Nokri
//
//  Created by apple on 8/6/19.
//  Copyright © 2019 Furqan Nadeem. All rights reserved.
//

import UIKit
import DropDown
import ActionSheetPicker_3_0
import WSTagsField
import TextFieldEffects
import GoogleMaps
import GooglePlaces
import Alamofire
import SwiftCheckboxDialog
import UICheckbox_Swift
import JGProgressHUD

class JobPostLocationTableViewController: UITableViewController,UITextFieldDelegate,GMSMapViewDelegate, GMSAutocompleteViewControllerDelegate,CLLocationManagerDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var viewCountry: UIView!
    @IBOutlet weak var viewCountrry: UIView!
    @IBOutlet weak var viewState: UIView!
    @IBOutlet weak var viewCity: UIView!
    @IBOutlet weak var viewTown: UIView!
    
    @IBOutlet weak var dropDownCountry: UIButton!
    @IBOutlet weak var dropDownState: UIButton!
    @IBOutlet weak var dropDownCity: UIButton!
    @IBOutlet weak var dropDownTown: UIButton!
    
    @IBOutlet weak var lblSelectCountryCity: UILabel!
    @IBOutlet weak var lblCountryValue: UILabel!
    @IBOutlet weak var lblStateValue: UILabel!
    @IBOutlet weak var lblCityValue: UILabel!
    @IBOutlet weak var lblTownValue: UILabel!
    
    @IBOutlet weak var lblCountry: UILabel!
    @IBOutlet weak var lblState: UILabel!
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var lblTown: UILabel!
    
    
    @IBOutlet weak var iconDropDownCountry: UIImageView!
    @IBOutlet weak var iconDropDownState: UIImageView!
    @IBOutlet weak var iconDropDownCity: UIImageView!
    @IBOutlet weak var iconDropDownTown: UIImageView!
    
    
    @IBOutlet weak var lblLocationOnMap: UILabel!
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var txtLocation: UITextField!
    @IBOutlet weak var lblLat: UILabel!
    @IBOutlet weak var lblLong: UILabel!
    @IBOutlet weak var txtLatitude: UITextField!
    @IBOutlet weak var txtLongitude: UITextField!
    @IBOutlet weak var tableViewJobs: UITableView!
    @IBOutlet weak var lblBoostJob: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var heightConstraintCollectionView: NSLayoutConstraint!
    @IBOutlet weak var btnJobPost: UIButton!
    
    //MARK:- Poporties
    
    var footerView = UIView()
    var job_Id:Int?
    var countryArray = NSMutableArray()
    var statArray = NSMutableArray()
    var cityArray = NSMutableArray()
    var townArray = NSMutableArray()
    var premiumArray = NSMutableArray()
    var premiumKeyArr = [String]()
    var premiumValueArr = [String]()
    var premiumRemainigArr = [String]()
    var packagesValueArr = [String]()
    var customArray = [JobPostCCustomData]()
    
    var isCountryShow:Bool?
    var isCountrySh:Bool?
    var isStateShow:Bool?
    var isStateSh:Bool?
    var isCityShow:Bool?
    var isCitySh:Bool?
    var appColorNew = UserDefaults.standard.string(forKey: "app_Color")
    var zoom: Float = 15
    var locationManager = CLLocationManager()
    
    var dropDownCountr = DropDown()
    var dropDownStat = DropDown()
    var dropDownCit = DropDown()
    var dropDownTow = DropDown()
    
    var jobTitle = ""
    var jobCat = 0
    var descriptionValue = ""
    var deadLineVal = ""
    var customDictionary = [String: Any]()
    var isFromEdit:Bool = false
    
    @IBOutlet weak var heightConstraintViewCountry: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nokri_viewHide()
        nokri_boolChecks()
        
        nokri_dropDownIcons()
        nokri_delegate()
        nokri_map(lat: "", long: "")
        print(customArray)
        btnJobPost.layer.cornerRadius = 18
        btnJobPost.backgroundColor = UIColor(hex:appColorNew!)
        let ed = UserDefaults.standard.bool(forKey: "ed")
        if ed == true{
            nokri_jobPostDataEdit()
        }else{
            nokri_jobPostData()
        }
        
        //nokri_jobPostData()
        let titlejob = UserDefaults.standard.string(forKey: "jobPost")
        self.title = titlejob
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        let cotName  = UserDefaults.standard.string(forKey: "coName")
        let cot2Name  = UserDefaults.standard.string(forKey: "coName")
        let cot3Name  = UserDefaults.standard.string(forKey: "coName")
        let cot4Name  = UserDefaults.standard.string(forKey: "coName")
        let cotKey = UserDefaults.standard.integer(forKey: "coKey")
        let cot2Key = UserDefaults.standard.integer(forKey: "co2Key")
        let cot3Key = UserDefaults.standard.integer(forKey: "co3Key")
        let cot4Key = UserDefaults.standard.integer(forKey: "co4Key")
        dropDownCountr.tag = cotKey
        self.lblCountryValue.text = cotName
        dropDownStat.tag = cot2Key
        self.lblCountryValue.text = cot2Name
        dropDownCit.tag = cot3Key
        self.lblCountryValue.text = cot3Name
        dropDownTow.tag = cot4Key
        self.lblCountryValue.text = cot4Name
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        txtLatitude.nokri_updateBottomBorderSize()
        txtLongitude.nokri_updateBottomBorderSize()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.heightConstraintCollectionView.constant = self.collectionView.contentSize.height
    }
    
    func nokri_viewHide(){
        viewState.isHidden = true
        viewCity.isHidden = true
        viewTown.isHidden = true
        heightConstraintViewCountry.constant -= 235
    }
    
    func nokri_boolChecks(){
        isCountryShow = true
        isCountrySh = true
        isStateShow = true
        isStateSh = true
        isCityShow = true
        isCitySh = true
    }
    
    //MARK:- IBAction
    
    func nokri_delegate(){
        mapView.delegate = self
        txtLatitude.delegate = self
        txtLongitude.delegate = self
        txtLatitude.nokri_addBottomBorder()
        txtLongitude.nokri_addBottomBorder()
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == txtLatitude {
            txtLatitude.nokri_updateBottomBorderColor(isTextFieldSelected: true)
        } else {
            txtLatitude.nokri_updateBottomBorderColor(isTextFieldSelected: false)
        }
        if textField == txtLongitude {
            txtLongitude.nokri_updateBottomBorderColor(isTextFieldSelected: true)
        } else {
            txtLongitude.nokri_updateBottomBorderColor(isTextFieldSelected: false)
        }
        return true
    }
    
    func nokri_dropDownIcons(){
        iconDropDownCountry.image = iconDropDownCountry.image?.withRenderingMode(.alwaysTemplate)
        iconDropDownCountry.tintColor = UIColor(hex: appColorNew!)
    }
    
    @IBAction func btnDropDownCountryClicked(_ sender: UIButton) {
        var countryArr = [String]()
        var countryChildArr = [Bool]()
        var countryKeyArr = [Int]()
        
        let country = self.countryArray as? [NSDictionary]
        for itemDict in country! {
            if let catObj = itemDict["value"] as? String{
                if catObj == ""{
                    continue
                }
                countryArr.append(catObj)
            }
            if let keyObj = itemDict["key"] as? Int{
                
                countryKeyArr.append(keyObj)
            }
            if let hasChild = itemDict["has_child"] as? Bool{
                print(hasChild)
                
                countryChildArr.append(hasChild)
            }
        }
        
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "JobPostCountryViewController") as? JobPostCountryViewController
        vc!.jobCatArr = countryArr
        vc!.childArr = countryChildArr
        vc!.keyArray = countryKeyArr
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    
    @IBAction func btnDropDownStateClicked(_ sender: UIButton) {
        dropDownStat.show()
    }
    
    @IBAction func btnDropDownCityClicked(_ sender: UIButton) {
        dropDownCit.show()
    }
    
    @IBAction func btnDropDownTownClicked(_ sender: UIButton) {
        dropDownTow.show()
    }
    
    @IBAction func txtLocationClicked(_ sender: UITextField) {
        let autoComplete = GMSAutocompleteViewController()
        autoComplete.delegate = self
        autoComplete.primaryTextHighlightColor = UIColor(hex: appColorNew!)
        //self.locationManager.startUpdatingLocation()
        self.present(autoComplete, animated: true, completion: nil)
    }
    
    //MARK:- Map
    
    struct Place {
        let id: Int
        let name: String
        let lat: CLLocationDegrees
        let lng: CLLocationDegrees
        let icon: String
    }
    
    func nokri_map(lat:String,long:String){
        let camera = GMSCameraPosition.camera(withLatitude: (lat as NSString).doubleValue, longitude: (long as NSString).doubleValue, zoom: 100)
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        self.mapView.camera = camera
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake((lat as NSString).doubleValue, (long as NSString).doubleValue)
        marker.appearAnimation = GMSMarkerAnimation.pop
        marker.title = txtLocation.text
        marker.snippet = txtLocation.text
        marker.infoWindowAnchor = CGPoint(x:0.5 , y: 0)
        marker.icon = UIImage(named: "marker")
        marker.map = self.mapView
        
    }
    
    //MARK:- CLLocation Manager Delegate
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error While get locations \(error)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locations = locations.last
        let camera = GMSCameraPosition.camera(withLatitude: (locations?.coordinate.latitude)!, longitude: (locations?.coordinate.longitude)!, zoom: 17.0)
        self.mapView.animate(to: camera)
        self.locationManager.stopUpdatingLocation()
    }
    
    //MARK:- GMSAutocomplete Delegate
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        let camera = GMSCameraPosition.camera(withLatitude: (place.coordinate.latitude), longitude: (place.coordinate.longitude), zoom: 17.0)
        self.mapView.animate(to: camera)
        txtLatitude.text = "\(place.coordinate.latitude)"
        txtLongitude.text = "\(place.coordinate.longitude)"
        txtLocation.text = place.name
        self.dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("Error Auto Complete \(error)")
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    //MARK:- GMSMapViewDelegate
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        self.mapView.isMyLocationEnabled = true
    }
    
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        self.mapView.isMyLocationEnabled = true
        if (gesture){
            mapView.selectedMarker = nil
        }
    }
    
    func didTapMyLocationButton(for mapView: GMSMapView) -> Bool {
        txtLatitude.text = "\((mapView.myLocation?.coordinate.latitude)!)"
        txtLongitude.text = "\((mapView.myLocation?.coordinate.longitude)!)"
        let camera = GMSCameraPosition.camera(withLatitude: (mapView.myLocation?.coordinate.latitude)!, longitude: (mapView.myLocation?.coordinate.longitude)!, zoom: 12)
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        self.mapView.camera = camera
        
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: (mapView.myLocation?.coordinate.latitude)!, longitude: (mapView.myLocation?.coordinate.longitude)!)
        geoCoder.reverseGeocodeLocation(location, completionHandler:
            {
                placemarks, error -> Void in
                guard let placeMark = placemarks!.first else { return }
                var streetName = ""
                var countryName = ""
                if let locationName = placeMark.location {
                    print(locationName)
                }
                if let street = placeMark.thoroughfare {
                    print(street)
                    streetName = "\(street)"
                }
                if let city = placeMark.subAdministrativeArea {
                    print(city)
                }
                if let zip = placeMark.isoCountryCode {
                    print(zip)
                }
                if let country = placeMark.country {
                    print(country)
                    countryName = "\(country)"
                }
                self.txtLocation.text = "\(streetName)" + ", \(countryName)"
        })
        return true
    }
    
    func nokri_dropDownSetup(){
        
        var countrID:Int?
        var countryArr = [String]()
        var countryChildArr = [Bool]()
        var countryKeyArr = [Int]()
        //var isCountrySelected:Bool?
       // var txtCountry:String?
        //var isCountry = 0
        let country = self.countryArray as? [NSDictionary]
        var hasChildCo = false
        
        for itemDict in country! {
            if let catObj = itemDict["value"] as? String{
                if catObj == ""{
                    continue
                }
                countryArr.append(catObj)
            }
            if let keyObj = itemDict["key"] as? Int{
                countrID = keyObj
                //dropDownCountr.tag = keyObj
                countryKeyArr.append(keyObj)
            }
            if let hasChild = itemDict["has_child"] as? Bool{
                print(hasChild)
                if hasChild == true {
                    // childCategories(id: catID!)
                    hasChildCo = true
                }
                countryChildArr.append(hasChild)
            }
            
            if isFromEdit == true{
                if let selected = itemDict["selected"] as? Bool{
                    if selected == true{
                        if let selObj = itemDict["value"] as? String{
                            self.lblCountry.text = selObj
                        }
                    }
                }
            }else{
                 self.lblCountryValue.text = countryArr[0]
            }
            
        }
       
    
    }
    
    func nokri_countryCategories(id:Int){
        
        var langCode = UserDefaults.standard.string(forKey: "langCode")
        if langCode == nil {
            langCode = "en"
        }
        
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
            
            let param: [String: Any] = [
                "country_id": id,
            ]
            print(param)
            
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.countryCat, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    let responseData = response.value as! NSArray
                    print(responseData)
                    self.nokri_stateDataParser(stateArr: responseData)
                    self.nokri_dropDownSetup()
                    self.stopAnimating()
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
            
            let param: [String: Any] = [
                "country_id": id,
            ]
            print(param)
            
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.countryCat, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    let responseData = response.value as! NSArray
                    print(responseData)
                    self.nokri_stateDataParser(stateArr: responseData)
                    self.nokri_dropDownSetup()
                    self.stopAnimating()
            }
        }
    }
    
    func nokri_stateDataParser(stateArr:NSArray){
        self.statArray.removeAllObjects()
        for item in stateArr{
            self.statArray.add(item)
        }
    }
    
    func nokri_jobPostDataFromEdit(){
        
        var langCode = UserDefaults.standard.string(forKey: "langCode")
        if langCode == nil {
            langCode = "en"
        }
        
        self.showLoader()
        var lati = ""
        var longi = ""
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
            
            let jbid = UserDefaults.standard.object(forKey: "jobId")
            let param: [String: Any] = [
                "job_id": jbid!,
                "is_update": jbid!
            ]
            print(param)
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.postJobFromEdit, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    
                    guard let res = response.value else{return}
                    
                    let responseData = res as! NSDictionary
                    let success = responseData["success"] as! Bool
                    let messageResponse = responseData["message"] as! String
                    if success == true{
                        let data = responseData["data"] as! NSDictionary
                        let job_id = data["job_id"]
                        UserDefaults.standard.set(job_id, forKey: "JobId")
                        print(job_id!)
                        let form = data["job_form"] as? Bool
                        if form == true{
                            print("Default...!")
                        }else{
                            let jobPostCustom = self.storyboard?.instantiateViewController(withIdentifier: "JobPostCustomViewController") as! JobPostCustomViewController
                            self.navigationController?.pushViewController(jobPostCustom, animated: false)
                            self.stopAnimating()
                            return
                        }
                        
                        let location = data["job_location_head"] as! NSDictionary
                        if let loc = location["key"]{
                            self.lblLocationOnMap.text = loc as? String
                        }
                        let setLocation = data["job_loc"] as! NSDictionary
                        if let setLoc = setLocation["key"]{
                            self.txtLocation.placeholder = setLoc as? String
                        }
                        let latitude = data["job_lat"] as! NSDictionary
                        if let lat = latitude["key"]{
                            self.txtLatitude.text = lat as? String
                            self.txtLatitude.placeholder = lat as? String
                            self.lblLat.text = lat as? String
                            lati = (lat as? String)!
                        }
                        if let lat = latitude["value"]{
                            self.txtLatitude.text = lat as? String
                            self.txtLatitude.placeholder = lat as? String
                            //self.lblLat.text = lat as? String
                            lati = (lat as? String)!
                        }
                        
                        let longitude = data["job_long"] as! NSDictionary
                        if let long = longitude["key"]{
                            self.txtLongitude.text = long as? String
                            self.txtLongitude.placeholder = long as? String
                            self.lblLong.text = long as? String
                            longi = (long as? String)!
                        }
                        if let long = longitude["value"]{
                            self.txtLongitude.text = long as? String
                            self.txtLongitude.placeholder = long as? String
                           // self.lblLong.text = long as? String
                            longi = (long as? String)!
                        }
                        if let premiumArray = data["premium_jobs"] as? NSArray {
                            self.nokri_premiumJobParser(premArray: premiumArray)
                        }
                        
                        let jobLocation = data["job_location"] as! NSDictionary
                        let jobLocationKey = jobLocation["key"] as! String
                        self.lblSelectCountryCity.text = jobLocationKey
                        
                        let jobCountry = data["job_country"] as! NSDictionary
                        let jobCountryKey = jobCountry["key"] as! String
                        self.lblCountry.text = jobCountryKey
                        if let countryArr = jobCountry["value"] as? NSArray {
                            self.nokri_countryDataParser(countryArr: countryArr)
                        }
                        
                        let state = data["job_state"] as! NSDictionary
                        let stateKey = state["key"] as! String
                        self.lblState.text = stateKey
                        
                        let city = data["job_city"] as! NSDictionary
                        let cityKey = city["key"] as! String
                        self.lblCity.text = cityKey
                        
                        let town = data["job_town"] as! NSDictionary
                        let townKey = town["key"] as! String
                        self.lblTown.text = townKey
                        
                        self.nokri_dropDownSetup()
                        self.tableViewJobs.reloadData()
                        
                    }else{
                        let hud = JGProgressHUD(style: .dark)
                        hud.textLabel.text = messageResponse
                        hud.detailTextLabel.text = nil
                        hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                        hud.position = .bottomCenter
                        hud.show(in: self.view)
                        hud.dismiss(afterDelay: 2.0)

                        //self.view.makeToast(messageResponse, duration: 1.5, position: .center)
                        self.perform(#selector(self.nokri_showBuyPackages), with: nil, afterDelay: 2)
                    }
                    self.stopAnimating()
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
            let jbid = UserDefaults.standard.object(forKey: "jobId")
            let param: [String: Any] = [
                "job_id": jbid!,
                "is_update": jbid!
            ]
            print(param)
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.postJobFromEdit, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    
                    guard let res = response.value else{return}
                    
                    let responseData = res as! NSDictionary
                    let success = responseData["success"] as! Bool
                    let messageResponse = responseData["message"] as! String
                    if success == true{
                        //var lat = ""
                       // var long = ""
                        let data = responseData["data"] as! NSDictionary
                        let job_id = data["job_id"]
                        UserDefaults.standard.set(job_id, forKey: "JobId")
                        print(job_id!)
                        
                        let form = data["job_form"] as? Bool
                        if form == true{
                            print("Default...!")
                        }else{
                            let jobPostCustom = self.storyboard?.instantiateViewController(withIdentifier: "JobPostCustomViewController") as! JobPostCustomViewController
                            self.navigationController?.pushViewController(jobPostCustom, animated: false)
                            self.stopAnimating()
                            return
                        }
                        
                        let location = data["job_location_head"] as! NSDictionary
                        if let loc = location["key"]{
                            self.lblLocationOnMap.text = loc as? String
                        }
                        let setLocation = data["job_loc"] as! NSDictionary
                        if let setLoc = setLocation["key"]{
                            self.txtLocation.placeholder = setLoc as? String
                        }
                        let latitude = data["job_lat"] as! NSDictionary
                        if let lat = latitude["key"]{
                            self.txtLatitude.text = lat as? String
                            self.txtLatitude.placeholder = lat as? String
                            self.lblLat.text = lat as? String
                            lati = (lat as? String)!
                        }
                        if let lat = latitude["value"]{
                            self.txtLatitude.text = lat as? String
                            self.txtLatitude.placeholder = lat as? String
                            //self.lblLat.text = lat as? String
                            lati = (lat as? String)!
                        }
                        
                        let longitude = data["job_long"] as! NSDictionary
                        if let long = longitude["key"]{
                            self.txtLongitude.text = long as? String
                            self.txtLongitude.placeholder = long as? String
                            self.lblLong.text = long as? String
                            longi = (long as? String)!
                        }
                        if let long = longitude["value"]{
                            self.txtLongitude.text = long as? String
                            self.txtLongitude.placeholder = long as? String
                            // self.lblLong.text = long as? String
                            longi = (long as? String)!
                        }
                        
                        if let premiumArray = data["premium_jobs"] as? NSArray {
                            self.nokri_premiumJobParser(premArray: premiumArray)
                        }
                        
                        let jobLocation = data["job_location"] as! NSDictionary
                        let jobLocationKey = jobLocation["key"] as! String
                        self.lblSelectCountryCity.text = jobLocationKey
                        
                        let jobCountry = data["job_country"] as! NSDictionary
                        let jobCountryKey = jobCountry["key"] as! String
                        self.lblCountry.text = jobCountryKey
                        if let countryArr = jobCountry["value"] as? NSArray {
                            self.nokri_countryDataParser(countryArr: countryArr)
                        }
                        
                        let state = data["job_state"] as! NSDictionary
                        let stateKey = state["key"] as! String
                        self.lblState.text = stateKey
                        
                        let city = data["job_city"] as! NSDictionary
                        let cityKey = city["key"] as! String
                        self.lblCity.text = cityKey
                        
                        let town = data["job_town"] as! NSDictionary
                        let townKey = town["key"] as! String
                        self.lblTown.text = townKey
                        
                        self.nokri_dropDownSetup()
                        self.tableViewJobs.reloadData()
                        
                    }else{
                        let hud = JGProgressHUD(style: .dark)
                        hud.textLabel.text = messageResponse
                        hud.detailTextLabel.text = nil
                        hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                        hud.position = .bottomCenter
                        hud.show(in: self.view)
                        hud.dismiss(afterDelay: 2.0)

                        //self.view.makeToast(messageResponse, duration: 1.5, position: .center)
                        self.perform(#selector(self.nokri_showBuyPackages), with: nil, afterDelay: 2)
                    }
                    self.stopAnimating()
            }
        }
    }
    
    func nokri_countryDataParser(countryArr:NSArray){
        self.countryArray.removeAllObjects()
        for item in countryArr{
            self.countryArray.add(item)
        }
    }
    
    func nokri_jobPostData(){
        
        var langCode = UserDefaults.standard.string(forKey: "langCode")
        if langCode == nil {
            langCode = "en"
        }
        
        self.showLoader()
        var email = ""
        var password = ""
        var lati = ""
        var longi = ""
        
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
            
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.jobPost, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    
                    guard let res = response.value else{return}
                    
                    let responseData = res as! NSDictionary
                    let success = responseData["success"] as! Bool
                   // let messageResponse = responseData["message"] as! String
                    
                    if success == true{
                        
                        let data = responseData["data"] as! NSDictionary
                        let job_id = data["job_id"]
                        UserDefaults.standard.set(job_id, forKey: "JobId")
                        print(job_id!)
                        
                        let location = data["job_location_head"] as! NSDictionary
                        if let loc = location["key"]{
                            self.lblLocationOnMap.text = loc as? String
                        }
                        let setLocation = data["job_loc"] as! NSDictionary
                        if let setLoc = setLocation["key"]{
                            self.txtLocation.placeholder = setLoc as? String
                        }
                        let latitude = data["job_lat"] as! NSDictionary
                        if let lat = latitude["key"]{
                            self.txtLatitude.text = lat as? String
                            self.txtLatitude.placeholder = lat as? String
                            self.lblLat.text = lat as? String
                            lati = (lat as? String)!
                        }
                        
                        let longitude = data["job_long"] as! NSDictionary
                        if let long = longitude["key"]{
                            self.txtLongitude.text = long as? String
                            self.txtLongitude.placeholder = long as? String
                            self.lblLong.text = long as? String
                            longi = (long as? String)!
                        }
                        
                        let job_boost = data["job_boost"] as! NSDictionary
                        if let jobBost = job_boost["key"]{
                            self.lblBoostJob.text = jobBost as? String
                        }
                        
                        if let premiumArray = data["premium_jobs"] as? NSArray {
                            self.nokri_premiumJobParser(premArray: premiumArray)
                        }
                        
                        let jobLocation = data["job_location"] as! NSDictionary
                        let jobLocationKey = jobLocation["key"] as! String
                        self.lblSelectCountryCity.text = jobLocationKey
                        
                        let jobCountry = data["job_country"] as! NSDictionary
                        let jobCountryKey = jobCountry["key"] as! String
                        self.lblCountry.text = jobCountryKey
                        if let countryArr = jobCountry["value"] as? NSArray {
                            self.nokri_countryDataParser(countryArr: countryArr)
                        }
                        
                        let state = data["job_state"] as! NSDictionary
                        let stateKey = state["key"] as! String
                        self.lblState.text = stateKey
                        
                        let city = data["job_city"] as! NSDictionary
                        let cityKey = city["key"] as! String
                        self.lblCity.text = cityKey
                        
                        let town = data["job_town"] as! NSDictionary
                        let townKey = town["key"] as! String
                        self.lblTown.text = townKey
                        
                        self.nokri_dropDownSetup()
                        self.tableViewJobs.reloadData()
                        
                    }else{
                    }
                    self.stopAnimating()
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
            
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.jobPost, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    
                    guard let res = response.value else{return}
                    
                    let responseData = res as! NSDictionary
                    let success = responseData["success"] as! Bool
                    //let messageResponse = responseData["message"] as! String
                    
                    if success == true{
                        
                        let data = responseData["data"] as! NSDictionary
                        let job_id = data["job_id"]
                        UserDefaults.standard.set(job_id, forKey: "JobId")
                        print(job_id!)
                        
                        let location = data["job_location_head"] as! NSDictionary
                        if let loc = location["key"]{
                            self.lblLocationOnMap.text = loc as? String
                            
                        }
                        let setLocation = data["job_loc"] as! NSDictionary
                        if let setLoc = setLocation["key"]{
                            self.txtLocation.placeholder = setLoc as? String
                            
                        }
                        let latitude = data["job_lat"] as! NSDictionary
                        if let lat = latitude["key"]{
                            self.txtLatitude.text = lat as? String
                            self.txtLatitude.placeholder = lat as? String
                            self.lblLat.text = lat as? String
                            lati = (lat as? String)!
                        }
                        let longitude = data["job_long"] as! NSDictionary
                        if let long = longitude["key"]{
                            self.txtLongitude.text = long as? String
                            self.txtLongitude.placeholder = long as? String
                            self.lblLong.text = long as? String
                            longi = (long as? String)!
                        }
                        
                        let job_boost = data["job_boost"] as! NSDictionary
                        if job_boost["key"] != nil{
                            //self.lblBoostJob.text = jobBost as? String
                        }
                        
                        if let premiumArray = data["premium_jobs"] as? NSArray {
                            self.nokri_premiumJobParser(premArray: premiumArray)
                        }
                        
                        let jobLocation = data["job_location"] as! NSDictionary
                        let jobLocationKey = jobLocation["key"] as! String
                        self.lblSelectCountryCity.text = jobLocationKey
                        
                        let jobCountry = data["job_country"] as! NSDictionary
                        let jobCountryKey = jobCountry["key"] as! String
                        self.lblCountry.text = jobCountryKey
                        if let countryArr = jobCountry["value"] as? NSArray {
                            self.nokri_countryDataParser(countryArr: countryArr)
                        }
                        
                        let state = data["job_state"] as! NSDictionary
                        let stateKey = state["key"] as! String
                        self.lblState.text = stateKey
                        
                        let city = data["job_city"] as! NSDictionary
                        let cityKey = city["key"] as! String
                        self.lblCity.text = cityKey
                        
                        let town = data["job_town"] as! NSDictionary
                        let townKey = town["key"] as! String
                        self.lblTown.text = townKey
                        
                        self.nokri_dropDownSetup()
                        self.heightConstraintCollectionView.constant = self.collectionView.contentSize.height
                        self.collectionView.reloadData()
                        
                    }else{
                    }
                    self.stopAnimating()
            }
        }
    }
    
    func nokri_premiumJobParser(premArray:NSArray){
        
        self.premiumArray.removeAllObjects()
        for item in premArray{
            self.premiumArray.add(item)
            func nokri_countryDataParser(countryArr:NSArray){
                
                self.countryArray.removeAllObjects()
                for item in countryArr{
                    self.countryArray.add(item)
                }
            }
        }
    }
    
    func nokri_jobPostDataEdit(){
        
        var langCode = UserDefaults.standard.string(forKey: "langCode")
        if langCode == nil {
            langCode = "en"
        }
        
        let jbid = UserDefaults.standard.string(forKey: "jbId")
        
        self.showLoader()
        var email = ""
        var password = ""
        var lati = ""
        var longi = ""
        
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
            
            let param: [String: Any] = [
                "job_id":jbid!,
                "is_update":jbid!
            ]
            
            print(param)
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.postJobFromEdit, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    
                    
                    guard let res = response.value else{return}
                    
                    let responseData = res as! NSDictionary
                    let success = responseData["success"] as! Bool
                    //let messageResponse = responseData["message"] as! String
                    
                    if success == true{
                        
                        let data = responseData["data"] as! NSDictionary
                        let job_id = data["job_id"]
                        UserDefaults.standard.set(job_id, forKey: "JobId")
                        print(job_id!)
                        
                        let location = data["job_location_head"] as! NSDictionary
                        if let loc = location["key"]{
                            self.lblLocationOnMap.text = loc as? String
                        }
                        let setLocation = data["job_loc"] as! NSDictionary
                        if let setLoc = setLocation["key"]{
                            self.txtLocation.placeholder = setLoc as? String
                        }
                        if let setLocVal = setLocation["value"]{
                            self.txtLocation.text = setLocVal as? String
                        }
                        let latitude = data["job_lat"] as! NSDictionary
                        if let lat = latitude["key"]{
                            self.txtLatitude.text = lat as? String
                            self.txtLatitude.placeholder = lat as? String
                            self.lblLat.text = lat as? String
                            lati = (lat as? String)!
                        }
                        if let latVal = latitude["value"]{
                            self.txtLatitude.text = latVal as? String
                            self.txtLatitude.placeholder = latVal as? String
                           // self.lblLat.text = latVal as? String
                            lati = (latVal as? String)!
                        }
                        
                        let longitude = data["job_long"] as! NSDictionary
                        if let long = longitude["key"]{
                            self.txtLongitude.text = long as? String
                            self.txtLongitude.placeholder = long as? String
                            self.lblLong.text = long as? String
                            longi = (long as? String)!
                        }
                        if let longVal = longitude["value"]{
                            self.txtLongitude.text = longVal as? String
                            self.txtLongitude.placeholder = longVal as? String
                           // self.lblLong.text = longVal as? String
                            longi = (longVal as? String)!
                        }
                        
                        let job_boost = data["job_boost"] as! NSDictionary
                        if let jobBost = job_boost["key"]{
                            self.lblBoostJob.text = jobBost as? String
                        }
                        
                        if let premiumArray = data["premium_jobs"] as? NSArray {
                            self.nokri_premiumJobParser(premArray: premiumArray)
                        }
                        
                        let jobLocation = data["job_location"] as! NSDictionary
                        let jobLocationKey = jobLocation["key"] as! String
                        self.lblSelectCountryCity.text = jobLocationKey
                        
                        let jobCountry = data["job_country"] as! NSDictionary
                        let jobCountryKey = jobCountry["key"] as! String
                        self.lblCountry.text = jobCountryKey
                        if let countryArr = jobCountry["value"] as? NSArray {
                            self.nokri_countryDataParser(countryArr: countryArr)
                        }
                        
                        let state = data["job_state"] as! NSDictionary
                        let stateKey = state["key"] as! String
                        self.lblState.text = stateKey
                        
                        let city = data["job_city"] as! NSDictionary
                        let cityKey = city["key"] as! String
                        self.lblCity.text = cityKey
                        
                        let town = data["job_town"] as! NSDictionary
                        let townKey = town["key"] as! String
                        self.lblTown.text = townKey
                        
                        self.nokri_dropDownSetup()
                        self.tableViewJobs.reloadData()
                        
                    }else{
                    }
                    self.stopAnimating()
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
            
            let param: [String: Any] = [
                "job_id":jbid!,
                "is_update":jbid!
            ]
            
            print(param)
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.postJobFromEdit, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    
                    guard let res = response.value else{return}
                    
                    let responseData = res as! NSDictionary

                    let success = responseData["success"] as! Bool
                   // let messageResponse = responseData["message"] as! String
                    
                    if success == true{
                        
                        let data = responseData["data"] as! NSDictionary
                        let job_id = data["job_id"]
                        UserDefaults.standard.set(job_id, forKey: "JobId")
                        print(job_id!)
                        
                        let location = data["job_location_head"] as! NSDictionary
                        if let loc = location["key"]{
                            self.lblLocationOnMap.text = loc as? String
                            
                        }
                        let setLocation = data["job_loc"] as! NSDictionary
                        if let setLoc = setLocation["key"]{
                            self.txtLocation.placeholder = setLoc as? String
                        }
                        if let setLocVal = setLocation["value"]{
                            self.txtLocation.text = setLocVal as? String
                        }
                        let latitude = data["job_lat"] as! NSDictionary
                        if let lat = latitude["key"]{
                            self.txtLatitude.text = lat as? String
                            self.txtLatitude.placeholder = lat as? String
                            self.lblLat.text = lat as? String
                            lati = (lat as? String)!
                        }
                        if let latVal = latitude["value"]{
                            self.txtLatitude.text = latVal as? String
                            self.txtLatitude.placeholder = latVal as? String
                           // self.lblLat.text = latVal as? String
                            lati = (latVal as? String)!
                        }
                        
                        let longitude = data["job_long"] as! NSDictionary
                        if let long = longitude["key"]{
                            self.txtLongitude.text = long as? String
                            self.txtLongitude.placeholder = long as? String
                            self.lblLong.text = long as? String
                            longi = (long as? String)!
                        }
                        if let longVal = longitude["value"]{
                            self.txtLongitude.text = longVal as? String
                            self.txtLongitude.placeholder = longVal as? String
                           // self.lblLong.text = longVal as? String
                            longi = (longVal as? String)!
                        }
                        
                        let job_boost = data["job_boost"] as! NSDictionary
                        if job_boost["key"] != nil{
                            //self.lblBoostJob.text = jobBost as? String
                        }
                        
                        if let premiumArray = data["premium_jobs"] as? NSArray {
                            self.nokri_premiumJobParser(premArray: premiumArray)
                        }
                        
                        let jobLocation = data["job_location"] as! NSDictionary
                        let jobLocationKey = jobLocation["key"] as! String
                        self.lblSelectCountryCity.text = jobLocationKey
                        
                        let jobCountry = data["job_country"] as! NSDictionary
                        let jobCountryKey = jobCountry["key"] as! String
                        self.lblCountry.text = jobCountryKey
                        if let countryArr = jobCountry["value"] as? NSArray {
                            self.nokri_countryDataParser(countryArr: countryArr)
                        }
                        
                        let state = data["job_state"] as! NSDictionary
                        let stateKey = state["key"] as! String
                        self.lblState.text = stateKey
                        
                        let city = data["job_city"] as! NSDictionary
                        let cityKey = city["key"] as! String
                        self.lblCity.text = cityKey
                        
                        let town = data["job_town"] as! NSDictionary
                        let townKey = town["key"] as! String
                        self.lblTown.text = townKey
                        
                        self.nokri_dropDownSetup()
                        self.heightConstraintCollectionView.constant = self.collectionView.contentSize.height
                        self.collectionView.reloadData()
                        
                    }else{
                    }
                    self.stopAnimating()
            }
        }
    }
    
    
    
    
    
    @objc func nokri_showBuyPackages(){
        let buyPkgController = self.storyboard?.instantiateViewController(withIdentifier: "PackagesViewController") as! PackagesViewController
        self.navigationController?.pushViewController(buyPkgController, animated: true)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return premiumArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LocationPremCollectionViewCell", for: indexPath) as! LocationPremCollectionViewCell
        
        
        let filterArr = self.premiumArray as? [NSDictionary]
        for itemDict in filterArr! {
            if let keyObj = itemDict["key"] as? String{
                premiumKeyArr.append(keyObj)
            }
            if let valueObj = itemDict["value"] as? String{
                premiumValueArr.append(valueObj)
            }
            if let fieldObj = itemDict["fieldname"] as? String{
                premiumRemainigArr.append(fieldObj)
            }
//            if let fieldObj = itemDict["is_required"] as? Bool{
//
//            }
        }
        
        cell.lblTitle.text = premiumKeyArr[indexPath.row]
        cell.lblRemaining.text = "\(premiumValueArr[indexPath.row] + " " + premiumRemainigArr[indexPath.row])"
        
        if indexPath.row % 2 == 0{
            cell.viewBg.backgroundColor = UIColor(hex:"EFEFF4")
        }else{
            cell.viewBg.backgroundColor = UIColor.white
        }
        cell.lblValue.text =  premiumValueArr[indexPath.row]
        cell.btnCheckBox.tag = indexPath.row
        cell.btnCheckBox.addTarget(self, action: #selector(nokri_btnCheckBoxClicked(_:)), for: .touchUpInside)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let kWhateverHeightYouWant = 100
        return CGSize(width: collectionView.bounds.size.width, height: CGFloat(kWhateverHeightYouWant))
    }
    
    @objc func nokri_btnCheckBoxClicked(_ sender:UICheckbox){
        
        print(sender.tag)
        
        let filterArr = self.premiumArray as? [NSDictionary]
        for itemDict in filterArr! {
            if let keyObj = itemDict["key"] as? String{
                premiumKeyArr.append(keyObj)
                
            }
            if let valueObj = itemDict["value"] as? String{
                premiumValueArr.append(valueObj)
            }
            if let fieldObj = itemDict["fieldname"] as? String{
                premiumRemainigArr.append(fieldObj)
            }
            
        }
        //cell.lblTitle.text = premiumKeyArr[indexPath.row]
        print("\(premiumValueArr[sender.tag])")
        packagesValueArr.append(premiumValueArr[sender.tag])
    }
    
    
    @IBAction func btnJobPostClicked(_ sender: UIButton) {
        
        let cotKey = UserDefaults.standard.integer(forKey: "coKey")
        let cot2Key = UserDefaults.standard.integer(forKey: "co2Key")
        let cot3Key = UserDefaults.standard.integer(forKey: "co3Key")
        let cot4Key = UserDefaults.standard.integer(forKey: "co4Key")
        
        let id = UserDefaults.standard.string(forKey: "JobId")
        print("Id Is: \(String(describing: id))")
        
        var parameter: [String: Any] = [
            "job_id" : id!,
            "is_update": id!,
            "job_cat" :jobCat,
            "job_title": jobTitle,
            "job_description": descriptionValue,
            "job_date": deadLineVal,
            "job_country": cotKey,
            "job_cities": cot2Key,
            "job_states": cot3Key,
            "job_town":cot4Key,
            "job_address": txtLocation.text!,
            "job_lat": txtLatitude.text!,
            "job_long": txtLongitude.text!,
            "class_type_value": packagesValueArr
        ]
        print(parameter)
        
        for ob in customArray{
            customDictionary[ob.fieldTypeName] = ob.fieldVal
        }
        
        print(customDictionary)
        let custom = Constants.json(from: customDictionary)
        print(custom! )
        let param: [String: Any] = ["custom_fields": custom!]
        parameter.merge(with: param)
        print(param)
        print(parameter)
        nokri_joPost(parameter: parameter as NSDictionary)
    }
    
    func nokri_joPost(parameter: NSDictionary) {
        self.showLoader()
        UserHandler.nokri_PostJob(parameter: parameter as NSDictionary, success: { (successResponse) in
            self.stopAnimating()
            if successResponse.success == true{
                let hud = JGProgressHUD(style: .dark)
                hud.textLabel.text = successResponse.message
                hud.detailTextLabel.text = nil
                hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                hud.position = .bottomCenter
                hud.show(in: self.view)
                hud.dismiss(afterDelay: 2.0)
                self.perform(#selector(self.nokri_showJobDetail), with: nil, afterDelay: 2)
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
    
    @objc func nokri_showJobDetail(){
        
        let jobId = UserDefaults.standard.string(forKey: "JobId")
        
        
        print("Job id: \(String(describing: jobId))" )
        
        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "JobDetailViewController") as! JobDetailViewController
        
        if let quantity = jobId as? NSNumber {
            // let totalfup = Int(( jobIdNew as! NSString).floatValue)
            nextViewController.jobId =  Int(truncating: quantity) //Int(totalfup)
            nextViewController.isFromAllJob = false
            //isFromLocation = false
            nextViewController.isfromJobPost = true
            self.navigationController?.pushViewController(nextViewController, animated: true)
            
        }
        else if let quantity = jobId  as? String{
            //let totalfup = Int(( jobIdNew as! NSString).floatValue)
            
            nextViewController.jobId =  Int(quantity)!  //Int(totalfup)
            nextViewController.isFromAllJob = false
           // isFromLocation = false
            nextViewController.isfromJobPost = true
            self.navigationController?.pushViewController(nextViewController, animated: true)
            
        }
         UserDefaults.standard.set(false, forKey: "isFromNoti")
    }
    
}
