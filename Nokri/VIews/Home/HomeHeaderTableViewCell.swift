//
//  HomeHeaderTableViewCell.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 5/3/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import UIKit
import Alamofire

class HomeHeaderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var viewSeparator: UIView!
    @IBOutlet weak var lblFindJob: UILabel!
    @IBOutlet weak var viewSearch: UIView!
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var txtFieldSearch: UITextField!
    @IBOutlet weak var imageViewHeader: UIImageView!
    var nextPage:Int?
    var searchedText:String?
    var hasNextPage:Bool = false
    var noOfJobs = ""
    
    var appColorNew = UserDefaults.standard.string(forKey: "app_Color")
    var message:String = ""
    var jobsArray = NSMutableArray()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //viewSearch.layer.cornerRadius = 15
        //viewSearch.roundCorners(.topLeft, radius: 15, borderColor: nil, borderWidth: nil)
        //viewSearch.roundCorners([.topRight, .bottomRight], radius: 15, borderColor: nil, borderWidth: nil)
        //btnSearch.roundCorners([.topRight, .bottomRight], radius: 15, borderColor: nil, borderWidth: nil)
    }
    

    @IBAction func searchClicked(_ sender: UIButton) {
        txtFieldSearch.resignFirstResponder()
        btnSearch.isEnabled = false
        //        if txtFieldSearch.text == ""{
        //            var confirmString:String?
        //            var btnOk:String?
        //            if let userData = UserDefaults.standard.object(forKey: "settingsData") {
        //                let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
        //                let dataTabs = SplashRoot(fromDictionary: objData)
        //                confirmString = dataTabs.data.genericTxts.confirm
        //                btnOk = dataTabs.data.genericTxts.btnConfirm
        //            }
        //            let Alert = UIAlertController(title: "Alert", message:"search field can not be empty.", preferredStyle: .alert)
        //            let okButton = UIAlertAction(title: "ok", style: .default) { _ in
        //            }
        //            Alert.addAction(okButton)
        //            self.window?.rootViewController?.present(Alert, animated: true, completion: nil)
        //        }else{
        nokri_jobDataWithFilters()
        //}
    }
    
    func nokri_jobDataWithFilters(){
        
        var langCode = UserDefaults.standard.string(forKey: "langCode")
        if langCode == nil {
            langCode = "en"
        }
        
        var isTimeOut = false
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
            params["job_title"] = txtFieldSearch.text
            print(params)
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.advanceSearch, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    guard let res = response.value else{return}
                    let responseData = res as! NSDictionary
                    self.message = (responseData["message"] as? String)!
                    let success = responseData["success"] as! Bool
                    if success == true{
                        self.btnSearch.isEnabled = true
                        isTimeOut = true
                        var pageTitle:String?
                        let data = responseData["data"] as! NSDictionary
                        if let page = data["page_title"]  as? String{
                            pageTitle = page
                        }
                        if let noOfJob = data["no_txt"]  as? String{
                            self.noOfJobs = noOfJob
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
                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SearchedJobViewController") as! SearchedJobViewController
                        nextViewController.jobsArray = self.jobsArray
                        nextViewController.message = self.message
                        nextViewController.pageTitle = pageTitle
                        nextViewController.hasNextPage = self.hasNextPage
                        nextViewController.nextPage = self.nextPage
                        nextViewController.searchedText = self.txtFieldSearch.text!
                        self.txtFieldSearch.text! = ""
                        nextViewController.noOfJobText = self.noOfJobs
                        self.viewContainingController()?.navigationController?.pushViewController(nextViewController, animated: true)
                        
                        
                        self.inputViewController?.navigationController?.pushViewController(nextViewController, animated: true)
                        
                    }else{
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
                "Nokri-Request-From" : Constants.customCodes.requestFrom,
                "Nokri-Lang-Locale" : "\(langCode!)"
            ]
            var params : [String:Any] = [:]
            params["job_title"] = txtFieldSearch.text
            print(params)
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.advanceSearch, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    guard let res = response.value else{return}
                    let responseData = res as! NSDictionary
                    self.message = (responseData["message"] as? String)!
                    let success = responseData["success"] as! Bool
                    if success == true{
                        self.btnSearch.isEnabled = true
                        isTimeOut = true
                        var pageTitle:String?
                        let data = responseData["data"] as! NSDictionary
                        if let page = data["page_title"]  as? String{
                            pageTitle = page
                        }
                        if let noOfJob = data["no_txt"]  as? String{
                            self.noOfJobs = noOfJob
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
                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SearchedJobViewController") as! SearchedJobViewController
                        nextViewController.jobsArray = self.jobsArray
                        nextViewController.message = self.message
                        nextViewController.pageTitle = pageTitle
                        nextViewController.hasNextPage = self.hasNextPage
                        nextViewController.nextPage = self.nextPage
                        nextViewController.searchedText = self.txtFieldSearch.text!
                        self.txtFieldSearch.text! = ""
                        nextViewController.noOfJobText = self.noOfJobs
                        self.viewContainingController()?.navigationController?.pushViewController(nextViewController, animated: true)
                        
                        
                        self.inputViewController?.navigationController?.pushViewController(nextViewController, animated: true)
                        
                    }else{
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
    
    func nokri_jobDataParserWithFilters(jobsArr:NSArray){
        
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
    
}


extension UIView {
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat, borderColor: UIColor?, borderWidth: CGFloat?) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        
        let mask = CAShapeLayer()
        mask.frame = self.bounds
        mask.path = path.cgPath
        self.layer.mask = mask
        
        if borderWidth != nil {
            addBorder(mask, borderWidth: borderWidth!, borderColor: borderColor!)
        }
    }
    
    private func addBorder(_ mask: CAShapeLayer, borderWidth: CGFloat, borderColor: UIColor) {
        let borderLayer = CAShapeLayer()
        borderLayer.path = mask.path
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.strokeColor = borderColor.cgColor
        borderLayer.lineWidth = borderWidth
        borderLayer.frame = bounds
        layer.addSublayer(borderLayer)
    }
}
