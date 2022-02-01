//
//  CertificationDetailViewController.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 4/27/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import UIKit
import Alamofire
import JGProgressHUD

class CertificationDetailViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,JobCertificationFieldDelegate {

    //MARK:- IBOutlets
    
    @IBOutlet weak var lblStepNo: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnSaveCertification: UIButton!
    @IBOutlet weak var viewStepNo: UIView!
    
    //MARK:- Proporties
    
    var appColorNew = UserDefaults.standard.string(forKey: "app_Color")
    var educationalArray = ["1"]
    var message:String?
    var certificationRoot: CertificationRoot?
    var certifications: [Certification] = []
    var certificationDegrees: [CertificationDegree] = []
    var selectedIndexPath:Int?
    var degreInt:Int = 0

    //MARK:- View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        nokri_customeButton()
        nokri_certificationGet()
        self.navigationController?.navigationBar.isHidden = true
        viewStepNo.backgroundColor = UIColor(hex: appColorNew!)
        self.addLeftBarButtonWithImage(#imageLiteral(resourceName: "menu"))
//        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(CertificationDetailViewController.dismisKeyboard as (CertificationDetailViewController) -> () -> Void))
//        view.addGestureRecognizer(tap)
        if let userData = UserDefaults.standard.object(forKey: "settingsData") {
            let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
            let dataTabs = SplashRoot(fromDictionary: objData)
            let obj = dataTabs.data.candTabs
            self.lblStepNo.text = obj?.certification
        }
        
    }

    @objc func dismisKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func btnSaveCertificationClicked(_ sender: UIButton) {
        
        
        let userData = UserDefaults.standard.object(forKey: "settingsData")
        let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
        let dataTabs = SplashRoot(fromDictionary: objData)
        
        let alert = Constants.showBasicAlert(message: dataTabs.data.extra.allField)
        
        
       // alert.addAction(btnOk)
        var dictArray = [[String:Any]]()
        for obj in certificationDegrees{
            var dictObj = [String:Any]()
            dictObj["certification_institute"] = obj.certificationInstitute
            dictObj["certification_name"] = obj.certificationName
            dictObj["certification_duration"] = obj.certificationDuration
            dictObj["certification_start"] = obj.certificationStart
            dictObj["certification_end"] = obj.certificationEnd
            dictObj["certification_desc"] = obj.certificationDesc
            dictArray.append(dictObj)
            print(dictObj)
        }
        for i in 0..<self.certificationDegrees.count {
            let indexPath = IndexPath(row: i, section: 0)
            if let  cell = tableView.cellForRow(at: indexPath) as? CertificationDetailTableViewCell{
            if cell.txtCertificationInstitute.text == ""{
                present(alert, animated: true, completion: nil)
                return
            }else if cell.txtCertificationTitle.text == "" {
                present(alert, animated: true, completion: nil)
                return
            }else if cell.txtCerticationDuration.text == "" {
                present(alert, animated: true, completion: nil)
                return
            }else if cell.txtCertificationStart.text == "" {
                present(alert, animated: true, completion: nil)
                return
            }else if cell.txtCertificationEnd.text == "" {
                present(alert, animated: true, completion: nil)
                return
            }else if cell.txtViewRichEditor.text == "" {
                present(alert, animated: true, completion: nil)
                return
            }else{
                print("Done..!")
                print(dictArray.toJSONString())
                self.nokri_certifactionDataPost(paramerts: dictArray.toJSONString()) { (done) in
                    self.tableView.reloadData()
                }
                }
            }
        }
    }
    
