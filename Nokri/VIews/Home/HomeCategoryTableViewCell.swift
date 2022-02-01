//
//  HomeCategoryTableViewCell.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 5/3/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import UIKit
import Alamofire
import NVActivityIndicatorView

class HomeCategoryTableViewCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var lblSelectCategory: UILabel!
    @IBOutlet weak var viewSeparator: UIView!
    var categoryArray  = [homeCatIcon]()
    var jobsArray = NSMutableArray()
    var catId:Int?
    var message:String?
    var nextPage:Int?
    var hasNextPage:Bool?
    var catMessage = ""
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        nokri_homeData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCategoryCollectionViewCell", for: indexPath) as! HomeCategoryCollectionViewCell
        let obj = categoryArray[indexPath.row]
        cell.imageView.sd_setImage(with: URL(string: obj.img), completed: nil)
        cell.imageView.sd_setShowActivityIndicatorView(true)
        cell.imageView.sd_setIndicatorStyle(.gray)
        cell.lblName.text = obj.name
        cell.lblJobCount.text = obj.count
        cell.btnId.tag = obj.jobCategory
        cell.btnId.addTarget(self, action:  #selector(HomeCategoryTableViewCell.nokri_btnJobDetailClicked), for: .touchUpInside)
        return cell
    }
    
    @objc func nokri_btnJobDetailClicked(_ sender: UIButton){
        catId = sender.tag
        nokri_jobDataWithFilters()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 0
        let collectionViewSize = collectionView.frame.size.width - padding
        return CGSize(width: collectionViewSize/2.5, height:122)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if collectionView.isDragging {
            cell.transform = CGAffineTransform.init(scaleX: 0.5, y: 0.5)
            UIView.animate(withDuration: 0.8, animations: {
                cell.transform = CGAffineTransform.identity
            })
        }
    }
    
    //MARK:- API Calls
    
    func nokri_homeData() {
        UserHandler.nokri_home(success: { (successResponse) in
            if successResponse.success {
                DispatchQueue.main.async {
                    self.categoryArray = successResponse.data.catIcons
                    if self.categoryArray.count == 0{
                        self.nokri_tableViewHelper()
                    }else{
                        self.nokri_tableViewHelper2()
                    }
                    self.collectionView.reloadData()
                }
            }
            else {
            }
        }) { (error) in
        }
    }
    
    
    func nokri_jobDataWithFilters(){
        
        var langCode = UserDefaults.standard.string(forKey: "langCode")
        if langCode == nil {
            langCode = "en"
        }
        
        sd_addActivityIndicator()
        
        var isTimeOut = false
        self.collectionView.isUserInteractionEnabled = false
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
            params["job_category"] = catId
            print(params)
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.advanceSearch, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    guard let res = response.value else{return}
                    let responseData = res as! NSDictionary
                    self.message = responseData["message"] as? String
                    let success = responseData["success"] as! Bool
                    if success == true{
                        self.sd_removeActivityIndicator()
                        self.collectionView.isUserInteractionEnabled = true
                        isTimeOut = true
                        var pageTitle:String?
                        let data = responseData["data"] as! NSDictionary
                        if let page = data["page_title"]  as? String{
                            pageTitle = page
                        }
                        if let JobArr = data["jobs"] as? NSArray {
                            self.nokri_jobDataParserWithFilters(jobsArr: JobArr)
                        }
                        var noJob = ""
                        if let noOfJob = data["no_txt"]  as? String{
                            noJob = noOfJob
                        }
                        if let pagination = responseData["pagination"] as? NSDictionary{
                            self.hasNextPage = pagination["has_next_page"] as? Bool
                            self.nextPage = pagination["next_page"] as? Int
                        }
                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SearchedJobViewController") as! SearchedJobViewController
                        nextViewController.jobsArray = self.jobsArray
                        nextViewController.message = self.message
                        nextViewController.pageTitle = pageTitle
                        nextViewController.hasNextPage = self.hasNextPage!
                        nextViewController.nextPage = self.nextPage
                        nextViewController.noOfJobText = noJob
                        self.viewContainingController()?.navigationController?.pushViewController(nextViewController, animated: true)
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
            params["job_category"] = catId
            print(params)
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.advanceSearch, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    guard let res = response.value else{return}
                    let responseData = res as! NSDictionary
                    self.message = responseData["message"] as? String
                    let success = responseData["success"] as! Bool
                    if success == true{
                        self.sd_removeActivityIndicator()
                        self.collectionView.isUserInteractionEnabled = true
                        isTimeOut = true
                        var pageTitle:String?
                        let data = responseData["data"] as! NSDictionary
                        if let page = data["page_title"]  as? String{
                            pageTitle = page
                        }
                        if let JobArr = data["jobs"] as? NSArray {
                            self.nokri_jobDataParserWithFilters(jobsArr: JobArr)
                        }
                        if let pagination = responseData["pagination"] as? NSDictionary{
                            self.hasNextPage = pagination["has_next_page"] as? Bool
                            self.nextPage = pagination["next_page"] as? Int
                        }
                        var noJob = ""
                        if let noOfJob = data["no_txt"]  as? String{
                            noJob = noOfJob
                        }
                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SearchedJobViewController") as! SearchedJobViewController
                        nextViewController.jobsArray = self.jobsArray
                        nextViewController.message = self.message
                        nextViewController.pageTitle = pageTitle
                        nextViewController.hasNextPage = self.hasNextPage!
                        nextViewController.nextPage = self.nextPage
                        nextViewController.noOfJobText = noJob
                        self.viewContainingController()?.navigationController?.pushViewController(nextViewController, animated: true)
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
    
    func nokri_tableViewHelper(){
        
        let rect = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: self.collectionView.bounds.size.width, height: self.collectionView.bounds.size.height))
        let messageLabel = UILabel(frame: rect)
        messageLabel.text = "No data to show"
        messageLabel.textColor = UIColor.lightGray
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont(name: "TrebuchetMS", size: 20)
        messageLabel.sizeToFit()
        collectionView.backgroundView = messageLabel
        
    }
    func nokri_tableViewHelper2(){
        
        let rect = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: self.collectionView.bounds.size.width, height: self.collectionView.bounds.size.height))
        let messageLabel = UILabel(frame: rect)
        messageLabel.text = ""
        messageLabel.textAlignment = .center;
        collectionView.backgroundView = messageLabel
        
    }
    
    
}



