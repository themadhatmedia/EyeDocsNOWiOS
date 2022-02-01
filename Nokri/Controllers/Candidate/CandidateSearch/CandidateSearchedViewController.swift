//
//  CandidateSearchedViewController.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 7/10/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import UIKit
import Alamofire
import JGProgressHUD

class CandidateSearchedViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnLoadMore: UIButton!
    @IBOutlet weak var viewBehindCell: UIView!
    
    var canArray = NSMutableArray()
    var message:String?
    var pageTitle:String?
    var hasNextPage:Bool?
    var nextPage:Int?
    var searchedText:String?
    
    var isFromFilter:Bool?
    var isType:Bool?
    var isLevel:Bool?
    var isSkill:Bool?
    var isExp:Bool?
    var isCountry:Bool?
    
    var typeInt:Int?
    var levelInt:Int?
    var skillInt:Int?
    var expInt:Int?
    var countryInt:Int?
    var appColorNew = UserDefaults.standard.string(forKey: "app_Color")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        //self.title = pageTitle
        
        if canArray.count == 0{
            nokri_tableViewHelper()
        }else{
            nokri_tableViewHelper2()
        }
       print(message!)
        cutomeButton()
        
        print(hasNextPage!)
        if hasNextPage == true {
            btnLoadMore.isHidden = false
        }
        self.showBackButton()
        //showSearchButtonnew()
        
        let userData = UserDefaults.standard.object(forKey: "settingsData")
        let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
        let dataTabs = SplashRoot(fromDictionary: objData)
        let obj = dataTabs.data.tabs
        self.title = obj?.canSearch
        
    }
    
    func showSearchButtonnew() {
        self.hideBackButton()
        let backButton = UIButton(type: .custom)
        backButton.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        if UserDefaults.standard.bool(forKey: "isRtl") {
            backButton.setBackgroundImage(UIImage(named: "searchWhite"), for: .normal)
        } else {
            backButton.setBackgroundImage(UIImage(named: "searchWhite"), for: .normal)
        }
        backButton.addTarget(self, action: #selector(onSearchButtonClciked), for: .touchUpInside)
        let backBarButton = UIBarButtonItem(customView: backButton)
        self.navigationItem.rightBarButtonItem = backBarButton
    }
    
    @objc override func onBackButtonClciked() {
           navigationController?.popViewController(animated: true)
       }
       
    @objc override func onSearchButtonClciked() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CandidateSearchViewController") as! CandidateSearchViewController
        navigationController?.pushViewController(vc,
                                                 animated: false)
        
    }

    //MARK:- Table View
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return canArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell  = tableView.dequeueReusableCell(withIdentifier: "CandidateSearchedTableViewCell", for: indexPath) as! CandidateSearchedTableViewCell
        
        let selectedActiveJob = self.canArray[indexPath.row] as? [NSDictionary];
        for itemDict in selectedActiveJob! {
            let innerDict = itemDict ;
            if let field_type_name = innerDict["field_type_name"] as? String{
                
                if field_type_name == "cand_name" {
                    if let value = innerDict["value"] as? String {
                        cell.lblFullName.text = value
                    }
                }
                if field_type_name == "cand_headline" {
                    if let value = innerDict["value"] as? String {
                        cell.lblSubName.text = value
                    }
                }
                if field_type_name == "cand_id" {
                    if let value = innerDict["value"] as? Int {
                        
                        cell.btnClickedCandidate.tag = value
                        print(value)
                    }
                }
                if field_type_name == "is_featured" {
                    if let value = innerDict["value"] as? Bool {
                        if value == true{
                            cell.imgFea.isHidden = false
                        }else{
                            cell.imgFea.isHidden = true

                        }
                    }
                }

                if field_type_name == "cand_dp" {
                    if let value = innerDict["value"] as? String {
                        
                        if let url = URL(string: value){
                            cell.imageViewCanSearched?.sd_setImage(with: url, completed: nil)
                            cell.imageViewCanSearched.sd_setShowActivityIndicatorView(true)
                            cell.imageViewCanSearched.sd_setIndicatorStyle(.gray)
                        }
                    }
                }
            }
        }
        
        cell.btnClickedCandidate.addTarget(self, action:  #selector(CandidateSearchedViewController.nokri_btnCanClicked), for: .touchUpInside)
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 92
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if tableView.isDragging {
            cell.transform = CGAffineTransform.init(scaleX: 0.5, y: 0.5)
            UIView.animate(withDuration: 0.3, animations: {
                cell.transform = CGAffineTransform.identity
            })
        }
    }
    
    @IBAction func btnLoadMoreClicked(_ sender: UIButton) {
        if isFromFilter == true{
            if hasNextPage == true{
                nokri_canDataWithFilters()
            }
        }else{
            if hasNextPage == true{
                nokri_canData()
            }
        }
    }
    
    //MARK:- IBActions
    
    @objc func nokri_btnCanClicked(_ sender: UIButton){
        let canId = sender.tag
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MyProfileViewController") as! MyProfileViewController
        nextViewController.userId = canId
        nextViewController.isFromCan = false
        nextViewController.idCheck = 1
        nextViewController.isFromFollower = true
        nextViewController.isFromCandSearch = true
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    
    //MARK:- CUSTOME Functions
    
    func cutomeButton(){
        btnLoadMore.isHidden = true
        btnLoadMore.layer.cornerRadius = 22
        btnLoadMore.backgroundColor = UIColor(hex: appColorNew!)
        btnLoadMore.setTitleColor(UIColor.white, for: .normal)
    }
    
    func nokri_tableViewHelper(){
        tableView.backgroundColor = UIColor.clear
        let rect = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: self.view.bounds.size.width, height: self.view.bounds.size.height))
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
        tableView.backgroundColor = UIColor.white
        let rect = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: self.view.bounds.size.width, height: self.view.bounds.size.height))
        let messageLabel = UILabel(frame: rect)
        messageLabel.text = ""
        messageLabel.textAlignment = .center;
        tableView.backgroundView = messageLabel
    
    }
    
    func nokri_canData(){
        
        var langCode = UserDefaults.standard.string(forKey: "langCode")
        if langCode == nil {
            langCode = "en"
        }
        
        var isTimeOut = false
        self.showLoader()
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
            "page_number" : nextPage!,
            "cand_title" : searchedText!
        ]
        print(param)
        Alamofire.request(Constants.URL.baseUrl+Constants.URL.candidateSearch, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { response in
                guard let res = response.value else{return}
                let responseData = res as! NSDictionary
                self.message = responseData["message"] as? String
                let success = responseData["success"] as! Bool
                if success == true{
                    isTimeOut = true
                    let data = responseData["data"] as! NSDictionary
                    if let JobArr = data["candidates"] as? NSArray {
                        self.nokri_jobDataParser(jobsArr: JobArr)
                    }
                    if let pagination = responseData["pagination"] as? NSDictionary{
                        self.hasNextPage = (pagination["has_next_page"] as? Bool)!
                        self.nextPage = pagination["next_page"] as? Int
                    }
                    if self.hasNextPage == true{
                        print(self.hasNextPage!)
                        //self.btnLoadMore.isHidden = false
                    }
                    print(self.nextPage!)
                    if self.hasNextPage == true{
                        print(self.hasNextPage!)
                        self.btnLoadMore.isHidden = false
                    }
                    if self.hasNextPage == false{
                        self.btnLoadMore.isHidden = true
                    }
                    self.tableView.reloadData()
                   
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
                        self.view.makeToast("Network Time out", duration: 1.5, position: .center)
                    }
                }
        }
    }
    
    func nokri_jobDataParser(jobsArr:NSArray){
        //self.canArray.removeAllObjects()
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
            self.canArray.add(arrayOfDictionaries);
        }
    }
    
    
    func nokri_canDataWithFilters(){
        
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
            if isType == true{
                params["cand_type"] = typeInt
            }
            if isLevel == true{
                params["cand_level"] = levelInt
            }
            if isSkill == true{
                params["cand_skills"] = skillInt
            }
            if isExp == true{
                params["cand_experience"] = expInt
            }
            if isCountry == true{
                params["cand_location"] = countryInt
            }
            params["page_number"] = nextPage
            print(params)
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.candidateSearch, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    guard let res = response.value else{return}
                    let responseData = res as! NSDictionary
                    self.message = responseData["message"] as? String
                    let success = responseData["success"] as! Bool
                    if success == true{
                        isTimeOut = true
                        //var pageTitle:String?
                        let data = responseData["data"] as! NSDictionary
                        if let page = data["page_title"]  as? String{
                            self.pageTitle = page
                        }
                        if let JobArr = data["candidates"] as? NSArray {
                            self.nokri_jobDataParserWithFilters(jobsArr: JobArr)
                        }
                        if let pagination = responseData["pagination"] as? NSDictionary{
                            self.hasNextPage = (pagination["has_next_page"] as? Bool)!
                            self.nextPage = pagination["next_page"] as? Int
                        }
                        if self.hasNextPage == true{
                            //print(self.hasNextPage)
                            self.btnLoadMore.isHidden = false
                        }
                        if self.hasNextPage == false{
                            self.btnLoadMore.isHidden = true
                        }
                        self.tableView.reloadData()
                        print(self.nextPage!)
                        
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
                            self.view.makeToast("Network Time out", duration: 1.5, position: .center)
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
            if isType == true{
                params["cand_type"] = typeInt
            }
            if isLevel == true{
                params["cand_level"] = levelInt
            }
            if isSkill == true{
                params["cand_skills"] = skillInt
            }
            if isExp == true{
                params["cand_experience"] = expInt
            }
            if isCountry == true{
                params["cand_location"] = countryInt
            }
            params["page_number"] = nextPage
            print(params)
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.candidateSearch, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    guard let res = response.value else{return}
                    let responseData = res as! NSDictionary
                    self.message = responseData["message"] as? String
                    let success = responseData["success"] as! Bool
                    if success == true{
                        isTimeOut = true
                        //var pageTitle:String?
                        let data = responseData["data"] as! NSDictionary
                        if let page = data["page_title"]  as? String{
                            self.pageTitle = page
                        }
                        if let JobArr = data["candidates"] as? NSArray {
                            self.nokri_jobDataParserWithFilters(jobsArr: JobArr)
                        }
                        if let pagination = responseData["pagination"] as? NSDictionary{
                            self.hasNextPage = (pagination["has_next_page"] as? Bool)!
                            self.nextPage = pagination["next_page"] as? Int
                        }
                        if self.hasNextPage == true{
                            //print(self.hasNextPage)
                            self.btnLoadMore.isHidden = false
                        }
                        if self.hasNextPage == false{
                            self.btnLoadMore.isHidden = true
                        }
                        self.tableView.reloadData()
                        print(self.nextPage!)
                        
                    }else{
                        let hud = JGProgressHUD(style: .dark)
                        hud.textLabel.text = self.message!
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
                            self.view.makeToast("Network Time out", duration: 1.5, position: .center)
                        }
                    }
            }
            
        }
        
       
    }
    
    func nokri_jobDataParserWithFilters(jobsArr:NSArray){
       // self.canArray.removeAllObjects()
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
            self.canArray.add(arrayOfDictionaries);
        }
    }
    

}
