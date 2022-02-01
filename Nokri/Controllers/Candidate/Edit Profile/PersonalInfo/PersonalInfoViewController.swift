//
//  PersonalInfoViewController.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 4/26/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import UIKit
import TextFieldEffects
import ActionSheetPicker_3_0
import DropDown
import Alamofire
import Toast_Swift
//import AMProgressBar
import JGProgressHUD

class PersonalInfoViewController: UITableViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate,UITextViewDelegate {
    
    //MARK:- IBOutlets
    
    @IBOutlet weak var lblStepNo: UILabel!
    @IBOutlet weak var imageViewPersonalInfo: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDetail: UILabel!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtProfession: UITextField!
    @IBOutlet weak var txtDob: UITextField!
    @IBOutlet weak var lblDropDownLastEducationKey: UILabel!
    @IBOutlet weak var lblDropDownLevelKey: UILabel!
    @IBOutlet weak var lblDropDownTypeKey: UILabel!
    @IBOutlet weak var lblDropDownExperienceKey: UILabel!
    @IBOutlet weak var btnSaveInfo: UIButton!
    @IBOutlet weak var txtViewRichEditor: UITextView!
    @IBOutlet weak var lblAbout: UILabel!
    @IBOutlet weak var lblProfileImage: UILabel!
    @IBOutlet weak var lblSetProKey: UILabel!
    @IBOutlet weak var viewStepNo: UIView!
    @IBOutlet weak var iconDropDownLasrEdu: UIImageView!
    @IBOutlet weak var iconDropDownLevel: UIImageView!
    @IBOutlet weak var iconDropDownType: UIImageView!
    @IBOutlet weak var iconDropDownExp: UIImageView!
    @IBOutlet weak var iconDropDownProfileImage: UIImageView!
    @IBOutlet weak var iconDropDownSetPro: UIImageView!
    @IBOutlet weak var txtLastEducation: UITextField!
    @IBOutlet weak var txtLevel: UITextField!
    @IBOutlet weak var txtType: UITextField!
    @IBOutlet weak var txtExperience: UITextField!
    @IBOutlet weak var txtProfile: UITextField!
    @IBOutlet weak var txtSetProValue: UITextField!
    @IBOutlet weak var lblNameKey: UILabel!
    @IBOutlet weak var lblPhoneKey: UILabel!
    @IBOutlet weak var lblProfessionKey: UILabel!
    @IBOutlet weak var lblDobKey: UILabel!
    @IBOutlet weak var lblEmailKey: UILabel!
    @IBOutlet weak var btnChangePass: UIButton!
    @IBOutlet weak var btnDeleteACC: UIButton!
    
    //MARK:- Proporties
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var appColorNew = UserDefaults.standard.string(forKey: "app_Color")
    let dropDownLastEduction = DropDown()
    let dropDownType = DropDown()
    let dropDownExperience = DropDown()
    let dropDownLevel = DropDown()
    let dropDownSetProfile = DropDown()
    var dataParserArray = NSMutableArray()
  
    private lazy var uploadingProgressBar: JGProgressHUD = {
        let progressBar = JGProgressHUD(style: .dark)
        progressBar.indicatorView = JGProgressHUDRingIndicatorView()
        progressBar.textLabel.text = "Uploading"
        return progressBar
    }()
    var extraArray = [PersonalInfoExtra]()
    var dataArray = [PersonalInfoData]()
    var lastEduArray = [String]()
    var typeArray = [String]()
    var experienceArray = [String]()
    var levelArray = [String]()
    var setProArrayVal = [String]()
    var imageUrl:URL?
    var imageUpdated:Bool = true
    var lastEduInt:Int?
    var typeInt:Int?
    var expInt:Int?
    var levelEduInt:Int?
    var setProInt:Int?
    
