//
//  ApplyNowViewController.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 8/18/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import UIKit
import TextFieldEffects
import DropDown
import JGProgressHUD
import Alamofire
import MobileCoreServices

class ApplyNowViewController: UIViewController,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,UIDocumentPickerDelegate,questionsProtocolApply {
    
    
    
    //MRK:- IBOutlets
    
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var lblJobTitle: UILabel!
    @IBOutlet weak var lblSelectResume: UILabel!
    @IBOutlet weak var txtDropDownResume: UITextField!
    @IBOutlet weak var iconDropDown: UIImageView!
    @IBOutlet weak var btnApplyNow: UIButton!
    @IBOutlet weak var txtCoverLetter: UITextField!
    @IBOutlet weak var lblCoverLetter: UILabel!
    @IBOutlet weak var iconDrop: UIImageView!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var heightConstName: NSLayoutConstraint!
    
    @IBOutlet weak var heightConstEmail: NSLayoutConstraint!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var btnResume: UIButton!
    
    
    @IBOutlet weak var heightConstBtnRes: NSLayoutConstraint!
    
    @IBOutlet weak var heightConstLblSelectRes: NSLayoutConstraint!
    @IBOutlet weak var heightConstraintQuesTable: NSLayoutConstraint!
    
    
    @IBOutlet weak var heightConstViewResDrop: NSLayoutConstraint!
    @IBOutlet weak var topConstraintBtnResume: NSLayoutConstraint!
    
    @IBOutlet weak var viewResDrop: UIView!
    
    //MARK:- Proporties
    
    
    var withOutLogin = UserDefaults.standard.string(forKey: "aType")
    var appColorNew = UserDefaults.standard.string(forKey: "app_Color")
    var jobId:Int?
    var applyJobInfo = [ApplyJobInfo]()
    var applyJobResumeArr  = [ApplyJobResume]()
    let dropDownResume = DropDown()
    var jobTitle:String?
    var selectedKey = ""
    var isWithOutLoginApply = false
    var emailPlaceholder = ""
    var namePlaceHolder = ""
    var titleIs = ""
    var questionArr = [String]()
    var mail = ""
    var message:String?
    var attachId = 0
    
    var resumesArray = NSMutableArray()
    var extraArray = NSMutableArray()
    var messageForResume:String?
    var fileUrl:URL?
    private lazy var uploadingProgressBar: JGProgressHUD = {
        let progressBar = JGProgressHUD(style: .dark)
        progressBar.indicatorView = JGProgressHUDRingIndicatorView()
        progressBar.textLabel.text = "Uploading"
        return progressBar
    }()
    var questionsArr = [String]()
    
    
    var isCvRequired = 0
    
    //MARK:- View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewHeader.backgroundColor = UIColor(hex: appColorNew!)
        txtDropDownResume.delegate = self
        txtDropDownResume.nokri_addBottomBorder()
        let param: [String: Any] = [
            "job_id": jobId!
        ]
        print(param)
        self.nokri_applyJobData(parameter: param as NSDictionary)
        nokri_customeButtons()
        iconDrop.image = iconDrop.image?.withRenderingMode(.alwaysTemplate)
        iconDrop.tintColor = UIColor(hex: appColorNew!)
        
        if isWithOutLoginApply == false{
            //heightConstName.constant = 0
            //heightConstEmail.constant = 0
        }else{
            txtName.placeholder = namePlaceHolder
            txtEmail.placeholder = emailPlaceholder
        }
        self.title = titleIs
        if withOutLogin == "5" && isWithOutLoginApply == true{
            topConstraintBtnResume.constant += 50
            iconDrop.isHidden = true
        }else{
            heightConstName.constant = 0
            heightConstEmail.constant = 0
        }
        
        
        if withOutLogin != "5"{
            
            if isCvRequired == 0{
               
            }else if isCvRequired == 1 {
                
            }else{
                heightConstBtnRes.constant = 0
                heightConstLblSelectRes.constant = 0
                heightConstViewResDrop.constant = 0
                viewResDrop.isHidden = true
            }
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        txtDropDownResume.nokri_updateBottomBorderSize()
    }
    
    //MARK:- Custome Functions
    
    func nokri_customeButtons(){
        btnApplyNow.layer.cornerRadius = 22
        btnApplyNow.backgroundColor = UIColor(hex:appColorNew!)
        btnApplyNow.setTitleColor(UIColor.white, for: .normal)
    }
    
    func nokri_populateData(){
        
        for obj in applyJobInfo{
            if obj.fieldTypeName == "job_resume"{
                lblSelectResume.text = obj.key
            }
            if obj.fieldTypeName == "job_cvr"{
                //lblCoverLetter.text = obj.key
                txtCoverLetter.placeholder = obj.key
            }
            if obj.fieldTypeName == "job_btn"{
                btnApplyNow.setTitle(obj.key, for: .normal)
            }
            lblJobTitle.text = jobTitle
        }
    }
    
