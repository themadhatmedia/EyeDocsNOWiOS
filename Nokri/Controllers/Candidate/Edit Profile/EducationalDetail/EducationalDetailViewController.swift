//
//  EducationalDetailViewController.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 4/26/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import UIKit
import Alamofire
//import SwiftValidator
import JGProgressHUD

class EducationalDetailViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,DegreeTextFieldDelegate {
    
    //MARK:- IBOutlets
    
    @IBOutlet weak var lblStepNo: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnSaveEducational: UIButton!    
    @IBOutlet weak var viewStepNo: UIView!
    
    //MARK:- Proporties

    var appColorNew = UserDefaults.standard.string(forKey: "app_Color")
    var message:String?
    var educationRoot: EducationRoot?
    var educations: [Education] = []
    var degrees: [Degree] = []
    var selectedIndexPath:Int?
    //let validator = Validator()
    public var degreInt : Int = 0
    
    //MARK:- View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nokri_customeButton()
        nokri_educationGet()
        viewStepNo.backgroundColor = UIColor(hex: appColorNew!)
        self.tableView.delegate = self
        self.tableView.dataSource = self
//        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(EducationalDetailViewController.dismisKeyboard as (EducationalDetailViewController) -> () -> Void))
//        view.addGestureRecognizer(tap)
        if let userData = UserDefaults.standard.object(forKey: "settingsData") {
            let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
            let dataTabs = SplashRoot(fromDictionary: objData)
            let obj = dataTabs.data.candTabs
            self.lblStepNo.text = obj?.education
        }
        
    }
 
    @objc func dismisKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    //MARK:- IBActions
    
    @IBAction func btnSaveEduationClicked(_ sender: UIButton) {
        
        let userData = UserDefaults.standard.object(forKey: "settingsData")
        let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
        let dataTabs = SplashRoot(fromDictionary: objData)
        
         let alert = Constants.showBasicAlert(message: dataTabs.data.extra.allField)
        
        
//        let alert = UIAlertController(title: "Please fill all required fields.", message: nil, preferredStyle: .alert)
//        let btnOk = UIAlertAction(title: "Ok", style: .default) { (ok) in
//            print("Ok.")
//        }
       // alert.addAction(btnOk)
        var dictArray = [[String:Any]]()
        for obj in degrees{
            var dictObj = [String:Any]()
            dictObj["degree_name"] = obj.degreeName
            dictObj["degree_institute"] = obj.degreeInstitute
            dictObj["degree_start"] = obj.degreeStart
            dictObj["degree_end"] = obj.degreeEnd
            dictObj["degree_percent"] = obj.degreePercent
            dictObj["degree_grade"] = obj.degreeGrade
            dictObj["degree_detail"] = obj.degreeDetail
            dictArray.append(dictObj)
            print(dictObj)
        }
        for i in 0..<self.educations.count {
            let indexPath = IndexPath(row: i, section: 0)
            if let  cell = tableView.cellForRow(at: indexPath) as? EducationalDetailTableViewCell{
                if cell.txtDegreeTitle.text == ""{
                   present(alert, animated: true, completion: nil)
                   return
                }else if cell.lblDegreeIntitute.text == "" {
                    present(alert, animated: true, completion: nil)
                   return
                }else if cell.lblDegreePercent.text == "" {
                    present(alert, animated: true, completion: nil)
                    return
                }else if cell.txtDegreeGrade.text == "" {
                    present(alert, animated: true, completion: nil)
                    return
                }else if cell.txtDegreeStart.text == "" {
                    present(alert, animated: true, completion: nil)
                    return
                }else if cell.txtDegreeEnd.text == "" {
                    present(alert, animated: true, completion: nil)
                    return
                }else if cell.txtViewRichEditor.text == "" {
                    present(alert, animated: true, completion: nil)
                    return
                }else{
                    print("Done..!")
                    print(dictArray.toJSONString())
                    self.nokri_educationDataPost(paramerts: dictArray.toJSONString()) { (done) in
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
    
    //MARK:- TableView
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return educations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "EducationalDetailTableViewCell", for: indexPath) as! EducationalDetailTableViewCell
        let education = educations[indexPath.row]
        let educationFiedls = education.educationFields
        for obj in educationFiedls!{
            switch obj.fieldTypeName! {
            case TextFieldType.degreeName:
                cell.lblDegreeTitle.text = obj.key
                cell.txtDegreeTitle.placeholder = obj.column
                cell.txtDegreeTitle.text = obj.value
            case TextFieldType.degreeStart:
                cell.lblDegreeStart.text = obj.key
                cell.txtDegreeStart.text = obj.value
                cell.txtDegreeStart.placeholder = obj.column
            case TextFieldType.degreeEnd:
                cell.lblDegreeEndKey.text = obj.key
                cell.txtDegreeEnd.text = obj.value
                cell.txtDegreeEnd.placeholder = obj.column
            case TextFieldType.degreeInstitute:
                cell.lblDegreeIntitute.text = obj.key
                cell.txtDegreeInstitute.placeholder = obj.column
                cell.txtDegreeInstitute.text = obj.value
            case TextFieldType.degreeGrade:
                cell.lblDegreeGrade.text = obj.key
                cell.txtDegreeGrade.placeholder = obj.column
                cell.txtDegreeGrade.text = obj.value
            case TextFieldType.degreePercent:
                cell.lblDegreePercent.text = obj.key
                cell.txtDegreePercent.placeholder = obj.column
                cell.txtDegreePercent.text = obj.value
            case TextFieldType.degreeDetail:
                cell.lblDegreeDetails.text = obj.key
                cell.txtViewRichEditor.text = obj.value
            default:
                print("Default.")
            }
        }
        cell.btnAdd.addTarget(self, action: #selector(EducationalDetailViewController.nokri_btnAddClicked), for: .touchUpInside)
        cell.btnDelete.addTarget(self, action: #selector(EducationalDetailViewController.nokri_btnDelClicked), for: .touchUpInside)
        cell.txtDegreeTitle.nokri_updateBottomBorderColor(isTextFieldSelected: false)
        cell.txtDegreeInstitute.nokri_updateBottomBorderColor(isTextFieldSelected: false)
        cell.txtDegreeGrade.nokri_updateBottomBorderColor(isTextFieldSelected: false)
        cell.txtDegreePercent.nokri_updateBottomBorderColor(isTextFieldSelected: false)
        cell.currentIndexPath = indexPath
        cell.degreeTextFieldDelegate = self
        cell.btnDelete.tag = indexPath.row
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 660
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
        
        var education = Education()
        let degree = Degree()
        education = educations.first!
        for i in 0..<education.educationFields.count {
            education.educationFields[i].value = ""
            let fieldTypeName = education.educationFields[i].fieldTypeName!
            switch  fieldTypeName {
            case TextFieldType.degreeName:
               degree.degreeName = fieldTypeName
            case TextFieldType.degreeStart:
              degree.degreeStart = fieldTypeName
            case TextFieldType.degreeEnd:
                degree.degreeEnd = fieldTypeName
            case TextFieldType.degreeInstitute:
                degree.degreeInstitute = fieldTypeName
            case TextFieldType.degreeGrade:
                degree.degreeGrade = fieldTypeName
            case TextFieldType.degreePercent:
                degree.degreePercent = fieldTypeName
            case TextFieldType.degreeDetail:
                degree.degreeDetail = fieldTypeName
            default:
                print("Default.")
            }
        }
        educations.append(education)
        degrees.append(degree)
        tableView.reloadData()
        tableView.scrollToRow(at: IndexPath(row: educations.count - 1, section: 0), at: .bottom, animated: true)
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
                var education = Education()
                let degree = Degree()
                education = self.educations.first!
                for i in 0..<education.educationFields.count {
                    education.educationFields[i].value = ""
                    let fieldTypeName = education.educationFields[i].fieldTypeName!
                    switch  fieldTypeName {
                    case TextFieldType.degreeName:
                        degree.degreeName = fieldTypeName
                    case TextFieldType.degreeStart:
                        degree.degreeStart = fieldTypeName
                    case TextFieldType.degreeEnd:
                        degree.degreeEnd = fieldTypeName
                    case TextFieldType.degreeInstitute:
                        degree.degreeInstitute = fieldTypeName
                    case TextFieldType.degreeGrade:
                        degree.degreeGrade = fieldTypeName
                    case TextFieldType.degreePercent:
                        degree.degreePercent = fieldTypeName
                    case TextFieldType.degreeDetail:
                        degree.degreeDetail = fieldTypeName
                    default:
                        print("Default.")
                    }
                }
                self.educations.append(education)
                self.degrees.append(degree)
                self.tableView.reloadData()
                self.tableView.scrollToRow(at: IndexPath(row: self.educations.count - 1, section: 0), at: .bottom, animated: true)
                self.educations.remove(at:sender.tag)
                self.degrees.remove(at:sender.tag)
                self.tableView.reloadData()
            }else{
                self.educations.remove(at:sender.tag)
                self.degrees.remove(at:sender.tag)
                self.tableView.reloadData()
                self.tableView.scrollToRow(at: IndexPath(row: self.educations.count - 1, section: 0), at: .bottom, animated: true)
                self.degreInt = 1
            }
        }
        let btnCancel = UIAlertAction(title: cncel, style: .default) { (Cancel) in
            print("Cancel.")
        }
        alert.addAction(btnOk)
        alert.addAction(btnCancel)
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
    //MARK:- Custome Functions
    
    func nokri_customeButton(){
        btnSaveEducational.layer.cornerRadius = 15
        btnSaveEducational.layer.borderWidth = 1
        btnSaveEducational.layer.borderColor = UIColor(hex:appColorNew!).cgColor
        //btnSaveEducational.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor
        //btnSaveEducational.layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
        //btnSaveEducational.layer.shadowOpacity = 0.7
        //btnSaveEducational.layer.shadowRadius = 0.3
        btnSaveEducational.layer.masksToBounds = false
        btnSaveEducational.backgroundColor = UIColor.white
        btnSaveEducational.setTitleColor(UIColor(hex: appColorNew!), for: .normal)
    }
    
    //MARK:- API Calls
  
    func nokri_educationDataPost( paramerts : String, completionHandler: @escaping (String) -> Void){
        
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
            let urlString = Constants.URL.baseUrl+Constants.URL.updateEducation
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
                // var success = res["success"] as! Bool
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
            let urlString = Constants.URL.baseUrl+Constants.URL.updateEducation
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
                // var success = res["success"] as! Bool
                let hud = JGProgressHUD(style: .dark)
                hud.textLabel.text = message
                hud.detailTextLabel.text = nil
                hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                hud.position = .bottomCenter
                hud.show(in: self.view)
                hud.dismiss(afterDelay: 2.0)
                //self.view.makeToast(message, duration: 1.5, position: .center)
                self.stopAnimating()
            }
        }
        
        
    }
    
    func nokri_educationGet() {
        self.tableView.isHidden = true
        self.showLoader()
        UserHandler.nokri_educationGet(success: { (successResponse) in
            self.stopAnimating()
            if successResponse.success {
                self.tableView.isHidden = false
                self.educationRoot = successResponse
                self.educations += successResponse.data.education
                let extra = successResponse.data.extras
                for obj in extra!{
                    if obj.fieldTypeName == "btn_name"{
                        self.btnSaveEducational.setTitle(obj.value, for: .normal)
                    }
                }
                for i in 0..<self.educations.count {
                    let degree = Degree()
                    let education = self.educations[i]
                    let educationFiedls = education.educationFields
                    for obj in educationFiedls!{
                        switch obj.fieldTypeName! {
                        case TextFieldType.degreeName:
                            degree.degreeName = obj.value
                        case TextFieldType.degreeStart:
                            degree.degreeStart = obj.value
                        case TextFieldType.degreeEnd:
                            degree.degreeEnd = obj.value
                        case TextFieldType.degreeInstitute:
                            degree.degreeInstitute = obj.value
                        case TextFieldType.degreeGrade:
                            degree.degreeGrade = obj.value
                        case TextFieldType.degreePercent:
                            degree.degreePercent = obj.value
                        case TextFieldType.degreeDetail:
                            degree.degreeDetail = obj.value
                        default:
                            print("Default.")
                        }
                    }
                    self.degrees.append(degree)
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
            let alert = Constants.showBasicAlert(message: error.message)
            self.present(alert, animated: true, completion: nil)
            self.stopAnimating()
        }
    }
    
    func nokri_didUpdateText(indexPath: IndexPath, txtDegreetTitle: UITextField?, txtDegreeInstitute: UITextField?, txtDegreetGrade: UITextField?, txtDegreePercent: UITextField?, txtDegreeStart: UITextField?, txtDegreeEnd: UITextField?, degreDetail: String) {
       
        if degreInt != 1{
            
        let degree = degrees[indexPath.row]
        print("Row: \(indexPath.row)")
        if txtDegreetTitle != nil {
            let degreeName = String(describing: (txtDegreetTitle?.text!)!)
            degree.degreeName = degreeName
            print("Title: \(degreeName)")
        } else if txtDegreeInstitute != nil {
            let institute = String(describing: (txtDegreeInstitute?.text!)!)
            degree.degreeInstitute = institute
            print("Institute: \(institute)")
        } else if txtDegreetGrade != nil {
            let degreeGrade = String(describing: (txtDegreetGrade?.text!)!)
            degree.degreeGrade = degreeGrade
            print("Grade: \(degreeGrade)")
        } else if txtDegreePercent != nil {
            let degreePercent = String(describing: (txtDegreePercent?.text!)!)
            degree.degreePercent = degreePercent
            print("Percent: \(degreePercent)")
        }else if txtDegreeStart != nil {
            let degreeStart = String(describing: (txtDegreeStart?.text!)!)
            degree.degreeStart = degreeStart
            print("Percent: \(degreeStart)")
        }else if txtDegreeEnd != nil {
            let degreeEnd = String(describing: (txtDegreeEnd?.text!)!)
            degree.degreeEnd = degreeEnd
            print("Percent: \(degreeEnd)")
        }
        else if degreDetail != nil || degreDetail != ""{
            let detail = String(describing: (degreDetail))
            degree.degreeDetail = detail
            print("detail: \(detail)")
            }
        }
    }
}


    