    //MARK:- TableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return certifications.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CertificationDetailTableViewCell", for: indexPath) as! CertificationDetailTableViewCell
        let certification = certifications[indexPath.row]
        let certificationFiedls = certification.certificationFields
        for obj in certificationFiedls!{
            switch obj.fieldTypeName! {
            case TextFieldType.certificationName:
                cell.lblCertificationTitle.text = obj.key
                cell.txtCertificationTitle.placeholder = obj.key
                cell.txtCertificationTitle.text = obj.value
            case TextFieldType.certificationInstitute:
                cell.lblCertificationIndtitute.text = obj.key
                cell.txtCertificationInstitute.text = obj.value
                cell.txtCertificationInstitute.placeholder = obj.key
            case TextFieldType.certificationDuration:
                cell.lblCertificationDuration.text = obj.key
                cell.txtCerticationDuration.text = obj.value
                cell.txtCerticationDuration.placeholder = obj.key
            case TextFieldType.certificationStart:
                cell.lblCertificationStart.text = obj.key
                cell.txtCertificationStart.text = obj.value
                cell.txtCertificationStart.placeholder = obj.key
            case TextFieldType.certificationEnd:
                cell.lblCertificationEnd.text = obj.key
                cell.txtCertificationEnd.text = obj.value
                cell.txtCertificationEnd.placeholder = obj.key
            case TextFieldType.certificationDesc:
                cell.lblDetain.text = obj.key
                cell.txtViewRichEditor.text = obj.value
            default:
                print("Default.")
            }
        }
        cell.btnAdd.addTarget(self, action: #selector(CertificationDetailViewController.nokri_btnAddClicked), for: .touchUpInside)
        cell.btnDelete.addTarget(self, action: #selector(CertificationDetailViewController.nokri_btnDelClicked), for: .touchUpInside)
        cell.txtCertificationInstitute.nokri_updateBottomBorderColor(isTextFieldSelected: false)
        cell.txtCertificationTitle.nokri_updateBottomBorderColor(isTextFieldSelected: false)
        cell.txtCertificationStart.nokri_updateBottomBorderColor(isTextFieldSelected: false)
        cell.txtCertificationEnd.nokri_updateBottomBorderColor(isTextFieldSelected: false)
        cell.txtCerticationDuration.nokri_updateBottomBorderColor(isTextFieldSelected: false)
        cell.currentIndexPath = indexPath
        cell.jobCertificationFieldDelegate = self
        cell.btnDelete.tag = indexPath.row
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 622
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if tableView.isDragging {
            cell.transform = CGAffineTransform.init(scaleX: 0.5, y: 0.5)
            UIView.animate(withDuration: 0.3, animations: {
                cell.transform = CGAffineTransform.identity
            })
        }
    }
    
    @objc func nokri_btnAddClicked(){
        var certification = Certification()
        let degree = CertificationDegree()
        certification = certifications.first!
        for i in 0..<certification.certificationFields.count {
            certification.certificationFields[i].value = ""
            let fieldTypeName = certification.certificationFields[i].fieldTypeName!
            switch  fieldTypeName {
            case TextFieldType.certificationName:
                degree.certificationName = fieldTypeName
            case TextFieldType.certificationStart:
                degree.certificationStart = fieldTypeName
            case TextFieldType.certificationEnd:
                degree.certificationEnd = fieldTypeName
            case TextFieldType.certificationDuration:
                degree.certificationDuration = fieldTypeName
            case TextFieldType.certificationInstitute:
                degree.certificationInstitute = fieldTypeName
            case TextFieldType.certificationDesc:
                degree.certificationDesc = fieldTypeName
            default:
                print("Default.")
            }
        }
        certifications.append(certification)
        certificationDegrees.append(degree)
        tableView.reloadData()
        tableView.scrollToRow(at: IndexPath(row: certifications.count - 1, section: 0), at: .bottom, animated: true)
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
                var certification = Certification()
                let degree = CertificationDegree()
                certification = self.certifications.first!
                for i in 0..<certification.certificationFields.count {
                    certification.certificationFields[i].value = ""
                    let fieldTypeName = certification.certificationFields[i].fieldTypeName!
                    switch  fieldTypeName {
                    case TextFieldType.certificationName:
                        degree.certificationName = fieldTypeName
                    case TextFieldType.certificationStart:
                        degree.certificationStart = fieldTypeName
                    case TextFieldType.certificationEnd:
                        degree.certificationEnd = fieldTypeName
                    case TextFieldType.certificationDuration:
                        degree.certificationDuration = fieldTypeName
                    case TextFieldType.certificationInstitute:
                        degree.certificationInstitute = fieldTypeName
                    case TextFieldType.certificationDesc:
                        degree.certificationDesc = fieldTypeName
                    default:
                        print("Default.")
                    }
                }
                self.certifications.append(certification)
                self.certificationDegrees.append(degree)
                self.tableView.reloadData()
                self.tableView.scrollToRow(at: IndexPath(row: self.certifications.count - 1, section: 0), at: .bottom, animated: true)
                self.certifications.remove(at:sender.tag)
                self.certificationDegrees.remove(at:sender.tag)
                self.tableView.reloadData()
            }else{
                self.certifications.remove(at:sender.tag)
                self.certificationDegrees.remove(at:sender.tag)
                self.tableView.reloadData()
                self.tableView.scrollToRow(at: IndexPath(row: self.certifications.count - 1, section: 0), at: .bottom, animated: true)
                self.degreInt = 1
            }
        }
        let btnCancel = UIAlertAction(title: cncel, style: .default) { (cancel) in
            print("cancel.")
        }
        alert.addAction(btnOk)
        alert.addAction(btnCancel)
        self.present(alert, animated: true, completion: nil)
    }
       
    
    func nokri_customeButton(){
        btnSaveCertification.layer.cornerRadius = 15
        btnSaveCertification.layer.borderWidth = 1
        btnSaveCertification.layer.borderColor = UIColor(hex:appColorNew!).cgColor
        btnSaveCertification.setTitleColor(UIColor(hex: appColorNew!), for: .normal)
        //btnSaveCertification.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor
        //btnSaveCertification.layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
        //btnSaveCertification.layer.shadowOpacity = 0.7
        //btnSaveCertification.layer.shadowRadius = 0.3
        btnSaveCertification.layer.masksToBounds = false
        btnSaveCertification.backgroundColor = UIColor.white
    }
    
    //MARK:- API Calls
    
    func nokri_certifactionDataPost( paramerts : String, completionHandler: @escaping (String) -> Void){
        
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
            let urlString = Constants.URL.baseUrl+Constants.URL.updateCertification
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
            let urlString = Constants.URL.baseUrl+Constants.URL.updateCertification
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

    func nokri_certificationGet() {
        self.tableView.isHidden = true
        self.showLoader()
        UserHandler.nokri_certificationGet(success: { (successResponse) in
            self.stopAnimating()
            if successResponse.success {
                self.tableView.isHidden = false
                self.certificationRoot = successResponse
                self.certifications += successResponse.data.certification
                let extra = successResponse.data.extras
                for obj in extra!{
                    if obj.fieldTypeName == "btn_name"{
                        self.btnSaveCertification.setTitle(obj.value, for: .normal)
                    }
                }
                for i in 0..<self.certifications.count {
                    let degree = CertificationDegree()
                    let certification = self.certifications[i]
                    let certificationFields = certification.certificationFields
                    for obj in certificationFields!{
                        switch obj.fieldTypeName! {
                        case TextFieldType.certificationName:
                            degree.certificationName = obj.value
                        case TextFieldType.certificationDuration:
                            degree.certificationDuration = obj.value
                        case TextFieldType.certificationStart:
                            degree.certificationStart = obj.value
                        case TextFieldType.certificationEnd:
                            degree.certificationEnd = obj.value
                        case TextFieldType.certificationInstitute:
                            degree.certificationInstitute = obj.value
                        case TextFieldType.certificationDesc:
                            degree.certificationDesc = obj.value
                        default:
                            print("Default.")
                        }
                    }
                    self.certificationDegrees.append(degree)
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
    
    func nokri_didUpdateText(indexPath: IndexPath, txtCertificationTitle: UITextField?, txtCerticationDuration: UITextField?, txtCertificationStart: UITextField?, txtCertificationEnd: UITextField?, degreDetail: String, txtCertificationInstitute: UITextField?) {
        
        if degreInt != 1{
        let degree = certificationDegrees[indexPath.row]
        print("Row: \(indexPath.row)")
        if txtCertificationTitle != nil {
            let certificationTitle = String(describing: (txtCertificationTitle?.text!)!)
            degree.certificationName = certificationTitle
            print("certificationTitle: \(certificationTitle)")
        } else if txtCerticationDuration != nil {
            let certicationDuration = String(describing: (txtCerticationDuration?.text!)!)
            degree.certificationDuration = certicationDuration
            print("certicationDuration: \(certicationDuration)")
        } else if txtCertificationInstitute != nil {
            let certificationInstitute = String(describing: (txtCertificationInstitute?.text!)!)
            degree.certificationInstitute = certificationInstitute
            print("certificationInstitute: \(certificationInstitute)")
        } else if txtCertificationStart != nil {
            let start = String(describing: (txtCertificationStart?.text!)!)
            degree.certificationStart = start
            print("start: \(start)")
        } else if txtCertificationEnd != nil {
            let end = String(describing: (txtCertificationEnd?.text!)!)
            degree.certificationEnd = end
            print("end: \(end)")
        }        else if degreDetail != nil {
            let detail = String(describing: (degreDetail))
            degree.certificationDesc = detail
            print("detail: \(detail)")
        }
      }
   }
}

  



