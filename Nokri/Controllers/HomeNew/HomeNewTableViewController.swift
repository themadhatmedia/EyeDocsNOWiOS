//
//  HomeNewTableViewController.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 7/30/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import UIKit
import Alamofire
import TTSegmentedControl

class HomeNewTableViewController: UITableViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    //MARK:- IBOutlets
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var viewSeparator: UIView!
    @IBOutlet weak var lblFindJob: UILabel!
    @IBOutlet weak var viewSearch: UIView!
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var txtFieldSearch: UITextField!
    @IBOutlet weak var imageViewHeader: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var lblSelectCategory: UILabel!
    @IBOutlet weak var viewSeparatorCat: UIView!
    @IBOutlet weak var tableViewJobs: UITableView!
    @IBOutlet weak var segmentControl: TTSegmentedControl!
    @IBOutlet weak var heightConstraintTableView: NSLayoutConstraint!
    
    //MARK:- Proporties
    
    var tableViewHeight:CGFloat = 0.0
    var heading:String = ""
    var findJobText:String = ""
    var searchKeywordText:String = ""
    var placeholderText:String = ""
    var homeDataObj:homeData?
    var imageHeader:String = ""
    var categoryText:String = ""
    var categoryArray  = [homeCatIcon]()
    var catId:Int?
    var jobsArray = NSMutableArray()
    var message:String?
    var activeJobArray = NSMutableArray()
    //var message:String?
    var senderButtonTag:Int?
    var featureTitle:String = ""
    var noOfJobs = ""
    
    //MARK:- View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nokri_homeData()
        collectionView.delegate = self
        collectionView.dataSource = self
        tableViewJobs.delegate = self
        tableViewJobs.dataSource = self
        nokri_jobData()
        segmentControl.didSelectItemWith = { (index, title) -> () in
            print("Selected item \(index)")
            if index == 0{
                self.nokri_jobData()
            }else{
                self.nokri_jobDataAll()
            }
        }
        
    }

    //MARK:- CollectionView
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCattCollectionViewCell", for: indexPath) as! HomeCattCollectionViewCell
        let obj = categoryArray[indexPath.row]
        cell.imageView.sd_setImage(with: URL(string: obj.img), completed: nil)
        cell.lblName.text = obj.name
        cell.lblJobCount.text = obj.count
        cell.btnId.tag = obj.jobCategory
        cell.btnId.addTarget(self, action:  #selector(HomeNewTableViewController.btnJobDetailClicked), for: .touchUpInside)
        return cell
        
    }
    
    @objc func btnJobDetailClicked(_ sender: UIButton){
        catId = sender.tag
        nokri_jobDataWithFilters()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let padding: CGFloat = 0
        let collectionViewSize = collectionView.frame.size.width - padding
        
        return CGSize(width: collectionViewSize/4, height:96)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
    
    //MARK:- Custome Functions
    
    func nokri_customeButtons(){
        
        self.segmentControl.itemTitles = ["Featured jobs", "Latest Jobs"]
        segmentControl.defaultTextColor = UIColor.darkGray
        segmentControl.selectedTextColor = UIColor.white
        segmentControl.thumbGradientColors = [UIColor(hex:Constants.AppColor.appColor), UIColor(hex:Constants.AppColor.appColor)]
        segmentControl.useShadow = true
        segmentControl.layer.borderColor = UIColor(hex: Constants.AppColor.appColor).cgColor
        segmentControl.selectedTextFont = UIFont(name: "HelveticaNeue-Bold", size: 14.0)!
        
    }
    
    func nokri_populateData(){
        lblTitle.text = heading
        lblFindJob.text = findJobText
        viewSeparator.backgroundColor = UIColor(hex: Constants.AppColor.appColor)
        btnSearch.backgroundColor = UIColor(hex: Constants.AppColor.appColor)
        txtFieldSearch.placeholder = placeholderText
        imageViewHeader.sd_setImage(with: URL(string: imageHeader), completed: nil)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return activeJobArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeJobListDataTableViewCell", for: indexPath) as! HomeJobListDataTableViewCell
        let selectedActiveJob = self.activeJobArray[indexPath.row] as? [NSDictionary];
        for itemDict in selectedActiveJob! {
            let innerDict = itemDict ;
            if let field_type_name = innerDict["field_type_name"] as? String{
                if field_type_name == "job_name" {
                    if let value = innerDict["value"] as? String {
                        cell.lblJobTitle.text = value
                    }
                }
                if field_type_name == "company_name" {
                    if let value = innerDict["value"] as? String {
                        cell.lblCompany.text = value
                    }
                }
                if field_type_name == "job_salary" {
                    if let value = innerDict["value"] as? String {
                        cell.lblPrice.text = value
                    }
                }
                if field_type_name == "job_posted" {
                    if let value = innerDict["value"] as? String {
                        cell.lblDate.text = value
                    }
                }
                if field_type_name == "job_type" {
                    if let value = innerDict["value"] as? String {
                        cell.lblJobType.text = value
                    }
                }
                if field_type_name == "job_location" {
                    if let value = innerDict["value"] as? String {
                        cell.lblLocation.text = value
                    }
                }
                if field_type_name == "company_logo" {
                    if let value = innerDict["value"] as? String {
                        cell.imageViewFeature.sd_setImage(with: URL(string: value), completed: nil)
                    }
                }
//                if field_type_name == "job_id" {
//                    if let value = innerDict["value"] as? Int {
//                        //cell.btnInActive.tag = value
//                        //cell.btnDropDown.tag = value
//                        //print(value)
//                    }
//                }
            }
        }
        return cell
    }
    
    func nokri_homeData() {
        self.showLoader()
        UserHandler.nokri_home(success: { (successResponse) in
            self.stopAnimating()
            if successResponse.success {
                DispatchQueue.main.async {
                    self.homeDataObj =  successResponse.data
                    self.heading = successResponse.data.heading
                    self.findJobText = successResponse.data.tagline
                    self.placeholderText = successResponse.data.placehldr
                    self.imageHeader = successResponse.data.img
                    self.categoryText = successResponse.data.catsText
                    self.categoryArray = successResponse.data.catIcons
                    self.collectionView.reloadData()
                    self.nokri_populateData()
                    self.tableView.reloadData()
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
            "Nokri-Login-Type" : "social",
            "Nokri-Lang-Locale" : "\(langCode!)"
            ]
        
        var params : [String:Any] = [:]
        params["job_category"] = catId
        
        print(params)
        
        Alamofire.request(Constants.URL.baseUrl+Constants.URL.advanceSearch, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { response in
                
                guard let res = response.value else{return}
                
                let responseData = res as! NSDictionary
                self.message = responseData["message"] as? String
                
                let success = responseData["success"] as! Bool
                if success == true{
                    self.stopAnimating()
                    isTimeOut = true
                    var pageTitle:String?
                    let data = responseData["data"] as! NSDictionary
                    if let page = data["page_title"]  as? String{
                        pageTitle = page
                    }
                    if let JobArr = data["jobs"] as? NSArray {
                        self.jobDataParserWithFilters(jobsArr: JobArr)
                    }
                    if let noOfJob = data["no_txt"]  as? String{
                        self.noOfJobs = noOfJob
                    }
                    
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SearchedJobViewController") as! SearchedJobViewController
                    nextViewController.jobsArray = self.jobsArray
                    nextViewController.message = self.message
                    nextViewController.pageTitle = pageTitle
                    nextViewController.noOfJobText = self.noOfJobs
                    self.navigationController?.pushViewController(nextViewController, animated: true)
                    
                    //self.viewContainingController()?.navigationController?.pushViewController(nextViewController, animated: true)
                    
                    
                }else{
                    self.stopAnimating()

                    //self.view.makeToast(self.message, duration: 1.5, position: .center)
                }
                
                if isTimeOut == false{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 30) {
                        
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
                "Nokri-Lang-Locale" : "\(langCode!)"
            ]
            
            var params : [String:Any] = [:]
            params["job_category"] = catId
            print(params)
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.advanceSearch, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    
                    guard let res = response.value else{return}
                    let responseData = res as! NSDictionary
                    self.message = responseData["message"] as? String
                    let success = responseData["success"] as! Bool
                    if success == true{
                        self.stopAnimating()
                        isTimeOut = true
                        var pageTitle:String?
                        let data = responseData["data"] as! NSDictionary
                        if let page = data["page_title"]  as? String{
                            pageTitle = page
                        }
                        if let JobArr = data["jobs"] as? NSArray {
                            self.jobDataParserWithFilters(jobsArr: JobArr)
                        }
                        if let noOfJob = data["no_txt"]  as? String{
                            self.noOfJobs = noOfJob
                        }
                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SearchedJobViewController") as! SearchedJobViewController
                        nextViewController.jobsArray = self.jobsArray
                        nextViewController.message = self.message
                        nextViewController.pageTitle = pageTitle
                        nextViewController.noOfJobText = self.noOfJobs
                    
                        self.navigationController?.pushViewController(nextViewController, animated: true)
                        
                        //self.viewContainingController()?.navigationController?.pushViewController(nextViewController, animated: true
                        
                    }else{
                        self.stopAnimating()
                        
                        //self.view.makeToast(self.message, duration: 1.5, position: .center)
                    }
                    if isTimeOut == false{
                        DispatchQueue.main.asyncAfter(deadline: .now() + 30) {
                            
                            //self.view.makeToast("Network Time out", duration: 1.5, position: .center)
                        }
                    }
            }
        }
    }
    
    func jobDataParserWithFilters(jobsArr:NSArray){
        
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
    
    func nokri_jobData(){
        
        var langCode = UserDefaults.standard.string(forKey: "langCode")
        if langCode == nil {
            langCode = "en"
        }
        
        
        //self.startActivityIndicator()
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
             "Nokri-Request-From" : Constants.customCodes.requestFrom,
            "Nokri-Lang-Locale" : "\(langCode!)"
            ]
        let param: [String: Any] = [
            "page_number": "1",
            ]
        
        print(param)
        Alamofire.request(Constants.URL.baseUrl+Constants.URL.featureJob, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { response in
                guard let res = response.value else{return}
                let responseData = res as! NSDictionary
                //self.message = responseData["message"] as? String
                let success = responseData["success"] as! Bool
                if success == true{
                    let data = responseData["data"] as! NSDictionary
                    self.featureTitle = data["tab_title"] as! String
                    
                    if let activeJobArr = data["jobs"] as? NSArray {
                        self.nokri_jobDataParser(activeJobArray: activeJobArr)
                    }
                    self.nokri_customeButtons()
                    self.tableView.reloadData()
                    self.heightConstraintTableView.constant = self.tableView.contentSize.height
                    self.tableView.frame.size.height = self.tableView.contentSize.height
                    UserDefaults.standard.set(5, forKey: "height")
                    
                }else{
                }
                
        }
    }
    func nokri_jobDataAll(){
        
        //self.startActivityIndicator()
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
             "Nokri-Request-From" : Constants.customCodes.requestFrom,
            "Nokri-Lang-Locale" : "\(langCode!)"
            ]
        let param: [String: Any] = [
            "page_number": "1",
            ]
        
        print(param)
        Alamofire.request(Constants.URL.baseUrl+Constants.URL.all_jobs, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { response in
                guard let res = response.value else{return}
                let responseData = res as! NSDictionary
                //self.message = responseData["message"] as? String
                let success = responseData["success"] as! Bool
                if success == true{
                    let data = responseData["data"] as! NSDictionary
                    // self.featureTitle = data["page_title"] as! String
                    if let activeJobArr = data["jobs"] as? NSArray {
                        self.nokri_jobDataParser(activeJobArray: activeJobArr)
                    }
                    self.tableView.reloadData()
                    self.heightConstraintTableView.constant += self.tableView.contentSize.height
                }else{
                }
                self.nokri_customeButtons()
                self.tableView.reloadData()
                
        }
    }
    
    
    func nokri_jobDataParser(activeJobArray:NSArray){
        self.activeJobArray.removeAllObjects()
        for item in activeJobArray{
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
            self.activeJobArray.add(arrayOfDictionaries);
        }
        if activeJobArray.count == 0{
            nokri_tableViewHelper()
            self.tableView.reloadData()
        }else{
            nokri_tableViewHelper2()
        }
        print("\(self.activeJobArray.count)");
        self.tableView.reloadData()
    }
    
    func nokri_tableViewHelper(){
        let rect = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: self.tableView.bounds.size.width, height: self.tableView.bounds.size.height))
        let messageLabel = UILabel(frame: rect)
        messageLabel.text = self.message
        messageLabel.textColor = UIColor.lightGray
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont(name: "TrebuchetMS", size: 20)
        messageLabel.sizeToFit()
        tableView.backgroundView = messageLabel
    }
    func nokri_tableViewHelper2(){
        let rect = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: self.tableView.bounds.size.width, height: self.tableView.bounds.size.height))
        let messageLabel = UILabel(frame: rect)
        messageLabel.text = ""
        messageLabel.textAlignment = .center;
        tableView.backgroundView = messageLabel
    }
    
}
