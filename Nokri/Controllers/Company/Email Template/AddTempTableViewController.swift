//
//  AddTempTableViewController.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 5/23/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import UIKit
import DropDown
import JGProgressHUD

class AddTempTableViewController: UITableViewController,UIWebViewDelegate,UITextFieldDelegate {

    //MARK:- IBOutlets
    
    @IBOutlet weak var btnViewTemp: UIButton!
    @IBOutlet weak var lblYoueEmailTemp: UILabel!
    @IBOutlet weak var btnDropDown: UIButton!
    @IBOutlet weak var lblDropDown: UILabel!
    @IBOutlet weak var btnSaveTemplate: UIButton!
    @IBOutlet weak var richEditor: UITextView!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtSubject: UITextField!
    @IBOutlet weak var viewJob: UIView!
    @IBOutlet weak var iconDropDown: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblSubject: UILabel!
    @IBOutlet weak var lblSelect: UILabel!
    
    
    //MARK:- Proprties
    
    var appColorNew = UserDefaults.standard.string(forKey: "app_Color")
    var data = [AddEmailTempData]()
    var extra = [AddEmailTempExtra]()
    var valuArr = [AddEmailTempValue]()
    var tempId:String?
    let dropDown = DropDown()
   
    var isTemp:Bool?
    var IntStatus:Int?
    var isFromUpdate = false
    
    //MARK:- View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nokri_customeButton()
        nokri_postForGet()
        self.viewJob.backgroundColor = UIColor(hex:appColorNew!)
        iconDropDown.image = iconDropDown.image?.withRenderingMode(.alwaysTemplate)
        iconDropDown.tintColor = UIColor(hex: appColorNew!)
        txtName.delegate = self
        txtSubject.delegate = self
        txtName.nokri_addBottomBorder()
        txtSubject.nokri_addBottomBorder()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AddTempTableViewController.dismisKeyboard as (AddTempTableViewController) -> () -> Void))
        view.addGestureRecognizer(tap)
        self.showBackButton()
        showSearchButton()
        
    }
  
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        txtName.nokri_updateBottomBorderSize()
        txtSubject.nokri_updateBottomBorderSize()
    }
    
    @objc func dismisKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

    //mark:- IBActions
    
    @IBAction func btnDropDownClicked(_ sender: UIButton) {
        dropDown.show()
    }
    
    @IBAction func txtNameClicked(_ sender: UITextField) {
    }
    
    @IBAction func txtSubjectClicked(_ sender: UITextField) {
    }
    
    @IBAction func btnSaveTempClicked(_ sender: UIButton) {
        guard let name = txtName.text else {
            return
        }
        guard let subject = txtSubject.text else {
            return
        }
 
        let alert = UIAlertController(title: "Name/subject can not be empty.", message: "", preferredStyle: .alert)
        let btnOk = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(btnOk)
        
        if IntStatus == nil{
         let alertSt = UIAlertController(title: "Status can not be empty", message: "", preferredStyle: .alert)
         let btnO = UIAlertAction(title: "Ok", style: .default, handler: nil)
         alertSt.addAction(btnO)
         self.present(alertSt, animated: true, completion: nil)
            
        }else{
        
        if isTemp == true{
            let param: [String: Any] = [
                "template_id": tempId!,
                "email_temp_name": name,
                "email_temp_subject": subject,
                "email_temp_for": IntStatus!,
                "email_temp_details":  richEditor.text!
            ]
            print(param)
            if txtName.text == ""{
               self.present(alert, animated: true, completion: nil)
            }else if txtSubject.text == ""{
                self.present(alert, animated: true, completion: nil)            }else{
                self.nokri_addTemplatePost(parameter: param as NSDictionary)
            }
            
        }else{
            let param: [String: Any] = [
                "email_temp_name": name,
                "email_temp_subject": subject,
                "email_temp_for": IntStatus!, //Resolve it
                "email_temp_details":  richEditor.text!
            ]
            print(param)
            if txtName.text == ""{
                self.present(alert, animated: true, completion: nil)
            }else if txtSubject.text == ""{
                self.present(alert, animated: true, completion: nil)
            }else{
                self.nokri_addTemplatePost(parameter: param as NSDictionary)
            }
        }
      }
    }

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == txtName {
            txtName.nokri_updateBottomBorderColor(isTextFieldSelected: true)
        } else {
            txtName.nokri_updateBottomBorderColor(isTextFieldSelected: false)
        }
        if textField == txtSubject {
            txtSubject.nokri_updateBottomBorderColor(isTextFieldSelected: true)
        } else {
            txtSubject.nokri_updateBottomBorderColor(isTextFieldSelected: false)
        }
        return true
    }
    
    