    func nokri_dropDownSetup(){
        var resumesTitleArr = [String]()
        var keyArr = [String]()
        for resumesTitle in applyJobResumeArr{
            resumesTitleArr.append(resumesTitle.value)
            keyArr.append(resumesTitle.key)
        }
        dropDownResume.dataSource = resumesTitleArr
        self.txtDropDownResume.text = "Select your resume"
        dropDownResume.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.txtDropDownResume.text = item
            self.selectedKey = keyArr[index]
        }
        dropDownResume.anchorView = txtDropDownResume
        DropDown.startListeningToKeyboard()
        DropDown.appearance().textColor = UIColor.black
        DropDown.appearance().textFont = UIFont.systemFont(ofSize: 12)
        DropDown.appearance().backgroundColor = UIColor.white
        DropDown.appearance().selectionBackgroundColor = UIColor(hex:appColorNew!)
        DropDown.appearance().cellHeight = 40
    }
    
    
    //MARK:- Textfield Delegate
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == txtDropDownResume {
            txtDropDownResume.nokri_updateBottomBorderColor(isTextFieldSelected: true)
        } else {
            txtDropDownResume.nokri_updateBottomBorderColor(isTextFieldSelected: false)
        }
        return true
    }
    
    //MARK:- IBActions
    
    
    
    @IBAction func btnResumeClicked(_ sender: UIButton) {
        let options = [kUTTypePDF as String, kUTTypeZipArchive  as String, kUTTypePNG as String, kUTTypeJPEG as String, kUTTypeText  as String, kUTTypePlainText as String]
        let documentPicker: UIDocumentPickerViewController = UIDocumentPickerViewController(documentTypes: options, in: .import)
        documentPicker.delegate = self
        documentPicker.modalPresentationStyle = .formSheet
        self.present(documentPicker, animated: true, completion: nil)
    }
    
    @IBAction func btnCloseClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnCloseBackgroundClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func txtDropDownClicked(_ sender: UITextField) {
        
    }
    
    @IBAction func btnDropDownResumeClicked(_ sender: UIButton) {
        dropDownResume.show()
    }
    
    @IBAction func btnApplyNowClicked(_ sender: UIButton) {
        
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let myString = formatter.string(from: Date()) // string purpose I add here
        let yourDate = formatter.date(from: myString)
        formatter.dateFormat = "MMM yyyy"
        let currentDate = formatter.string(from: yourDate!)
        print(currentDate)
        
        guard let email = txtEmail.text else {
            return
        }
        guard let name = txtName.text else {
            return
        }
        
        if let userData = UserDefaults.standard.object(forKey: "settingsData") {
            let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
            let dataTabs = SplashRoot(fromDictionary: objData)
            
            //            if name == "" {
            //                let alert = Constants.showBasicAlert(message: dataTabs.data.extra.allField)
            //                self.present(alert, animated: true, completion: nil)
            //            }
            //            if email == "" {
            //                let alert = Constants.showBasicAlert(message: dataTabs.data.extra.allField)
            //                self.present(alert, animated: true, completion: nil)
            //            }
            //            else if isValidEmail(testStr: email) == false  {
            //                let alert = Constants.showBasicAlert(message: dataTabs.data.extra.validEmail)
            //                self.present(alert, animated: true, completion: nil)
            //            }
            //            else{
            
            
            if isCvRequired == 0{
                if mail == "mail"{
                    let param: [String: Any] = [
                        "job_id": jobId!,
                        "cand_apply_resume": selectedKey,
                        "cand_cover_letter": txtCoverLetter.text!,
                        "cand_date": currentDate,
                        "cand_name":name,
                        "cand_email":email,
                        "questions_ans":questionsArr
                    ]
                    print(param)
                    self.nokri_applyPostMail(parameter: param as NSDictionary)
                }else{
                    var param: [String: Any] = [
                        "job_id": jobId!,
                        "cand_apply_resume": selectedKey,
                        "cand_cover_letter": txtCoverLetter.text!,
                        "cand_date": currentDate,
                        "questions_ans":questionsArr
                    ]
                    if withOutLogin == "5" && isWithOutLoginApply == true{
                        param["cand_name"] = name
                        param["cand_email"] = email
                    }
                    print(param)
                    self.nokri_applyPost(parameter: param as NSDictionary)
                }
            }else if isCvRequired == 1{
                
                if selectedKey == ""{
                    let alert = Constants.showBasicAlert(message: dataTabs.data.extra.upload_resume_txt)
                    self.present(alert, animated: true, completion: nil)
                }else{
                    if mail == "mail"{
                        let param: [String: Any] = [
                            "job_id": jobId!,
                            "cand_apply_resume": selectedKey,
                            "cand_cover_letter": txtCoverLetter.text!,
                            "cand_date": currentDate,
                            "cand_name":name,
                            "cand_email":email,
                            "questions_ans":questionsArr
                        ]
                        print(param)
                        self.nokri_applyPostMail(parameter: param as NSDictionary)
                    }else{
                        var param: [String: Any] = [
                            "job_id": jobId!,
                            "cand_apply_resume": selectedKey,
                            "cand_cover_letter": txtCoverLetter.text!,
                            "cand_date": currentDate,
                            "questions_ans":questionsArr
                        ]
                        if withOutLogin == "5" && isWithOutLoginApply == true{
                            param["cand_name"] = name
                            param["cand_email"] = email
                        }
                        print(param)
                        self.nokri_applyPost(parameter: param as NSDictionary)
                    }
                }
                
                
            }
            else{
                if mail == "mail"{
                    let param: [String: Any] = [
                        "job_id": jobId!,
                        "cand_cover_letter": txtCoverLetter.text!,
                        "cand_date": currentDate,
                        "cand_name":name,
                        "cand_email":email,
                        "questions_ans":questionsArr
                    ]
                    print(param)
                    self.nokri_applyPostMail(parameter: param as NSDictionary)
                }else{
                    var param: [String: Any] = [
                        "job_id": jobId!,
                        "cand_cover_letter": txtCoverLetter.text!,
                        "cand_date": currentDate,
                        "questions_ans":questionsArr
                    ]
                    if withOutLogin == "5" && isWithOutLoginApply == true{
                        param["cand_name"] = name
                        param["cand_email"] = email
                    }
                    print(param)
                    self.nokri_applyPost(parameter: param as NSDictionary)
                }
            }
        }
    }
    
    func isValidEmail(testStr:String) -> Bool {
        print("validate emilId: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: testStr)
        return result
    }
    
    //MARK:- API Calls
    
    func nokri_applyJobData(parameter: NSDictionary) {
        self.btnApplyNow.isHidden = true
        self.showLoader()
        UserHandler.nokri_applyJobGet(parameter: parameter as NSDictionary, success: { (successResponse) in
            self.stopAnimating()
            if successResponse.success == true{
                self.btnApplyNow.isHidden = false
                self.applyJobInfo = successResponse.data.info
                self.applyJobResumeArr = successResponse.data.resumes
                //                if self.applyJobResumeArr.count == 0{
                //                    self.btnResume.isHidden = false
                //                }
                self.questionArr = successResponse.data.questions
                if self.questionArr.count == 0{
                    self.tableView.isHidden = true
                    self.heightConstraintQuesTable.constant = 0
                }
                self.nokri_populateData()
                self.nokri_dropDownSetup()
                self.tableView.delegate = self
                self.tableView.dataSource = self
                self.tableView.reloadData()
            }
            else {
                self.btnApplyNow.isHidden = true
                let alert = Constants.showBasicAlert(message: successResponse.message)
                self.present(alert, animated: true, completion: nil)
                self.stopAnimating()
            }
        }) { (error) in
            self.btnApplyNow.isHidden = true
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
                // self.view.makeToast(successResponse.message, duration: 1.5, position: .center)
                let hud = JGProgressHUD(style: .dark)
                hud.textLabel.text = successResponse.message!
                hud.detailTextLabel.text = nil
                hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                hud.position = .bottomCenter
                hud.show(in: self.view)
                hud.dismiss(afterDelay: 2.0)
                self.perform(#selector(self.nokri_Dismiss), with: nil, afterDelay: 2.2)
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
    
    @objc func nokri_Dismiss(){
        self.dismiss(animated: true, completion: nil)
    }
    
    func nokri_applyPostMail(parameter: NSDictionary) {
        self.showLoader()
        UserHandler.nokri_applyJobPostMail(parameter: parameter as NSDictionary, success: { (successResponse) in
            self.stopAnimating()
            if successResponse.success == true{
                
                let hud = JGProgressHUD(style: .dark)
                hud.textLabel.text = successResponse.message!
                hud.detailTextLabel.text = nil
                hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                hud.position = .bottomCenter
                hud.show(in: self.view)
                hud.dismiss(afterDelay: 2.0)
                self.perform(#selector(self.nokri_Dismiss), with: nil, afterDelay: 2.2)
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
    
    //MARK:- TableView
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ApplyNowQuestionTableViewCell", for: indexPath) as! ApplyNowQuestionTableViewCell
        
        cell.txtQuestion.placeholder = questionArr[indexPath.row]
        cell.index = indexPath.row
        cell.delegate = self
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    //MARK:- Delegates For UIDocumentPicker
    
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        self.saveFileToDocumentDirectory(document: url)
        if withOutLogin == "5" && isWithOutLoginApply == true{
            self.nokri_uploadResumeWithOutLogin(documentUrl: url)
        }else{
            self.nokri_uploadResume(documentUrl: url)
        }
    }
    
    public func documentMenu(_ documentMenu:UIDocumentPickerViewController, didPickDocumentPicker documentPicker: UIDocumentPickerViewController) {
        documentPicker.delegate = self
        present(documentPicker, animated: true, completion: nil)
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print("view was cancelled")
        dismiss(animated: true, completion: nil)
    }
    
    func saveFileToDocumentDirectory(document: URL) {
        if let fileUrl = FileManager.default.saveFileToDocumentDirectory(fileUrl: document, name: "my_cv_upload", extention: ".pdf") {
            print(fileUrl)
            //self.uploadResume(documentUrl: fileUrl)
        }
    }
    
    func removeFileFromDocumentsDirectory(fileUrl: URL) {
        _ = FileManager.default.removeFileFromDocumentsDirectory(fileUrl: fileUrl)
    }
    
    //MARK:- API Calls
    
    func nokri_uploadResumeWithOutLogin(documentUrl: URL) {
        uploadingProgressBar.progress = 0.0
        uploadingProgressBar.detailTextLabel.text = "0% Completed"
        uploadingProgressBar.show(in: view)
        //startActivityIndicator()
        UserHandler.nokri_uploadResumeWithOutLogin(fileName: "my_cv_upload", fileUrl: documentUrl, progress: { (uploadProgress) in
            print(uploadProgress)
            let currentProgress = Float(uploadProgress)/100
            self.uploadingProgressBar.detailTextLabel.text = "\(uploadProgress)% Completed"
            self.uploadingProgressBar.setProgress(currentProgress, animated: true)
        }, success: { (successResponse) in
            self.uploadingProgressBar.dismiss(animated: true)
            //self.removeFileFromDocumentsDirectory(fileUrl: self.fileUrl!)
            let hud = JGProgressHUD(style: .dark)
            hud.textLabel.text = successResponse.message!
            hud.detailTextLabel.text = nil
            hud.indicatorView = JGProgressHUDSuccessIndicatorView()
            hud.position = .bottomCenter
            hud.show(in: self.view)
            hud.dismiss(afterDelay: 2.0)
            //self.view.makeToast(successResponse.message, duration: 2.5, position: .center)
            self.selectedKey = successResponse.attach_id
            let param: [String: Any] = [
                "job_id": self.jobId!
            ]
            print(param)
            self.nokri_applyJobData(parameter: param as NSDictionary)
            self.tableView.reloadData()
            self.stopAnimating()
        }, failure: { (error) in
            
            let alert = Constants.showBasicAlert(message: error.message)
            self.present(alert, animated: true, completion: nil)
            self.stopAnimating()
            
        })
    }
    
    func nokri_uploadResume(documentUrl: URL) {
        uploadingProgressBar.progress = 0.0
        uploadingProgressBar.detailTextLabel.text = "0% Completed"
        uploadingProgressBar.show(in: view)
        //startActivityIndicator()
        UserHandler.nokri_uploadResume(fileName: "my_cv_upload", fileUrl: documentUrl, progress: { (uploadProgress) in
            print(uploadProgress)
            let currentProgress = Float(uploadProgress)/100
            self.uploadingProgressBar.detailTextLabel.text = "\(uploadProgress)% Completed"
            self.uploadingProgressBar.setProgress(currentProgress, animated: true)
        }, success: { (successResponse) in
            self.uploadingProgressBar.dismiss(animated: true)
            //self.removeFileFromDocumentsDirectory(fileUrl: self.fileUrl!)
            
            let hud = JGProgressHUD(style: .dark)
            hud.textLabel.text = successResponse.message!
            hud.detailTextLabel.text = nil
            hud.indicatorView = JGProgressHUDSuccessIndicatorView()
            hud.position = .bottomCenter
            hud.show(in: self.view)
            hud.dismiss(afterDelay: 2.0)
            
            //self.view.makeToast(successResponse.message, duration: 2.5, position: .center)
            let param: [String: Any] = [
                "job_id": self.jobId!
            ]
            print(param)
            self.nokri_applyJobData(parameter: param as NSDictionary)
            self.tableView.reloadData()
            self.stopAnimating()
        }, failure: { (error) in
            
            let alert = Constants.showBasicAlert(message: error.message)
            self.present(alert, animated: true, completion: nil)
            self.stopAnimating()
            
        })
    }
    
    
    func questionsDa(indexP: Int, questionString: String) {
        questionsArr.append(questionString)
        print(questionString)
        print(questionsArr)
    }
    
    
}