    //MARK:- View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        nokri_shadow()
        nokri_dropDownSetup()
        nokri_customeButton()
        nokri_personalInfoData()
        nokri_Data()
        nokri_dropDownIcons()
        nokri_txtAddBottomorder()
        nokri_roundedImage()
        self.tabBarController?.tabBar.barTintColor =  UIColor(hex: appColorNew!)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(PersonalInfoViewController.dismisKeyboard as (PersonalInfoViewController) -> () -> Void))
        view.addGestureRecognizer(tap)
        
        if let userData = UserDefaults.standard.object(forKey: "settingsData") {
            let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
            let dataTabs = SplashRoot(fromDictionary: objData)
            let obj = dataTabs.data.candTabs
            self.lblStepNo.text = obj?.personal
        }
  
    }
    
    @objc func dismisKeyboard() {
        view.endEditing(true)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if let userData = UserDefaults.standard.object(forKey: "settingsData") {
            let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
            let dataTabs = SplashRoot(fromDictionary: objData)
            let obj = dataTabs.data.candTabs
      
            self.tabBarController?.tabBar.items?[4].title = NSLocalizedString((obj?.certification)!, comment: "comment")
            self.tabBarController?.tabBar.items?[5].title = NSLocalizedString((obj?.skills)!, comment: "comment")
            self.tabBarController?.tabBar.items?[6].title = NSLocalizedString((obj?.portfolio)!, comment: "comment")
            self.tabBarController?.tabBar.items?[7].title = NSLocalizedString((obj?.socail)!, comment: "comment")
            self.tabBarController?.tabBar.items?[8].title = NSLocalizedString((obj?.loca)!, comment: "comment")
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        nokri_updateBottomBorderSize()
    }
    
    //MARK:- Custome Functions
    
    func nokri_updateBottomBorderSize(){
        txtExperience.nokri_updateBottomBorderSize()
        txtEmail.nokri_updateBottomBorderSize()
        txtName.nokri_updateBottomBorderSize()
        txtPhone.nokri_updateBottomBorderSize()
        txtDob.nokri_updateBottomBorderSize()
        txtType.nokri_updateBottomBorderSize()
        txtLevel.nokri_updateBottomBorderSize()
        txtProfile.nokri_updateBottomBorderSize()
        txtExperience.nokri_updateBottomBorderSize()
        txtLastEducation.nokri_updateBottomBorderSize()
        txtProfession.nokri_updateBottomBorderSize()
        txtSetProValue.nokri_updateBottomBorderSize()
    }
    
    func nokri_txtAddBottomorder(){
        txtEmail.delegate = self
        txtName.delegate = self
        txtPhone.delegate = self
        txtDob.delegate = self
        txtType.delegate = self
        txtLevel.delegate = self
        txtProfile.delegate = self
        txtExperience.delegate = self
        txtLastEducation.delegate = self
        txtSetProValue.delegate = self
        
        txtEmail.nokri_addBottomBorder()
        txtLastEducation.nokri_addBottomBorder()
        txtName.nokri_addBottomBorder()
        txtPhone.nokri_addBottomBorder()
        txtDob.nokri_addBottomBorder()
        txtType.nokri_addBottomBorder()
        txtLevel.nokri_addBottomBorder()
        txtProfile.nokri_addBottomBorder()
        txtExperience.nokri_addBottomBorder()
        txtProfession.nokri_addBottomBorder()
        txtSetProValue.nokri_addBottomBorder()
    }
    
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == txtEmail {
            txtEmail.nokri_updateBottomBorderColor(isTextFieldSelected: true)
        } else {
            txtEmail.nokri_updateBottomBorderColor(isTextFieldSelected: false)
        }
        if textField == txtName {
            txtName.nokri_updateBottomBorderColor(isTextFieldSelected: true)
        } else {
            txtName.nokri_updateBottomBorderColor(isTextFieldSelected: false)
        }
        if textField == txtExperience {
            txtExperience.nokri_updateBottomBorderColor(isTextFieldSelected: true)
        } else {
            txtExperience.nokri_updateBottomBorderColor(isTextFieldSelected: false)
        }
        if textField == txtType {
            txtType.nokri_updateBottomBorderColor(isTextFieldSelected: true)
        } else {
            txtType.nokri_updateBottomBorderColor(isTextFieldSelected: false)
        }
        if textField == txtLevel {
            txtLevel.nokri_updateBottomBorderColor(isTextFieldSelected: true)
        } else {
            txtLevel.nokri_updateBottomBorderColor(isTextFieldSelected: false)
        }
        if textField == txtDob {
            txtDob.nokri_updateBottomBorderColor(isTextFieldSelected: true)
        } else {
            txtDob.nokri_updateBottomBorderColor(isTextFieldSelected: false)
        }
        if textField == txtPhone {
            txtPhone.nokri_updateBottomBorderColor(isTextFieldSelected: true)
        } else {
            txtPhone.nokri_updateBottomBorderColor(isTextFieldSelected: false)
        }
        if textField == txtProfile {
            txtProfile.nokri_updateBottomBorderColor(isTextFieldSelected: true)
        } else {
            txtProfile.nokri_updateBottomBorderColor(isTextFieldSelected: false)
        }
        if textField == txtLastEducation {
            txtLastEducation.nokri_updateBottomBorderColor(isTextFieldSelected: true)
        } else {
            txtLastEducation.nokri_updateBottomBorderColor(isTextFieldSelected: false)
        }
        if textField == txtProfession {
            txtProfession.nokri_updateBottomBorderColor(isTextFieldSelected: true)
        } else {
            txtProfession.nokri_updateBottomBorderColor(isTextFieldSelected: false)
        }
        if textField == txtSetProValue {
            txtSetProValue.nokri_updateBottomBorderColor(isTextFieldSelected: true)
        } else {
            txtSetProValue.nokri_updateBottomBorderColor(isTextFieldSelected: false)
        }
        return true
    }
    
    func nokri_populateData(){
        let isUpdatedImage = UserDefaults.standard.integer(forKey: "isUpdatedImage")
        if isUpdatedImage == 10{
            let updateImage = UserDefaults.standard.string(forKey: "updatedImage")
            imageViewPersonalInfo.sd_setImage(with: URL(string:updateImage!), completed: nil)
            imageViewPersonalInfo.sd_setShowActivityIndicatorView(true)
            imageViewPersonalInfo.sd_setIndicatorStyle(.gray)
        }else{
        }
        for obj in dataArray{
            if obj.fieldTypeName == "cand_name"{
                lblName.text = obj.value
                lblNameKey.text = obj.key
                txtName.placeholder = obj.key
                UserDefaults.standard.set(obj.value, forKey: "updateName")
                txtName.text = obj.value
            }else if obj.fieldTypeName == "cand_phone"{
                lblPhoneKey.text = obj.key
                txtPhone.placeholder = obj.key
                txtPhone.text = obj.value
            }else if obj.fieldTypeName == ""{
                lblEmailKey.text = obj.key
                txtEmail.placeholder = obj.key
                txtEmail.text = obj.value
            }else if obj.fieldTypeName == "cand_headline"{
                lblProfessionKey.text = obj.key
                txtProfession.placeholder = obj.key
                txtProfession.text = obj.value
                lblDetail.text = obj.value
            }else if obj.fieldTypeName == "cand_dob"{
                lblDobKey.text = obj.key
                txtDob.placeholder = obj.key
                txtDob.text = obj.value
            }else if obj.fieldTypeName == "cand_last"{
                lblDropDownLastEducationKey.text = obj.key
            }else if obj.fieldTypeName == "cand_level"{
                lblDropDownLevelKey.text = obj.key
            }else if obj.fieldTypeName == "cand_type"{
                lblDropDownTypeKey.text = obj.key
            }else if obj.fieldTypeName == "cand_experience"{
                lblDropDownExperienceKey.text = obj.key
            }else if obj.fieldTypeName == "cand_dp"{
                lblProfileImage.text = obj.key
                txtProfile.text = obj.key
            }else if obj.fieldTypeName == "cand_intro"{
                lblAbout.text = obj.key
            }else if obj.fieldTypeName == "cand_prof_stat"{
                lblSetProKey.text = obj.key
                txtSetProValue.text = obj.key
            }
            else{
                print("Nothing..")
            }
        }
        for obj in extraArray {
            if obj.fieldTypeName == "btn_name"{
                btnSaveInfo.setTitle(obj.value, for: .normal)
            }
            if obj.fieldTypeName == "change_pasword"{
                btnChangePass.setTitle(obj.value, for: .normal)
                btnChangePass.setTitleColor(UIColor(hex: appColorNew!), for: .normal)
            }
            if obj.fieldTypeName == "del_acount"{
                btnDeleteACC.setTitle(obj.value, for: .normal)
            }
        }
    }
    
    func nokri_dropDownIcons(){
        iconDropDownLasrEdu.image = iconDropDownLasrEdu.image?.withRenderingMode(.alwaysTemplate)
        iconDropDownLasrEdu.tintColor = UIColor(hex: appColorNew!)
        iconDropDownExp.image = iconDropDownExp.image?.withRenderingMode(.alwaysTemplate)
        iconDropDownExp.tintColor = UIColor(hex: appColorNew!)
        iconDropDownType.image = iconDropDownType.image?.withRenderingMode(.alwaysTemplate)
        iconDropDownType.tintColor = UIColor(hex: appColorNew!)
        iconDropDownLevel.image = iconDropDownLevel.image?.withRenderingMode(.alwaysTemplate)
        iconDropDownLevel.tintColor = UIColor(hex:appColorNew!)
        iconDropDownProfileImage.image = iconDropDownProfileImage.image?.withRenderingMode(.alwaysTemplate)
        iconDropDownProfileImage.tintColor = UIColor(hex: appColorNew!)
        iconDropDownLasrEdu.image = iconDropDownLasrEdu.image?.withRenderingMode(.alwaysTemplate)
        iconDropDownLasrEdu.tintColor = UIColor(hex: appColorNew!)
        iconDropDownSetPro.image = iconDropDownSetPro.image?.withRenderingMode(.alwaysTemplate)
        iconDropDownSetPro.tintColor = UIColor(hex: appColorNew!)
        viewStepNo.backgroundColor = UIColor(hex:appColorNew!)
    }
    
    //MARK:- IBActions

    @IBAction func txtDobClicked(_ sender: UITextField) {
    }

    @IBAction func txtEducationClicked(_ sender: UITextField) {
        dropDownLastEduction.show()
    }
    
    @IBAction func txtLevelClicked(_ sender: UITextField) {
        dropDownLevel.show()
    }
    
    @IBAction func txtTypeClicked(_ sender: UITextField) {
        dropDownType.show()
    }
    
    @IBAction func txtExperienceClicked(_ sender: UITextField) {
        dropDownExperience.show()
    }
    
    @IBAction func btnLastEduClicked(_ sender: UIButton) {
         dropDownLastEduction.show()
    }
    
    @IBAction func btnLevelClicked(_ sender: UIButton) {
        dropDownLevel.show()
    }
    
    @IBAction func btnTypeClicked(_ sender: UIButton) {
         dropDownType.show()
    }
    
    @IBAction func btnExpClicked(_ sender: UIButton) {
        dropDownExperience.show()
    }
    
    @IBAction func btnSetProClicked(_ sender: UIButton) {
        dropDownSetProfile.show()
    }
    
    @IBAction func btnDobClicked(_ sender: UIButton) {
        let datePicker = ActionSheetDatePicker(title: "Select Date:", datePickerMode: UIDatePicker.Mode.date, selectedDate: Date(), doneBlock: {
            picker, value, index in
            print("value = \(String(describing: value))")
            print("index = \(String(describing: index))")
            print("picker = \(String(describing: picker))")
            let fullName = "\(String(describing: value!))"
            let fullNameArr = fullName.components(separatedBy: " ")
            let name  = "\(fullNameArr[0])" + " " + "\(fullNameArr[1])"
            print(name)
            let dateFormatterGet = DateFormatter()
            dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let dateFormatterPrint = DateFormatter()
            dateFormatterPrint.dateFormat = "MMM yyyy"
            if let date = dateFormatterGet.date(from:  name){
                print(dateFormatterPrint.string(from: date))
                self.txtDob.text = dateFormatterPrint.string(from: date)
            }
            else {
                print("There was an error decoding the string")
            }
            return
        }, cancel: { ActionStringCancelBlock in return }, origin: (sender as AnyObject).superview!?.superview)
        let secondsInWeek: TimeInterval = 15000 * 24 * 60 * 60;
        datePicker?.minimumDate = Date(timeInterval: -secondsInWeek, since: Date())
        datePicker?.maximumDate = Date(timeInterval: secondsInWeek, since: Date())
        datePicker?.minuteInterval = 20
        datePicker?.show()
    }
    
    @IBAction func btnProfileClicked(_ sender: UIButton) {
        
        var select:String?
        var camera:String?
        var gallery:String?
        var cancel:String?
        
        if let userData = UserDefaults.standard.object(forKey: "settingsData") {
            let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
            let dataTabs = SplashRoot(fromDictionary: objData)
            select = dataTabs.data.extra.select
            camera = dataTabs.data.extra.camera
            gallery = dataTabs.data.extra.gallery
            cancel = dataTabs.data.genericTxts.btnCancel
        }
        
        let actionSheet = UIAlertController(title: select, message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        actionSheet.addAction(UIAlertAction(title: camera, style: .default, handler: { (action) -> Void in
            self.nokri_selectFromCameraPressed()
        }))
        actionSheet.addAction(UIAlertAction(title: gallery, style: .default, handler: { (action) -> Void in
            self.nokri_selectFromGalleryPressed()
        }))
        actionSheet.addAction(UIAlertAction(title: cancel, style: .destructive, handler: { (action) -> Void in
        }))
        self.present(actionSheet, animated: true, completion: nil)    
    }

    @IBAction func txtProfileClicked(_ sender: UITextField) {
    
           }

    @IBAction func btnSaveInfoClicked(_ sender: UIButton) {
   
        var status = ""
        if txtSetProValue.text == "Public"{
            status = "pub"
        }else{
            status = "priv"
        }
        
        guard let name = txtName.text else {
            return
        }
        guard let phone = txtPhone.text else {
            return
        }
        guard let profession = txtProfession.text else {
            return
        }
        guard let dob = txtDob.text else {
            return
        }
        guard txtLastEducation.text != nil else {
            return
        }
        guard txtLevel.text != nil else {
            return
        }
        guard txtType.text != nil else {
            return
        }
        guard txtExperience.text != nil else {
            return
        }
        let param: [String: Any] = [
            "cand_name": name,
            "cand_dob": dob,
            "cand_phone": phone,
            "cand_headline": profession,
            "cand_last": lastEduInt ?? 103,
            "cand_level": levelEduInt ?? 25,
            "cand_type": typeInt ?? 19,
            "cand_experience": expInt ?? 47,
            "cand_prof_stat" : status,
            "cand_intro": txtViewRichEditor.text!
        ]
        print(param)
        self.nokri_personalInfoPost(parameter: param as NSDictionary)
    }
    
    @IBAction func btnChangePassClicked(_ sender: UIButton) {
        
        let controller = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ChangePasswordViewController") as! ChangePasswordViewController
        
        controller.modalPresentationStyle = .overCurrentContext
        self.present(controller, animated: true, completion: nil)
        
    }
    
    @IBAction func btnDeleteAccClicked(_ sender: UIButton) {
        
        let user_id = UserDefaults.standard.integer(forKey: "id")
        print(user_id)
        var confirmString:String?
        var btnOk:String?
        var btnCncel:String?
        if let userData = UserDefaults.standard.object(forKey: "settingsData") {
            let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
            let dataTabs = SplashRoot(fromDictionary: objData)
            confirmString = dataTabs.data.genericTxts.confirm
            btnOk = dataTabs.data.genericTxts.btnConfirm
            btnCncel = dataTabs.data.genericTxts.btnCancel
        }
        let Alert = UIAlertController(title:confirmString, message:"", preferredStyle: .alert)
        let okButton = UIAlertAction(title: btnOk, style: .default) { _ in
            
            let param: [String: Any] = [
                "user_id":user_id
            ]
            print(param)
            self.nokri_deleteAccount(parameter: param as NSDictionary)
        }
        let CancelButton = UIAlertAction(title: btnCncel, style: .cancel)
        Alert.addAction(okButton)
        Alert.addAction(CancelButton)
        self.present(Alert, animated: true, completion: nil)

    }
    
    //MARK:- Image Selection
    
    func nokri_selectFromCameraPressed(){
        
        let userData = UserDefaults.standard.object(forKey: "settingsData")
        let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
        let dataTabs = SplashRoot(fromDictionary: objData)
        let objExtraTxt = dataTabs.data.extra
        
        let imagePickerConroller = UIImagePickerController()
        imagePickerConroller.delegate = self
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            imagePickerConroller.sourceType = .camera
        }else{
            let alert = UIAlertController(title: objExtraTxt?.alertName, message: objExtraTxt?.cameraNot, preferredStyle: UIAlertController.Style.alert)
            let OkAction = UIAlertAction(title: dataTabs.data.progressTxt.btnOk, style: UIAlertAction.Style.cancel, handler: nil)
            alert.addAction(OkAction)
            self.present(alert, animated: true, completion: nil)
        }
        self.present(imagePickerConroller,animated:true, completion:nil)
    }
    
    func nokri_selectFromGalleryPressed(){
        
        let userData = UserDefaults.standard.object(forKey: "settingsData")
        let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
        let dataTabs = SplashRoot(fromDictionary: objData)
        let objExtraTxt = dataTabs.data.extra
        
        let imagePickerConroller = UIImagePickerController()
        imagePickerConroller.delegate = self
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            imagePickerConroller.sourceType = .photoLibrary
        }else{
            let alert = UIAlertController(title:objExtraTxt?.alertName, message: objExtraTxt?.galleryNot, preferredStyle: UIAlertController.Style.alert)
            let OkAction = UIAlertAction(title: dataTabs.data.progressTxt.btnOk, style: UIAlertAction.Style.cancel, handler: nil)
            alert.addAction(OkAction)
            self.present(alert, animated: true, completion: nil)
        }
        self.present(imagePickerConroller,animated:true, completion:nil)
    }
    
     func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
           if (info[UIImagePickerController.InfoKey.originalImage] as? UIImage) != nil {
               if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                saveFileToDocumentDirectory(image: pickedImage)
                self.removeFileFromDocumentsDirectory(fileUrl: self.imageUrl!)
                nokri_uploadImage()
            }
            dismiss(animated: true, completion: nil)
        }
    }
    
    func saveFileToDocumentDirectory(image: UIImage) {
        if let savedUrl = FileManager.default.saveFileToDocumentsDirectory(image: image, name: "profile_img", extention: ".png") {
            self.imageUrl = savedUrl
            print("Library \(String(describing: imageUrl))")
        }
    }
    
    func removeFileFromDocumentsDirectory(fileUrl: URL) {
        _ = FileManager.default.removeFileFromDocumentsDirectory(fileUrl: fileUrl)
    }
    
    //MARKL:- Custome Functions
    
    func nokri_roundedImage(){
        imageViewPersonalInfo.layer.borderWidth = 2
        imageViewPersonalInfo.layer.masksToBounds = false
        imageViewPersonalInfo.layer.borderColor = UIColor(hex:appColorNew!).cgColor
        imageViewPersonalInfo.layer.cornerRadius = imageViewPersonalInfo.frame.height/2
        imageViewPersonalInfo.clipsToBounds = true
    }
    
    func nokri_dropDownSetup(){
        
        var lastEduKeyArr = [Int]()
        var levelKeyArr = [Int]()
        var typeKeyArr = [Int]()
        var expkeyArr = [Int]()
        var setProArr = [Int]()
        
        let selectedDataJob = self.dataParserArray as? [NSDictionary];
        for itemDict in selectedDataJob! {
            let innerDict = itemDict ;
            if let field_type_name = innerDict["field_type_name"] as? String{
                
                if field_type_name == "cand_last" {
                    if let value = innerDict["value"] as? [NSDictionary] {
                        
                        for obj in value{
                            let otherInnerDict = obj
                            if let selected = otherInnerDict["selected"] as? Bool {
                                if let value = otherInnerDict["value"] as? String {
                                    lastEduArray.append(value)
                                    if selected == true{
                                        self.txtLastEducation.text = value
                                    }
                                }
                            }
                            if let value = otherInnerDict["key"] as? Int {
                                lastEduKeyArr.append(value)
                            }
                        }
                    }
                   
                }
                if field_type_name == "cand_level" {
                    if let value = innerDict["value"] as? [NSDictionary] {
                        for obj in value{
                            let otherInnerDict = obj
                            
                            if let value = otherInnerDict["key"] as? Int {
                                levelKeyArr.append(value)
                            }
                            if let selected = otherInnerDict["selected"] as? Bool {
                                if let value = otherInnerDict["value"] as? String {
                                    levelArray.append(value)
                                    if selected == true{
                                        self.txtLevel.text = value
                                    }
                                }
                            }
                        }
                    }
                }
                if field_type_name == "cand_type" {
                    if let value = innerDict["value"] as? [NSDictionary] {
                        for obj in value{
                            let otherInnerDict = obj
                            if let value = otherInnerDict["key"] as? Int {
                                typeKeyArr.append(value)
                            }
                            if let selected = otherInnerDict["selected"] as? Bool {
                                if let value = otherInnerDict["value"] as? String {
                                    typeArray.append(value)
                                    if selected == true{
                                        txtType.text = value
                                    }
                                }
                            }
                        }
                    }
                   
                }
                if field_type_name == "cand_experience" {
                    if let value = innerDict["value"] as? [NSDictionary] {
                        for obj in value{
                            let otherInnerDict = obj
                            if let value = otherInnerDict["value"] as? String {
                                experienceArray.append(value)
                            }
                            if let value = otherInnerDict["key"] as? Int {
                                expkeyArr.append(value)
                            }
                            if let selected = otherInnerDict["selected"] as? Bool {
                                if let value = otherInnerDict["value"] as? String {
                                    experienceArray.append(value)
                                    if selected == true{
                                        txtExperience.text = value
                                    }
                                }
                            }
                        }
                    }
                }
                if field_type_name == "cand_prof_stat" {
                    if let value = innerDict["value"] as? [NSDictionary] {
                        for obj in value{
                            let otherInnerDict = obj
                            
                            if let value = otherInnerDict["key"] as? Int {
                                setProArr.append(value)
                            }
                            if let selected = otherInnerDict["selected"] as? Bool {
                                //setProfileBool = value
                                if let value = otherInnerDict["value"] as? String {
                                    setProArrayVal.append(value)
                                    if selected == true{
                                        txtSetProValue.text = value
                                    }
                                }
                               
                            }
                        }
                    }
                }
            }
        }
        
        dropDownLastEduction.dataSource = lastEduArray
        //self.dropDownLastEduction.tag = lastEduKeyArr[0]
        print(lastEduArray)
        dropDownLastEduction.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.lastEduInt = lastEduKeyArr[index]
            self.txtLastEducation.text = item
        }
        dropDownType.dataSource = typeArray
        dropDownType.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.txtType.text = item
            self.typeInt = typeKeyArr[index]
        }
        dropDownExperience.dataSource = experienceArray
        dropDownExperience.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.dropDownExperience.tag = expkeyArr[index]
            self.expInt = expkeyArr[index] //levelEduInt
            self.txtExperience.text = item
        }
        dropDownLevel.dataSource = levelArray
        dropDownLevel.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.dropDownLevel.tag = levelKeyArr[index]
            self.txtLevel.text = item
            self.levelEduInt = levelKeyArr[index]
        }
        
        dropDownSetProfile.dataSource = setProArrayVal
        dropDownSetProfile.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            //self.setProInt = setProArr[index]
            self.txtSetProValue.text = item
        }
        
        dropDownLastEduction.anchorView = txtLastEducation
        dropDownLevel.anchorView = txtLevel
        dropDownType.anchorView = txtType
        dropDownExperience.anchorView = txtExperience
        dropDownSetProfile.anchorView = txtSetProValue
        DropDown.startListeningToKeyboard()
        DropDown.appearance().textColor = UIColor.black
        DropDown.appearance().textFont = UIFont.systemFont(ofSize: 12)
        DropDown.appearance().backgroundColor = UIColor.white
        DropDown.appearance().selectionBackgroundColor = UIColor(hex:appColorNew!)
        DropDown.appearance().cellHeight = 40
        
    }
    
    func nokri_customeButton(){
        btnSaveInfo.layer.cornerRadius = 15
        btnSaveInfo.layer.borderWidth = 1
        btnSaveInfo.layer.borderColor = UIColor(hex:appColorNew!).cgColor
        btnSaveInfo.layer.shadowRadius = 0.3
        btnSaveInfo.layer.masksToBounds = false
        btnSaveInfo.backgroundColor = UIColor.white
        btnSaveInfo.setTitleColor(UIColor(hex: appColorNew!), for: .normal)
    }

    func nokri_shadow(){
        txtViewRichEditor.layer.borderColor = UIColor.groupTableViewBackground.cgColor
        txtViewRichEditor.layer.cornerRadius = 0
        txtViewRichEditor.layer.shadowColor = UIColor(white: 0.0, alpha: 0.5).cgColor
        txtViewRichEditor.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        txtViewRichEditor.layer.shadowOpacity = 0.8
        txtViewRichEditor.layer.shadowRadius = 1
        txtViewRichEditor.layer.borderWidth = 1
    }
    
    //MARK:- API Calls
    
    func nokri_personalInfoData() {
        self.showLoader()
        UserHandler.nokri_candidatePersonalInfo(success: { (successResponse) in
            self.stopAnimating()
            if successResponse.success {
                self.dataArray = successResponse.data
                self.extraArray = successResponse.extras
                self.nokri_populateData()
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
    
    func nokri_Data(){
        
        var langCode = UserDefaults.standard.string(forKey: "langCode")
        if langCode == nil {
            langCode = "en"
        }
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
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.canPersonalInfo, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    guard let res = response.value else{return}
                    let responseData = res as! NSDictionary
                    let success = responseData["success"] as! Bool
                    let messageResponse = responseData["message"] as! String
                    //success = false
                    if success == true{
                        self.tableView.isHidden = false
                        if let array = responseData["data"] as? NSArray {
                            self.nokri_dataParser(dataArray: array)
                        }
                        self.nokri_dropDownSetup()
                    }else{
                        //self.tableView.isHidden = true
                        let hud = JGProgressHUD(style: .dark)
                        hud.textLabel.text = messageResponse
                        hud.detailTextLabel.text = nil
                        hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                        hud.position = .bottomCenter
                        hud.show(in: self.view)
                        hud.dismiss(afterDelay: 2.0)
                        self.stopAnimating()
                    }
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
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.canPersonalInfo, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    guard let res = response.value else{return}
                    let responseData = res as! NSDictionary
                    let success = responseData["success"] as! Bool
                    let messageResponse = responseData["message"] as! String
                    //success = false
                    if success == true{
                        self.tableView.isHidden = false
                        if let array = responseData["data"] as? NSArray {
                            self.nokri_dataParser(dataArray: array)
                        }
                        self.nokri_dropDownSetup()
                    }else{
                        //self.tableView.isHidden = true
                        self.view.makeToast(messageResponse, duration: 1.5, position: .center)
                        self.stopAnimating()
                    }
                    self.stopAnimating()
            }
        }
    }
    
    func nokri_dataParser(dataArray:NSArray){
        self.dataParserArray.removeAllObjects()
        for item in dataArray{
            self.dataParserArray.add(item)
        }
    }
    
    func nokri_personalInfoPost(parameter: NSDictionary) {
        self.showLoader()
        UserHandler.nokri_personalInfoPost(parameter: parameter as NSDictionary, success: { (successResponse) in
            self.stopAnimating()
            if successResponse.success == true {
                let hud = JGProgressHUD(style: .dark)
                hud.textLabel.text = successResponse.message
                hud.detailTextLabel.text = nil
                hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                hud.position = .bottomCenter
                hud.show(in: self.tableView)
                hud.dismiss(afterDelay: 2.0)
                //self.view.makeToast(successResponse.message, duration: 1.5, position: .bottom)
                self.nokri_Data()
                self.nokri_personalInfoData()
                UserDefaults.standard.set(10, forKey: "isUpdat")
            }
            else {
                let hud = JGProgressHUD(style: .dark)
                hud.textLabel.text = successResponse.message!
                hud.detailTextLabel.text = nil
                hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                hud.position = .bottomCenter
                hud.show(in: self.view)
                hud.dismiss(afterDelay: 2.0)
                self.stopAnimating()
            }
        }) { (error) in
            let alert = Constants.showBasicAlert(message: error.message)
            self.present(alert, animated: true, completion: nil)
            self.stopAnimating()
        }
    }
    
    func nokri_deleteAccount(parameter: NSDictionary) {
        self.showLoader()
        UserHandler.nokri_deleteAccount(parameter: parameter as NSDictionary, success: { (successResponse) in
            self.stopAnimating()
            if successResponse.success == true{
                UserDefaults.standard.set(false, forKey: "isSocial")
                UserDefaults.standard.set("0" , forKey: "id")
                UserDefaults.standard.set(nil , forKey: "email")
                UserDefaults.standard.set(nil, forKey: "img")
                UserDefaults.standard.set("3" , forKey: "acountTypeafb")
                UserDefaults.standard.set(5, forKey: "aType")
                let isHome = UserDefaults.standard.string(forKey: "home")
                if isHome == "1"{
                    self.appDelegate.nokri_moveToHome1()
                }else{
                    self.appDelegate.nokri_moveToHome2()
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
    
    func nokri_uploadImage() {
        uploadingProgressBar.progress = 0.0
        uploadingProgressBar.detailTextLabel.text = "0% Completed"
        uploadingProgressBar.show(in: view)
        UserHandler.nokri_uploadImage(fileName: "logo_img", fileUrl: imageUrl!, progress: { (uploadProgress) in
            let currentProgress = Float(uploadProgress)/100
            self.uploadingProgressBar.detailTextLabel.text = "\(uploadProgress)% Completed"
            self.uploadingProgressBar.setProgress(currentProgress, animated: true)
        }, success: { (successResponse) in
            if successResponse.success == true{
                self.uploadingProgressBar.dismiss(animated: true)
                self.removeFileFromDocumentsDirectory(fileUrl: self.imageUrl!)
                let hud = JGProgressHUD(style: .dark)
                hud.textLabel.text = successResponse.message!
                hud.detailTextLabel.text = nil
                hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                hud.position = .bottomCenter
                hud.show(in: self.view)
                hud.dismiss(afterDelay: 2.0)
                //self.view.makeToast(successResponse.message, duration: 2.5, position: .center)
                UserDefaults.standard.set(successResponse.data.image, forKey: "updatedImage")
                UserDefaults.standard.set(10, forKey: "isUpdatedImage")
                self.nokri_populateData()
                self.stopAnimating()
            }
            else{
                self.uploadingProgressBar.dismiss(animated: true)
                let alert = Constants.showBasicAlert(message: successResponse.message)
                self.present(alert, animated: true, completion: nil)
                self.stopAnimating()
            }
        }, failure: { (error) in
            self.uploadingProgressBar.dismiss(animated: true)
            let alert = Constants.showBasicAlert(message: error.message)
            self.present(alert, animated: true, completion: nil)
            self.stopAnimating()
        })
    }
}


