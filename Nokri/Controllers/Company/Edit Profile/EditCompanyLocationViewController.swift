//
//  EditCompanyLocationViewController.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 4/17/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import JGProgressHUD
import Alamofire

class EditCompanyLocationViewController: UIViewController,GMSMapViewDelegate,GMSAutocompleteViewControllerDelegate,CLLocationManagerDelegate,UITextFieldDelegate {
    
    //MARK:- IBOutlets
    
    @IBOutlet weak var viewTop: UIView!
    @IBOutlet weak var txtLocation: UITextField!
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var txtLatitude: UITextField!
    @IBOutlet weak var txtLongitude: UITextField!
    @IBOutlet weak var btnSaveLocation: UIButton!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblLat: UILabel!
    @IBOutlet weak var lblLong: UILabel!
    @IBOutlet weak var lblStepNo: UILabel!
    @IBOutlet weak var viewCountry: UIView!
    @IBOutlet weak var lblCountryKey: UILabel!
    @IBOutlet weak var lblCountryValue: UILabel!
    @IBOutlet weak var btnCountry: UIButton!
    
    //MARK:- Proporties
    
    var appColorNew = UserDefaults.standard.string(forKey: "app_Color")
    var markerDict: [Int: GMSMarker] = [:]
    var locationManager = CLLocationManager()
    var locationDataArray = [LocationData]()
    var locationExtraArray = [LocationExtra]()
    var locationCheck:Bool = true
    var countryArray = NSMutableArray()
    var stateArray = NSMutableArray()
    var cityArray = NSMutableArray()
    var townArray = NSMutableArray()
    var mapHide = UserDefaults.standard.bool(forKey: "candMap")
    
    //MARK:- View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nokri_customeButton()
        nokri_locationData()
        nokri_locationManag()
        nokri_textFieldAddBorder()
        mapView.delegate = self
        self.btnSaveLocation.layer.borderColor = UIColor(hex:appColorNew!).cgColor
        self.viewTop.backgroundColor = UIColor(hex: appColorNew!)
        if let userData = UserDefaults.standard.object(forKey: "settingsData") {
            let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
            let dataTabs = SplashRoot(fromDictionary: objData)
            let obj = dataTabs.data.empEditTabs
            self.lblStepNo.text = obj?.loc
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        textFieldUpdateBottomBorderSize()
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

        if cotKey != 0{
            btnCountry.tag = cotKey
            self.lblCountryValue.text = cotName
        }
        if cot2Key != 0{
            //btnCountry.tag = cotKey
            self.lblCountryValue.text = cot2Name
        }
        if cot3Key != 0{
            //btnCountry.tag = cotKey
            self.lblCountryValue.text = cot3Name
        }
        if cot4Key != 0{
            //btnCountry.tag = cotKey
            self.lblCountryValue.text = cot4Name
        }
        
    }

    //MARK:- IBActions
    
    @IBAction func txtLocatonClicked(_ sender: UITextField) {
        let autoComplete = GMSAutocompleteViewController()
        autoComplete.delegate = self
        autoComplete.primaryTextHighlightColor = UIColor(hex:"FFC400")
        self.locationManager.startUpdatingLocation()
        self.present(autoComplete, animated: true, completion: nil)
    }
    
    @IBAction func txtLatClicked(_ sender: UITextField) {
    }
    
