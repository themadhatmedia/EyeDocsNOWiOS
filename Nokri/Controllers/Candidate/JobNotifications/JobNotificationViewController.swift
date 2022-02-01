//
//  JobNotificationViewController.swift
//  Nokri
//
//  Created by apple on 4/27/20.
//  Copyright © 2020 Furqan Nadeem. All rights reserved.
//

import UIKit
import Alamofire
import JGProgressHUD

class JobNotificationViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    //MARK:- IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK:- Proporties
    
    var appColorNew = UserDefaults.standard.string(forKey: "app_Color")
    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
    var message:String?
    var companiesArray = NSMutableArray()
    var btnUnfollowText:String?
    var comp_Id:Int?
    var nextPage:Int?
    var hasNextPage:Bool?
    
    //MARK:- View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        addLeftBarButtonWithImage(#imageLiteral(resourceName: "menu"))
        nokri_companiesData()
        showSearchButton()
        if let userData = UserDefaults.standard.object(forKey: "settingsData") {
                  let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
            let dataTabs = SplashRoot(fromDictionary: objData)
            self.title = dataTabs.data.extra.notifypage
        }
    }
    
    //MARK:- TableView
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return companiesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "JobNotificationTableViewCell", for: indexPath) as! JobNotificationTableViewCell
      
              let selectedActiveJob = self.companiesArray[indexPath.row] as? [NSDictionary];
              for itemDict in selectedActiveJob! {
                  let innerDict = itemDict ;
                  if let field_type_name = innerDict["field_type_name"] as? String{
                      if field_type_name == "company_name" {
                          if let value = innerDict["value"] as? String {
                              cell.lblComName.text = value
                          }
                      }
                    
                    if field_type_name == "job_post" {
                        if let value = innerDict["value"] as? String {
                            cell.lblPosted.text = value
                        }
                    }
                    
                    if field_type_name == "job_title" {
                        if let value = innerDict["value"] as? String {
                            cell.lblJobName.text = value
                        }
                    }
                    if field_type_name == "posting_time" {
                        if let value = innerDict["value"] as? String {
                            cell.lblTime.text = value
                        }
                    }
                      if field_type_name == "job_id"{
                          if let value = innerDict["value"] as? Int {
                              cell.btnJobDetail.tag = value
                              print(value)
                          }
                      }
                
                      if field_type_name == "company_img" {
                          if let value = innerDict["value"] as? String {

                              if let url = URL(string: value){
                                  cell.imgView?.sd_setImage(with: url, completed: nil)
                                  cell.imgView.sd_setShowActivityIndicatorView(true)
                                  cell.imgView.sd_setIndicatorStyle(.gray)
                              }
                          }
                      }
                  }
              }
           
              cell.btnJobDetail.addTarget(self, action:  #selector(JobNotificationViewController.nokri_btnJobDetailClicked), for: .touchUpInside)
          
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
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
    
    @objc func nokri_btnJobDetailClicked( _ sender: UIButton){
          let nextViewController = storyBoard.instantiateViewController(withIdentifier: "JobDetailViewController") as! JobDetailViewController
       
           nextViewController.jobId = sender.tag
           UserDefaults.standard.set(false, forKey: "isFromNoti")
        
          self.navigationController?.pushViewController(nextViewController, animated: true)
      }
    
    //MARK:- API Calls
       
       func nokri_companiesData(){
        
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
               let param: [String: Any] = [
                   "page_number": "1"
               ]
               print(param)
               Alamofire.request(Constants.URL.baseUrl+Constants.URL.jobNotificationget, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers)
                   .responseJSON { response in
                       guard let res = response.value else{return}
                       let responseData = res as! NSDictionary
                       self.message = responseData["message"] as? String
                       let success = responseData["success"] as! Bool
                       if success == true{
                           isTimeOut = true
                           let data = responseData["data"] as! NSDictionary
                           if let page = data["page_title"]  as? String{
                               self.title = page
                           }
                           if let btnUnfollow = data["btn_text"]  as? String{
                               self.btnUnfollowText = btnUnfollow
                           }
                           if let companiesArr = data["notification"] as? NSArray {
                               self.nokri_compParser(compArr: companiesArr)
                           }
                           if let pagination = responseData["pagination"] as? NSDictionary{
                               self.hasNextPage = pagination["has_next_page"] as? Bool
                               self.nextPage = pagination["next_page"] as? Int
                           }
                         
                       }else{
                           //self.view.makeToast(self.message, duration: 1.5, position: .center)
                        self.nokri_tableViewHelper()
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
               let param: [String: Any] = [
                   "page_number": "1"
               ]
               print(param)
               Alamofire.request(Constants.URL.baseUrl+Constants.URL.jobNotificationget, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers)
                   .responseJSON { response in
                       guard let res = response.value else{return}
                       let responseData = res as! NSDictionary
                       self.message = responseData["message"] as? String
                       let success = responseData["success"] as! Bool
                       if success == true{
                           isTimeOut = true
                           let data = responseData["data"] as! NSDictionary
                           if let page = data["page_title"]  as? String{
                               self.title = page
                           }
                           if let btnUnfollow = data["btn_text"]  as? String{
                               self.btnUnfollowText = btnUnfollow
                           }
                           if let companiesArr = data["notification"] as? NSArray {
                               self.nokri_compParser(compArr: companiesArr)
                           }
                           if let pagination = responseData["pagination"] as? NSDictionary{
                               self.hasNextPage = pagination["has_next_page"] as? Bool
                               self.nextPage = pagination["next_page"] as? Int
                           }
                        
                       }else{
                           //self.view.makeToast(self.message, duration: 1.5, position: .center)
                        self.nokri_tableViewHelper()
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
           }
       }
    
    func nokri_compParser(compArr:NSArray){
        self.companiesArray.removeAllObjects()
        for item in compArr{
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
            self.companiesArray.add(arrayOfDictionaries);
        }
        if compArr.count == 0{
            nokri_tableViewHelper()
            self.tableView.reloadData()
        }else{
            nokri_tableViewHelper2()
        }
        print("\(self.companiesArray.count)");
        self.tableView.reloadData()
    }
    
    func nokri_tableViewHelper(){
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
           let rect = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: self.view.bounds.size.width, height: self.view.bounds.size.height))
           let messageLabel = UILabel(frame: rect)
           messageLabel.text = ""
           messageLabel.textAlignment = .center;
           tableView.backgroundView = messageLabel
       }
    
}
