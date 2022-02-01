//
//  JobExperienceViewController.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 4/27/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import UIKit
//import UICheckbox_Swift
import Alamofire
import JGProgressHUD

class JobExperienceViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,JobExperienceFieldDelegate {
    
    
    
    //MARK:- IBOutlets
    
    @IBOutlet weak var lblStepNo: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnSaveProfession: UIButton!
    @IBOutlet weak var viewStepNo: UIView!
    
    //MARK:- Proporties
    
    var appColorNew = UserDefaults.standard.string(forKey: "app_Color")
    var message:String?
    var experienceRoot: ExperienceRoot?
    var experiences: [Experience] = []
    var experienceDegrees: [ExperienceDegree] = []
    var selectedIndexPath:Int?
    var degreInt:Int = 0
    
    //MARK:- View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        nokri_customeButton()
        nokri_experienceGet()
        viewStepNo.backgroundColor = UIColor(hex: appColorNew!)
        self.addLeftBarButtonWithImage(#imageLiteral(resourceName: "menu"))
        //        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(JobExperienceViewController.dismisKeyboard as (JobExperienceViewController) -> () -> Void))
        //        view.addGestureRecognizer(tap)
        if let userData = UserDefaults.standard.object(forKey: "settingsData") {
            let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
            let dataTabs = SplashRoot(fromDictionary: objData)
            let obj = dataTabs.data.candTabs
            self.lblStepNo.text = obj?.experience
        }
        
    }
    
