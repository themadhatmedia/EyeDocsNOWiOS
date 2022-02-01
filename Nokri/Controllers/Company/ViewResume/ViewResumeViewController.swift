//
//  ViewResumeViewController.swift
//  Nokri
//
//  Created by apple on 4/2/20.
//  Copyright © 2020 Furqan Nadeem. All rights reserved.
//

import UIKit

import Alamofire
import JGProgressHUD

class ViewResumeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    //MARK:- IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    
    //MARK:- Proporties
    
    var appColorNew = UserDefaults.standard.string(forKey: "app_Color")
    var followerArray = NSMutableArray();
    var btnText:String?
    var pageTitle:String?
    var message:String?
    var nextPage:Int?
    var hasNextPage:Bool?
    var job_id = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        //nokri_ltrRtl()
        nokri_saveResumeData()
        self.title = "Resumes"
    }
    
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return followerArray.count
      }
      
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          
          let cell = tableView.dequeueReusableCell(withIdentifier: "ViewResumeTableViewCell", for: indexPath) as! ViewResumeTableViewCell
          let selectedFollower = self.followerArray[indexPath.row] as? [NSDictionary];
          for itemDict in selectedFollower! {
              let innerDict = itemDict ;
              if let field_type_name = innerDict["field_type_name"] as? String{
                  if field_type_name == "cand_name" {
                      if let value = innerDict["value"] as? String {
                          cell.lblName.text = value;
                      }
                  }
                  if field_type_name == "cand_dp" {
                      if let value = innerDict["value"] as? String {
                          cell.imgView.sd_setImage(with: URL(string: value), placeholderImage: UIImage(named: ""), options: .refreshCached, completed: nil);
                          cell.imgView.sd_setShowActivityIndicatorView(true)
                          cell.imgView.sd_setIndicatorStyle(.gray)
                      }
                  }
                  if field_type_name == "cand_head" {
                      if let value = innerDict["value"] as? String {
                          cell.lblRole.text = value
                      }
                  }
                  if field_type_name == "cand_id" {
                      if let value = innerDict["value"] as? Int {
                          cell.btnViewProfile.tag = value
                          //cell.btnRemove.tag = value
                        
                        print(value)
                    }
                }
                
                if field_type_name == "attachment_id" {
                    if let value = innerDict["value"] as? String {
                        cell.btnRemove.setTitle(value, for: .normal)
                        if value == ""{
                            cell.btnRemove.isHidden = true
                        }
                        //cell.btnRemove.currentTitleColor = UIColor.clear
                        print(value)
                    }
                }
                
            }
        }
        
        if let userData = UserDefaults.standard.object(forKey: "settingsData") {
        let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
            let dataTabs = SplashRoot(fromDictionary: objData)
            cell.btnViewProfile.setTitle(dataTabs.data.extra.view_profile, for: .normal)
            //cell.btnRemove.setTitle(dataTabs.data.menuResume.download, for: .normal)
        }
        
        
      cell.btnRemove.addTarget(self, action: #selector(ViewResumeViewController.nokri_btnRemoveClicked(_:)), for: .touchUpInside)
      cell.btnViewProfile.addTarget(self, action: #selector(ViewResumeViewController.nokri_btnViewProfileClicked(_:)), for: .touchUpInside)
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
      
      //MARK:- Custome Functions
      
    @objc func nokri_btnViewProfileClicked(_ sender: UIButton){
        let candProfCtrl = self.storyboard?.instantiateViewController(withIdentifier: "MyProfileViewController") as! MyProfileViewController
        candProfCtrl.isFromCandSearch = true
        candProfCtrl.idCheck = 1
        candProfCtrl.userId = sender.tag
        self.navigationController?.pushViewController(candProfCtrl, animated: true)
    }

     @objc func nokri_btnRemoveClicked(_ sender: UIButton){
      
            if let URL = NSURL(string: sender.currentTitle!) {
                load(url: URL as URL, to: URL as URL) {
                    print("ok")
                }
            }
     
        
//        var confirmString:String?
//               var btnOk:String?
//               var btnCncel:String?
//               if let userData = UserDefaults.standard.object(forKey: "settingsData") {
//                   let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
//                   let dataTabs = SplashRoot(fromDictionary: objData)
//                   confirmString = dataTabs.data.genericTxts.confirm
//                   btnOk = dataTabs.data.genericTxts.btnConfirm
//                   btnCncel = dataTabs.data.genericTxts.btnCancel
//               }
//               let alert = UIAlertController(title: confirmString, message: nil, preferredStyle: .alert)
//               let ok = UIAlertAction(title: btnOk, style: .default) { (ok) in
//                   let follower_id = sender.tag
//                   print(follower_id)
//                   let param: [String: Any] = [
//                       "resume_id": follower_id
//                   ]
//                   print(param)
//                   self.nokri_removeResume(parameter: param as NSDictionary)
//               }
//               let cancel = UIAlertAction(title: btnCncel, style: .cancel) { (cancel) in
//               }
//               alert.addAction(ok)
//               alert.addAction(cancel)
//               self.present(alert, animated: true, completion: nil)
      }
    
      func nokri_ltrRtl(){
          let isRtl = UserDefaults.standard.string(forKey: "isRtl")
          if isRtl == "0"{
              self.addLeftBarButtonWithImage(#imageLiteral(resourceName: "menu"))
          }else{
              self.addRightBarButtonWithImage(#imageLiteral(resourceName: "menu"))
          }
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
    
    //MARK:- Api Calls
    
    func nokri_saveResumeData(){
        
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
                    "page_number": "1",
                    "job_id" : job_id
                ]
                print(param)
                Alamofire.request(Constants.URL.baseUrl+Constants.URL.matchedResSingle, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers)
                    .responseJSON { response in
                        print(response.request as Any)  // original URL request
                        print(response.response as Any) // URL response
                        print(response.result.value as Any)
                        let responseData = response.value as! NSDictionary
                        self.message = responseData["message"] as? String
                        let data = responseData["data"] as! NSDictionary
                        print(data)
                        if let btnTitle = data["btn_text"]  as? String{
                            self.btnText = btnTitle
                        }
                        if let pageTitle = data["page_title"]  as? String{
                            self.title = pageTitle
                        }
                        if let array = data["jobs"] as? NSArray {
                            self.nokri_companydataParser(companyDataArray: array)
                        }
                        if let pagination = responseData["pagination"] as? NSDictionary{
                            self.hasNextPage = pagination["has_next_page"] as? Bool
                            self.nextPage = pagination["next_page"] as? Int
                        }
                        if self.hasNextPage == true{
                            print(self.hasNextPage!)
                            //self.btnLoadMore.isHidden = false
                        }
                        if self.hasNextPage == false{
                            //self.btnLoadMore.isHidden = true
                        }
                        self.tableView.delegate = self
                        self.tableView.dataSource = self
                        self.stopAnimating()
                }
            }
        }else{
            if let userEmail = UserDefaults.standard.string(forKey: "email") {
                email = userEmail
            }
            if let userPassword = UserDefaults.standard.string(forKey: "password") {
                password = userPassword
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
                     "job_id" : job_id
                ]
                print(param)
                Alamofire.request(Constants.URL.baseUrl+Constants.URL.matchedResSingle, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers)
                    .responseJSON { response in
                        print(response.request as Any)  // original URL request
                        print(response.response as Any) // URL response
                        print(response.result.value as Any)
                        let responseData = response.value as! NSDictionary
                        self.message = responseData["message"] as? String
                        let data = responseData["data"] as! NSDictionary
                        print(data)
                        if let btnTitle = data["btn_text"]  as? String{
                            self.btnText = btnTitle
                        }
                        if let pageTitle = data["page_title"]  as? String{
                            self.title = pageTitle
                        }
                        if let array = data["jobs"] as? NSArray {
                            self.nokri_companydataParser(companyDataArray: array)
                        }
                        if let pagination = responseData["pagination"] as? NSDictionary{
                            self.hasNextPage = pagination["has_next_page"] as? Bool
                            self.nextPage = pagination["next_page"] as? Int
                        }
                        if self.hasNextPage == true{
                            print(self.hasNextPage!)
                            //self.btnLoadMore.isHidden = false
                        }
                        if self.hasNextPage == false{
                            //self.btnLoadMore.isHidden = true
                        }
                        self.tableView.delegate = self
                        self.tableView.dataSource = self
                        self.stopAnimating()
                }
            }
        }
    }
    
    func nokri_companydataParser(companyDataArray:NSArray){
        self.followerArray.removeAllObjects()
        for item in companyDataArray{
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
            self.followerArray.add(arrayOfDictionaries);
        }
        if companyDataArray.count == 0{
            nokri_tableViewHelper()
            self.tableView.reloadData()
        }else{
            nokri_tableViewHelper2()
        }
        print("\(self.followerArray.count)");
        self.tableView.reloadData()
    }

    func nokri_removeResume(parameter: NSDictionary) {
        self.showLoader()
        UserHandler.nokri_RemoveResume(parameter: parameter as NSDictionary, success: { (successResponse) in
            let hud = JGProgressHUD(style: .dark)
            hud.textLabel.text = successResponse.message!
            hud.detailTextLabel.text = nil
            hud.indicatorView = JGProgressHUDSuccessIndicatorView()
            hud.position = .bottomCenter
            hud.show(in: self.view)
            hud.dismiss(afterDelay: 2.0)
            //self.view.makeToast(successResponse.message, duration: 1.5, position: .center)
            self.nokri_saveResumeData()
            self.tableView.reloadData()
            self.stopAnimating()
        }) { (error) in
            let alert = Constants.showBasicAlert(message: error.message)
            self.present(alert, animated: true, completion: nil)
            self.stopAnimating()
        }
    }
    
    

        func load(url: URL, to localUrl: URL, completion: @escaping () -> ()) {
            let sessionConfig = URLSessionConfiguration.default
            let session = URLSession(configuration: sessionConfig)
            let request = try! URLRequest(url: url, method: .get)
            showLoader()
            let task = session.downloadTask(with: request) { (tempLocalUrl, response, error) in
                if let tempLocalUrl = tempLocalUrl, error == nil {
                    // Success
                    if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                        print("Success: \(statusCode)")
                        DispatchQueue.main.async {
                                self.perform(#selector(self.showSuccess), with: nil, afterDelay: 0.0)
                            self.stopAnimating()
                        }
                    }else{
                        //print("Success: \(statusCode)")
                        DispatchQueue.main.async {
                            self.perform(#selector(self.showSuccess), with: nil, afterDelay: 0.0)
                            self.stopAnimating()
                        }
                    }
                
                } else {
                    //print("Failure: %@", error?.localizedDescription);
                }
            }
            task.resume()
        }
        
        @objc func showSuccess(){
            let hud = JGProgressHUD(style: .dark)
            hud.textLabel.text = "Downloaded Successfully"
            hud.detailTextLabel.text = nil
            hud.indicatorView = JGProgressHUDSuccessIndicatorView()
            hud.position = .bottomCenter
            hud.show(in: self.tableView)
            hud.dismiss(afterDelay: 2.0)
        }
    
    
    
}


