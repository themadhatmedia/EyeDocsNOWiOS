
//
//  DashboardCompanyViewController.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 4/12/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import Alamofire
import GoogleMobileAds
import JGProgressHUD


class DashboardCompanyViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,GADBannerViewDelegate,SwiftyAdDelegate {
    
    //MARK:- IBOutlets
    
    @IBOutlet weak var tableView: UITableView!{
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.showsVerticalScrollIndicator = false
            tableView.addSubview(refreshControl)
        }
    }
    @IBOutlet weak var heightConstraintBanner: NSLayoutConstraint!
    @IBOutlet weak var adBannerView: GADBannerView!
    @IBOutlet weak var bannerViewBottom: GADBannerView!
    @IBOutlet weak var heightConstraintBottomBanner: NSLayoutConstraint!
    
    //MARK:- Proporties
    
    var interstitial: GADInterstitial!
    var appColorNew = UserDefaults.standard.string(forKey: "app_Color")
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var dataArray = [CandidateDashboardInfo]()
    var extraArr = [CandidateDashboardExtra]()
    var dataArraySkills = [CandidateDashboardSkill]()
    var sampleArray = [Int]()
    var keyArr = [String]()
    var valArr = [String]()
    var infoArray = NSMutableArray()
    var extraArray = NSMutableArray()
    var location:String?
    var dashboard:String?
    var aboutMe:String?
    var locationMap:String?
    var image:String?
    var latitude:String?
    var longitude:String?
    var latCheck:Bool = true
    var longCheck:Bool = true
    //var social:DashboardSocial?
    var titleDasboard:String?
    var titleAboutCompany:String?
    var titleSkill:String?
    var titleLocation:String?
    var aboutCellHeight : CGFloat = 0.0;
    var message:String?
    var profileImage:String?
    var noAbout:String?
    var isData = false
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(refreshTableView),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor(hex: appColorNew!)
        
        return refreshControl
    }()

    //MARK:- View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        if let userData = UserDefaults.standard.object(forKey: "settingsData") {
            let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
            let dataTabs = SplashRoot(fromDictionary: objData)
            let obj = dataTabs.data.tabs
            self.title = obj?.dashboard
        }
        addLeftBarButtonWithImage(#imageLiteral(resourceName: "menu"))
        nokri_dashboardData()
        showSearchButton()
        //interstitial = GADInterstitial(adUnitID: Constants.AdMob.intersetialId!)
        //let request = GADRequest()
        //request.testDevices = [kGADSimulatorID]
        //interstitial.load(request)
        //self.perform(#selector(self.nokri_adMob), with: nil, afterDelay: 7.5)
        nokri_adMob()
        
    }
    
    @objc func refreshTableView() {
        isData = true
        nokri_dashboardData()
    }

    //MARK:- AdMob Delegate Methods
    
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        print("Banner loaded successfully")
        let translateTransform = CGAffineTransform(translationX: 0, y: -bannerView.bounds.size.height)
        bannerView.transform = translateTransform
        
        UIView.animate(withDuration: 0.5) {
            bannerView.transform = CGAffineTransform.identity
        }
        if UserHandler.sharedInstance.objSaplash?.adMob != nil {
            let objData = UserHandler.sharedInstance.objSaplash?.adMob
            var isShowAd = false
            if let adShow = objData?.show {
                isShowAd = adShow
            }
            isShowAd = true
            if isShowAd {
                
                SwiftyAd.shared.delegate = self
                var isShowBanner = false
                var isShowInterstital = false
                if let banner = objData?.is_show_banner {
                    isShowBanner = banner
                }
                if let intersitial = objData?.is_show_initial {
                    isShowInterstital = intersitial
                }
                if isShowBanner {
                    //print(objData?.banner_id!)
                    SwiftyAd.shared.setup(withBannerID: (objData?.banner_id)!, interstitialID: "", rewardedVideoID: "")
                    self.tableView.translatesAutoresizingMaskIntoConstraints = false
                    if objData?.position == "top" {
                        heightConstraintBanner.constant = 65
                        heightConstraintBottomBanner.constant = 0
                        //tableView.tableHeaderView?.frame = bannerView.frame
                        //tableView.tableHeaderView = bannerView
                    }
                    else {
                        heightConstraintBottomBanner.constant = 65
                        heightConstraintBanner.constant = 0
                        //tableView.tableFooterView?.frame = bannerView.frame
                        //tableView.tableFooterView = bannerView
                    }
                }
                if isShowInterstital {
                    SwiftyAd.shared.setup(withBannerID: "", interstitialID: (objData?.ad_id)!, rewardedVideoID: "")
                    SwiftyAd.shared.showInterstitial(from: self)
                }
            }
        }
    }
  
    func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
        print("Fail to receive ads")
        print(error)
    }
    
    func swiftyAdDidOpen(_ swiftyAd: SwiftyAd) {
        print("Open")
    }
    
    func swiftyAdDidClose(_ swiftyAd: SwiftyAd) {
        print("Close")
    }
    
    func swiftyAd(_ swiftyAd: SwiftyAd, didRewardUserWithAmount rewardAmount: Int) {
        print(rewardAmount)
    }
    
    //MARK:- Custome Functions
    
  func nokri_ltrRtl(){
        let isRtl = UserDefaults.standard.string(forKey: "isRtl")
        if isRtl == "0"{
            self.addLeftBarButtonWithImage(#imageLiteral(resourceName: "menu"))
        }else{
            self.addRightBarButtonWithImage(#imageLiteral(resourceName: "menu"))
        }
    }
    
    @objc func nokri_adMob(){
        heightConstraintBanner.constant = 0
        heightConstraintBottomBanner.constant = 0
        if UserHandler.sharedInstance.objSaplash?.adMob != nil {
            let objData = UserHandler.sharedInstance.objSaplash?.adMob
            var isShowAd = false
            if let adShow = objData?.show {
                isShowAd = adShow
            }
            //isShowAd = false
            if isShowAd == true {
                let objData = UserHandler.sharedInstance.objSaplash?.adMob
                let req = GADRequest()
                //adBannerView = GADBannerView(adSize: kGADAdSizeSmartBannerPortrait)
                adBannerView?.adUnitID = objData?.banner_id
                adBannerView?.delegate = self
                adBannerView?.rootViewController = self
                adBannerView!.load(req)
                bannerViewBottom?.adUnitID = objData?.banner_id
                bannerViewBottom?.delegate = self
                bannerViewBottom?.rootViewController = self
                bannerViewBottom!.load(req)
                SwiftyAd.shared.delegate = self
                var isShowBanner = false
                var isShowInterstital = false
                if let banner = objData?.is_show_banner {
                    isShowBanner = banner
                }
                if let intersitial = objData?.is_show_initial {
                    isShowInterstital = intersitial
                }
                if isShowBanner {
                    //print(objData?.banner_id!)
                    SwiftyAd.shared.setup(withBannerID: (objData?.banner_id)!, interstitialID: "", rewardedVideoID: "")
                    self.tableView.translatesAutoresizingMaskIntoConstraints = false
                    
                }
                if objData?.position == "top"{
                    heightConstraintBottomBanner.constant = 0
                    heightConstraintBanner.constant = 65
                }else{
                    heightConstraintBanner.constant = 0
                    heightConstraintBottomBanner.constant = 65
                }
                if isShowInterstital {
                    if interstitial.isReady {
                        interstitial.present(fromRootViewController: self)
                    } else {
                        print("Ad wasn't ready")
                    }
                }
            }else{
                heightConstraintBanner.constant = 0
                heightConstraintBottomBanner.constant = 0
            }
        }
    }
    
    func nokri_populateData() {
        
        if isData == true{
            self.infoArray.removeAllObjects()
            print(self.infoArray)
        }
        
        let selectedActiveJob = self.infoArray as? [NSDictionary];
        for itemDict in selectedActiveJob! {
            let innerDict = itemDict ;
            if let field_type_name = innerDict["field_type_name"] as? String{
                
                if field_type_name == "cand_email" {
                    if let value = innerDict["value"] as? String {
                        if value != ""{
                            valArr.append(value)
                            if let key = innerDict["key"] as? String {
                                if key != ""{
                                    keyArr.append(key)
                                }
                            }
                        }
                    }
                }
                if field_type_name == "cand_phone" {
                    if let value = innerDict["value"] as? String {
                        if value != ""{
                            valArr.append(value)
                            if let key = innerDict["key"] as? String {
                                if key != ""{
                                    keyArr.append(key)
                                }
                            }
                        }
                    }
                }
                if field_type_name == "cand_rgstr" {
                    if let value = innerDict["value"] as? String {
                        if value != ""{
                            valArr.append(value)
                            if let key = innerDict["key"] as? String {
                                if key != ""{
                                    keyArr.append(key)
                                }
                            }
                        }
                    }
                }
                if field_type_name == "cand_dob" {
                    if let value = innerDict["value"] as? String {
                        if value != ""{
                            valArr.append(value)
                            if let key = innerDict["key"] as? String {
                                if key != ""{
                                    keyArr.append(key)
                                }
                            }
                        }
                    }
                }
                if field_type_name == "last_esdu" {
                    if let value = innerDict["value"] as? String {
                        if value != ""{
                            valArr.append(value)
                            if let key = innerDict["key"] as? String {
                                if key != ""{
                                    keyArr.append(key)
                                }
                            }
                        }
                    }
                }
                if field_type_name == "cand_type" {
                    if let value = innerDict["value"] as? String {
                        if value != ""{
                            valArr.append(value)
                            if let key = innerDict["key"] as? String {
                                if key != ""{
                                    keyArr.append(key)
                                }
                            }
                        }
                    }
                }
                if field_type_name == "cand_level" {
                    if let value = innerDict["value"] as? String {
                        if value != ""{
                            valArr.append(value)
                            if let key = innerDict["key"] as? String {
                                if key != ""{
                                    keyArr.append(key)
                                }
                            }
                        }
                    }
                }
                if field_type_name == "cand_experience" {
                    if let value = innerDict["value"] as? String {
                        if value != ""{
                            valArr.append(value)
                            if let key = innerDict["key"] as? String {
                                if key != ""{
                                    keyArr.append(key)
                                }
                            }
                        }
                    }
                }
                if field_type_name == "cand_hand" {
                    if let value = innerDict["value"] as? String {
                        if value != ""{
                            valArr.append(value)
                            if let key = innerDict["key"] as? String {
                                if key != ""{
                                    keyArr.append(key)
                                }
                            }
                        }
                    }
                }
                if field_type_name == "cand_adress" {
                    if let value = innerDict["value"] as? String {
                        if value != ""{
                            valArr.append(value)
                            if let key = innerDict["key"] as? String {
                                if key != ""{
                                    keyArr.append(key)
                                }
                            }
                        }
                    }
                }
            }
            
            for itemDict in selectedActiveJob! {
                let innerDict = itemDict ;
                if let field_type_name = innerDict["field_type_name"] as? String{
                    
                    if field_type_name == "your_dashbord" {
                        
                        if let key = innerDict["key"] as? String {
                            dashboard = key
                        }
                    }
                    if field_type_name == "about_me" {
                        
                        if let key = innerDict["key"] as? String {
                            aboutMe = key
                            
                        }
                    }
                    if field_type_name == "loc" {
                        
                        if let key = innerDict["key"] as? String {
                            location = key
                        }
                    }
                }
            }
        }
        
        let extraArr = self.extraArray as? [NSDictionary];
        for itemDict in extraArr! {
            let innerDict = itemDict ;
            if let field_type_name = innerDict["field_type_name"] as? String{
                
                if field_type_name == "cand_about" {
                    if let value = innerDict["value"] as? String {
                        noAbout = value
                    }
                }
            }
        }
    }
    
    //MARK:- TableView
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else if section == 1{
            return keyArr.count
        }else if section == 2{
            return 1
        }
        else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DashboardCandidateHeaderTableViewCell", for: indexPath) as! DashboardCandidateHeaderTableViewCell
            let selectedActiveJob = self.infoArray as? [NSDictionary];
            for itemDict in selectedActiveJob! {
                let innerDict = itemDict ;
                if let field_type_name = innerDict["field_type_name"] as? String{
                    if field_type_name == "cand_name" {
                        if let value = innerDict["value"] as? String {
                            cell.lblName.text = value
                        }
                    }
                    if field_type_name == "cand_adress" {
                        if let value = innerDict["value"] as? String {
                            cell.lblLocation.text = value
                        }
                    }
                }
            }
            if profileImage != nil{
                cell.imageViewDashboard.sd_setImage(with: URL(string: profileImage!), completed: nil)
                cell.imageViewDashboard.sd_setShowActivityIndicatorView(true)
                cell.imageViewDashboard.sd_setIndicatorStyle(.gray)
            }
            
            return cell
        }
        else if indexPath.section == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "DashboardCandidateInfoTableViewCell", for: indexPath) as! DashboardCandidateInfoTableViewCell
            cell.lblKey.text = keyArr[indexPath.row]
            cell.lblValue.text = valArr[indexPath.row]
            return cell
        }
        else if indexPath.section == 2{
            let cell = tableView.dequeueReusableCell(withIdentifier: "DashboardAboutCandidateTableViewCell", for: indexPath) as! DashboardAboutCandidateTableViewCell
            let selectedActiveJob = self.infoArray as? [NSDictionary];
            for itemDict in selectedActiveJob! {
                let innerDict = itemDict ;
                if let field_type_name = innerDict["field_type_name"] as? String{
                    if field_type_name == "about_me" {
                        if let value = innerDict["value"] as? String {
                            if value != ""{
                                let strokeTextAttributes: [NSAttributedString.Key: Any] = [
                                    .foregroundColor : UIColor.gray,
                                    .font :  UIFont(name:"Open Sans",size:13)!
                                ]
                                let data = value.data(using: String.Encoding.unicode)!
                                let attrStr = try? NSAttributedString(
                                    data: data,
                                    options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html],
                                    documentAttributes: nil)
                                
                                cell.lblAboutCompany.attributedText = NSMutableAttributedString(string: (attrStr?.string)!, attributes: strokeTextAttributes)
                                
                                //print(cell.lblAboutCompany.attributedText)
                                self.aboutCellHeight = (cell.lblAboutCompany.attributedText?.height(withConstrainedWidth: self.view.frame.size.width))!+80;

                            }else{
                                self.aboutCellHeight = 50
                                cell.lblAboutCompany.text = noAbout
                                print(noAbout!)
                            }
                        }
                    }
                }
            }
            return cell
        }
        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DashboardCandidateLocationAndMapTableViewCell", for: indexPath) as! DashboardCandidateLocationAndMapTableViewCell
            var markerDict: [Int: GMSMarker] = [:]
            let zoom: Float = 20
            let selectedActiveJob = self.infoArray as? [NSDictionary];
            for itemDict in selectedActiveJob! {
                let innerDict = itemDict ;
                if let field_type_name = innerDict["field_type_name"] as? String{
                    if field_type_name == "cand_long" {
                        if let value = innerDict["value"] as? String {
                            longitude = value
                            longCheck = false
                        }
                    }
                    if field_type_name == "cand_lat" {
                        if let value = innerDict["value"] as? String {
                            latitude = value
                            latCheck = false
                        }
                    }
                }
            }
            let extraObj = self.extraArray as? [NSDictionary];
            for itemDict in extraObj! {
                let innerDict = itemDict ;
                if let field_type_name = innerDict["field_type_name"] as? String{
                    
                    if field_type_name == "del_acount" {

                    }
                }
            }
            //MARKL:- Map
            
            struct Place {
                let id: Int
                let name: String
                let lat: CLLocationDegrees
                let lng: CLLocationDegrees
                let icon: String
            }
            
            if latCheck == true{
                latitude = ""
                longitude = ""
            }
            let camera = GMSCameraPosition.camera(withLatitude: (latitude! as NSString).doubleValue, longitude: (longitude! as NSString).doubleValue, zoom: zoom)
            cell.mapView.camera = camera
            do {
                if let styleURL = Bundle.main.url(forResource: "style", withExtension: "json") {
                    cell.mapView.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
                } else {
                    NSLog("Unable to find style.json")
                }
            } catch {
                NSLog("One or more of the map styles failed to load. \(error)")
            }
            let places = [
                Place(id: 0, name: "MrMins", lat: (latitude! as NSString).doubleValue, lng: (longitude! as NSString).doubleValue, icon: "i01"),
                ]
            for place in places {
                let marker = GMSMarker()
                marker.position = CLLocationCoordinate2D(latitude: place.lat, longitude: place.lng)
                marker.title = place.name
                marker.snippet = "\(place.name)"
                //marker.icon = self.imageWithImage(image: UIImage(named: place.icon)!, scaledToSize: CGSize(width: 35.0, height: 35.0))
                marker.map = cell.mapView
                markerDict[place.id] = marker
            }
        
            return cell
        }
    }
    /*
    @objc func nokri_btnDeleteAccClicked(_ sender: UIButton){
        let user_id = UserDefaults.standard.integer(forKey: "id")
        print(user_id)
        var confirmString:String?
        var btnOk:String?
        var btnCncel:String?
        if let userData = UserDefaults.standard.object(forKey: "settingsData") {
            let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
            let dataTabs = SplashRoot(fromDictionary: objData)
            confirmString = dataTabs.data.genericTxts.confirm
            btnOk = dataTabs.data.genericTxts.btnConfirm
            btnCncel = dataTabs.data.genericTxts.btnCancel
        }
        let Alert = UIAlertController(title:confirmString, message:"", preferredStyle: .alert)
        let okButton = UIAlertAction(title: btnOk, style: .default) { _ in
            
            let param: [String: Any] = [
                "user_id":user_id
            ]
            print(param)
            self.nokri_deleteAccount(parameter: param as NSDictionary)
        }
        let CancelButton = UIAlertAction(title: btnCncel, style: .cancel)
        Alert.addAction(okButton)
        Alert.addAction(CancelButton)
        self.present(Alert, animated: true, completion: nil)
        
    }*/
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return 235
        }else if (indexPath.section == 1){
            return 45
        }else if indexPath.section == 2{
            return self.aboutCellHeight;
        }
        else{
            return 228
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return ""
        }else if section == 1 {
            return  dashboard
        }else if section == 2{
            return aboutMe
            
        }else{
            return location
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0{
            return 0
        }else{
            return 40
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if tableView.isDragging {
            cell.transform = CGAffineTransform.init(scaleX: 0.5, y: 0.5)
            UIView.animate(withDuration: 0.3, animations: {
                cell.transform = CGAffineTransform.identity
            })
        }
    }
    
    //MARK:- API Calls
    
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
                //                if let intersitial = objData?.is_show_initial {
                //                    isShowInterstital = intersitial
                //                }
                if isShowBanner {
                    SwiftyAd.shared.setup(withBannerID: (objData?.banner_id)!, interstitialID: "", rewardedVideoID: "")
                    self.tableView.translatesAutoresizingMaskIntoConstraints = false
                    if objData?.position == "top" {
                        self.view.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100).isActive = true
                        SwiftyAd.shared.showBanner(from: self, at: .top)
                    }
                    else {
                        self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 60).isActive = true
                        SwiftyAd.shared.showBanner(from: self, at: .bottom)
                    }
                }
                //                if isShowInterstital {
                //                    SwiftyAd.shared.setup(withBannerID: "", interstitialID: (objData?.interstitalId)!, rewardedVideoID: "")
                //                    SwiftyAd.shared.showInterstitial(from: self)
                //                }
            }
        }
    }
    
    
    func nokri_deleteAccount(parameter: NSDictionary) {
        self.showLoader()
        UserHandler.nokri_deleteAccount(parameter: parameter as NSDictionary, success: { (successResponse) in
            self.stopAnimating()
            if successResponse.success == true{
                UserDefaults.standard.set(false, forKey: "isSocial")
                UserDefaults.standard.set("0" , forKey: "id")
                UserDefaults.standard.set(nil , forKey: "email")
                // UserDefaults.standard.set(nil, forKey: "email")
                UserDefaults.standard.set(nil, forKey: "img")
                UserDefaults.standard.set("3" , forKey: "acountTypeafb")
                UserDefaults.standard.set(5, forKey: "aType")
                //self.appDelegate.nokri_moveToHome()
                let isHome = UserDefaults.standard.string(forKey: "home")
                if isHome == "1"{
                    self.appDelegate.nokri_moveToHome1()
                }else{
                    self.appDelegate.nokri_moveToHome2()
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
    
    func nokri_dashboardData(){
        //self.tableView.isHidden = true
        
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
            
            
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.dashboardCandidate, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    
                    guard let res = response.value else{return}
                    let responseData = res as! NSDictionary
                    self.message = responseData["message"] as? String
                    let success = responseData["success"] as! Bool
                    if success == true{
                        self.tableView.isHidden = false
                        isTimeOut = true
                        let data = responseData["data"] as! NSDictionary
                        let profile = data["profile"] as! NSDictionary
                        let innerData = profile["data"] as! NSDictionary
                        self.profileImage = innerData["profile_img"] as? String
                        if let infoArray = innerData["info"] as? NSArray {
                            self.nokri_infoArrayDataParser(infoArr: infoArray)
                        }
                        if let extraArray = innerData["extra"] as? NSArray {
                            self.nokri_extraArrayDataParser(extrArr: extraArray)
                        }
                        self.tableView.delegate = self
                        self.tableView.dataSource = self
                        self.nokri_populateData()
                        self.stopAnimating()
                        self.refreshControl.endRefreshing()
                        self.tableView.reloadData()
                        
                    }else{
                        self.tableView.isHidden = true
                        let alert = Constants.showBasicAlert(message: self.message!)
                        self.present(alert, animated: true, completion: nil)
                        self.stopAnimating()
                    }
                    self.stopAnimating()
                    if isTimeOut == false{
                        DispatchQueue.main.asyncAfter(deadline: .now() + 30) {
                            self.stopAnimating()
                            let hud = JGProgressHUD(style: .dark)
                            hud.textLabel.text = "Network time out"
                            hud.detailTextLabel.text = nil
                            hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                            hud.position = .bottomCenter
                            hud.show(in: self.view)
                            hud.dismiss(afterDelay: 2.0)
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
            
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.dashboardCandidate, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers)
                .responseJSON { response in
                    
                    guard let res = response.value else{return}
                    let responseData = res as! NSDictionary
                    self.message = responseData["message"] as? String
                    let success = responseData["success"] as! Bool
                    if success == true{
                        self.tableView.isHidden = false
                        isTimeOut = true
                        let data = responseData["data"] as! NSDictionary
                        let profile = data["profile"] as! NSDictionary
                        let innerData = profile["data"] as! NSDictionary
                        self.profileImage = innerData["profile_img"] as? String
                        if let infoArray = innerData["info"] as? NSArray {
                            self.nokri_infoArrayDataParser(infoArr: infoArray)
                        }
                        if let extraArray = innerData["extra"] as? NSArray {
                            self.nokri_extraArrayDataParser(extrArr: extraArray)
                        }
                        self.tableView.delegate = self
                        self.tableView.dataSource = self
                        self.nokri_populateData()
                        self.stopAnimating()
                        self.refreshControl.endRefreshing()
                        self.tableView.reloadData()
                        
                    }else{
                        self.tableView.isHidden = true
                        let alert = Constants.showBasicAlert(message: self.message!)
                        self.present(alert, animated: true, completion: nil)
                        self.stopAnimating()
                    }
                    self.refreshControl.endRefreshing()
                    self.stopAnimating()
                    if isTimeOut == false{
                        DispatchQueue.main.asyncAfter(deadline: .now() + 30) {
                            self.stopAnimating()
                            let hud = JGProgressHUD(style: .dark)
                            hud.textLabel.text = "Network time out"
                            hud.detailTextLabel.text = nil
                            hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                            hud.position = .bottomCenter
                            hud.show(in: self.view)
                            hud.dismiss(afterDelay: 2.0)
                        }
                    }
            }
        }
    }
    
    func nokri_infoArrayDataParser(infoArr:NSArray){
        self.infoArray.removeAllObjects()
        for item in infoArr{
            self.infoArray.add(item)
        }
    }
    
    func nokri_extraArrayDataParser(extrArr:NSArray){
        self.extraArray.removeAllObjects()
        for item in extrArr{
            self.extraArray.add(item)
        }
    }
    
}