    @IBAction func txtLongClicked(_ sender: UITextField) {
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
      
    @IBAction func btnSaveLocationClicked(_ sender: UIButton) {
        
        let cotKey = UserDefaults.standard.integer(forKey: "coKey")
        let cot2Key = UserDefaults.standard.integer(forKey: "co2Key")
        let cot3Key = UserDefaults.standard.integer(forKey: "co3Key")
        let cot4Key = UserDefaults.standard.integer(forKey: "co4Key")
        
        guard let lat = txtLatitude.text else {
            return
        }
        guard let long = txtLongitude.text else {
            return
        }
        guard let location = txtLocation.text else {
            return
        }
        if lat == "" {
            let alert = Constants.showBasicAlert(message: "Please Enter latitude.")
            self.present(alert, animated: true, completion: nil)
        }
        else if long == "" {
            let alert = Constants.showBasicAlert(message: "Please Enter longitude.")
            self.present(alert, animated: true, completion: nil)
        }
        else if location == "" {
            let alert = Constants.showBasicAlert(message: "Please Enter location.")
            self.present(alert, animated: true, completion: nil)
        }
        else{
            let param: [String: Any] = [
                "emp_lat": lat,
                "emp_long": long,
                "emp_loc": location,
                "emp_country":btnCountry.tag,
                "emp_country_states":cot2Key,
                "emp_country_cities":cot3Key,
                "emp_country_towns":cot4Key
            ]
            print(param)
            self.nokri_locationPost(parameter: param as NSDictionary)
        }
    }
    
    //MARK:- Custome Functions
    
    func nokri_customeButton(){
        btnSaveLocation.layer.cornerRadius = 15
        btnSaveLocation.layer.borderWidth = 1
        btnSaveLocation.layer.borderColor = UIColor(hex:appColorNew!).cgColor
        btnSaveLocation.layer.masksToBounds = false
        btnSaveLocation.backgroundColor = UIColor.white
        btnSaveLocation.setTitleColor(UIColor(hex: appColorNew!), for: .normal)
    }
    
    func nokri_locationManag(){
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.startMonitoringSignificantLocationChanges()
    }
    
    func nokri_populateData(){
        var lat:String = ""
        var long:String = ""
        
        for obj in locationDataArray{
            if obj.fieldTypeName == "emp_loc" {
                lblLocation.text = obj.key
                txtLocation.placeholder = obj.key
                txtLocation.text = obj.value
            }
            if obj.fieldTypeName == "emp_lat" {
                lblLat.text = obj.key
                txtLatitude.placeholder = obj.key
                txtLatitude.text = obj.value
                lat = obj.value
            }
            if obj.fieldTypeName == "emp_long" {
                lblLong.text = obj.key
                txtLongitude.placeholder = obj.key
                txtLongitude.text = obj.value
                long = obj.value
            }
        }
        for obj in locationExtraArray{
            if obj.fieldTypeName == "save" {
                btnSaveLocation.setTitle(obj.value, for: .normal)
            }
        }
        nokri_map(lat: lat, long: long)
        
        var countryText = ""
        var stateText = ""
        var cityText = ""
        var townText = ""
        
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
            if let isSelected = itemDict["selected"] as? Bool{
                if isSelected == true{
                    if let catObj = itemDict["value"] as? String{
                        //lblCountryValue.text = catObj
                        countryText = catObj
                    }
                }
            }
        }
        
        var stateArr = [String]()
        var stateChildArr = [Bool]()
        var stateKeyArr = [Int]()
        
        let state = self.stateArray as? [NSDictionary]
        for itemDict in state! {
            if let catObj = itemDict["value"] as? String{
                if catObj == ""{
                    continue
                }
                stateArr.append(catObj)
            }
            if let keyObj = itemDict["key"] as? Int{
                
                stateKeyArr.append(keyObj)
            }
            if let hasChild = itemDict["has_child"] as? Bool{
                print(hasChild)
                
                stateChildArr.append(hasChild)
            }
            if let isSelected = itemDict["selected"] as? Bool{
                if isSelected == true{
                    if let catObj = itemDict["value"] as? String{
                        lblCountryValue.text = catObj
                        stateText = catObj
                    }
                }
            }
        }
        
        var cityArr = [String]()
        var cityChildArr = [Bool]()
        var cityKeyArr = [Int]()
        
        let city = self.cityArray as? [NSDictionary]
        for itemDict in city! {
            if let catObj = itemDict["value"] as? String{
                if catObj == ""{
                    continue
                }
                stateArr.append(catObj)
            }
            if let keyObj = itemDict["key"] as? Int{
                
                cityKeyArr.append(keyObj)
            }
            if let hasChild = itemDict["has_child"] as? Bool{
                print(hasChild)
                
                cityChildArr.append(hasChild)
            }
            if let isSelected = itemDict["selected"] as? Bool{
                if isSelected == true{
                    if let catObj = itemDict["value"] as? String{
                        //lblCountryValue.text = catObj
                        cityText = catObj
                    }
                }
            }
            
        }
        
        var townArr = [String]()
        var townChildArr = [Bool]()
        var townKeyArr = [Int]()
        
        let town = self.townArray as? [NSDictionary]
        for itemDict in town! {
            if let catObj = itemDict["value"] as? String{
                if catObj == ""{
                    continue
                }
                stateArr.append(catObj)
            }
            if let keyObj = itemDict["key"] as? Int{
                
                townKeyArr.append(keyObj)
            }
            if let hasChild = itemDict["has_child"] as? Bool{
                print(hasChild)
                
                townChildArr.append(hasChild)
            }
            if let isSelected = itemDict["selected"] as? Bool{
                if isSelected == true{
                    if let catObj = itemDict["value"] as? String{
                        //lblCountryValue.text = catObj
                        townText = catObj
                    }
                }
            }
        }
        
        
        var txtLocationData = [String]()
        if townText != ""{
             txtLocationData.append(townText)
        }
        if cityText != ""{
            txtLocationData.append(cityText)
        }
        if stateText != ""{
             txtLocationData.append(stateText)
        }
        if countryText != ""{
            txtLocationData.append(countryText)
        }
        let formattedArray = (txtLocationData.map{String($0)}).joined(separator: ",")
        lblCountryValue.text = formattedArray //"\(townText),\(cityText),\(stateText),\(countryText)"
        
    }
    
