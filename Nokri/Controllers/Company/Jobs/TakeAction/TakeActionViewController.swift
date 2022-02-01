//
//  TakeActionViewController.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 8/13/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import UIKit
import TTSegmentedControl
import DropDown
import JGProgressHUD

class TakeActionViewController: UIViewController,UITextFieldDelegate {

    //Mark:- IBOutlets
    
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var segmentedControl: TTSegmentedControl!
    @IBOutlet weak var lblSelectEmailTemp: UILabel!
    @IBOutlet weak var txtEmailTemp: UITextField!
    @IBOutlet weak var iconDropDown: UIImageView!
    @IBOutlet weak var lblEmailSubject: UILabel!
    @IBOutlet weak var txtEmailSubject: UITextField!
    @IBOutlet weak var lblEmailBody: UILabel!
    @IBOutlet weak var textRichEditor: UITextView!
    @IBOutlet weak var btnSend: UIButton!
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var btnCloseBackground: UIButton!
    @IBOutlet weak var lblEmailTitle: UILabel!
    @IBOutlet weak var heightConstraintView: NSLayoutConstraint!
    @IBOutlet weak var heightConstrtaintRichEditor: NSLayoutConstraint!
    @IBOutlet weak var viewFull: UIView!
    @IBOutlet weak var viewDrop1: UIView!
    @IBOutlet weak var viewDrop2: UIView!
    @IBOutlet weak var heightConstLblEmailBody: NSLayoutConstraint!
    @IBOutlet weak var heightConstView1: NSLayoutConstraint!
    @IBOutlet weak var heightContLblEmailSub: NSLayoutConstraint!
    @IBOutlet weak var heightConstView2: NSLayoutConstraint!
    @IBOutlet weak var heightConstWeb: NSLayoutConstraint!
    
    //MARK:- Proporties
    
    var appColorNew = UserDefaults.standard.string(forKey: "app_Color")
    var extraArray = [TakeActionExtra]()
    var segmetedValue:String = ""
    var userId:Int?
    var job_Id:Int?
    let dropDownTemplates = DropDown()
    var emailData = [EmailData]()
    var dropownKeyArr = [String]()
    var dropDownValueArr = [String]()
    var selectedTempKey:String?
    var TakActionDataArray = [TakActionData]()
    var isSendEmail:Bool = true
    var statusKeyAr = [String]()
    var statusValAr = [String]()
    var txtSelectStatus:String = ""
    var txtSelectEmailTemp:String = ""
    var keyForStatus:Int = 0
    
