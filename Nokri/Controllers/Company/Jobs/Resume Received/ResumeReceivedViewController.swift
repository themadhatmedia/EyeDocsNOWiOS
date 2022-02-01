//
//  ResumeReceivedViewController.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 4/19/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import UIKit
import DropDown
import Alamofire
import JGProgressHUD

class ResumeReceivedViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate , URLSessionTaskDelegate, URLSessionDownloadDelegate , UIDocumentInteractionControllerDelegate {

    //Mark:- IBOutlets
    
    @IBOutlet weak var btnDropDown: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblDropDownValue: UILabel!
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var pageTitle: UILabel!
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var iconDropDown: UIImageView!
    @IBOutlet weak var viewSearch: UIView!
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var txtSearch: UITextField!
     @IBOutlet weak var btnLoadMore: UIButton!
    //@IBOutlet weak var viewSearch: UIView!
    @IBOutlet weak var viewSearch2: UIView!
    @IBOutlet weak var viewSearchCountry: UIView!
    @IBOutlet weak var lblDropDownCoVal: UILabel!
    @IBOutlet weak var btnCountry: UIButton!
    @IBOutlet weak var viewGender: UIView!
    @IBOutlet weak var lblDropDownGendVal: UILabel!
    @IBOutlet weak var btnDropDownGender: UIButton!
    @IBOutlet weak var iconDropDownGender: UIImageView!
    @IBOutlet weak var iconDropDownLoc: UIImageView!
    
    
    
    
    //MARK:- Proporties
    
    var appColorNew = UserDefaults.standard.string(forKey: "app_Color")
    let dropDown = DropDown()
    let dropDownGender = DropDown()
    var resumeReceivedArr =  NSMutableArray()
    var message:String?
    var filterArray = NSMutableArray()
    var genderArrayData = NSMutableArray()
    var jobId:Int?
    let dropDownSecond = DropDown()
    var dropDownArrSecond = [String]()
    var senderButtonTag:Int?
    var downloadUrl:String?
    var backgroundSession : URLSession?
    var bgtaks : URLSessionDownloadTask?
    var documentInteractionController : UIDocumentInteractionController?
    var nextPage:Int?
    var hasNextPage:Bool?
    var isFromSearch:Bool = false
    var fileUrl:URL?
    var isCoverLetter:Bool = true
    var titleCoverLetter:String = ""
    var coverLetterValue:String = ""
    private lazy var uploadingProgressBar: JGProgressHUD = {
        let progressBar = JGProgressHUD(style: .dark)
        progressBar.indicatorView = JGProgressHUDRingIndicatorView()
        progressBar.textLabel.text = "Uploading"
        return progressBar
    }()
    var statusKeyArr = [String]()
    var statusValArr = [String]()
    var genderKeyArr = [String]()
    var genderValArr = [String]()
    var questArr = [String]()
    var ansArr = [String]()
    var countryArray = NSMutableArray()
    var stateArray = NSMutableArray()
    var cityArray = NSMutableArray()
    var townArray = NSMutableArray()
    var genderSelectedKey = 0
   
    //MARK:- View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        //nokri_dropDownSetupTwo()
        nokri_customeButton()
        cutomeButton()
        iconDropDown.image = iconDropDown.image?.withRenderingMode(.alwaysTemplate)
        iconDropDown.tintColor = UIColor(hex: appColorNew!)
        iconDropDownGender.image = iconDropDownGender.image?.withRenderingMode(.alwaysTemplate)
        iconDropDownGender.tintColor = UIColor(hex: appColorNew!)
        iconDropDownLoc.image = iconDropDownLoc.image?.withRenderingMode(.alwaysTemplate)
        iconDropDownLoc.tintColor = UIColor(hex: appColorNew!)
        viewHeader.backgroundColor = UIColor(hex: appColorNew!)
        if let userData = UserDefaults.standard.object(forKey: "settingsData") {
            let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
            let dataTabs = SplashRoot(fromDictionary: objData)
          self.title = dataTabs.data.menuActive.resume
        }
        nokri_jobLoctData()
        nokri_resumeReceivedData()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        
        let cotName  = UserDefaults.standard.string(forKey: "coName")
        let cot2Name  = UserDefaults.standard.string(forKey: "coName")
        let cot3Name  = UserDefaults.standard.string(forKey: "coName")
        let cot4Name  = UserDefaults.standard.string(forKey: "coName")
        let cotKey = UserDefaults.standard.integer(forKey: "coKey")
        let cot2Key = UserDefaults.standard.integer(forKey: "co2Key")
        let cot3Key = UserDefaults.standard.integer(forKey: "co3Key")
        let cot4Key = UserDefaults.standard.integer(forKey: "co4Key")

