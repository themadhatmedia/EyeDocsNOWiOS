//
//  DashboarCompanyViewController.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 4/16/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import UIKit
import SDWebImage
import GoogleMaps
import GooglePlaces
import GoogleMobileAds


class DashboarCompanyViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,GMSMapViewDelegate,GADBannerViewDelegate,SwiftyAdDelegate {
    
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
    
    var appColorNew = UserDefaults.standard.string(forKey: "app_Color")
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var dataArray = [DashboardExtra]()
    var extraArr = [DashboardExtra]()
    var dataArrImage = [DashboardImages]()
    var dataArraySkills = [DashboardSkill]()
    var sampleArray = [Int]()
    var keyArr = [String]()
    var valArr = [String]()
    var location:String?
    var dashboard:String?
    var aboutCompany:String?
    var skill:String?
    var locationMap:String?
    var image:String?
    var latitude:String?
    var longitude:String?
    var latCheck:Bool = true
    var social:DashboardSocial?
    var titleDasboard:String?
    var titleAboutCompany:String?
    var titleSkill:String?
    var titleLocation:String?
    var aboutCellHeight : CGFloat = 0.0;
    var skillArrCount = [String]()
    var isSkil:Int = 0
    var skillText = ""
    var deleteAccountText = ""
    var skillCellHeight : CGFloat = 0.0;
    var isData = false
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(refreshTableView),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor(hex: appColorNew!)
        