    //MARK:- View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        iconDropDown.image = iconDropDown.image?.withRenderingMode(.alwaysTemplate)
        iconDropDown.tintColor = UIColor(hex: appColorNew!)
        nokri_takeActionData()
        nokri_customeUi()
        viewHeader.backgroundColor = UIColor(hex: appColorNew!)
        txtEmailSubject.delegate = self
        txtEmailTemp.delegate = self
        txtEmailSubject.nokri_addBottomBorder()
        txtEmailTemp.nokri_addBottomBorder()
        segmentedControl.itemTitles = ["Yes","No"]
        segmentedControl.didSelectItemWith = { (index, title) -> () in
            print("Selected item \(index)")
            if index == 0{
                print("Yes")
                self.segmetedValue = "Yes"
                self.isSendEmail = true
                self.lblSelectEmailTemp.text = self.txtSelectEmailTemp
                self.nokri_dropDownSetup()
                self.viewDrop2.isHidden = false
                self.lblEmailBody.isHidden = false
                self.lblEmailSubject.isHidden = false
                self.textRichEditor.isHidden = false
            }else{
                self.segmetedValue = "No"
                print("No")
                self.nokri_dropDownSetupForStatus()
                self.isSendEmail = false
                self.viewDrop2.isHidden = true
                self.lblEmailBody.isHidden = true
                self.lblEmailSubject.isHidden = true
                self.textRichEditor.isHidden = true
                self.lblSelectEmailTemp.text = self.txtSelectStatus
                
            }
        }
    
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(TakeActionViewController.dismisKeyboard as (TakeActionViewController) -> () -> Void))
        view.addGestureRecognizer(tap)
        
    }
    @objc func dismisKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        txtEmailSubject.nokri_updateBottomBorderSize()
        txtEmailTemp.nokri_updateBottomBorderSize()
    }

    //MARK:- IBAction
    
    @IBAction func btnTepClicked(_ sender: UIButton) {
        dropDownTemplates.show()
    }
    
    @IBAction func textTempClicked(_ sender: UITextField) {
    }

    @IBAction func btnCloseClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnCloseBacground(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnSubmitClicked(_ sender: UIButton) {
        
        if isSendEmail == false{
           
                let param: [String: Any] = [
                    "job_id":job_Id!,
                    "candidate_id":userId!,
                    "cand_status": keyForStatus,
                    "is_send_mail": isSendEmail,
                ]
                print(param)
                self.nokri_takeActionPost(parameter: param as NSDictionary)
        }else{
            var status:String = ""
            for obj in TakActionDataArray{
                if obj.key == "status"{
                    status = obj.value
                }
               // print (obj.value)
            }
            
            guard let emailTemp = txtEmailTemp.text else {
                return
            }
            guard let emailSubject = txtEmailSubject.text else {
                return
            }
            if emailTemp == "" {
                let alert = Constants.showBasicAlert(message: "Please Enter name.")
                self.present(alert, animated: true, completion: nil)
            }
            else if emailSubject == "" {
                let alert = Constants.showBasicAlert(message: "Please Enter email.")
                self.present(alert, animated: true, completion: nil)
            }
            else {
                let param: [String: Any] = [
                    "job_id":job_Id!,
                    "candidate_id":userId!,
                    "cand_status": status,
                    "email_sub": emailSubject,
                    "is_send_mail": isSendEmail,
                    "email_body":textRichEditor.text!
                ]
                print(param)
                self.nokri_takeActionPost(parameter: param as NSDictionary)
            }
        }
    }
    
    //MARK:- TextField Delegate
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == txtEmailSubject {
            txtEmailSubject.nokri_updateBottomBorderColor(isTextFieldSelected: true)
        } else {
            txtEmailSubject.nokri_updateBottomBorderColor(isTextFieldSelected: false)
        }
        if textField == txtEmailTemp {
            txtEmailTemp.nokri_updateBottomBorderColor(isTextFieldSelected: true)
        } else {
            txtEmailTemp.nokri_updateBottomBorderColor(isTextFieldSelected: false)
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return false
    }
    
    //MARK:- Custome Function
    
    func nokri_dropDownSetup(){
       
        for obj in emailData{
            dropownKeyArr.append(obj.key)
            dropDownValueArr.append(obj.value)
        }
        dropDownTemplates.dataSource = dropDownValueArr
        self.txtEmailTemp.text = dropDownValueArr[0]
        dropDownTemplates.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.txtEmailTemp.text = item
            self.selectedTempKey = self.dropownKeyArr[index]
            print(self.selectedTempKey!)
            let param: [String: Any] = [
                "temp_val":self.selectedTempKey!
            ]
            print(param)
            self.nokri_selectActionPost(parameter: param as NSDictionary)
            
        }
        dropDownTemplates.anchorView = txtEmailTemp
    }
    
    func nokri_dropDownSetupForStatus(){
        
        dropDownTemplates.dataSource = statusKeyAr
        //self.txtEmailTemp.text = dropDownValueArr[0]
        txtEmailTemp.text = statusKeyAr[0]
        let intArray = statusValAr.map { Int($0)!}
        dropDownTemplates.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.keyForStatus = intArray[index]
            self.txtEmailTemp.text = item
        }
        dropDownTemplates.anchorView = txtEmailTemp
    }
    
    func nokri_customeUi(){
        segmentedControl.layer.borderWidth = 1
        segmentedControl.layer.borderColor = UIColor(hex:appColorNew!).cgColor
        segmentedControl.layer.cornerRadius = 3
        segmentedControl.thumbGradientColors = [UIColor(hex:appColorNew!), UIColor(hex:appColorNew!)]
      
        btnSend.layer.borderWidth = 0.5
        btnSend.layer.borderColor = UIColor.lightGray.cgColor
        btnSend.layer.cornerRadius = 1
        btnSend.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor
        btnSend.layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
        btnSend.layer.shadowOpacity = 0.7
        btnSend.layer.shadowRadius = 0.3
        btnSend.layer.masksToBounds = false
        btnSend.setTitleColor(UIColor(hex:appColorNew!), for: .normal)
        btnSend.backgroundColor = UIColor.white
    }
    
    func nokri_populateData(){
        let userEmail = UserDefaults.standard.string(forKey: "email")
        lblEmailTitle.text = userEmail
        for obj in extraArray{
            if obj.fieldTypeName == "email_send"{
                lblEmail.text = obj.key
            }
            if obj.fieldTypeName == "email_yes"{
                
            }
            if obj.fieldTypeName == "email_no"{
                
            }
            if obj.fieldTypeName == "email_temp"{
                lblSelectEmailTemp.text = obj.key
                txtSelectEmailTemp = obj.key
            }
            if obj.fieldTypeName == "email_sub"{
                lblEmailSubject.text = obj.key
                txtEmailSubject.text = obj.value
                txtEmailSubject.placeholder = obj.key

            }
            if obj.fieldTypeName == "email_body"{
                lblEmailBody.text = obj.key
            }
            if obj.fieldTypeName == "email_btn"{
                btnSend.setTitle(obj.key, for: .normal)
                btnSend.setTitleColor(UIColor(hex: appColorNew!), for: .normal)
            }
            if obj.fieldTypeName == "select_status"{
                txtSelectStatus = obj.key
            }
        }
    }
    
    //MARK:- API Calls
    
    func nokri_takeActionData() {
        self.showLoader()
        self.viewFull.isHidden = true
        UserHandler.nokri_takeActionGet(success: { (successResponse) in
            self.stopAnimating()
            if successResponse.success {
                 self.viewFull.isHidden = false
                self.extraArray = successResponse.data.extra
                self.emailData = successResponse.data.emailData
                self.nokri_populateData()
                self.nokri_dropDownSetup()
                self.stopAnimating()
            }
            else {
                self.viewFull.isHidden = true
                let alert = Constants.showBasicAlert(message: successResponse.message)
                self.present(alert, animated: true, completion: nil)
                self.stopAnimating()
            }
        }) { (error) in
             self.viewFull.isHidden = true
            let alert = Constants.showBasicAlert(message: error.message)
            self.present(alert, animated: true, completion: nil)
            self.stopAnimating()
        }
    }
    
    func nokri_takeActionPost(parameter: NSDictionary) {
        self.showLoader()
        UserHandler.nokri_takeActionPost(parameter: parameter as NSDictionary, success: { (successResponse) in
            self.stopAnimating()
            if successResponse.success == true {
               
                let hud = JGProgressHUD(style: .dark)
                hud.textLabel.text = successResponse.message!
                hud.detailTextLabel.text = nil
                hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                hud.position = .bottomCenter
                hud.show(in: self.view)
                hud.dismiss(afterDelay: 2.0)
                //self.view.makeToast(successResponse.message, duration: 1.5, position: .center)
                 //self.perform(#selector(self.dismissContr), with: nil, afterDelay: 2)
                self.stopAnimating()
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
    
//    @objc func dismissContr(){
//        self.dismiss(animated: true, completion: nil)
//    }
    
    func nokri_selectActionPost(parameter: NSDictionary) {
        self.showLoader()
        UserHandler.nokri_selectTemplatePost(parameter: parameter as NSDictionary, success: { (successResponse) in
            self.stopAnimating()
            if successResponse.success == true {
                self.TakActionDataArray =  successResponse.data
                for obj in self.TakActionDataArray{
                    if obj.key == "body"{

                        self.textRichEditor.text = obj.value
                        
                        self.heightConstraintView.constant = CGFloat(self.textRichEditor.contentMode.rawValue)
                    }
                    if obj.key == "name"{
                        self.txtEmailSubject.text = obj.value
                    }
                }
                self.stopAnimating()
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
}

extension Data {
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: self, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            print("error:", error)
            return  nil
        }
    }
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
}

extension String {
    var html2AttributedString: NSAttributedString? {
        return Data(utf8).html2AttributedString
    }
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
}