//    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
//        //heightWk = webView.scrollView.contentSize.height
//         //tableView.reloadData()
//        //print(webView.scrollView.contentSize.height)
//    }
    
    //MARK:- Custome Functions
    
    func nokri_postForGet(){
        if tempId == nil {
            nokri_emailTempData()
        }
        else {
            let param: [String: Any] = [
                "template_id": tempId!
            ]
            print(param)
            self.nokri_addTemplatePostForGet(parameter: param as NSDictionary)
        }
    }
    
    func nokri_populateData(){
        for obj in data{
            if obj.fieldTypeName == "email_temp_name"{
                self.txtName.placeholder = obj.key
                lblName.text = obj.key
                txtName.text = obj.stringVal
            }
            if obj.fieldTypeName == "email_temp_subject"{
                self.txtSubject.placeholder = obj.key
                lblSubject.text = obj.key
                txtSubject.text = obj.stringVal
            }
            if obj.fieldTypeName == "email_temp_details"{
                //richEditor.text = obj.stringVal
                //wkWeb.loadHTMLString(obj.stringVal, baseURL: nil)
                //wkWeb.loadHTMLStringWithMagic(content:obj.stringVal!, baseURL: nil)
                
                let htmlData = NSString(string: obj.stringVal).data(using: String.Encoding.unicode.rawValue)

                let options = [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html]

                let attributedString = try! NSAttributedString(data: htmlData!, options: options, documentAttributes: nil)

                richEditor.attributedText = attributedString
                
            }
            self.lblDropDown.text = obj.key
            self.lblSelect.text = obj.key
        }
    
        for obj in extra{
            
            if obj.fieldTypeName == "add"{
               self.lblYoueEmailTemp.text = obj.val
            }
            if obj.fieldTypeName == "view"{
                self.btnViewTemp.setTitle(obj.val, for: .normal)
            }
            if obj.fieldTypeName == "page_title"{
              self.title = obj.val
            }
            if obj.fieldTypeName == "save"{
               self.btnSaveTemplate.setTitle(obj.val, for: .normal)
            }
        }
        nokri_dropDownSetup()
    }
   
    func nokri_dropDownSetup(){
        var array = [String]()
        var arrayString = [String]()
        var selectedString = ""
        var selectedStatus:Int?
        
        for obj in data{
            for objVal in obj.valu{
                array.append(objVal.key)
                arrayString.append(objVal.value)
                if objVal.selected == true{
                    self.IntStatus = Int(objVal.value)
                    selectedStatus = Int(objVal.value)
                    selectedString = objVal.key
                }
            }
        }
        
        let intArray = arrayString.map { Int($0)!}
        if isFromUpdate == false{
            self.IntStatus = intArray[0]
            self.lblDropDown.text = array[0]
        }else{
            self.IntStatus = selectedStatus
            self.lblDropDown.text = selectedString
        }
        
        dropDown.dataSource = array
        
     
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.lblDropDown.text = item
            self.IntStatus = intArray[index]
        }
        dropDown.anchorView = btnDropDown
        DropDown.startListeningToKeyboard()
        DropDown.appearance().textColor = UIColor.black
        DropDown.appearance().textFont = UIFont.systemFont(ofSize: 12)
        DropDown.appearance().backgroundColor = UIColor.white
        DropDown.appearance().selectionBackgroundColor = UIColor(hex:appColorNew!)
        DropDown.appearance().cellHeight = 40
    }
    
    func nokri_customeButton(){
        btnSaveTemplate.layer.cornerRadius = 15
        btnSaveTemplate.layer.borderWidth = 1
        btnSaveTemplate.layer.borderColor = UIColor(hex:appColorNew!).cgColor
        btnSaveTemplate.setTitleColor(UIColor(hex: appColorNew!), for: .normal)
        btnSaveTemplate.backgroundColor = UIColor.white
        btnSaveTemplate.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor
        btnSaveTemplate.layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
        btnSaveTemplate.layer.shadowOpacity = 0.7
        btnSaveTemplate.layer.shadowRadius = 0.3
        btnSaveTemplate.layer.masksToBounds = false
    }
    
    //MARK:- API Calls
    
    func nokri_emailTempData() {
        self.showLoader()
        self.btnSaveTemplate.isHidden = true
        self.viewJob.isHidden = true
        UserHandler.nokri_emailTempGet(success: { (successResponse) in
            self.stopAnimating()
            if successResponse.success {
                self.btnSaveTemplate.isHidden = false
                self.viewJob.isHidden = false
                self.data = successResponse.data
                self.extra = successResponse.extras
                self.nokri_populateData()
            }
            else {
                self.btnSaveTemplate.isHidden = true
                self.viewJob.isHidden = true
                let alert = Constants.showBasicAlert(message: successResponse.message as String)
                self.present(alert, animated: true, completion: nil)
            }
        }) { (error) in
            self.btnSaveTemplate.isHidden = true
            self.viewJob.isHidden = true
            let alert = Constants.showBasicAlert(message: error.message)
            self.present(alert, animated: true, completion: nil)
            self.stopAnimating()
        }
    }
    
    func nokri_addTemplatePost(parameter: NSDictionary) {
        self.showLoader()
        UserHandler.nokri_emailTempPost(parameter: parameter as NSDictionary, success: { (successResponse) in
            self.stopAnimating()
            if successResponse.success == true{
                let hud = JGProgressHUD(style: .dark)
                hud.textLabel.text = successResponse.message!
                hud.detailTextLabel.text = nil
                hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                hud.position = .bottomCenter
                hud.show(in: self.view)
                hud.dismiss(afterDelay: 2.0)
                // self.view.makeToast(successResponse.message, duration: 1.5, position: .bottom)
            }
            else {
                let alert = Constants.showBasicAlert(message: successResponse.message)
                self.present(alert, animated: true, completion: nil)
            }
        }) { (error) in
            let alert = Constants.showBasicAlert(message: error.message)
            self.present(alert, animated: true, completion: nil)
           self.stopAnimating()
        }
    }
    
    func nokri_addTemplatePostForGet(parameter: NSDictionary) {
        self.showLoader()
        UserHandler.nokri_emailTempPost(parameter: parameter as NSDictionary, success: { (successResponse) in
            self.stopAnimating()
            if successResponse.success == true{
                self.data = successResponse.data
                self.extra = successResponse.extras
                self.nokri_populateData()
            }
        }) { (error) in
            let alert = Constants.showBasicAlert(message: error.message)
            self.present(alert, animated: true, completion: nil)
            self.stopAnimating()
        }
    }
}

extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}

//extension WKWebView {
//    ///
//    //// - Parameters:
//    ///   - content: HTML content which we need to load in the webview.
//    ///   - baseURL: Content base url. It is optional.
//    func loadHTMLStringWithMagic(content:String,baseURL:URL?){
//        let headerString = "<header><meta name='viewport' content='width=device-width, initial-scale=1.08, maximum-scale=1.08, minimum-scale=1.08, user-scalable=no '></header>"
//        loadHTMLString( headerString + content , baseURL: baseURL)
//    }
//}