        return refreshControl
    }()
    var videoUrl = ""
    var titleEmployerVid = ""
    var titlePortfolio = ""
    var mapHide = UserDefaults.standard.bool(forKey: "empMap")
    var interstitial: GADInterstitial!
    
    
    //MARK:- View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //nokri_ltrRtl()
        addLeftBarButtonWithImage(#imageLiteral(resourceName: "menu"))
        tableView.dataSource = self
        tableView.delegate  = self
        if let userData = UserDefaults.standard.object(forKey: "settingsData") {
            let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
            let dataTabs = SplashRoot(fromDictionary: objData)
            let obj = dataTabs.data.tabs.dashboard
            self.title = obj
        }
        nokri_dashboardData()
        showSearchButton()
//        let request = GADRequest()
//        request.testDevices = [kGADSimulatorID]
//        interstitial.load(request)
//        self.perform(#selector(self.nokri_adMob), with: nil, afterDelay: 7.5)
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
              dataArray.removeAll()
        }
        for ab in dataArray{

            if ab.value != "" && ab.value != nil{
                keyArr.append(ab.key)
                valArr.append(ab.value)
                sampleArray.append(dataArray.count)
            }
            
            if ab.fieldTypeName == "your_dashbord"{
                self.titleDasboard = ab.key
            }
            if ab.fieldTypeName == "about_me"{
                self.titleAboutCompany = ab.key
            }
            if ab.fieldTypeName == "loc"{
                self.titleLocation = ab.key
            }
        }
       
        for obj in extraArr{
            if obj.fieldTypeName == "emp_skills"{
                self.titleSkill = obj.value
            }
            if obj.fieldTypeName == "emp_not_skills"{
                isSkil = 1
                skillText = obj.value
            }
            if obj.fieldTypeName == "del_acount"{
                deleteAccountText = obj.value
            }
            if obj.fieldTypeName == "video_url"{
                 videoUrl = obj.value
                titleEmployerVid = obj.key
            }
            if obj.fieldTypeName == "port_text"{
                titlePortfolio = obj.key
            }
            
        }
    }
    
    //MARK:- TableView
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else if section == 1{
            return valArr.count
        }else if section == 2{
            return 1
        }else if section == 3{
            if isSkil == 1{
                return 1
            }else{
                 return dataArraySkills.count
            }
        }else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DashboardCompanyHeaderTableViewCell", for: indexPath) as! DashboardCompanyHeaderTableViewCell
            for ab in dataArray{
                if ab.fieldTypeName == "emp_name"{
                    cell.lblName.text = ab.value
                }
                if ab.fieldTypeName == "emp_adress"{
                    cell.lblLocation.text = ab.value
                }
                if ab.fieldTypeName == "emp_long"{
                    longitude = ab.value!
                    latCheck = false
                }
                if ab.fieldTypeName == "emp_lat"{
                    latitude = ab.value!
                    latCheck = false
                }
                if ab.fieldTypeName == "emp_skills"{
                    self.titleSkill = ab.key
                }
               
                if let imgUrl = URL(string: self.image!) {
                    cell.imageViewDashboard.sd_setImage(with: imgUrl, completed: nil)
                    cell.imageViewDashboard.sd_setShowActivityIndicatorView(true)
                    cell.imageViewDashboard.sd_setIndicatorStyle(.gray)
                }
            }
            for obj in extraArr{
                if obj.fieldTypeName == "change_password"{
                    //cell.btnChangePassword.setTitle(obj.value, for: .normal)
                }
            }
            return cell
        }
        else if indexPath.section == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "DashboardCompanyInfoTableViewCell", for: indexPath) as! DashboardCompanyInfoTableViewCell
            cell.lblKey.text = keyArr[indexPath.row]
            cell.lblValue.text = valArr[indexPath.row]
            
            if valArr[indexPath.row].contains("www.") {
                cell.btnLink.isUserInteractionEnabled = true
                cell.lblValue.textColor = UIColor.blue
                cell.btnLink.titleLabel?.textColor = UIColor.clear
                cell.btnLink.setTitle( cell.lblValue.text, for: .normal)
                cell.btnLink.addTarget(self, action:  #selector(DashboarCompanyViewController.nokri_btnCompanyDetailClicked), for: .touchUpInside)
            }else{
                cell.lblValue.textColor = UIColor.lightGray
                cell.btnLink.isUserInteractionEnabled = false
            }
         
            if indexPath.row == keyArr.count{
                cell.viewSeparator.isHidden = true
            }
            return cell
            
        }
        else if indexPath.section == 2{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "DashboardAboutCompanyTableViewCell", for: indexPath) as! DashboardAboutCompanyTableViewCell
          
            for ab in dataArray{
        
                if ab.fieldTypeName == "about_me"{
                    
                    if ab.value == "" {
                        
                        for obj in extraArr{
                            
                            if obj.fieldTypeName == "emp_about"{
                                let htmlString = obj.value
    
                        
                                let strokeTextAttributes: [NSAttributedString.Key: Any] = [
                                    .foregroundColor : UIColor.gray,
                                    .font : UIFont(name:"Open Sans",size:13)!
                                ]
                                let data = htmlString!.data(using: String.Encoding.unicode)!
                                let attrStr = try? NSAttributedString(
                                    data: data,
                                    options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html],
                                    documentAttributes: nil)
                                
                                cell.lblAbout.attributedText = NSMutableAttributedString(string: (attrStr?.string)!, attributes: strokeTextAttributes)
                                
                                
                                
                                
                               // cell.lblAbout.font = UIFont(name:"Open Sans",size:12)
                                self.aboutCellHeight = (cell.lblAbout.attributedText?.height(withConstrainedWidth: self.view.frame.size.width))!+30;
                            }
                            
                        }
                        
                    }
                    else{
                    
                        let strokeTextAttributes: [NSAttributedString.Key: Any] = [
                            .foregroundColor : UIColor.gray,
                            .font : UIFont(name:"Open Sans",size:13)!
                        ]
                        let data = ab.value.data(using: String.Encoding.unicode)!
                        let attrStr = try? NSAttributedString(
                            data: data,
                            options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html],
                            documentAttributes: nil)
                        
                        cell.lblAbout.attributedText = NSMutableAttributedString(string: (attrStr?.string)!, attributes: strokeTextAttributes)
                        
                        //cell.lblAbout.attributedText = attrStr
                        self.aboutCellHeight = (cell.lblAbout.attributedText?.height(withConstrainedWidth: self.view.frame.size.width))!+16;
                    }
                }
                
            }
        return cell
        }
        else if indexPath.section == 3{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "DasboardSkillsTableViewCell", for: indexPath) as! DasboardSkillsTableViewCell
            if dataArraySkills.isEmpty == true{
                cell.lblSkill.text = skillText
                isSkil = 1
            }else{
                var skill = [String]()
                for obj in dataArraySkills{
                    skill.append(obj.value)
                    //cell.lblSkill.text = obj.value
                }
                print(skill)

                cell.lblSkill.text = skill.joined(separator: ",")
                
                let htmlString = skill.joined(separator: ",")
                // works even without <html><body> </body></html> tags, BTW
                let data = htmlString.data(using: String.Encoding.unicode)! // mind "!"
                let attrStr = try? NSAttributedString( // do catch
                    data: data,
                    options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html],
                    documentAttributes: nil)
                cell.lblSkill.attributedText = attrStr
                
                
                
                self.skillCellHeight = (cell.lblSkill.attributedText?.height(withConstrainedWidth: self.view.frame.size.width))!+16;
                
            }
            return cell
            
        }
        
        else if indexPath.section == 4{
            let cell = tableView.dequeueReusableCell(withIdentifier: "CompanyPortfolioImgTableViewCell", for: indexPath) as! CompanyPortfolioImgTableViewCell
            
            if dataArrImage.count == 0{
                cell.lblNot.isHidden = false
            }else{
                cell.datImgArr = dataArrImage
                cell.collectionView.reloadData()
                 cell.lblNot.isHidden = true
            }
            
            return cell
            
        }
        
        else if indexPath.section == 5{
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyProfileVideoTableViewCell", for: indexPath) as! MyProfileVideoTableViewCell
            
            if videoUrl == ""{
                cell.youTubePlayer.isHidden = true
                cell.lblNot.isHidden = false
                //cell.lblNotVideo.text = notVideo
            }else{
                 cell.lblNot.isHidden = true
                cell.youTubePlayer.isHidden = false
                 cell.youTubePlayer.load(withVideoId: videoUrl)
            }
            
            return cell
        }
        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DashboardLocationAndMapTableViewCell", for: indexPath) as! DashboardLocationAndMapTableViewCell
            var markerDict: [Int: GMSMarker] = [:]
            let zoom: Float = 20
            
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
                Place(id: 0, name: "", lat: (latitude! as NSString).doubleValue, lng: (longitude! as NSString).doubleValue, icon: ""),
                ]
            
            for place in places {
                let marker = GMSMarker()
                marker.position = CLLocationCoordinate2D(latitude: place.lat, longitude: place.lng)
                marker.title = place.name
                marker.snippet = "\(place.name)"
                marker.map = cell.mapView
                markerDict[place.id] = marker
            }
            
             //cell.btnDeleteAccount.addTarget(self, action: #selector(DashboarCompanyViewController.nokri_btnDeleteAccClicked(_:)), for: .touchUpInside)
            //cell.btnDeleteAccount.setTitle(deleteAccountText, for: .normal)
            return cell
        }
    }
    
 
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0{
            return 235
        }else if (indexPath.section == 1){
            return 45
        }else if indexPath.section == 2{
            return self.aboutCellHeight + 50
            
        }else if indexPath.section == 3 {
            return skillCellHeight + 45
        }else if indexPath.section == 4{
            return 250
        }else if indexPath.section == 5{
            return 250
        } else if indexPath.section == 6{
            if mapHide == true{
                return 0
            }else{
                return 230
            }
        }
        else{
            return 230
        }
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0 {
            return ""
        }else if section == 1 {
            return  titleDasboard
        }else if section == 2{
            return titleAboutCompany
            
        }else if section == 3{
            return titleSkill
        }else if section == 4{
            return titlePortfolio
        }
        else if section == 5{
             return titleEmployerVid
        }else{
            
            return titleLocation
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0{
            return 0
        }else if section == 6 {
            if mapHide == true{
                return 0
            }else{
                return 40
            }
        } else{
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
    
    
    @objc func nokri_btnCompanyDetailClicked(_ sender: UIButton){
        UIApplication.shared.open(URL(string: (sender.titleLabel?.text)!)!)
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
                         self.view.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 150).isActive = true
                        SwiftyAd.shared.showBanner(from: self, at: .top)
                    }
                    else {
                        self.tableView.bottomAnchor.constraint(equalTo: self.tableView.bottomAnchor, constant: 60).isActive = true
                        SwiftyAd.shared.showBanner(from: self, at: .bottom)
                    }
                }
            }
        }
    }
    
    func nokri_dashboardData() {
        //self.tableView.isHidden = true
        self.showLoader()
        UserHandler.nokri_dashboardCompany(success: { (successResponse) in
            self.stopAnimating()
            if successResponse.success {
                self.tableView.isHidden = false
                self.stopAnimating()
                self.refreshControl.endRefreshing()
                //UserHandler.sharedInstance.objDashboard = successResponse.data
                self.dataArray = successResponse.data.info
                self.dataArraySkills = successResponse.data.skills
                self.image = successResponse.data.profileImg.img
                self.social = successResponse.data.social
                self.extraArr = successResponse.data.extra
                self.dataArrImage = successResponse.data.dataImgArr
                self.nokri_populateData()
                self.tableView.reloadData()
            }
            else {
                self.tableView.isHidden = true
                let alert = Constants.showBasicAlert(message: successResponse.message)
                self.present(alert, animated: true, completion: nil)
                self.stopAnimating()
                
            }
        }) { (error) in
            self.stopAnimating()
            self.tableView.isHidden = true
            let alert = Constants.showBasicAlert(message: error.message)
            self.present(alert, animated: true, completion: nil)
            self.stopAnimating()
            
        }
    }
}
extension NSAttributedString {
    func height(withConstrainedWidth width: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func width(withConstrainedHeight height: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        
        return ceil(boundingBox.width)
    }
}