    @objc func dismisKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    @IBAction func btnSaveProfessionClicked(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Please fill all required fields.", message: nil, preferredStyle: .alert)
        let btnOk = UIAlertAction(title: "Ok", style: .default) { (ok) in
            print("Ok.")
        }
        alert.addAction(btnOk)
        var dictArray = [[String:Any]]()
        for obj in experienceDegrees{
            var dictObj = [String:Any]()
            dictObj["project_organization"] = obj.jobOrganization
            dictObj["project_role"] = obj.jobRole
            dictObj["project_start"] = obj.projectStart
            if obj.isChecked != "true"{
                dictObj["project_end"] = obj.projectEnd
                dictObj["project_name"] = "0"
            }else{
                dictObj["project_name"] = "1"
            }
            dictObj["project_desc"] = obj.projectDetail
            dictArray.append(dictObj)
            print(dictObj)
        }
        for i in 0..<self.experiences.count {
            let indexPath = IndexPath(row: i, section: 0)
            if let  cell = tableView.cellForRow(at: indexPath) as? JobExperienceTableViewCell{
                if cell.txtOrganizationName.text == ""{
                    present(alert, animated: true, completion: nil)
                    return
                }else if cell.txtRole.text == "" {
                    present(alert, animated: true, completion: nil)
                    return
                }else if cell.txtDegreeStart.text == "" {
                    present(alert, animated: true, completion: nil)
                    return
                }else if cell.txtDegreeEnd.text == ""{
                    present(alert, animated: true, completion: nil)
                    return
                }else if cell.txtViewRichEditor.text == "" {
                    present(alert, animated: true, completion: nil)
                    return
                }else{
                    print("Done..!")
                    print(dictArray.toJSONString())
                    self.nokri_experienceDataPost(paramerts: dictArray.toJSONString()) { (done) in
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
    
    //MARK:- TableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return experiences.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "JobExperienceTableViewCell", for: indexPath) as! JobExperienceTableViewCell
        let experience = experiences[indexPath.row]
        let experienceFiedls = experience.experienceFields
        for obj in experienceFiedls!{
            switch obj.fieldTypeName! {
            case TextFieldType.jobOrganization:
                cell.lblOrganizationKey.text = obj.key
                cell.txtOrganizationName.placeholder = obj.fieldname
                cell.txtOrganizationName.text = obj.value
            case TextFieldType.projectStart:
                cell.lblJobStart.text = obj.key
                cell.txtDegreeStart.text = obj.value
                cell.txtDegreeStart.placeholder = obj.fieldname
            case TextFieldType.projectEnd:
                cell.lblJobEnd.text = obj.key
                cell.txtDegreeEnd.text = obj.value
                cell.txtDegreeEnd.placeholder = obj.fieldname
            case TextFieldType.jobRole:
                cell.lblRoleKey.text = obj.key
                cell.txtRole.text = obj.value
                cell.txtRole.placeholder = obj.fieldname
            case TextFieldType.projectDescription:
                cell.lblDegreeDetailKey.text = obj.key
                cell.txtViewRichEditor.text = obj.value
            default:
                print("Default.")
            }
        }
        cell.btnAdd.addTarget(self, action: #selector(JobExperienceViewController.nokri_btnAddClicked), for: .touchUpInside)
        cell.btnDelete.addTarget(self, action: #selector(JobExperienceViewController.nokri_btnDelClicked), for: .touchUpInside)
        cell.txtOrganizationName.nokri_updateBottomBorderColor(isTextFieldSelected: false)
        cell.txtRole.nokri_updateBottomBorderColor(isTextFieldSelected: false)
        cell.txtDegreeStart.nokri_updateBottomBorderColor(isTextFieldSelected: false)
        cell.txtDegreeEnd.nokri_updateBottomBorderColor(isTextFieldSelected: false)
        cell.currentIndexPath = indexPath
        cell.jobExperienceFieldDelegate = self
        cell.btnDelete.tag = indexPath.row
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 575
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if tableView.isDragging {
            cell.transform = CGAffineTransform.init(scaleX: 0.5, y: 0.5)
            UIView.animate(withDuration: 0.3, animations: {
                cell.transform = CGAffineTransform.identity
            })
        }
    }
    
    //MARK:- IBActions
    
    @objc func nokri_btnAddClicked(){
        
        var experience = Experience()
        let degree = ExperienceDegree()
        experience = experiences.first!
        for i in 0..<experience.experienceFields.count {
            experience.experienceFields[i].value = ""
            let fieldTypeName = experience.experienceFields[i].fieldTypeName!
            switch  fieldTypeName {
            case TextFieldType.jobOrganization:
                degree.jobOrganization = fieldTypeName
            case TextFieldType.projectStart:
                degree.projectStart = fieldTypeName
            case TextFieldType.projectEnd:
                degree.projectEnd = fieldTypeName
            case TextFieldType.jobRole:
                degree.jobRole = fieldTypeName
            case TextFieldType.projectDescription:
                degree.projectDetail = fieldTypeName
            default:
                print("Default.")
            }
        }
        experiences.append(experience)
        experienceDegrees.append(degree)
        tableView.reloadData()
        tableView.scrollToRow(at: IndexPath(row: experiences.count - 1, section: 0), at: .bottom, animated: true)
        
    }
    
    @objc func nokri_btnDelClicked(_ sender: UIButton){
        
        var confirmString:String?
        var ok:String?
        var cncel:String?
        if let userData = UserDefaults.standard.object(forKey: "settingsData") {
            let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
            let dataTabs = SplashRoot(fromDictionary: objData)
            confirmString = dataTabs.data.genericTxts.confirm
            ok = dataTabs.data.genericTxts.btnConfirm
            cncel = dataTabs.data.genericTxts.btnCancel
        }
        let alert = UIAlertController(title: confirmString, message: nil, preferredStyle: .alert)
        let btnOk = UIAlertAction(title: ok, style: .default) { (ok) in
            print("Ok.")
            if sender.tag == 0{
                var experience = Experience()
                let degree = ExperienceDegree()
                experience = self.experiences.first!
                for i in 0..<experience.experienceFields.count {
                    experience.experienceFields[i].value = ""
                    let fieldTypeName = experience.experienceFields[i].fieldTypeName!
                    switch  fieldTypeName {
                    case TextFieldType.jobOrganization:
                        degree.jobOrganization = fieldTypeName
                    case TextFieldType.projectStart:
                        degree.projectStart = fieldTypeName
                    case TextFieldType.projectEnd:
                        degree.projectEnd = fieldTypeName
                    case TextFieldType.jobRole:
                        degree.jobRole = fieldTypeName
                    case TextFieldType.projectDescription:
                        degree.projectDetail = fieldTypeName
                    default:
                        print("Default.")
                    }
                }
                self.experiences.append(experience)
                self.experienceDegrees.append(degree)
                self.tableView.reloadData()
                self.tableView.scrollToRow(at: IndexPath(row: self.experiences.count - 1, section: 0), at: .bottom, animated: true)
                self.experiences.remove(at:sender.tag)
                self.experienceDegrees.remove(at:sender.tag)
                self.tableView.reloadData()
            }else{
                self.experiences.remove(at:sender.tag)
                self.experienceDegrees.remove(at:sender.tag)
                self.tableView.reloadData()
                self.tableView.scrollToRow(at: IndexPath(row: self.experiences.count - 1, section: 0), at: .bottom, animated: true)
                self.degreInt = 1
            }
        }
        let btnCancel = UIAlertAction(title: cncel, style: .default) { (ok) in
            print("Cancel")
        }
        alert.addAction(btnOk)
        alert.addAction(btnCancel)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func nokri_customeButton(){
        btnSaveProfession.layer.cornerRadius = 15
        btnSaveProfession.layer.borderWidth = 1
        btnSaveProfession.layer.borderColor = UIColor(hex:appColorNew!).cgColor
        btnSaveProfession.setTitleColor(UIColor(hex: appColorNew!), for: .normal)
        //btnSaveProfession.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor
        //btnSaveProfession.layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
        //btnSaveProfession.layer.shadowOpacity = 0.7
        //btnSaveProfession.layer.shadowRadius = 0.3
        btnSaveProfession.layer.masksToBounds = false
        btnSaveProfession.backgroundColor = UIColor.white
        
    }
    
    //MARK:- API Calls
    
    func nokri_experienceDataPost( paramerts : String, completionHandler: @escaping (String) -> Void){
        
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
            print(paramerts)
            let urlString = Constants.URL.baseUrl+Constants.URL.updateProfession
            let url = URL(string: urlString)!
            let jsonData = paramerts.data(using: .utf8, allowLossyConversion: false)!
            var request = URLRequest(url: url)
            request.httpMethod = HTTPMethod.post.rawValue
            request.allHTTPHeaderFields = headers
            request.httpBody = jsonData
            Alamofire.request(request).responseJSON {
                (response) in
                print(response)
                let res = response.value as! [String:Any]
                let message = res["message"] as! String
                //self.view.makeToast(message, duration: 1.5, position: .center)
                let hud = JGProgressHUD(style: .dark)
                hud.textLabel.text = message
                hud.detailTextLabel.text = nil
                hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                hud.position = .bottomCenter
                hud.show(in: self.view)
                hud.dismiss(afterDelay: 2.0)
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
            print(paramerts)
            let urlString = Constants.URL.baseUrl+Constants.URL.updateProfession
            let url = URL(string: urlString)!
            let jsonData = paramerts.data(using: .utf8, allowLossyConversion: false)!
            var request = URLRequest(url: url)
            request.httpMethod = HTTPMethod.post.rawValue
            request.allHTTPHeaderFields = headers
            request.httpBody = jsonData
            Alamofire.request(request).responseJSON {
                (response) in
                print(response)
                let res = response.value as! [String:Any]
                let message = res["message"] as! String
                //self.view.makeToast(message, duration: 1.5, position: .center)
                let hud = JGProgressHUD(style: .dark)
                hud.textLabel.text = message
                hud.detailTextLabel.text = nil
                hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                hud.position = .bottomCenter
                hud.show(in: self.view)
                hud.dismiss(afterDelay: 2.0)
                self.stopAnimating()
            }
        }
    }
    
    func nokri_experienceGet() {
        self.tableView.isHidden = true
        self.showLoader()
        UserHandler.nokri_experienceGet(success: { (successResponse) in
            self.stopAnimating()
            if successResponse.success {
                self.tableView.isHidden = false
                self.experienceRoot = successResponse
                self.experiences += successResponse.data.experience
                let extra = successResponse.data.extras
                for obj in extra!{
                    if obj.fieldTypeName == "btn_name"{
                        self.btnSaveProfession.setTitle(obj.value, for: .normal)
                    }
                }
                for i in 0..<self.experiences.count {
                    let degree = ExperienceDegree()
                    let experience = self.experiences[i]
                    let experienceFiedls = experience.experienceFields
                    for obj in experienceFiedls!{
                        switch obj.fieldTypeName! {
                        case TextFieldType.jobOrganization:
                            degree.jobOrganization = obj.value
                        case TextFieldType.projectStart:
                            degree.projectStart = obj.value
                        case TextFieldType.projectEnd:
                            degree.projectEnd = obj.value
                            
                        case TextFieldType.projectDescription:
                            degree.projectDetail = obj.value
                        default:
                            print("Default.")
                        }
                    }
                    self.experienceDegrees.append(degree)
                }
                self.stopAnimating()
                self.tableView.reloadData()
            }
            else {
                self.tableView.isHidden = true
                let alert = Constants.showBasicAlert(message: successResponse.pageTitle)
                self.present(alert, animated: true, completion: nil)
                self.stopAnimating()
            }
        }) { (error) in
            self.tableView.isHidden = true
            let alert = Constants.showBasicAlert(message: error.message)
            self.present(alert, animated: true, completion: nil)
            self.stopAnimating()
        }
    }
    
    func nokri_didUpdateText(indexPath: IndexPath, txtOrganizationName: UITextField?, txtRole: UITextField?, txtDegreeStart: UITextField?, txtDegreeEnd: UITextField?, degreDetail: String,isChecked:String) {
        if degreInt != 1{
            let degree = experienceDegrees[indexPath.row]
            print("Row: \(indexPath.row)")
            if txtOrganizationName != nil {
                let organizationName = String(describing: (txtOrganizationName?.text!)!)
                degree.jobOrganization = organizationName
                print("organizationName: \(organizationName)")
            } else if txtRole != nil {
                let role = String(describing: (txtRole?.text!)!)
                degree.jobRole = role
                print("role: \(role)")
            } else if txtDegreeStart != nil {
                let start = String(describing: (txtDegreeStart?.text!)!)
                degree.projectStart = start
                print("start: \(start)")
            } else if txtDegreeEnd != nil {
                let end = String(describing: (txtDegreeEnd?.text!)!)
                degree.projectEnd = end
                print("end: \(end)")
            } else if degreDetail != nil {
                let detail = String(describing: (degreDetail))
                degree.projectDetail = detail
                print("detail: \(detail)")
            }
            if isChecked != nil {
                let ch = String(describing: (isChecked))
                degree.isChecked = ch
                print("detail: \(ch)")
            }
        }
    }
    
}






