
//  JobDetailViewController.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 5/2/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import UIKit
import DropDown
import JGProgressHUD
import WebKit


class JobDetailViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,WKNavigationDelegate,JobDetailDelegate {
    
    
    
    //MARK:- IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnApplyNow: UIButton!
    @IBOutlet weak var btnApplyWith: UIButton!
    @IBOutlet weak var viewBottom: UIView!
    @IBOutlet weak var viewButtons: UIView!
    
    //MARK:- Proporties
    
    var webView = WKWebView()
    var appColorNew = UserDefaults.standard.string(forKey: "app_Color")
    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
    var jobId = 0
    var isFmLoc = false
    var jobInfoArr = [ViewCompanyInfo]()
    var jobContentArr = [VIewJobContent]()
    var companyInfo = [viewCompInfo]()
    var extraArr = [ViewJobExtra]()
    var nearByInfoArr = [NearByJobsDataArray]()
    var sampleArray = [Int]()
    var keyArr = [String]()
    var valArr = [String]()
    var sectionTitleTwo:String?
    var sectionTitleThree:String?
    var countArray = [String]()
    var aboutCellHeight : CGFloat = 0.0;
    var isFromAllJob:Bool?
    var jobTITLE:String?
    var linkedInUrl:String = ""
    var isCandidate:String?
    var applyMessage:String?
    var msgLogin:String?
    var isJobExpire:String?
    var compId:Int?
    var shareText:String = ""
    var jobUrl:String = ""
    var isfromJobPost = false
    var withOutLogin = UserDefaults.standard.string(forKey: "aType")
    let type = UserDefaults.standard.integer(forKey: "usrTyp")
    var isWithOutLoginApply = false
    var emailPlace = ""
    var namePlace = ""
    var apploNowTitle = ""
    var jobType = ""
    var externalUrl = ""
    var inValidUrl:String = ""
    var email = ""
    var isApplied = false
    var alrearApplyText = ""
    var resumeCheck = 0
    var heightNearBy: Double = 0
    var jobIdNearBY = 0
    var nearByOnOff = ""
    var neabySectionTitle = ""

    //MARK:- VIew Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.delegate = self
        tableView.dataSource = self
        //        self.tableView.register(UINib(nibName: "NearbyJobs", bundle: nil), forCellReuseIdentifier: "NearbyJobs")
        
