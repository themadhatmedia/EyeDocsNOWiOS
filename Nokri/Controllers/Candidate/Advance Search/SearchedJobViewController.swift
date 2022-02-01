//
//  SearchedJobViewController.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 4/30/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import UIKit
import Alamofire
import NVActivityIndicatorView
import JGProgressHUD


class SearchedJobViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    
    //MARK:- IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var btnLoadMore: UIButton!
    @IBOutlet weak var lblNoOfJob: UILabel!
    
    
    //MARK:- Proporties
    
    var appColorNew = UserDefaults.standard.string(forKey: "app_Color")
    var message:String?
    var jobsArray = NSMutableArray()
    //var jobTitle:String?
    var pageTitle:String?
    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
    var hasNextPage:Bool = false
    var nextPage:Int?
    var searchedText:String?
    var isfromFilter:Bool = false
    var compId:Int?
    var noOfJobText = ""
   
    
    var isJobCat:Bool?
    var isQulificaton:Bool?
    var isSalarCurrency:Bool?
    var isJobShift:Bool?
    var isJobLevel:Bool?
    var isSkill:Bool?
    
    var jobCatInt:Int?
    var qualificationInt:Int?
    var salarCurrencyInt:Int?
    var jobShiftInt:Int?
    var jobLevelInt:Int?
    var skillInt:Int?
    
    var jobliststyle = 0
    var listStyle = UserDefaults.standard.string(forKey: "listStyle")
    
    
    //MARK:- View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        navigationController?.navigationBar.backItem?.backBarButtonItem?.title = ""
        guard let next = nextPage else {return}
        print(jobsArray.count)
        print(pageTitle!)
        print(next)
        self.lblNoOfJob.text = noOfJobText

        self.title = pageTitle
        if jobsArray.count == 0{
            nokri_tableViewHelper()
        }else{
            nokri_tableViewHelper2()
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        cutomeButton()
        if hasNextPage == true {
            btnLoadMore.isHidden = false
        }
        self.showBackButton()
        showSearchButton()
    }
    
    //MARK:- CUSTOME Functions
    
    @IBAction func btnLoadMoreClicked(_ sender: UIButton) {
        
        if isfromFilter == true{
            if hasNextPage == true{
                nokri_jobDataWithFilters()
            }
        }else{
            if hasNextPage == true{
                nokri_jobData()
            }
        }
    }
    
    func cutomeButton(){
        btnLoadMore.isHidden = true
        btnLoadMore.layer.cornerRadius = 22
        btnLoadMore.backgroundColor = UIColor(hex: appColorNew!)
        btnLoadMore.setTitleColor(UIColor.white, for: .normal)
    }
    
    func nokri_tableViewHelper(){
         tableView.backgroundColor = UIColor.clear
        let rect = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 50, height: self.view.bounds.size.height))
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
    
    @objc func nokri_btnCompanyDetailClicked(_ sender: UIButton){
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CompanyDetailViewController") as! CompanyDetailViewController
        //nextViewController.comp_Id = sender.tag
        UserDefaults.standard.set( sender.tag, forKey: "comp_Id")
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    @objc func nokri_btnJobDetailClicked( _ sender: UIButton){
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "JobDetailViewController") as! JobDetailViewController
        print(sender.tag)
        nextViewController.jobId = sender.tag
        nextViewController.isFromAllJob = false
        nextViewController.compId =
            Int((sender.titleLabel?.text)!)!
         UserDefaults.standard.set(false, forKey: "isFromNoti")
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    //MARK:- Table View
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jobsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if listStyle == "style2"{
                   
                   let cell = tableView.dequeueReusableCell(withIdentifier: "Home3JobsListTableViewCell", for: indexPath) as! Home3JobsListTableViewCell
                        
                          let selectedActiveJob = self.jobsArray[indexPath.row] as? [NSDictionary];
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
                                  if field_type_name == "job_type" {
                                      if let value = innerDict["value"] as? String {
                                          cell.lblJobType.text = value
                                       if value == ""{
                                           cell.lblJobType.text = "N/A"
                                       }
                                       
                                       
                                      }
                                  }
                                  if field_type_name == "job_location" {
                                      if let value = innerDict["value"] as? String {
                                          cell.lblLocation.text = value
                                      }
                                  }
                                  if field_type_name == "job_salary" {
                                      if let value = innerDict["value"] as? String {
                                          cell.lblPrice.text = value
                                       if value == ""{
                                            cell.lblPrice.text = "N/A"
                                       }
                                      }
                                  }
                               if field_type_name == "job_posted" {
                                   if let key = innerDict["value"] as? String {
                                       cell.lblDate.text = key
                                       if key == ""{
                                           cell.lblDate.text = ""
                                       }
                                   }
                               }
                                  if field_type_name == "job_id" {
                                      if let value = innerDict["value"] as? Int {
                                          //jobId = value
                                          cell.btnJobDetail.tag = value
                                          cell.btnCompanyDetail.tag = value
                                          print(value)
                                      }
                                  }
                                  if field_type_name == "company_id" {
                                      
                                      if let value = innerDict["value"] as? String {
                                          
                                          cell.btnCompanyDetail.tag = Int(value)!
                                          compId = Int(value)!
                                          cell.btnJobDetail.setTitle(value, for: .normal)
                                          cell.btnJobDetail.titleLabel?.textColor = UIColor.clear
                                          print(value)
                                      }
                                  }
                                  if field_type_name == "company_logo" {
                                      if let value = innerDict["value"] as? String {
                                          if let url = URL(string: value){
                                              cell.imageViewFeature?.sd_setImage(with: url, completed: nil)
                                              cell.imageViewFeature.sd_setShowActivityIndicatorView(true)
                                              cell.imageViewFeature.sd_setIndicatorStyle(.gray)
                                          }
                                      }
                                  }
                              }
                              
                          }
                          
                          cell.btnCompanyDetail.addTarget(self, action:  #selector(JobsListViewController.nokri_btnCompanyDetailClicked), for: .touchUpInside)
                          cell.btnJobDetail.addTarget(self, action:  #selector(JobsListViewController.nokri_btnJobDetailClicked), for: .touchUpInside)
                          
                          return cell
                   
               }else{
                   
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchedJobTableViewCell", for: indexPath) as! SearchedJobTableViewCell
        let selectedActiveJob = self.jobsArray[indexPath.row] as? [NSDictionary];
        for itemDict in selectedActiveJob! {
            let innerDict = itemDict ;
            if let field_type_name = innerDict["field_type_name"] as? String{
                
                if field_type_name == "job_name" {
                    if let value = innerDict["value"] as? String {
                        cell.lblTitle.text = value
                    }
                }
                if field_type_name == "company_name" {
                    if let value = innerDict["value"] as? String {
                        cell.lblSubTitle.text = value
                    }
                }
                if field_type_name == "job_type" {
                    if let value = innerDict["value"] as? String {
                        cell.lblPartOrFullTime.text = value
                    }
                }
                if field_type_name == "job_location" {
                    if let value = innerDict["value"] as? String {
                        cell.lblLocation.text = value
                    }
                }
                if field_type_name == "job_salary" {
                    if let value = innerDict["value"] as? String {
                        cell.lblPrice.text = value
                    }
                }
                if field_type_name == "job_time" {
                    if let key = innerDict["value"] as? String {
                        cell.lblTime.text = key
                    }
                }
                if field_type_name == "job_id" {
                    if let value = innerDict["value"] as? Int {
    
                        cell.btnJobDetail.tag = value
                        print(value)
                    }
                }
                if field_type_name == "company_id" {
                    
                    if let value = innerDict["value"] as? String {
                        compId = Int(value)!
                        cell.btnCompanyDetail.tag = Int(value)!
                        cell.btnJobDetail.setTitle(value, for: .normal)
                        print(value)
                        
                    }
                }
                if field_type_name == "company_logo" {
                    if let value = innerDict["value"] as? String {
                        
                        if let url = URL(string: value){
                            cell.imageViewJobList?.sd_setImage(with: url, completed: nil)
                            cell.imageViewJobList.sd_setShowActivityIndicatorView(true)
                            cell.imageViewJobList.sd_setIndicatorStyle(.gray)
                        }
                        
                    }
                }
            }
        }
        cell.btnCompanyDetail.addTarget(self, action:  #selector(SearchedJobViewController.nokri_btnCompanyDetailClicked), for: .touchUpInside)
        cell.btnJobDetail.addTarget(self, action:  #selector(SearchedJobViewController.nokri_btnJobDetailClicked), for: .touchUpInside)
        
        return cell
        
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if listStyle == "style2"{
            return 210
        }else{
            return 180
        }    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if tableView.isDragging {
            cell.transform = CGAffineTransform.init(scaleX: 0.5, y: 0.5)
            UIView.animate(withDuration: 0.3, animations: {
                cell.transform = CGAffineTransform.identity
            })
        }
    }
    
    func nokri_jobData(){
        
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
            guard let next = nextPage else {return}
            let param: [String: Any] = [
                
                "page_number" : next,
                "job_title" : searchedText!
                
            ]
            print(param)
            
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.advanceSearch, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    
                    guard let res = response.value else{return}
                    
                    let responseData = res as! NSDictionary
                    self.message = responseData["message"] as? String
                    
                    let success = responseData["success"] as! Bool
                    if success == true{
                        
                        isTimeOut = true
                        let data = responseData["data"] as! NSDictionary
                        if let JobArr = data["jobs"] as? NSArray {
                            self.nokri_jobDataParser(jobsArr: JobArr)
                        }
                        if let pagination = responseData["pagination"] as? NSDictionary{
                            self.hasNextPage = pagination["has_next_page"] as! Bool
                            self.nextPage = pagination["next_page"] as? Int
                        }
                        if self.hasNextPage == true{
                            print(self.hasNextPage)
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
            guard let next = nextPage else {return}
            let param: [String: Any] = [
                
                "page_number" : next,
                "job_title" : searchedText!
                
            ]
            print(param)
            
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.advanceSearch, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    
                    guard let res = response.value else{return}
                    
                    let responseData = res as! NSDictionary
                    self.message = responseData["message"] as? String
                    
                    let success = responseData["success"] as! Bool
                    if success == true{
                        
                        isTimeOut = true
                        let data = responseData["data"] as! NSDictionary
                        if let JobArr = data["jobs"] as? NSArray {
                            self.nokri_jobDataParser(jobsArr: JobArr)
                        }
                        if let pagination = responseData["pagination"] as? NSDictionary{
                            self.hasNextPage = pagination["has_next_page"] as! Bool
                            self.nextPage = pagination["next_page"] as? Int
                        }
                        if self.hasNextPage == true{
                            print(self.hasNextPage)
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
            
            if isJobCat == true{
                params["job_category"] = jobCatInt
            }
            
            if isQulificaton == true{
                params["job_qualifications"] = qualificationInt
            }
            if isSalarCurrency == true{
                params["salary_currency"] = salarCurrencyInt
            }
            if isJobShift == true{
                params["job_shift"] = jobShiftInt
            }
            if isJobLevel == true{
                params["job_level"] = jobLevelInt
            }
            if isSkill == true{
                params["job_skills"] = skillInt
            }
            params["page_number"] = nextPage
            
            
            print(params)
            
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.advanceSearch, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    
                    guard let res = response.value else{return}
                    
                    let responseData = res as! NSDictionary
                    self.message = responseData["message"] as? String
                    
                    let success = responseData["success"] as! Bool
                    if success == true{
                        
                        isTimeOut = true
                       // var pageTitle:String = ""
                        let data = responseData["data"] as! NSDictionary
                        if let page = data["page_title"]  as? String{
                            self.pageTitle = page
                        }
                        if let JobArr = data["jobs"] as? NSArray {
                            self.nokri_jobDataParserWithFilters(jobsArr: JobArr)
                        }
                        if let pagination = responseData["pagination"] as? NSDictionary{
                            self.hasNextPage = (pagination["has_next_page"] as? Bool)!
                            self.nextPage = pagination["next_page"] as? Int
                        }
                        if self.hasNextPage == true{
                            print(self.hasNextPage)
                            //self.btnLoadMore.isHidden = false
                        }
                        
                        if self.hasNextPage == true{
                            print(self.hasNextPage)
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
            
            if isJobCat == true{
                params["job_category"] = jobCatInt
            }
            
            if isQulificaton == true{
                params["job_qualifications"] = qualificationInt
            }
            if isSalarCurrency == true{
                params["salary_currency"] = salarCurrencyInt
            }
            if isJobShift == true{
                params["job_shift"] = jobShiftInt
            }
            if isJobLevel == true{
                params["job_level"] = jobLevelInt
            }
            if isSkill == true{
                params["job_skills"] = skillInt
            }
            params["page_number"] = nextPage
            
            
            print(params)
            
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.advanceSearch, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
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
                        if let JobArr = data["jobs"] as? NSArray {
                            self.nokri_jobDataParserWithFilters(jobsArr: JobArr)
                        }
                        if let pagination = responseData["pagination"] as? NSDictionary{
                            self.hasNextPage = (pagination["has_next_page"] as? Bool)!
                            self.nextPage = pagination["next_page"] as? Int
                        }
                        if self.hasNextPage == true{
                            print(self.hasNextPage)
                            //self.btnLoadMore.isHidden = false
                        }
                        
                        if self.hasNextPage == true{
                            print(self.hasNextPage)
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
        
        //self.jobsArray.removeAllObjects()
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
    
    func nokri_jobDataParser(jobsArr:NSArray){
        
        //self.jobsArray.removeAllObjects()
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
    
    
}

