//
//  CompanyDetailChildViewController.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 5/1/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import Alamofire
import GoogleMaps
import GooglePlaces

class CompanyDetailChildViewController: UIViewController,IndicatorInfoProvider,UITableViewDelegate,UITableViewDataSource {
    
    //MARK:- IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeightContraint: NSLayoutConstraint!
    @IBOutlet var mainView: UIView!
    
    
    //MARK:- Proporties
    
    var appColorNew = UserDefaults.standard.string(forKey: "app_Color")
    var infoArray = NSMutableArray()
    var aboutCellHeight : CGFloat = 0.0;
    var titleAboutCompany:String?
    var titleProfileDetail:String?
    var keyArray = [String]()
    var valueArray = [String]()
    var latitude:String?
    var longitude:String?
    var latCheck:Bool = true
    var reviewsData = [ReviewsData]()
    var reviewCardHeight = false
    var writeReviewSectionTitle = ""
    var firstRating = ""
    var secondRating = ""
    var thirdRating = ""
    var reviewFieldTitle = ""
    var yourReviewFieldTitle = ""
    var candId = 0
    var loginFirst = ""
    var enterTitle = ""
    var enterMessage = ""
    var btnSubmitReview = ""
    var addReviewtext = ""
    var pageTitleReview = ""
    var tableViewheaderBtnTxt = ""
    //var isMapHide = false
    
    //View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate  = self
        tableView.dataSource = self
        
        //self.view.heightAnchor = tableView.contentSize.height
        let comp_id = UserDefaults.standard.integer(forKey: "comp_Id")
        