        nokri_viewJob()
        viewBottom.isHidden = false
        self.showBackButton()
        showSearchButton()
        if isfromJobPost == true{
            //addLeftBarButtonWithImage(UIImage(named: "menu")!)
        }
        viewBottom.isHidden = true
    }
    
    //MARK:- IBAction
    
    @IBAction func btnApplyWithClicked(_ sender: UIButton) {
        
        if withOutLogin == "5"{
            let userData = UserDefaults.standard.object(forKey: "settingsData")
            let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
            let dataTabs = SplashRoot(fromDictionary: objData)
            let alertLog = UIAlertController(title: nil, message: self.applyMessage, preferredStyle: .alert)
            let btnOk = UIAlertAction(title: dataTabs.data.extra.confTitle, style: .default) { (ok) in
                print("Ok")
                appDelegate.nokri_moveToSignIn()
            }
            let btnCancel = UIAlertAction(title: dataTabs.data.extra.btnCancel, style: .destructive) { (cancel) in
                print("Cancel")
            }
            alertLog.addAction(btnCancel)
            alertLog.addAction(btnOk)
            self.present(alertLog, animated: true, completion: nil)
        }else{
            if self.isCandidate! == "0"{
                let alert = Constants.showBasicAlert(message: self.applyMessage!)
                self.present(alert, animated: true, completion: nil)
            }else{
                //linkedInAuthVC()
                let linkedVc = self.storyboard?.instantiateViewController(withIdentifier: "ApplyWithLinkedViewController") as! ApplyWithLinkedViewController
                linkedVc.modalPresentationStyle = .overCurrentContext
                linkedVc.jobId = self.jobId
                view.transform = CGAffineTransform(scaleX: 0.8, y: 1.2)
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
                    self.view.transform = .identity
                }) { (success) in
                    self.present(linkedVc, animated: true, completion: nil)
                }
            }
        }
    }
    
    @IBAction func btnApplyNowClicked(_ sender: UIButton) {
        
        if isApplied == true{
            let alert = Constants.showBasicAlert(message: self.alrearApplyText)
            self.present(alert, animated: true, completion: nil)
        }else{
            
            if self.withOutLogin == "5" && isWithOutLoginApply == false {
                
                let userData = UserDefaults.standard.object(forKey: "settingsData")
                let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
                let dataTabs = SplashRoot(fromDictionary: objData)
                
                
                let alertLog = UIAlertController(title: nil, message: self.applyMessage, preferredStyle: .alert)
                let btnOk = UIAlertAction(title: dataTabs.data.extra.confTitle, style: .default) { (ok) in
                    print("Ok")
                    appDelegate.nokri_moveToSignIn()
                }
                let btnCancel = UIAlertAction(title: dataTabs.data.extra.btnCancel, style: .destructive) { (cancel) in
                    print("Cancel")
                }
                alertLog.addAction(btnCancel)
                alertLog.addAction(btnOk)
                
                self.present(alertLog, animated: true, completion: nil)
                
            }else{
                if self.isCandidate! == "0"{
                    let alert = Constants.showBasicAlert(message: self.applyMessage!)
                    self.present(alert, animated: true, completion: nil)
                }else{
                    if jobType == "exter"{
                        if let userData = UserDefaults.standard.object(forKey: "settingsData") {
                            let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
                            let dataTabs = SplashRoot(fromDictionary: objData)
                            inValidUrl = dataTabs.data.extra.invalid_url
                            let alert = UIAlertController(title: dataTabs.data.extra.confTitle, message: dataTabs.data.extra.confContent, preferredStyle: UIAlertController.Style.alert)
                            let OkAction = UIAlertAction(title: dataTabs.data.extra.btnConfirm, style: .default) { (ok) in
                                if #available(iOS 10.0, *) {
                                    if self.verifyUrl(urlString: self.externalUrl) == false {
                                        let hud = JGProgressHUD(style: .dark)
                                        hud.textLabel.text = self.inValidUrl
                                        hud.detailTextLabel.text = nil
                                        hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                                        hud.position = .bottomCenter
                                        hud.show(in: self.view)
                                        hud.dismiss(afterDelay: 2.0)
                                    }else{
                                        let params:NSDictionary = ["job_id":self.jobId]
                                        print(params)
                                        self.nokri_ExternalApply(parameter: params)
                                    }
                                } else {
                                    
                                    if self.verifyUrl(urlString: self.externalUrl) == false {
                                        self.view.makeToast(self.inValidUrl)
                                        let hud = JGProgressHUD(style: .dark)
                                        hud.textLabel.text = self.inValidUrl
                                        hud.detailTextLabel.text = nil
                                        hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                                        hud.position = .bottomCenter
                                        hud.show(in: self.view)
                                        hud.dismiss(afterDelay: 2.0)
                                    }else{
                                        let params:NSDictionary = ["job_id":self.jobId]
                                        print(params)
                                        self.nokri_ExternalApply(parameter: params)
                                    }
                                }
                                
                            }
                            let cancelAction = UIAlertAction(title: dataTabs.data.extra.btnCancel, style: .cancel) { (cancel) in
                            }
                            alert.addAction(OkAction)
                            alert.addAction(cancelAction)
                            self.present(alert, animated: true, completion: nil)
                        }
                    }else if jobType == "mail"{
                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ApplyNowViewController") as! ApplyNowViewController
                        nextViewController.jobId = jobId
                        nextViewController.jobTitle = jobTITLE
                        nextViewController.isWithOutLoginApply = isWithOutLoginApply
                        nextViewController.isWithOutLoginApply = isWithOutLoginApply
                        nextViewController.emailPlaceholder = emailPlace
                        nextViewController.namePlaceHolder = namePlace
                        nextViewController.titleIs = apploNowTitle
                        nextViewController.mail = "mail"
                        nextViewController.isCvRequired = resumeCheck
                        nextViewController.modalPresentationStyle = .overCurrentContext
                        nextViewController.modalTransitionStyle = .flipHorizontal
                        self.navigationController?.pushViewController(nextViewController, animated: true)
                    }else if jobType == "whatsapp"{
                        
                        if let userData = UserDefaults.standard.object(forKey: "settingsData") {
                            let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
                            let dataTabs = SplashRoot(fromDictionary: objData)
                            inValidUrl = dataTabs.data.extra.invalid_url
                            let alert = UIAlertController(title: dataTabs.data.extra.confTitle, message: dataTabs.data.extra.confContent, preferredStyle: UIAlertController.Style.alert)
                            let OkAction = UIAlertAction(title: dataTabs.data.extra.btnConfirm, style: .default) { (ok) in
                                self.openWhatsApp(number: self.externalUrl)
                                
                            }
                            let cancelAction = UIAlertAction(title: dataTabs.data.extra.btnCancel, style: .destructive) { (cancel) in
                            }
                            alert.addAction(OkAction)
                            alert.addAction(cancelAction)
                            self.present(alert, animated: true, completion: nil)
                        }
                        
                        
                        
                        
                        
                    }else{
                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ApplyNowViewController") as! ApplyNowViewController
                        nextViewController.jobId = jobId
                        nextViewController.jobTitle = jobTITLE
                        nextViewController.isWithOutLoginApply = isWithOutLoginApply
                        nextViewController.isWithOutLoginApply = isWithOutLoginApply
                        nextViewController.emailPlaceholder = emailPlace
                        nextViewController.namePlaceHolder = namePlace
                        nextViewController.titleIs = apploNowTitle
                        nextViewController.isCvRequired = resumeCheck
                        nextViewController.modalPresentationStyle = .overCurrentContext
                        nextViewController.modalTransitionStyle = .flipHorizontal
                        self.navigationController?.pushViewController(nextViewController, animated: true)
                    }
                    
                }
            }
        }
        
    }
    
    @IBAction func btnBookMarkClicked(_ sender: UIButton) {
        print(isCandidate!)
        if withOutLogin == "5"{
            let alert = Constants.showBasicAlert(message: self.applyMessage!)
            self.present(alert, animated: true, completion: nil)
        }else{
            if self.isCandidate! == "0"{
                let alert = Constants.showBasicAlert(message: self.applyMessage!)
                self.present(alert, animated: true, completion: nil)
            }else{
                let params:NSDictionary = ["job_id":jobId]
                print(params)
                nokri_BookMarkJob(parameter: params)
            }
        }
    }
    
    @IBAction func btnShareClicked(_ sender: Any) {
        let jobTitle = jobTITLE
        if let jobURL = NSURL(string: jobUrl) {
            let objectsToShare = [jobTitle!, jobURL] as [Any]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            activityVC.popoverPresentationController?.sourceView = sender as? UIView
            self.present(activityVC, animated: true, completion: nil)
        }
    }
    
    //MARK:- Custome Functions
    
    func stringToDictionary(text:String)->[String:Any]?{
        if let data = text.data(using: .utf8){
            do{
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]
            }catch{
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    func verifyUrl (urlString: String?) -> Bool {
        //Check for nil
        if let urlString = urlString {
            // create NSURL instance
            if let url = NSURL(string: urlString) {
                // check if your application can open the NSURL instance
                return UIApplication.shared.canOpenURL(url as URL)
            }
        }
        return false
    }
    
    func nokri_populateData(){
        
        for obj in extraArr{
            
            if obj.fieldTypeName == "short_desc"{
                sectionTitleTwo = obj.key
            }
            if obj.fieldTypeName == "job_desc"{
                sectionTitleThree = obj.key
            }
            // if type != 1{
            if obj.fieldTypeName == "job_apply"{
                //lblApplyNow.text = obj.key
                self.apploNowTitle = obj.key
                self.btnApplyNow.layer.borderWidth = 1
                self.btnApplyNow.layer.borderColor = UIColor.groupTableViewBackground.cgColor
                self.btnApplyNow.layer.cornerRadius = 20
                self.btnApplyNow.backgroundColor = UIColor(hex: appColorNew!)
            }
            if obj.fieldTypeName == "upload_resume_option"{
                resumeCheck = obj.resumeCheck
                
            }
            if obj.fieldTypeName == "book_mark"{
                //lblBookMark.text = obj.key
            }
            if obj.fieldTypeName == "already_applied"{
                alrearApplyText = obj.key
            }
            
            if obj.fieldTypeName == "apply_linked"{
                self.btnApplyWith.setTitle(obj.key, for: .normal)
                self.btnApplyWith.layer.borderWidth = 1
                self.btnApplyWith.layer.borderColor = UIColor.groupTableViewBackground.cgColor
                self.btnApplyWith.layer.cornerRadius = 20
            }
            if obj.fieldTypeName == "page_title"{
                self.title = obj.key
            }
            if obj.fieldTypeName == "cand_bookmark"{
                self.applyMessage = obj.key
            }
            if obj.fieldTypeName == "is_login"{
                self.msgLogin = obj.key
            }
            if obj.fieldTypeName == "share_job"{
                self.jobUrl = obj.value
            }
            if obj.fieldTypeName == "apply_without_check"{
                isWithOutLoginApply = obj.isjobApplyAllow
            }
            if obj.fieldTypeName == "cand_name"{
                namePlace = obj.key
            }
            if obj.fieldTypeName == "cand_email"{
                emailPlace = obj.key
            }
            
            if obj.fieldTypeName == "job_apply_with"{
                jobType = obj.value
            }
            
            if obj.fieldTypeName == "job_apply_url"{
                if obj.value != nil{
                    externalUrl = obj.value
                }
            }
            if obj.fieldTypeName == "apply_status"{
                if obj.valueBool != nil{
                    if obj.valueBool == true{
                        isApplied = true
                        let userData = UserDefaults.standard.object(forKey: "settingsData")
                        let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
                        let dataTabs = SplashRoot(fromDictionary: objData)
                        let appliedText = dataTabs.data.extra.applied
                        self.btnApplyNow.setTitle(appliedText, for: .normal)
                        self.btnApplyNow.backgroundColor = UIColor.systemGreen
                        
                    }else{
                        self.btnApplyNow.setTitle(self.apploNowTitle, for: .normal)
                        
                    }
                }
            }
            
        }
        for ab in jobInfoArr{
            if  ab.value == "" || ab.fieldTypeName == "is_candidate" || ab.fieldTypeName == "job_expire" || ab.fieldTypeName == "job_apply" {
                print("Do not add...!")
            }else{
                if ab.value != nil {
                    keyArr.append(ab.key)
                    valArr.append(ab.value!)
                }
            }
        }
        
    }
    
    //MARK:- TableView
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }else if section == 1{
            return valArr.count //sampleArray.count
        }else if section == 2{
            return 1
        }
        else  if section == 3{
            return 1
        }
        else if section == 5 {
            return 1
            //nearByInfoArr.count
        }
        else{
            return 1
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "JobDetailHeaderTableViewCell", for: indexPath) as! JobDetailHeaderTableViewCell
            for obj in jobInfoArr{
                if obj.fieldTypeName == "job_title"{
                    cell.lblJobTitle.text = obj.value
                    jobTITLE = obj.value
                    
                }
                if obj.fieldTypeName == "job_cat"{
                    cell.lblJobType.text = obj.value
                }
                if obj.fieldTypeName == "job_last"{
                    cell.lblLastDateKey.text = obj.key
                    cell.lblLastDateValue.text = obj.value
                }
                if obj.fieldTypeName == "is_candidate"{
                    isCandidate = obj.value
                }
                
                if isCandidate == "0"{
                    viewBottom.isHidden = true
                }else{
                    viewBottom.isHidden = false
                }
                
                if obj.fieldTypeName == "job_expire"{
                    isJobExpire = obj.value
                    print(isJobExpire!)
                    if isJobExpire == "true"{
                        cell.viewDate.backgroundColor = UIColor.red
                        cell.lblLastDateKey.isHidden = true
                        cell.lblLastDateValue.isHidden = true
                        cell.lblExpiry.isHidden = false
                        cell.lblExpiry.text = obj.key
                        viewBottom.isHidden = true
                    }
                }
            }
            return cell
        }else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "JobDetailShortDescriptionTableViewCell", for: indexPath) as! JobDetailShortDescriptionTableViewCell
            cell.lblKey.text = keyArr[indexPath.row]
            cell.lblValue.text = valArr[indexPath.row]
            if valArr[indexPath.row].contains("www.") {
                cell.lblValue.textColor = UIColor.blue
                cell.btnLink.backgroundColor = UIColor.clear
            }else{
                cell.btnLink.isUserInteractionEnabled = false
            }
            return cell
        }else if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "JobDetailJobDescriptionTableViewCell", for: indexPath) as! JobDetailJobDescriptionTableViewCell
            for obj in jobContentArr{
                if obj.fieldTypeName == "job_content"{
                    let htmlString = obj.value
                    let strokeTextAttributes: [NSAttributedString.Key: Any] = [
                        .foregroundColor : UIColor.gray,
                        .font :  UIFont(name:"Open Sans",size:13)!
                    ]
                    let data = htmlString?.data(using: String.Encoding.unicode.rawValue)!
                    let attrStr = try? NSAttributedString(
                        data: data!,
                        options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html],
                        documentAttributes: nil)
                    cell.lblDescription.attributedText = NSMutableAttributedString(string: (attrStr?.string)!, attributes: strokeTextAttributes)
                    self.aboutCellHeight = (cell.lblDescription.attributedText?.height(withConstrainedWidth: self.view.frame.size.width))!+25;
                }
            }
            return cell
        }else if indexPath.section == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "JobDetailButtonTableViewCell", for: indexPath) as! JobDetailButtonTableViewCell
            
            if isCandidate == "0"{
                cell.isHidden = true
            }else{
                cell.isHidden = false
            }
            
            for obj in extraArr{
                if obj.fieldTypeName == "share_job"{
                    cell.btnShare.setTitle(obj.key, for: .normal)
                }
                if obj.fieldTypeName == "book_mark"{
                    cell.btnBookrMark.setTitle(obj.key, for: .normal)
                }
                cell.btnBookrMark.layer.borderWidth = 1
                cell.btnBookrMark.layer.borderColor = UIColor.groupTableViewBackground.cgColor
                cell.btnBookrMark.layer.cornerRadius = 20
                cell.btnShare.layer.borderWidth = 1
                cell.btnShare.layer.borderColor = UIColor.groupTableViewBackground.cgColor
                cell.btnShare.layer.cornerRadius = 20
            }
            cell.btnBookrMark.addTarget(self, action:  #selector(JobDetailViewController.nokri_btnBookMarkClicked), for: .touchUpInside)
            cell.btnShare.addTarget(self, action:  #selector(JobDetailViewController.nokri_btnShareClicked), for: .touchUpInside)
            
            return cell
        }
        
        else if indexPath.section == 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "JobDetailFooterTableViewCell", for: indexPath) as! JobDetailFooterTableViewCell
            for obj in companyInfo{
                if obj.fieldTypeName == "comp_name"{
                    cell.lblCompanyName.text = obj.value
                }
                if obj.fieldTypeName == "comp_web"{
                    cell.lblCompEmail.text = obj.value
                }
                if obj.fieldTypeName == "company_adress"{
                    cell.lblAddress.text = obj.value
                }
                if obj.fieldTypeName == "comp_img"{
                    if obj.value != nil {
                        
                        if let imageUrl = URL(string: obj.value){
                            cell.imageViewJobDetailFooter.sd_setImage(with: imageUrl, completed: nil)
                            cell.imageViewJobDetailFooter.sd_setShowActivityIndicatorView(true)
                            cell.imageViewJobDetailFooter.sd_setIndicatorStyle(.gray)
                        }
                    }
                }
            }
            cell.btnCompDetail.addTarget(self, action:  #selector(JobDetailViewController.nokri_btnCompanyDetailClicked), for: .touchUpInside)
            return cell
        }
        else  {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NearbyJobs", for: indexPath) as! NearbyJobs
            cell.dataArray = nearByInfoArr
            print(nearByInfoArr.count)
            heightNearBy =  Double(cell.collcetionView.contentSize.height)
            //Double(cell.collcetionView.contentSize.height)
            //            heightNearBy =  Double(cell.collcetionView.frame.size.height)
            //Double(cell.collcetionView.collectionViewLayout.collectionViewContentSize.height)
            cell.delegate = self
            print(heightNearBy)
            cell.collcetionView.reloadData()
            
            return cell
            
        }
    }
    
    
    
    @objc func nokri_btnCompanyDetailClicked(_ sender: UIButton){
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CompanyDetailViewController") as! CompanyDetailViewController
        UserDefaults.standard.set(compId, forKey: "comp_Id")
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height: CGFloat = 0
        
        if indexPath.section == 0{
            return 87
        }else if (indexPath.section == 1){
            return 50//UITableViewAutomaticDimension
        }else if indexPath.section == 2{
            return self.aboutCellHeight
        }else if indexPath.section == 3 {
            
            if isCandidate == "0"{
                return 0
            }else{
                return 100
            }
        }
        else if indexPath.section == 4 {
            return 250
        }
        else if indexPath.section == 5 {
            if nearByOnOff == "1"{
                height = CGFloat(heightNearBy) + 30
            }
            else {
                height = 0
            }
        }
        else{
            height = 220
        }
        return height
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        tableView.headerView(forSection: 0)?.isHidden = true
        tableView.headerView(forSection: 3)?.isHidden = true
//        tableView.headerView(forSection: 5)?.isHidden = true
        
        if section == 1 {
            return sectionTitleTwo
        }else if section == 2 {
            return sectionTitleThree
        }
        else if section == 5 {
            return neabySectionTitle
            
        }
        else {
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0{
            return 0
        }
        else if section == 3{
            return 0
        }
        else if section == 4{
            return 0
        }
        else if section == 5{
            if nearByOnOff == "1"{
                return 40
            }
            else{
                return 0
            }
        }
        else{
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
    
    @objc func nokri_btnBookMarkClicked(_ sender: UIButton){
        print(isCandidate!)
        if withOutLogin == "5"{
            let alert = Constants.showBasicAlert(message: self.applyMessage!)
            self.present(alert, animated: true, completion: nil)
        }else{
            if self.isCandidate! == "0"{
                let alert = Constants.showBasicAlert(message: self.applyMessage!)
                self.present(alert, animated: true, completion: nil)
            }else{
                let params:NSDictionary = ["job_id":jobId]
                print(params)
                nokri_BookMarkJob(parameter: params)
            }
        }
    }
    
    @objc func nokri_btnShareClicked(_ sender: UIButton){
        let jobTitle = jobTITLE
        if let jobURL = NSURL(string: jobUrl) {
            let objectsToShare = [jobTitle!, jobURL] as [Any]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            activityVC.popoverPresentationController?.sourceView = sender 
            self.present(activityVC, animated: true, completion: nil)
        }
    }
    //MARK:-Deleagate Methods for NearByjobdetail
    func goToJobDetail(job_id: Int) {
//        print(job_id)
//        jobIdNearBY = job_id
//        print(jobIdNearBY)
//        jobId = 0
//        jobId =  jobIdNearBY
//        print(jobId)
//
//        nokri_viewJob()
        let nextViewController = self.storyBoard.instantiateViewController(withIdentifier: "JobDetailViewController") as! JobDetailViewController
        nextViewController.jobId = job_id
        self.pushVC(nextViewController, completion: nil)

    }
    
    func nokri_viewJob() {
        self.tableView.isHidden = true
        self.viewBottom.isHidden = true
        self.viewButtons.isHidden = true
        print (jobId)
        let params:NSDictionary = ["job_id":jobId]
        print(params)
        self.showLoader()
        UserHandler.nokri_viewJob(parameter: params as NSDictionary, success: { (successResponse) in
            self.stopAnimating()
            if successResponse.success == true{
                self.viewBottom.isHidden = false
                self.tableView.isHidden = false
                self.viewButtons.isHidden = false
                self.jobInfoArr = successResponse.data.jobInfo
                self.jobContentArr = successResponse.data.jobContent
                self.companyInfo = successResponse.data.compInfo
                self.extraArr = successResponse.data.extras
                self.nearByInfoArr =  successResponse.data.nearByJobsInfo
                self.nearByOnOff = successResponse.data.nearBySwitch
                self.neabySectionTitle = successResponse.data.nearbySectionTitle
                self.nokri_populateData()
                self.tableView.reloadData()
            }
            else {
                self.tableView.isHidden = true
                self.viewBottom.isHidden = true
                self.viewButtons.isHidden = true
                let alert = Constants.showBasicAlert(message: successResponse.message)
                self.present(alert, animated: true, completion: nil)
                self.stopAnimating()
            }
        }) { (error) in
            self.tableView.isHidden = true
            self.viewBottom.isHidden = true
            self.viewButtons.isHidden = true
            let alert = Constants.showBasicAlert(message: error.message)
            self.present(alert, animated: true, completion: nil)
            self.stopAnimating()
        }
    }
    
    func nokri_BookMarkJob(parameter: NSDictionary) {
        self.showLoader()
        UserHandler.nokri_bookMarkJob(parameter: parameter as NSDictionary, success: { (successResponse) in
            self.stopAnimating()
            if successResponse.success == true{
                let hud = JGProgressHUD(style: .dark)
                hud.textLabel.text = successResponse.message
                hud.detailTextLabel.text = nil
                hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                hud.position = .bottomCenter
                hud.show(in: self.view)
                hud.dismiss(afterDelay: 2.0)
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
    
    func nokri_ExternalApply(parameter: NSDictionary) {
        self.showLoader()
        UserHandler.nokri_ExternalApply(parameter: parameter as NSDictionary, success: { (successResponse) in
            self.stopAnimating()
            if successResponse.success == true{
                
                if #available(iOS 10.0, *) {
                    
                    UIApplication.shared.open(URL(string: self.externalUrl)!, options: [:], completionHandler: nil)
                    
                } else {
                    
                    UIApplication.shared.open(URL(string: self.externalUrl)!, options: [:], completionHandler: nil)
                    
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
    
    func nokri_loginPostSocial(parameter: NSDictionary) {
        self.showLoader()
        UserHandler.nokri_loginUserFb(parameter: parameter as NSDictionary, success: { (successResponse) in
            self.stopAnimating()
            if successResponse.success == true {
                guard UserHandler.sharedInstance.objFbUser != nil else {
                    return
                }
                //print(data.acountType)
                let param: [String: Any] = [
                    "job_id": self.jobId,
                    "url":self.linkedInUrl
                ]
                print(param)
                self.nokri_applyPost(parameter: param as NSDictionary)
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
    
    func nokri_applyPost(parameter: NSDictionary) {
        self.showLoader()
        UserHandler.nokri_applyJobPost(parameter: parameter as NSDictionary, success: { (successResponse) in
            self.stopAnimating()
            if successResponse.success == true{
                //self.view.makeToast(successResponse.message, duration: 1.5, position: .center)
                let hud = JGProgressHUD(style: .dark)
                hud.textLabel.text = successResponse.message
                hud.detailTextLabel.text = nil
                hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                hud.position = .bottomCenter
                hud.show(in: self.view)
                hud.dismiss(afterDelay: 2.0)
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
    
    //MARK:- LinkedIn
    
    func linkedInAuthVC() {
        // Create linkedIn Auth ViewController
        let linkedInVC = UIViewController()
        // Create WebView
        //let webView = WKWebView()
        webView.navigationDelegate = self
        linkedInVC.view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: linkedInVC.view.topAnchor),
            webView.leadingAnchor.constraint(equalTo: linkedInVC.view.leadingAnchor),
            webView.bottomAnchor.constraint(equalTo: linkedInVC.view.bottomAnchor),
            webView.trailingAnchor.constraint(equalTo: linkedInVC.view.trailingAnchor)
        ])
        
        let state = "linkedin\(Int(NSDate().timeIntervalSince1970))"
        
        let authURLFull = Constants.LinkedInConstants.AUTHURL + "?response_type=code&client_id=" + Constants.LinkedInConstants.CLIENT_ID + "&scope=" + Constants.LinkedInConstants.SCOPE + "&state=" + state + "&redirect_uri=" + Constants.LinkedInConstants.REDIRECT_URI
        
        
        let urlRequest = URLRequest.init(url: URL.init(string: authURLFull)!)
        webView.load(urlRequest)
        
        // Create Navigation Controller
        let navController = UINavigationController(rootViewController: linkedInVC)
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(self.cancelAction))
        linkedInVC.navigationItem.leftBarButtonItem = cancelButton
        let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(self.refreshAction))
        linkedInVC.navigationItem.rightBarButtonItem = refreshButton
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navController.navigationBar.titleTextAttributes = textAttributes
        linkedInVC.navigationItem.title = "linkedin.com"
        navController.navigationBar.isTranslucent = false
        navController.navigationBar.tintColor = UIColor.white
        // navController.navigationBar.barTintColor = UIColor.colorFromHex("#0072B1")
        navController.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        navController.modalTransitionStyle = .coverVertical
        
        self.present(navController, animated: true, completion: nil)
    }
    @objc func cancelAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func refreshAction() {
        self.webView.reload()
    }
    
    
    
    
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        RequestForCallbackURL(request: navigationAction.request)
        
        //Close the View Controller after getting the authorization code
        if let urlStr = navigationAction.request.url?.absoluteString {
            if urlStr.contains("?code=") {
                self.dismiss(animated: true, completion: nil)
            }
        }
        decisionHandler(.allow)
    }
    
    func RequestForCallbackURL(request: URLRequest) {
        // Get the authorization code string after the '?code=' and before '&state='
        let requestURLString = (request.url?.absoluteString)! as String
        if requestURLString.hasPrefix(Constants.LinkedInConstants.REDIRECT_URI) {
            if requestURLString.contains("?code=") {
                if let range = requestURLString.range(of: "=") {
                    let linkedinCode = requestURLString[range.upperBound...]
                    if let range = linkedinCode.range(of: "&state=") {
                        let linkedinCodeFinal = linkedinCode[..<range.lowerBound]
                        handleAuth(linkedInAuthorizationCode: String(linkedinCodeFinal))
                    }
                }
            }
        }
    }
    
    func handleAuth(linkedInAuthorizationCode: String) {
        linkedinRequestForAccessToken(authCode: linkedInAuthorizationCode)
    }
    
    func linkedinRequestForAccessToken(authCode: String) {
        let grantType = "authorization_code"
        
        // Set the POST parameters.
        let postParams = "grant_type=" + grantType + "&code=" + authCode + "&redirect_uri=" + Constants.LinkedInConstants.REDIRECT_URI + "&client_id=" + Constants.LinkedInConstants.CLIENT_ID + "&client_secret=" + Constants.LinkedInConstants.CLIENT_SECRET
        let postData = postParams.data(using: String.Encoding.utf8)
        let request = NSMutableURLRequest(url: URL(string: Constants.LinkedInConstants.TOKENURL)!)
        request.httpMethod = "POST"
        request.httpBody = postData
        request.addValue("application/x-www-form-urlencoded;", forHTTPHeaderField: "Content-Type")
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task: URLSessionDataTask = session.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
            let statusCode = (response as! HTTPURLResponse).statusCode
            if statusCode == 200 {
                let results = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [AnyHashable: Any]
                
                let accessToken = results?["access_token"] as! String
                print("accessToken is: \(accessToken)")
                
                let expiresIn = results?["expires_in"] as! Int
                print("expires in: \(expiresIn)")
                
                // Get user's id, first name, last name, profile pic url
                self.fetchLinkedInUserProfile(accessToken: accessToken)
            }
        }
        task.resume()
    }
    
    
    func fetchLinkedInUserProfile(accessToken: String) {
        let tokenURLFull = "https://api.linkedin.com/v2/me?projection=(id,firstName,lastName,profilePicture(displayImage~:playableStreams))&oauth2_access_token=\(accessToken)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let verify: NSURL = NSURL(string: tokenURLFull!)!
        let request: NSMutableURLRequest = NSMutableURLRequest(url: verify as URL)
        let task = URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
            if error == nil {
                let linkedInProfileModel = try? JSONDecoder().decode(LinkedInProfileModel.self, from: data!)
                
                //AccessToken
                print("LinkedIn Access Token: \(accessToken)")
                //self.linkedInAccessToken = accessToken
                
                // LinkedIn Id
                let linkedinId: String! = linkedInProfileModel?.id
                print("LinkedIn Id: \(linkedinId ?? "")")
                // self.linkedInId = linkedinId
                
                // LinkedIn First Name
                let linkedinFirstName: String! = linkedInProfileModel?.firstName.localized.enUS
                print("LinkedIn First Name: \(linkedinFirstName ?? "")")
                // self.linkedInFirstName = linkedinFirstName
                
                // LinkedIn Last Name
                let linkedinLastName: String! = linkedInProfileModel?.lastName.localized.enUS
                print("LinkedIn Last Name: \(linkedinLastName ?? "")")
                // self.linkedInLastName = linkedinLastName
                
                // LinkedIn Profile Picture URL
                let linkedinProfilePic: String!
                
                /*
                 Change row of the 'elements' array to get diffrent size of the profile url
                 elements[0] = 100x100
                 elements[1] = 200x200
                 elements[2] = 400x400
                 elements[3] = 800x800
                 */
                if let pictureUrls = linkedInProfileModel?.profilePicture.displayImage.elements[2].identifiers[0].identifier {
                    linkedinProfilePic = pictureUrls
                } else {
                    linkedinProfilePic = "Not exists"
                }
                print("LinkedIn Profile Avatar URL: \(linkedinProfilePic ?? "")")
                //self.linkedInProfilePicURL = linkedinProfilePic
                
                // Get user's email address
                self.fetchLinkedInEmailAddress(accessToken: accessToken)
            }
        }
        task.resume()
    }
    
    func fetchLinkedInEmailAddress(accessToken: String) {
        let tokenURLFull = "https://api.linkedin.com/v2/emailAddress?q=members&projection=(elements*(handle~))&oauth2_access_token=\(accessToken)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let verify: NSURL = NSURL(string: tokenURLFull!)!
        let request: NSMutableURLRequest = NSMutableURLRequest(url: verify as URL)
        let task = URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
            if error == nil {
                let linkedInEmailModel = try? JSONDecoder().decode(LinkedInEmailModel.self, from: data!)
                
                // LinkedIn Email
                let linkedinEmail: String! = linkedInEmailModel?.elements[0].elementHandle.emailAddress
                print("LinkedIn Email: \(linkedinEmail ?? "")")
                self.email = linkedinEmail
                
                DispatchQueue.main.async {
                    let param: [String: Any] = [
                        "email": linkedinEmail!,
                        "type": "social"
                    ]
                    print(param)
                    
                    //self.isSocial = true
                    // UserDefaults.standard.set(self.email, forKey: "email")
                    //UserDefaults.standard.set(self.isSocial, forKey: "isSocial")
                    UserDefaults.standard.set("1122", forKey: "password")
                    UserDefaults.standard.set(7, forKey: "aType")
                    self.nokri_loginPostSocial(parameter: param as NSDictionary)
                    
                }
            }
        }
        task.resume()
    }
    
    
    func openWhatsApp(number : String){
        var fullMob = number
        fullMob = fullMob.replacingOccurrences(of: " ", with: "")
        fullMob = fullMob.replacingOccurrences(of: "+", with: "")
        fullMob = fullMob.replacingOccurrences(of: "-", with: "")
        let urlWhats = "whatsapp://send?phone=\(fullMob)"
        
        if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) {
            if let whatsappURL = NSURL(string: urlString) {
                if UIApplication.shared.canOpenURL(whatsappURL as URL) {
                    UIApplication.shared.open(whatsappURL as URL, options: [:], completionHandler: { (Bool) in
                    })
                } else {
                    let alert = Constants.showBasicAlert(message: self.applyMessage!)
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
}

extension UIViewController {
    
    // MARK: - VC Flow
    open func pushVC(_ vc: UIViewController, completion: (() -> Swift.Void)?) {
        CATransaction.begin()
        navigationController?.pushViewController(vc, animated: true)
        
        CATransaction.setCompletionBlock({
            completion?()
        })
        CATransaction.commit()
    }
    
}