    //-->> Custome Text Fields
    
    func nokri_textFieldAddBorder(){
        txtLocation.delegate = self
        txtLatitude.delegate = self
        txtLongitude.delegate = self
        txtLocation.nokri_addBottomBorder()
        txtLatitude.nokri_addBottomBorder()
        txtLongitude.nokri_addBottomBorder()
    }
    
    func textFieldUpdateBottomBorderSize(){
        txtLocation.nokri_updateBottomBorderSize()
        txtLatitude.nokri_updateBottomBorderSize()
        txtLongitude.nokri_updateBottomBorderSize()
    }
    
    //MARK:- TextField Delegate
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == txtLocation{
            txtLocation.nokri_updateBottomBorderColor(isTextFieldSelected: true)
        } else {
            txtLocation.nokri_updateBottomBorderColor(isTextFieldSelected: false)
        }
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
    
    // MARK: - Map
    
    struct Place {
        let id: Int
        let name: String
        let lat: CLLocationDegrees
        let lng: CLLocationDegrees
        let icon: String
    }
    
    func nokri_map(lat:String,long:String){
        let camera = GMSCameraPosition.camera(withLatitude: (lat as NSString).doubleValue, longitude: (long as NSString).doubleValue, zoom: 12)
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
        let camera = GMSCameraPosition.camera(withLatitude: (locations?.coordinate.latitude)!, longitude: (locations?.coordinate.longitude)!, zoom: 12.0)
        self.mapView.animate(to: camera)
        self.locationManager.stopUpdatingLocation()
    }
    
    //MARK:- GMSAutocomplete Delegate
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        let camera = GMSCameraPosition.camera(withLatitude: (place.coordinate.latitude), longitude: (place.coordinate.longitude), zoom: 12.0)
                self.mapView.animate(to: camera)
        txtLatitude.text = "\(place.coordinate.latitude)"
        txtLongitude.text = "\(place.coordinate.longitude)"
        txtLocation.text = place.name
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(place.coordinate.latitude, place.coordinate.longitude)
        marker.appearAnimation = GMSMarkerAnimation.pop
        marker.title = place.name
        marker.snippet = place.name
        marker.infoWindowAnchor = CGPoint(x:0.5 , y: 0)
        marker.icon = UIImage(named: "marker")
        marker.map = self.mapView
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
  
    //MARK:- API Calls
    