        if cotKey != 0{
            btnCountry.tag = cotKey
            self.lblDropDownCoVal.text = cotName
            if cotName == ""{
                self.lblDropDownCoVal.text = "Country"
            }
        }
        if cot2Key != 0{
            btnCountry.tag = cot2Key
            self.lblDropDownCoVal.text = cot2Name
        }
        if cot3Key != 0{
            btnCountry.tag = cot3Key
            self.lblDropDownCoVal.text = cot3Name
        }
        if cot4Key != 0{
            btnCountry.tag = cot4Key
            self.lblDropDownCoVal.text = cot4Name
        }
        let fromRec = UserDefaults.standard.string(forKey: "isFromRec")
        if fromRec == "1"{
            self.nokri_filterRecvdResumeLoc(filterKey:btnCountry.tag)
        }
       
        
    }
    
    func downloadProgress(progress: Double, id: String){
        print("Progress \(progress) for id : \(id)")
        let currentProgress = progress
        self.uploadingProgressBar.detailTextLabel.text = "\(currentProgress)% Completed"
        self.uploadingProgressBar.setProgress(Float(currentProgress), animated: true)
    }
    
    func downloadCompleted(success: Bool, id: String){
        print("downloadCompleted \(success) for id : \(id)")
         self.uploadingProgressBar.dismiss(animated: true)
    }
    
    //MARK:- IBActions
    
    @IBAction func dropDownClicked(_ sender: UIButton) {
        dropDown.show()
    }
    
    @IBAction func btnDropDownCoClicked(_ sender: UIButton) {
        var countryArr = [String]()
        var countryChildArr = [Bool]()
        var countryKeyArr = [Int]()
        let country = self.countryArray as? [NSDictionary]
        for itemDict in country! {
            if let catObj = itemDict["value"] as? String{
                if catObj == ""{
                    continue
                }
                countryArr.append(catObj)
            }
            if let keyObj = itemDict["key"] as? Int{
                countryKeyArr.append(keyObj)
            }
            if let hasChild = itemDict["has_child"] as? Bool{
                print(hasChild)
                countryChildArr.append(hasChild)
            }
        }
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "JobPostCountryViewController") as? JobPostCountryViewController
        vc!.jobCatArr = countryArr
        vc!.childArr = countryChildArr
        vc!.keyArray = countryKeyArr
        UserDefaults.standard.setValue("1", forKey: "isFromRec")
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func btnDropDownGenderClicked(_ sender: UIButton) {
        dropDownGender.show()
    }
    
    @IBAction func searchBtnClicked(_ sender: UIButton) {
      isFromSearch = true
      nokri_resumeReceivedDataBySearch()
    }
    
    @IBAction func brnCloseClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK:- Table View
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resumeReceivedArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResumeReceivedTableViewCell", for: indexPath) as! ResumeReceivedTableViewCell
        let selectedActiveJob = self.resumeReceivedArr[indexPath.row] as? [NSDictionary];
        for itemDict in selectedActiveJob! {
            let innerDict = itemDict ;
            if let field_type_name = innerDict["field_type_name"] as? String{
                if field_type_name == "cand_name" {
                    if let value = innerDict["value"] as? String {
                        cell.lblName.text = value
                    }
                }
                if field_type_name == "cand_dp" {
                    if let value = innerDict["value"] as? String {
                        if let imageUrl = NSURL(string: value){
                            cell.imageViewResumeRecv.sd_setImage(with: imageUrl as URL, completed: nil)
                            cell.imageViewResumeRecv.sd_setShowActivityIndicatorView(true)
                            cell.imageViewResumeRecv.sd_setIndicatorStyle(.gray)
                        }
                    }
                }
                if field_type_name == "cand_stat" {
                    if let value = innerDict["value"] as? String {
                        cell.lblRecv.text = value
                    }
                }
                if field_type_name == "cand_adress" {
                    if let value = innerDict["value"] as? String {
                        cell.lblLocation.text = value
                    }
                }
                if field_type_name == "job_date" {
                    if let key = innerDict["key"] as? String {
                        cell.lblDate.text = key
                    }
                }
                if field_type_name == "cand_id" {
                    if let value = innerDict["value"] as? Int {
                        cell.btnDropDown.tag = value
                        print(value)
                    }
                }
                if field_type_name == "cand_cover" {
                    if (innerDict["is_required"] as? Bool) != nil {
                        isCoverLetter = true
                        if let coverVal = innerDict["value"] as? String {
                            coverLetterValue = coverVal
                            cell.btnDropDown.titleLabel?.text = coverLetterValue
                        }
                    }
                }
                if field_type_name == "cand_dwnlod" {
                    if let value = innerDict["value"] as? String {
                        cell.btnDropDown.titleLabel?.text = "\(value)"
                        downloadUrl = value
                        print(cell.btnDropDown.titleLabel?.text! as Any)
                    }
                }
  
                if field_type_name == "cand_question" {
                    if let value = innerDict["value"] as? NSArray {
                        print(value)
                        
                        for dict in value{
                            if let category = dict as? NSDictionary {
                                if let title = innerDict["key"] as? String {
                                    titleCoverLetter = title
                                }
                                
                                if let que = category["quest"] as? String {
                                    self.questArr.append(que)
                                }
                                if let ans = category["answer"] as? String {
                                    self.ansArr.append(ans)
                                }
                            }
                            
                        }
                    }
                }
              
            }
        }
        cell.btnDropDown.addTarget(self, action: #selector(ResumeReceivedViewController.nokri_btnDropDownClicked(_:)), for: .touchUpInside)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 147
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
    
    @IBAction func btnLoadMoreClicked(_ sender: UIButton) {
        if isFromSearch == true {
            if hasNextPage == true{
                nokri_resumeReceivedDataBySearchPagination()
            }
        }else{
            if hasNextPage == true{
                nokri_resumeReceivedDataPagination()
            }
        }
    }
    
    func cutomeButton(){
        btnLoadMore.isHidden = true
        btnLoadMore.layer.cornerRadius = 22
        btnLoadMore.backgroundColor = UIColor(hex: appColorNew!)
        btnLoadMore.setTitleColor(UIColor.white, for: .normal)
    }
    
    @objc func nokri_btnDropDownClicked(_ sender: UIButton){
        dropDownSecond.show()
        dropDownSecond.anchorView = sender
        senderButtonTag = sender.tag
        coverLetterValue = (sender.titleLabel?.text)!
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
    
    func nokri_customeButton(){
        btnSearch.backgroundColor = UIColor(hex: appColorNew!)
    }
    
    func nokri_dropDownSetup(){
        var dropDownArr = [String]()
        var dropDownArrKey = [String]()
        let filterArr = self.filterArray as? [NSDictionary]
        for itemDict in filterArr! {
            if let filterObj = itemDict["key"] as? String{
                dropDownArr.append(filterObj)
            }
            if let filterObj = itemDict["value"] as? String{
                dropDownArrKey.append(filterObj)
            }
        }
        statusKeyArr = dropDownArr
        statusValArr = dropDownArrKey
        print(dropDownArr.count)
        print(dropDownArrKey.count)
        let intArray = dropDownArrKey.map { Int($0)!}
        dropDown.dataSource = dropDownArr
        self.lblDropDownValue.text = dropDownArr[0]
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.lblDropDownValue.text = item
            self.nokri_filterRecvdResume(filterKey: (intArray[index]))
        }
        
        
        
        var dropDownArrGender = [String]()
        var dropDownArrGenderKey = [String]()
        let filterArrGender = self.genderArrayData as? [NSDictionary]
        for itemDict in filterArrGender! {
            if let filterObj = itemDict["key"] as? String{
                dropDownArrGender.append(filterObj)
            }
            if let filterObj = itemDict["value"] as? String{
                dropDownArrGenderKey.append(filterObj)
            }
        }
        
        genderKeyArr = dropDownArrGender
        genderValArr = dropDownArrGenderKey
        print(dropDownArr.count)
        print(dropDownArrKey.count)
        dropDownGender.dataSource = dropDownArrGender
        self.lblDropDownGendVal.text = dropDownArrGender[0]
        dropDownGender.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.lblDropDownGendVal.text = item
            self.nokri_filterRecvdResumeG(filterKey: index)
        }
    
        dropDownGender.anchorView = btnDropDownGender
        dropDown.anchorView = btnDropDown
        DropDown.startListeningToKeyboard()
        DropDown.appearance().textColor = UIColor.black
        DropDown.appearance().textFont = UIFont.systemFont(ofSize: 12)
        DropDown.appearance().backgroundColor = UIColor.white
        DropDown.appearance().selectionBackgroundColor = UIColor(hex:appColorNew!)
        DropDown.appearance().cellHeight = 40
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
    
    func nokri_dropDownSetupTwo(){
        
        if let userData = UserDefaults.standard.object(forKey: "settingsData") {
            let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
            let dataTabs = SplashRoot(fromDictionary: objData)
            let obj = dataTabs.data.menuResume
            if dropDownArrSecond.count == 3 || dropDownArrSecond.count == 4 {
                print("No need to add !")
            }else{
                dropDownArrSecond.append(obj!.action)
                dropDownArrSecond.append(obj!.download)
                if isCoverLetter == true{
                    dropDownArrSecond.append("Detail")
                }
                dropDownArrSecond.append(obj!.profile)
                dropDownArrSecond.append(dataTabs.data.menuActive.del)
            }
            dropDownSecond.dataSource = dropDownArrSecond
            dropDownSecond.selectionAction = { [unowned self] (index: Int, item: String) in
                print("Selected item: \(item) at index: \(index)")
                if index == 0{
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "TakeActionViewController") as! TakeActionViewController
                    nextViewController.userId = self.senderButtonTag!
                    nextViewController.job_Id = self.jobId
                    nextViewController.statusKeyAr = self.statusKeyArr
                    nextViewController.statusValAr = self.statusValArr
                    nextViewController.modalPresentationStyle = .overCurrentContext
                    //nextViewController.modalTransitionStyle = .flipHorizontal
                    self.present(nextViewController, animated: true, completion: nil)
                }else if index == 1{
                    var inValidUrl:String = ""
                    if let userData = UserDefaults.standard.object(forKey: "settingsData") {
                        let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
                        let dataTabs = SplashRoot(fromDictionary: objData)
                        inValidUrl = dataTabs.data.extra.invalid_url
                    }
                    if #available(iOS 10.0, *) {
                        if self.verifyUrl(urlString: self.downloadUrl!) == false {
                            let hud = JGProgressHUD(style: .dark)
                            hud.textLabel.text = inValidUrl
                            hud.detailTextLabel.text = nil
                            hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                            hud.position = .bottomCenter
                            hud.show(in: self.view)
                            hud.dismiss(afterDelay: 2.0)
                            //self.view.makeToast("\(inValidUrl)")
                        }else{

                            UIApplication.shared.open(URL(string:self.downloadUrl!)!, options: [:], completionHandler: nil)
                        }
                    } else {
                        if self.verifyUrl(urlString: self.downloadUrl!) == false {
                            let hud = JGProgressHUD(style: .dark)
                            hud.textLabel.text = inValidUrl
                            hud.detailTextLabel.text = nil
                            hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                            hud.position = .bottomCenter
                            hud.show(in: self.view)
                            hud.dismiss(afterDelay: 2.0)
                            //self.view.makeToast("\(inValidUrl)")
                        }else{
                            UIApplication.shared.openURL(URL(string: self.downloadUrl!)!)
                        }
                    }
                    self.nokri_downloadPdf(pdfReport: "Resume", uniqueName: "Resume") { (ok, true) in
                        print(ok)
                    }
                }
                else if index == 2 && self.isCoverLetter == true{
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CoverLetterViewController") as! CoverLetterViewController
                    nextViewController.titleCover = self.titleCoverLetter
                    nextViewController.valueCoverLetter = self.coverLetterValue
                    nextViewController.questionArr = self.questArr
                    nextViewController.answersArr = self.ansArr
                    nextViewController.modalPresentationStyle = .overCurrentContext
                    self.present(nextViewController, animated: true, completion: nil)
                }
                
                else if index == 2 && self.isCoverLetter == false {
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MyProfileViewController") as! MyProfileViewController
                    nextViewController.userId = self.senderButtonTag!
                    nextViewController.isFromCan = false
                     nextViewController.isFromCandSearch = true
                    nextViewController.idCheck = 1
                    self.present(nextViewController, animated: true, completion: nil)
                }
                    else if index == 3 && self.isCoverLetter == true {
                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MyProfileViewController") as! MyProfileViewController
                        nextViewController.userId = self.senderButtonTag!
                        nextViewController.isFromCan = false
                        nextViewController.idCheck = 1
                        nextViewController.isFromCandSearch = true
                        self.present(nextViewController, animated: true, completion: nil)
                    }
                else{
                    
                    let obj = dataTabs.data.genericTxts
                    let alert = UIAlertController(title: obj?.confirm, message: nil, preferredStyle: .alert)
                    let cancelButton = UIAlertAction(title: obj?.btnCancel, style: .default) { (cancel) in
                    }
                    let okButton = UIAlertAction(title: obj?.btnConfirm, style: .default) { (ok) in
                        let param: [String: Any] = [
                            "job_id": self.jobId!,
                            "cand_id": self.senderButtonTag!
                        ]
                        print(param)
                        self.nokri_deletJob(parameter: param as NSDictionary)
                    }
                    alert.addAction(cancelButton)
                    alert.addAction(okButton)
                    self.present(alert, animated: true, completion: nil)
                }
            }
            DropDown.startListeningToKeyboard()
            DropDown.appearance().textColor = UIColor.black
            DropDown.appearance().textFont = UIFont.systemFont(ofSize: 12)
            DropDown.appearance().backgroundColor = UIColor.white
            DropDown.appearance().selectionBackgroundColor = UIColor(hex:appColorNew!)
            DropDown.appearance().cellHeight = 40
        }
    }
    
    //MARK:- API Calls

    func nokri_deletJob(parameter: NSDictionary) {
        self.showLoader()
        UserHandler.nokri_resumeDelete(parameter: parameter as NSDictionary, success: { (successResponse) in
            let hud = JGProgressHUD(style: .dark)
            hud.textLabel.text = successResponse.message
            hud.detailTextLabel.text = nil
            hud.indicatorView = JGProgressHUDSuccessIndicatorView()
            hud.position = .bottomCenter
            hud.show(in: self.view)
            hud.dismiss(afterDelay: 2.0)
            //self.view.makeToast("Deleted Successfully.", duration: 1.5, position: .center)
            self.nokri_resumeReceivedData()
            self.tableView.reloadData()
            self.stopAnimating()
        }) { (error) in
            let alert = Constants.showBasicAlert(message: error.message)
            self.present(alert, animated: true, completion: nil)
            self.stopAnimating()
        }
    }
    
    func nokri_resumeReceivedDataBySearch(){
        
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
                "job_id": jobId!,
                "c_name": txtSearch.text!,
                "page_number": "1"
            ]
            print(param)
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.resumeReceived, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    let responseData = response.value as! NSDictionary
                    self.message = responseData["message"] as? String
                    let success = responseData["success"] as! Bool
                    if success == true{
                        let data = responseData["data"] as! NSDictionary
                        if let page = data["page_title"]  as? String{
                            self.pageTitle.text = page
                        }
                        if let array = data["cand_filter"] as? NSArray {
                            self.nokri_resumeRecvDataParser(jobFilterArray: array)
                        }
                        if let arrayGender = data["gender_filters"] as? NSArray {
                            self.nokri_genderDataParser(genderArr: arrayGender)
                        }

                        if let activeJobArr = data["jobs"] as? NSArray {
                            self.nokri_jobDataParser(resumeRecvArr: activeJobArr)
                        }
                        
                        if let pagination = responseData["pagination"] as? NSDictionary{
                            self.hasNextPage = pagination["has_next_page"] as? Bool
                            self.nextPage = pagination["next_page"] as? Int
                        }
                        if self.hasNextPage == true{
                            print(self.hasNextPage!)
                            self.btnLoadMore.isHidden = false
                        }
                        if self.hasNextPage == false{
                            self.btnLoadMore.isHidden = true
                        }
                    }else{
                    }
                    self.nokri_dropDownSetup()
                    self.stopAnimating()
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
                "job_id": jobId!,
                "c_name": txtSearch.text!,
                "page_number": "1"
            ]
            print(param)
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.resumeReceived, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    let responseData = response.value as! NSDictionary
                    self.message = responseData["message"] as? String
                    let success = responseData["success"] as! Bool
                    if success == true{
                        let data = responseData["data"] as! NSDictionary
                        if let page = data["page_title"]  as? String{
                            self.pageTitle.text = page
                        }
                        if let array = data["cand_filter"] as? NSArray {
                            self.nokri_resumeRecvDataParser(jobFilterArray: array)
                        }
                        if let arrayGender = data["gender_filters"] as? NSArray {
                            self.nokri_genderDataParser(genderArr: arrayGender)
                        }
                        if let activeJobArr = data["jobs"] as? NSArray {
                            self.nokri_jobDataParser(resumeRecvArr: activeJobArr)
                        }
                        if let pagination = responseData["pagination"] as? NSDictionary{
                            self.hasNextPage = pagination["has_next_page"] as? Bool
                            self.nextPage = pagination["next_page"] as? Int
                        }
                        if self.hasNextPage == true{
                            print(self.hasNextPage!)
                            self.btnLoadMore.isHidden = false
                        }
                        if self.hasNextPage == false{
                            self.btnLoadMore.isHidden = true
                        }
                    }else{
                    }
                    self.nokri_dropDownSetup()
                    self.stopAnimating()
            }
        }
    }
    
    func nokri_resumeReceivedDataBySearchPagination(){
        
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
                "job_id": jobId!,
                "c_name": txtSearch.text!,
                "page_number": nextPage!
            ]
            print(param)
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.resumeReceived, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    let responseData = response.value as! NSDictionary
                    self.message = responseData["message"] as? String
                    let success = responseData["success"] as! Bool
                    if success == true{
                        let data = responseData["data"] as! NSDictionary
                        if let page = data["page_title"]  as? String{
                            self.pageTitle.text = page
                        }
                        if let array = data["cand_filter"] as? NSArray {
                            self.nokri_resumeRecvDataParser(jobFilterArray: array)
                        }
                        if let arrayGender = data["gender_filters"] as? NSArray {
                            self.nokri_genderDataParser(genderArr: arrayGender)
                        }
                        if let activeJobArr = data["jobs"] as? NSArray {
                            self.nokri_jobDataParser(resumeRecvArr: activeJobArr)
                        }
                        
                        if let pagination = responseData["pagination"] as? NSDictionary{
                            self.hasNextPage = pagination["has_next_page"] as? Bool
                            self.nextPage = pagination["next_page"] as? Int
                        }
                        if self.hasNextPage == true{
                            print(self.hasNextPage!)
                            self.btnLoadMore.isHidden = false
                        }
                        if self.hasNextPage == false{
                            self.btnLoadMore.isHidden = true
                        }
                    }else{
                    }
                    self.nokri_dropDownSetup()
                    self.stopAnimating()
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
                "job_id": jobId!,
                "c_name": txtSearch.text!,
                "page_number": nextPage!
            ]
            print(param)
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.resumeReceived, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    let responseData = response.value as! NSDictionary
                    self.message = responseData["message"] as? String
                    let success = responseData["success"] as! Bool
                    if success == true{
                        let data = responseData["data"] as! NSDictionary
                        if let page = data["page_title"]  as? String{
                            self.pageTitle.text = page
                        }
                        if let array = data["cand_filter"] as? NSArray {
                            self.nokri_resumeRecvDataParser(jobFilterArray: array)
                        }
                        if let arrayGender = data["gender_filters"] as? NSArray {
                            self.nokri_genderDataParser(genderArr: arrayGender)
                        }
                        if let activeJobArr = data["jobs"] as? NSArray {
                            self.nokri_jobDataParser(resumeRecvArr: activeJobArr)
                        }
                        
                        if let pagination = responseData["pagination"] as? NSDictionary{
                            self.hasNextPage = pagination["has_next_page"] as? Bool
                            self.nextPage = pagination["next_page"] as? Int
                        }
                        if self.hasNextPage == true{
                            print(self.hasNextPage!)
                            self.btnLoadMore.isHidden = false
                        }
                        if self.hasNextPage == false{
                            self.btnLoadMore.isHidden = true
                        }
                    }else{
                    }
                    self.nokri_dropDownSetup()
                    self.stopAnimating()
            }
        }
    }
    
    func nokri_resumeReceivedDataPagination(){
        
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
                "job_id": jobId!,
                "page_number": nextPage!
            ]
            print(param)
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.resumeReceived, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    let responseData = response.value as! NSDictionary
                    self.message = responseData["message"] as? String
                    let success = responseData["success"] as! Bool
                    if success == true{
                        let data = responseData["data"] as! NSDictionary
                        if let page = data["page_title"]  as? String{
                            self.pageTitle.text = page
                        }
                        if let array = data["cand_filter"] as? NSArray {
                            self.nokri_resumeRecvDataParser(jobFilterArray: array)
                        }
                        if let arrayGender = data["gender_filters"] as? NSArray {
                            self.nokri_genderDataParser(genderArr: arrayGender)
                        }
                        if let activeJobArr = data["jobs"] as? NSArray {
                            self.nokri_jobDataParser(resumeRecvArr: activeJobArr)
                        }
                        
                        if let pagination = responseData["pagination"] as? NSDictionary{
                            self.hasNextPage = pagination["has_next_page"] as? Bool
                            self.nextPage = pagination["next_page"] as? Int
                        }
                        if self.hasNextPage == true{
                            print(self.hasNextPage!)
                            self.btnLoadMore.isHidden = false
                        }
                        if self.hasNextPage == false{
                            self.btnLoadMore.isHidden = true
                        }
                        
                    }else{
                    }
                    self.nokri_dropDownSetup()
                    self.stopAnimating()
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
                "job_id": jobId!,
                "page_number": nextPage!
            ]
            print(param)
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.resumeReceived, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    let responseData = response.value as! NSDictionary
                    self.message = responseData["message"] as? String
                    let success = responseData["success"] as! Bool
                    if success == true{
                        let data = responseData["data"] as! NSDictionary
                        if let page = data["page_title"]  as? String{
                            self.pageTitle.text = page
                        }
                        if let array = data["cand_filter"] as? NSArray {
                            self.nokri_resumeRecvDataParser(jobFilterArray: array)
                        }
                        if let arrayGender = data["gender_filters"] as? NSArray {
                            self.nokri_genderDataParser(genderArr: arrayGender)
                        }
                        if let activeJobArr = data["jobs"] as? NSArray {
                            self.nokri_jobDataParser(resumeRecvArr: activeJobArr)
                        }
                        
                        if let pagination = responseData["pagination"] as? NSDictionary{
                            self.hasNextPage = pagination["has_next_page"] as? Bool
                            self.nextPage = pagination["next_page"] as? Int
                        }
                        if self.hasNextPage == true{
                            print(self.hasNextPage!)
                            self.btnLoadMore.isHidden = false
                        }
                        if self.hasNextPage == false{
                            self.btnLoadMore.isHidden = true
                        }
                        
                    }else{
                    }
                    self.nokri_dropDownSetup()
                    self.stopAnimating()
            }
        }
    }
    
    func nokri_resumeReceivedData(){
        
        var langCode = UserDefaults.standard.string(forKey: "langCode")
        if langCode == nil {
            langCode = "en"
        }
        
        self.showLoader()
        self.viewSearch.isHidden = true
        self.viewSearch2.isHidden = true
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
                "job_id": jobId!
            ]
            print(param)
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.resumeReceived, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    let responseData = response.value as! NSDictionary
                    self.message = responseData["message"] as? String
                    let success = responseData["success"] as! Bool
                    if success == true{
                        self.viewSearch.isHidden = false
                        self.viewSearch2.isHidden = false
                        let data = responseData["data"] as! NSDictionary
                        if let page = data["page_title"]  as? String{
                            self.pageTitle.text = page
                        }
                        if let array = data["cand_filter"] as? NSArray {
                            self.nokri_resumeRecvDataParser(jobFilterArray: array)
                        }
                        if let arrayGender = data["gender_filters"] as? NSArray {
                            self.nokri_genderDataParser(genderArr: arrayGender)
                        }
                        if let activeJobArr = data["jobs"] as? NSArray {
                            self.nokri_jobDataParser(resumeRecvArr: activeJobArr)
                        }
                        if let pagination = responseData["pagination"] as? NSDictionary{
                            self.hasNextPage = pagination["has_next_page"] as? Bool
                            self.nextPage = pagination["next_page"] as? Int
                        }
                        if self.hasNextPage == true{
                            print(self.hasNextPage!)
                            self.btnLoadMore.isHidden = false
                        }
                        if self.hasNextPage == false{
                            self.btnLoadMore.isHidden = true
                        }
                    }else{
                    }
                    self.nokri_dropDownSetup()
                    self.nokri_dropDownSetupTwo()
                    self.stopAnimating()
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
                "job_id": jobId!
            ]
            print(param)
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.resumeReceived, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    let responseData = response.value as! NSDictionary
                    self.message = responseData["message"] as? String
                    let success = responseData["success"] as! Bool
                    if success == true{
                        self.viewSearch.isHidden = false
                        self.viewSearch2.isHidden = false
                        let data = responseData["data"] as! NSDictionary
                        if let page = data["page_title"]  as? String{
                            self.pageTitle.text = page
                        }
                        if let array = data["cand_filter"] as? NSArray {
                            self.nokri_resumeRecvDataParser(jobFilterArray: array)
                        }
                        if let arrayGender = data["gender_filters"] as? NSArray {
                            self.nokri_genderDataParser(genderArr: arrayGender)
                        }
                        if let activeJobArr = data["jobs"] as? NSArray {
                            self.nokri_jobDataParser(resumeRecvArr: activeJobArr)
                        }
                        if let pagination = responseData["pagination"] as? NSDictionary{
                            self.hasNextPage = pagination["has_next_page"] as? Bool
                            self.nextPage = pagination["next_page"] as? Int
                        }
                        if self.hasNextPage == true{
                            print(self.hasNextPage!)
                            self.btnLoadMore.isHidden = false
                        }
                        if self.hasNextPage == false{
                            self.btnLoadMore.isHidden = true
                        }
                    }else{
                    }
                    self.nokri_dropDownSetup()
                    self.nokri_dropDownSetupTwo()
                    self.stopAnimating()
            }
        }
       self.tableView.reloadData()
    }
    
    func nokri_resumeRecvDataParser(jobFilterArray:NSArray){
        self.filterArray.removeAllObjects()
        for item in jobFilterArray{
            self.filterArray.add(item)
        }
    }
    
    func nokri_genderDataParser(genderArr:NSArray){
        self.genderArrayData.removeAllObjects()
        for item in genderArr{
            self.genderArrayData.add(item)
        }
    }
    
    func nokri_jobDataParser(resumeRecvArr:NSArray){
        self.resumeReceivedArr.removeAllObjects()
        for item in resumeRecvArr{
            print(item)
            var arrayOfDictionaries = [NSDictionary]()
            if let innerArray = item as? NSArray{
                for innerItem in innerArray{
                    print(innerItem)
                    if let innerDictionary = innerItem as? NSDictionary{
                        arrayOfDictionaries.append(innerDictionary)
                    }
                }
            }
            self.resumeReceivedArr.add(arrayOfDictionaries)
        }
        if resumeRecvArr.count == 0{
            nokri_tableViewHelper()
            //self.tableView.reloadData()
        }else{
            nokri_tableViewHelper2()
        }
        print("\(self.resumeReceivedArr.count)");
        self.tableView.reloadData()
    }
    
    func nokri_filterRecvdResumeG(filterKey:Int){
        
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
           
            var genderKey = ""
            
            if filterKey == 0{
                genderKey = "male"
            }else if filterKey == 1{
                genderKey = "female"
            }else{
                genderKey = "other"
            }
            
            let param: [String: Any] = [
                "cand_gender": genderKey,
                "job_id": jobId!,
                "page_number":"1"
            ]
            print(param)
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.resumeReceived, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    let responseData = response.value as! NSDictionary
                    self.message = responseData["message"] as? String
                    
                    let success = responseData["success"] as! Bool
                    if success == true{
                        let data = responseData["data"] as! NSDictionary
                        if let activeJobArr = data["jobs"] as? NSArray {
                            self.nokri_jobDataParser(resumeRecvArr: activeJobArr)
                        }
                    }else{
                    }
                    self.tableView.reloadData()
                    self.stopAnimating()
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
            var genderKey = ""
            
            if filterKey == 0{
                genderKey = "male"
            }else if filterKey == 1{
                genderKey = "female"
            }else{
                genderKey = "other"
            }
            
            let param: [String: Any] = [
                "cand_gender": genderKey,
                "job_id": jobId!,
                "page_number":"1"
            ]
            print(param)
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.resumeReceived, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    let responseData = response.value as! NSDictionary
                    self.message = responseData["message"] as? String
                    
                    let success = responseData["success"] as! Bool
                    if success == true{
                        let data = responseData["data"] as! NSDictionary
                        if let activeJobArr = data["jobs"] as? NSArray {
                            self.nokri_jobDataParser(resumeRecvArr: activeJobArr)
                        }
                    }else{
                    }
                    self.tableView.reloadData()
                    self.stopAnimating()
            }
        }
    }
    
    func nokri_filterRecvdResumeLoc(filterKey:Int){
        
        UserDefaults.standard.setValue("2", forKey: "isFromRec")
        
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
            let x : Int = filterKey
            let fKey = String(x)
            let param: [String: Any] = [
                "cand_loc": fKey,
                "job_id": jobId!,
                "page_number":"1"
            ]
            print(param)
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.resumeReceived, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    let responseData = response.value as! NSDictionary
                    self.message = responseData["message"] as? String
                    
                    let success = responseData["success"] as! Bool
                    if success == true{
                        let data = responseData["data"] as! NSDictionary
                        if let activeJobArr = data["jobs"] as? NSArray {
                            self.nokri_jobDataParser(resumeRecvArr: activeJobArr)
                        }
                    }else{
                    }
                    self.tableView.reloadData()
                    self.stopAnimating()
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
            let x : Int = filterKey
            let fKey = String(x)
            let param: [String: Any] = [
                "cand_loc": fKey,
                "job_id": jobId!,
                "page_number":"1"
            ]
            print(param)
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.resumeReceived, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    let responseData = response.value as! NSDictionary
                    self.message = responseData["message"] as? String
                    
                    let success = responseData["success"] as! Bool
                    if success == true{
                        let data = responseData["data"] as! NSDictionary
                        if let activeJobArr = data["jobs"] as? NSArray {
                            self.nokri_jobDataParser(resumeRecvArr: activeJobArr)
                        }
                    }else{
                    }
                    self.tableView.reloadData()
                    self.stopAnimating()
            }
        }
    }
    
    func nokri_filterRecvdResume(filterKey:Int){
        
        UserDefaults.standard.setValue("2", forKey: "isFromRec")
        
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
            let x : Int = filterKey
            let fKey = String(x)
            let param: [String: Any] = [
                "c_status": fKey,
                "job_id": jobId!,
                "page_number":"1"
            ]
            print(param)
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.resumeReceived, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    let responseData = response.value as! NSDictionary
                    self.message = responseData["message"] as? String
                    
                    let success = responseData["success"] as! Bool
                    if success == true{
                        let data = responseData["data"] as! NSDictionary
                        if let activeJobArr = data["jobs"] as? NSArray {
                            self.nokri_jobDataParser(resumeRecvArr: activeJobArr)
                        }
                    }else{
                    }
                    self.tableView.reloadData()
                    self.stopAnimating()
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
            let x : Int = filterKey
            let fKey = String(x)
            let param: [String: Any] = [
                "c_status": fKey,
                "job_id": jobId!,
                "page_number":"1"
            ]
            print(param)
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.resumeReceived, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    let responseData = response.value as! NSDictionary
                    self.message = responseData["message"] as? String
                    
                    let success = responseData["success"] as! Bool
                    if success == true{
                        let data = responseData["data"] as! NSDictionary
                        if let activeJobArr = data["jobs"] as? NSArray {
                            self.nokri_jobDataParser(resumeRecvArr: activeJobArr)
                        }
                    }else{
                    }
                    self.tableView.reloadData()
                    self.stopAnimating()
            }
        }
    }
    
    //MARK: Session delegate
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        if totalBytesExpectedToWrite > 0 {
            let progress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
            print("progress : \(progress)")
        }
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        
        let documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        let destinationURLForFile = documentsUrl?.appendingPathComponent((downloadTask.originalRequest?.url?.lastPathComponent)!)
        let fileManager = FileManager()//(response?.url!.lastPathComponent)
        if fileManager.fileExists(atPath: (destinationURLForFile?.path)!){
            showFileWithPath(path: (destinationURLForFile?.path)!)
        }
        else{
            do {
                try fileManager.moveItem(at: location, to: destinationURLForFile!)
                // show file
                showFileWithPath(path: (destinationURLForFile?.path)!)
            }catch{
                print("An error occurred while moving file to destination url")
            }
        }
        self.bgtaks = nil;
        self.backgroundSession?.finishTasksAndInvalidate();
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        //print("error\(errorString(describing: ?.localizedDescription))");
    }
    func showFileWithPath(path: String){
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Downloaded"
        hud.detailTextLabel.text = nil
        hud.indicatorView = JGProgressHUDSuccessIndicatorView()
        hud.position = .bottomCenter
        hud.show(in: self.view)
        hud.dismiss(afterDelay: 2.0)
        //self.view.makeToast("Downloaded.", duration: 2.0, position: .center)
        
        let isFileFound:Bool? = FileManager.default.fileExists(atPath: path)
        if isFileFound == true{
            let viewer = UIDocumentInteractionController(url: URL(fileURLWithPath: path))
            viewer.delegate = self
            viewer.presentPreview(animated: true)
        }
    }
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return self;
    }
    func documentInteractionControllerViewForPreview(_ controller: UIDocumentInteractionController) -> UIView? {
        return self.view;
    }

        func nokri_downloadPdf(pdfReport: String, uniqueName: String, completionHandler:@escaping(String, Bool)->()){
            let downloadUrl = self.downloadUrl!
            print(downloadUrl)
            let destination: DownloadRequest.DownloadFileDestination = { _, _ in
                var documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                documentsURL.appendPathComponent("Resume")
                return (documentsURL, [.removePreviousFile])
            }
            self.showLoader()
            Alamofire.download(
                downloadUrl as URLConvertible,
                method: .get,
                parameters: nil,
                encoding: JSONEncoding.default,
                headers: nil,
                to: destination).downloadProgress(closure: { (progress) in
                    //progress closure
                }).response(completionHandler: { (DefaultDownloadResponse) in
                    //here you able to access the DefaultDownloadResponse
                    //result closure
                    let destinationUrl = DefaultDownloadResponse.destinationURL
                    print(destinationUrl!)
                    print(DefaultDownloadResponse.response!)
                     self.stopAnimating()
                    let hud = JGProgressHUD(style: .dark)
                    hud.textLabel.text = "Downloaded"
                    hud.detailTextLabel.text = nil
                    hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                    hud.position = .bottomCenter
                    hud.show(in: self.view)
                    hud.dismiss(afterDelay: 2.0)
                  //self.view.makeToast("Downloaded", duration: 1.5, position: .center)
                  
                })
    }

    func nokri_jobLoctData(){
        
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
        Alamofire.request(Constants.URL.baseUrl+Constants.URL.location, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { response in
                
                guard let res = response.value else{return}
                let responseData = res as! NSDictionary
                let success = responseData["success"] as! Bool
                if success == true{
                    let customLocation = responseData["custom_location"] as! NSDictionary
                    let jobCountry = customLocation["job_country"] as! NSDictionary
                    if let countryArr = jobCountry["value"] as? NSArray {
                        self.nokri_countryDataParser(countryArr: countryArr)
                    }
                    let jobState = customLocation["job_state"] as! NSDictionary
                    //self.lblCountryKey.text = "jobCountryKey"
                    if let stateArr = jobState["value"] as? NSArray {
                        self.nokri_stateDataParser(stateArr: stateArr)
                    }
                    
                    let jobCity = customLocation["job_city"] as! NSDictionary
                    //self.lblCountryKey.text = jobCountryKey
                    if let cityArr = jobCity["value"] as? NSArray {
                        self.nokri_cityDataParser(cityArr: cityArr)
                    }
                    
                    let jobTown = customLocation["job_town"] as! NSDictionary
                    //self.lblCountryKey.text = jobCountryKey
                    if let townArr = jobTown["value"] as? NSArray {
                        self.nokri_townDataParser(townArr: townArr)
                    }
                }else{
                }
                self.stopAnimating()
        }
    }
    
    func nokri_countryDataParser(countryArr:NSArray){
        self.countryArray.removeAllObjects()
        for item in countryArr{
            
            self.countryArray.add(item)
        }
    }
    
    func nokri_stateDataParser(stateArr:NSArray){
        self.stateArray.removeAllObjects()
        for item in stateArr{
            self.stateArray.add(item)
        }
    }

    func nokri_cityDataParser(cityArr:NSArray){
        self.cityArray.removeAllObjects()
        for item in cityArr{
            self.cityArray.add(item)
        }
    }

    func nokri_townDataParser(townArr:NSArray){
        self.townArray.removeAllObjects()
        for item in townArr{
            self.townArray.add(item)
        }
    }
}

class Downloader {
     func load(url: URL, to localUrl: URL, completion: @escaping () -> ()) {
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        let request = try! URLRequest(url: url, method: .get)
        
        let task = session.downloadTask(with: request) { (tempLocalUrl, response, error) in
            if let tempLocalUrl = tempLocalUrl, error == nil {
                // Success
                if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                    print("Success: \(statusCode)")
                }
                do {
                    try FileManager.default.copyItem(at: tempLocalUrl, to: localUrl)
                    completion()
                } catch (let writeError) {
                    print("error writing file \(localUrl) : \(writeError)")
                }
            } else {
                print("Failure: %@", error?.localizedDescription);
            }
        }
        task.resume()
    }
}