        let param: [String: Any]?
        //        if isFromFollowedCompany == false{
        //            param = [
        //                "comp_id": company_Id!
        //            ]
        //            print(param!)
        //        }else{
        param = [
            "company_id": comp_id
        ]
        print(param!)
        self.nokri_employerReviewData(params: param as! NSDictionary)
    }
    
    override func viewDidLayoutSubviews(){
        super.viewDidLayoutSubviews()
        tableViewHeightContraint.constant = 1400
        print("\(tableViewHeightContraint.constant)")
        keyArray = UserDefaults.standard.stringArray(forKey: "arr")!
        valueArray = UserDefaults.standard.stringArray(forKey: "arr2")!
        self.tableView.register(UINib(nibName: "Ratings", bundle: nil), forCellReuseIdentifier: "Ratings")
        self.tableView.register(UINib(nibName: "RatingsList", bundle: nil), forCellReuseIdentifier: "RatingsList")
        
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        var title:String?
        if let userData = UserDefaults.standard.object(forKey: "settingsData") {
            let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
            let dataTabs = SplashRoot(fromDictionary: objData)
            title = dataTabs.data.compnyPublicJobs.details
        }
        return IndicatorInfo(title: title)
    }
    
    //MARK:- Custome Functions
    
    func nokri_PopulateData(){
        
        
    }
    
    //MARK:- Table View
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 5
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0{
            return 1
        }else if section == 1{
            return valueArray.count
        }
        else if section == 2{
            return reviewsData.count
            
            
        }
        else{
            return 1
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "AboutCompanyTableViewCell", for: indexPath) as! AboutCompanyTableViewCell
            
            
            let valueAbout = UserDefaults.standard.string(forKey: "valueAbout")
            if valueAbout == nil{
                let alert = Constants.showBasicAlert(message: "Please try again")
                self.present(alert, animated: true, completion: nil)
            }else{
                let htmlString = valueAbout
                let data = htmlString?.data(using: String.Encoding.unicode)! // mind "!"
                let attrStr = try? NSAttributedString( // do catch
                    data: data!,
                    options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html],
                    documentAttributes: nil)
                
                if let ab = attrStr{
                    cell.lblAbout.attributedText = ab
                }
                
                self.aboutCellHeight = (cell.lblAbout.attributedText?.height(withConstrainedWidth: self.view.frame.size.width))!+16;
            }
            
            //cell.lblAbout.text = "not provided"
            return cell
            
        }else if indexPath.section == 1{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileDetailTableViewCell", for: indexPath) as! ProfileDetailTableViewCell
            
            //if keyArray.count == valueArray.count{
            cell.lblKey.text = keyArray[indexPath.row]
            cell.lblValue.text = valueArray[indexPath.row]
            //            }else{
            //                let alert = Constants.showBasicAlert(message: "Please try again")
            //                self.present(alert, animated: true, completion: nil)
            //            }
            
            return cell
            
        }
        else if indexPath.section == 2{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "RatingsList", for: indexPath) as! RatingsList
            let objData = reviewsData[indexPath.row]
            if let title = objData.ratingPoster {
                cell.lblUserName.text = title
            }
            if let ratingStars = objData.ratingAverage {
                cell.rating.rating = Double(ratingStars)
            }
            if let ratingMessage = objData.ratingDescription {
                cell.lblContent.text = ratingMessage
            }
            if let ratingDate = objData.ratingDate {
                cell.lblDate.text = ratingDate
                
            }
            
            if let img = objData.userImage{
                if let url = URL(string: img){
                    cell.imgUser.sd_setImage(with: url, completed: nil)
                    cell.imgUser.sd_setShowActivityIndicatorView(true)
                    cell.imgUser.sd_setIndicatorStyle(.gray)
                }
            }
            if let hasReply = objData.hasReply {
                
                if hasReply == true {
                    reviewCardHeight = true
                    cell.containerReply.isHidden = false
                    if let repliertext = objData.repliedTxt{
                        cell.lblReplierText.text = repliertext
                    }
                    if let replierHeading = objData.repliedHeadingTxt{
                        cell.lblReplierHeading.text = replierHeading
                    }
                }
                else{
                    cell.containerReply.isHidden = true
                    reviewCardHeight = false
                    
                    
                }
            }
            cell.replyButton.isHidden = true
            return cell
            
        }
        else if indexPath.section == 3{
            let cell = tableView.dequeueReusableCell(withIdentifier: "Ratings", for: indexPath) as! Ratings
            cell.lblHeading.text = self.writeReviewSectionTitle
            cell.btnSubmit.setTitle(self.addReviewtext, for: .normal)
            cell.btnSubmitAction = { () in
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let vc = storyBoard.instantiateViewController(withIdentifier: "SubmitRatingViewController") as! SubmitRatingViewController
                vc.firstRating = self.firstRating
                vc.secondRating = self.secondRating
                vc.thirdRating = self.thirdRating
                vc.reviewFieldTitle = self.reviewFieldTitle
                vc.yourReviewFieldTitle = self.yourReviewFieldTitle
                vc.btnSubmitReview = self.btnSubmitReview
                vc.loginFirst = self.loginFirst
                vc.enterTitle = self.enterTitle
                vc.enterMessage = self.enterMessage
                vc.candId = self.candId
                vc.screenTitle = self.pageTitleReview
                vc.celledFromEmploy = true
                self.present(vc, animated: true, completion: nil)
                
            }
            return cell
        }
        else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "LocationTableViewCell", for: indexPath) as! LocationTableViewCell
            
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
            
            latitude = UserDefaults.standard.string(forKey: "lat")
            longitude = UserDefaults.standard.string(forKey: "long")
            
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
                marker.snippet = "Custom snipet message \(place.name)"
                marker.map = cell.mapView
                markerDict[place.id] = marker
            }
            
            return cell
            
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = Bundle.main.loadNibNamed("CandidateAvailabilityHeader", owner: self, options: nil)?.first as! CandidateAvailabilityHeader
        
        let about = UserDefaults.standard.string(forKey: "keyAbout")
        let detail = UserDefaults.standard.string(forKey: "detail")
        let location = UserDefaults.standard.string(forKey: "loc")
        
        
        switch section {
        case 0:
            headerView.lblheadingScheduleHour.text = about
            headerView.containerView.backgroundColor = UIColor.groupTableViewBackground
            
            return headerView
        case 1:
            headerView.lblheadingScheduleHour.text = detail
            headerView.containerView.backgroundColor = UIColor.groupTableViewBackground
            
            return headerView
            
            
        case 2:
            
            headerView.lblheadingScheduleHour.text =  self.pageTitleReview
            headerView.containerView.backgroundColor = UIColor.groupTableViewBackground
            headerView.btnViewAll.isHidden = false
            headerView.btnViewAll.setTitle(self.tableViewheaderBtnTxt, for: .normal)
            headerView.btnViewAll.layer.cornerRadius = 5
            headerView.btnViewAll.backgroundColor = UIColor(hex:appColorNew!)
            headerView.btnViewAll.setTitleColor(UIColor.white, for: .normal)
            headerView.btnViewAllAction  = { [self]()in
                
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let vc = storyBoard.instantiateViewController(withIdentifier: "RatingReviewsViewController") as! RatingReviewsViewController
                vc.userId = self.candId
                vc.calledforEmploye = true
                self.present(vc, animated: true, completion: nil)
                
            }
            return headerView
        case 3:
            headerView.lblheadingScheduleHour.text = self.addReviewtext
            headerView.containerView.backgroundColor = UIColor.groupTableViewBackground
            
            return headerView
        case 4:
            headerView.lblheadingScheduleHour.text = location
            headerView.containerView.backgroundColor = UIColor.groupTableViewBackground
            
            return headerView
        default:
            break
        }
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let about = UserDefaults.standard.string(forKey: "keyAbout")
        let detail = UserDefaults.standard.string(forKey: "detail")
        let location = UserDefaults.standard.string(forKey: "loc")
        
        if section == 0{
            return about
        }else if section == 1 {
            return detail
        }
        else{
            return location
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let isMapHide = UserDefaults.standard.string(forKey: "isEmpMapShow")
        
        if section == 0{
            return 40
        }else if section == 1{
            return 40
        }
        else if section == 2{
            if reviewsData.count == 0{
                return 0
            }
            else{
                return 40
            }        }
        
        else if section == 3{
            return 40
        }
        else if section == 4{
            
            if isMapHide == "1"{
                return 40
            }else{
                return 0
            }
        }
        
        else{
            return 40
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let isMapHide = UserDefaults.standard.string(forKey: "isEmpMapShow")
        if indexPath.section == 0 {
            return aboutCellHeight
        }else if indexPath.section == 1 {
            return 40
        }
        else if indexPath.section == 2 {
            if reviewsData.count == 0{
                return 0
            }
            else {
                if reviewCardHeight == false {
                    return 170
                }
                else{
                    return UITableView.automaticDimension
                }
            }
        }
        else if indexPath.section == 3 {
            return UITableView.automaticDimension
        }
        else{
            if isMapHide == "1"{
                return 800
            }else{
                return 0
            }
            
        }
        
    }
    
    func nokri_employerReviewData(params: NSDictionary){
        self.showLoader()
        UserHandler.nokri_PostEmployerPublicProfile(parameter: params , success: { (successResponse) in
            self.stopAnimating()
            if successResponse.success {
                
                self.reviewsData = successResponse.data.userReviewsData.reviewsArray
                //                successResponse.data.userReviewsData.extra
                print(self.reviewsData.count)
                self.writeReviewSectionTitle = successResponse.data.userReviewsData.extra.writeReviewTitle
                if successResponse.data.userReviewsData.extra.firstRating != nil{
                    self.firstRating = successResponse.data.userReviewsData.extra.firstRating

                }
                if  successResponse.data.userReviewsData.extra.secondRating != nil {
                    self.secondRating = successResponse.data.userReviewsData.extra.secondRating
                }
                if successResponse.data.userReviewsData.extra.thirdRating != nil {
                    self.thirdRating = successResponse.data.userReviewsData.extra.thirdRating
                }
                self.yourReviewFieldTitle = successResponse.data.userReviewsData.extra.reviewTitle
                self.reviewFieldTitle = successResponse.data.userReviewsData.extra.yourReview
                self.candId = successResponse.data.userReviewsData.extra.empId
                print(self.candId)
                self.loginFirst = successResponse.data.userReviewsData.extra.loginFirst
                self.enterTitle = successResponse.data.userReviewsData.extra.enterTitle
                self.enterMessage = successResponse.data.userReviewsData.extra.enterMessage
                self.btnSubmitReview = successResponse.data.userReviewsData.extra.submit
                self.addReviewtext = successResponse.data.userReviewsData.extra.addReviewtext
                self.pageTitleReview = successResponse.data.userReviewsData.extra.pageTitle
                self.tableViewheaderBtnTxt = successResponse.data.userReviewsData.extra.viewAll
                self.tableView.reloadData()
                
            }
            else{}
        })
        { (error) in
            let alert = Constants.showBasicAlert(message: error.message)
            self.present(alert, animated: true, completion: nil)
            self.stopAnimating()
        }}
}