    func nokri_locationData() {
        
        self.showLoader()
        self.btnSaveLocation.isHidden = true
        self.viewTop.isHidden = true
        UserHandler.nokri_locationData(success: { (successResponse) in
            self.stopAnimating()
            if successResponse.success {
                self.viewTop.isHidden = false
                self.btnSaveLocation.isHidden = false
                self.locationDataArray = successResponse.data
                self.locationExtraArray = successResponse.extras
                self.nokri_jobLoctData()
            }
            else {
                self.btnSaveLocation.isHidden = true
                self.viewTop.isHidden = true
                let alert = Constants.showBasicAlert(message: successResponse.message)
                self.present(alert, animated: true, completion: nil)
            }
        }) { (error) in
            self.btnSaveLocation.isHidden = true
            self.viewTop.isHidden = true
            let alert = Constants.showBasicAlert(message: error.message)
            self.present(alert, animated: true, completion: nil)
            self.stopAnimating()
        }
    }
    
    func nokri_locationPost(parameter: NSDictionary) {
        self.showLoader()
        UserHandler.nokri_locationPost(parameter: parameter as NSDictionary, success: { (successResponse) in
            self.stopAnimating()
            if successResponse.success == true{
                let hud = JGProgressHUD(style: .dark)
                hud.textLabel.text = successResponse.message
                hud.detailTextLabel.text = nil
                hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                hud.position = .bottomCenter
                hud.show(in: self.view)
                hud.dismiss(afterDelay: 2.0)
                self.nokri_locationData()
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
                // var isShowInterstital = false
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
    
    func nokri_jobLoctData(){
        
        var langCode = UserDefaults.standard.string(forKey: "langCode")
        if langCode == nil {
            langCode = "en"
        }
        
        var email = ""
        var password = ""
        
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
            "Nokri-Request-From" : Constants.customCodes.requestFrom
        ]
        Alamofire.request(Constants.URL.baseUrl+Constants.URL.location, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { response in
                
                guard let res = response.value else{return}
                let responseData = res as! NSDictionary
                let success = responseData["success"] as! Bool
                if success == true{
                    let customLocation = responseData["custom_location"] as! NSDictionary
                    let jobCountry = customLocation["job_country"] as! NSDictionary
                    let jobCountryKey = jobCountry["key"] as! String
                    self.lblCountryKey.text = jobCountryKey
                    if let countryArr = jobCountry["value"] as? NSArray {
                        self.nokri_countryDataParser(countryArr: countryArr)
                    }
                    let jobState = customLocation["job_state"] as! NSDictionary
                    let jobStateKey = jobState["key"] as! String
                    //self.lblCountryKey.text = "jobCountryKey"
                    if let stateArr = jobState["value"] as? NSArray {
                        self.nokri_stateDataParser(stateArr: stateArr)
                    }
                    
                    let jobCity = customLocation["job_city"] as! NSDictionary
                    let jobCityKey = jobCity["key"] as! String
                    //self.lblCountryKey.text = jobCountryKey
                    if let cityArr = jobCity["value"] as? NSArray {
                        self.nokri_cityDataParser(cityArr: cityArr)
                    }
                    
                    let jobTown = customLocation["job_town"] as! NSDictionary
                    let jobTownKey = jobTown["key"] as! String
                    //self.lblCountryKey.text = jobCountryKey
                    if let townArr = jobTown["value"] as? NSArray {
                        self.nokri_townDataParser(townArr: townArr)
                    }
                    self.lblCountryKey.text = "\(jobCountryKey),\(jobStateKey),\(jobCityKey),\(jobTownKey)"
                    
                     self.nokri_populateData()
                }else{
                }
                self.stopAnimating()
        }
    }
    
    func nokri_countryDataParser(countryArr:NSArray){
        self.countryArray.removeAllObjects()
        for item in countryArr{
            self.countryArray.add(item)
        }
    }
    
    func nokri_stateDataParser(stateArr:NSArray){
        self.stateArray.removeAllObjects()
        for item in stateArr{
            self.stateArray.add(item)
        }
    }

    func nokri_cityDataParser(cityArr:NSArray){
        self.cityArray.removeAllObjects()
        for item in cityArr{
            self.cityArray.add(item)
        }
    }

    func nokri_townDataParser(townArr:NSArray){
        self.townArray.removeAllObjects()
        for item in townArr{
            self.townArray.add(item)
        }
    }
}
