//
//  PersonalInfoStaticTableViewCell.swift
//  Nokri
//
//  Created by apple on 3/3/20.
//  Copyright © 2020 Furqan Nadeem. All rights reserved.
//

import UIKit
import DropDown
import JGProgressHUD
import ActionSheetPicker_3_0
import Alamofire



protocol PersonalInfoStaticProt {
    func personalInfoStatic(name:String ,phone:String,profession:String,dob:String,edu:Int,level:Int,type:Int,exp:Int,setPro:Int,txtAboutDes:String,salary:Int,salaryType:Int,currency:Int,gender:Int)
}

class PersonalInfoStaticTableViewCell: UITableViewCell,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate,UITextViewDelegate {
    
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
    @IBOutlet weak var lblDropDownSalaryKey: UILabel!
    @IBOutlet weak var lblDropDownCurrencyKey: UILabel!
    @IBOutlet weak var lblDropDownSalaryTypeKey: UILabel!
    
    @IBOutlet weak var lblGenderKey: UILabel!
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
    @IBOutlet weak var txtLastEducation: UIButton!
    @IBOutlet weak var txtSalary: UIButton!
    @IBOutlet weak var txtSalaryType: UIButton!
    @IBOutlet weak var txtCurrency: UIButton!
    @IBOutlet weak var txtLevel: UIButton!
    @IBOutlet weak var txtType: UIButton!
    @IBOutlet weak var txtExperience: UIButton!
    @IBOutlet weak var txtProfile: UIButton!
    @IBOutlet weak var txtSetProValue: UIButton!
    @IBOutlet weak var txtGender: UIButton!
    
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
    let dropDownSalary = DropDown()
    let dropDownSalaryType = DropDown()
    let dropDownCurrency = DropDown()
    let dropDownGender = DropDown()
    
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
    var salaryEduArray = [String]()
    var salaryTypeEduArray = [String]()
    var currencyEduArray = [String]()
    var genderArray = [String]()
    var typeArray = [String]()
    var experienceArray = [String]()
    var levelArray = [String]()
    var setProArrayVal = [String]()
    var imageUrl:URL?
    var imageUpdated:Bool = true
    var lastEduInt:Int?
     var salaryInt:Int?
     var salaryTypeInt:Int?
     var currencyInt:Int?
    var genderInt:Int?
    var typeInt:Int?
    var expInt:Int?
    var levelEduInt:Int?
    var setProInt:Int?
    var delegate:PersonalInfoStaticProt?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        nokri_shadow()
        nokri_dropDownSetup()
        nokri_personalInfoData()
        nokri_Data()
        nokri_roundedImage()
        txtViewRichEditor.delegate  = self
        //self.tabBarController?.tabBar.barTintColor =  UIColor(hex: appColorNew!)
        //        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(PersonalInfoViewController.dismisKeyboard as (PersonalInfoViewController) -> () -> Void))
        //        view.addGestureRecognizer(tap)
        
        //        if let userData = UserDefaults.standard.object(forKey: "settingsData") {
        //            let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
        //            let dataTabs = SplashRoot(fromDictionary: objData)
        //            let obj = dataTabs.data.candTabs
        //            //self.lblStepNo.text = obj?.personal
        //        }
        
        delegate?.personalInfoStatic(name: txtName.text!, phone: txtPhone.text!, profession: txtProfession.text!, dob: txtDob.text!, edu: 103, level: 25, type: 19, exp: 47, setPro: 0,txtAboutDes: txtViewRichEditor.text,salary: dropDownSalary.tag,salaryType: dropDownSalaryType.tag,currency: dropDownCurrency.tag, gender: self.dropDownGender.tag)
        
    }
    
    @IBAction func txtNameChange(_ sender: UITextField) {
        
        delegate?.personalInfoStatic(name: txtName.text!, phone: txtPhone.text!, profession: txtProfession.text!, dob: txtDob.text!, edu: dropDownLastEduction.tag, level: dropDownLevel.tag, type: dropDownType.tag, exp: dropDownExperience.tag, setPro: 0,txtAboutDes: txtViewRichEditor.text,salary: dropDownSalary.tag,salaryType: dropDownSalaryType.tag,currency: dropDownCurrency.tag,gender:dropDownGender.tag)
        
    }
    
    
    @IBAction func txtPhoneChange(_ sender: UITextField) {
        delegate?.personalInfoStatic(name: txtName.text!, phone: txtPhone.text!, profession: txtProfession.text!, dob: txtDob.text!, edu: dropDownLastEduction.tag, level: dropDownLevel.tag, type: dropDownType.tag, exp: dropDownExperience.tag, setPro: 0,txtAboutDes: txtViewRichEditor.text,salary: dropDownSalary.tag,salaryType: dropDownSalaryType.tag,currency: dropDownCurrency.tag,gender:dropDownGender.tag)
    }
    
    
    @IBAction func txtProChange(_ sender: UITextField) {
        delegate?.personalInfoStatic(name: txtName.text!, phone: txtPhone.text!, profession: txtProfession.text!, dob: txtDob.text!, edu: dropDownLastEduction.tag, level: dropDownLevel.tag, type: dropDownType.tag, exp: dropDownExperience.tag, setPro: 0,txtAboutDes: txtViewRichEditor.text,salary: dropDownSalary.tag,salaryType: dropDownSalaryType.tag,currency: dropDownCurrency.tag,gender:dropDownGender.tag)
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
                
            }else if obj.fieldTypeName == "cand_dob"{
                lblDobKey.text = obj.key
                txtDob.placeholder = obj.key
                txtDob.text = obj.value
            }else if obj.fieldTypeName == "cand_last"{
                lblDropDownLastEducationKey.text = obj.key
            }else if obj.fieldTypeName == "cand_gender"{
                lblGenderKey.text = obj.key
            }else if obj.fieldTypeName == "cand_salary_range"{
                lblDropDownSalaryKey.text = obj.key
            }else if obj.fieldTypeName == "cand_salary_type"{
                lblDropDownSalaryTypeKey.text = obj.key
            }else if obj.fieldTypeName == "cand_salary_curren"{
                lblDropDownCurrencyKey.text = obj.key
            }else if obj.fieldTypeName == "cand_level"{
                lblDropDownLevelKey.text = obj.key
            }else if obj.fieldTypeName == "cand_type"{
                lblDropDownTypeKey.text = obj.key
            }else if obj.fieldTypeName == "cand_experience"{
                lblDropDownExperienceKey.text = obj.key
            }else if obj.fieldTypeName == "cand_dp"{
                lblProfileImage.text = obj.key
                //txtProfile.text = obj.key
                txtProfile.setTitle(obj.key, for: .normal)
            }else if obj.fieldTypeName == "cand_intro"{
                lblAbout.text = obj.key
                txtViewRichEditor.text = obj.value
            }else if obj.fieldTypeName == "cand_prof_stat"{
                lblSetProKey.text = obj.key
                txtSetProValue.setTitle(obj.value, for: .normal)
            }
            else{
                print("Nothing..")
            }
        }
        for obj in extraArray {
            if obj.fieldTypeName == "btn_name"{
                // btnSaveInfo.setTitle(obj.value, for: .normal)
            }
            if obj.fieldTypeName == "change_pasword"{
                btnChangePass.setTitle(obj.value, for: .normal)
                btnChangePass.setTitleColor(UIColor(hex: appColorNew!), for: .normal)
            }
            if obj.fieldTypeName == "del_acount"{
                //btnDeleteACC.setTitle(obj.value, for: .normal)
            }
        }
    }
    
    //MARK:- IBActions
    
    @IBAction func btnLastEduClicked(_ sender: UIButton) {
        dropDownLastEduction.show()
    }
    
    
    @IBAction func btnSalaryClicked(_ sender: UIButton) {
        dropDownSalary.show()
    }
    
    @IBAction func btnSalaryTypeClicked(_ sender: UIButton) {
        dropDownSalaryType.show()
    }
    
    @IBAction func btnCurrencyClicked(_ sender: UIButton) {
        dropDownCurrency.show()
    }
    
    @IBAction func btnGenderClicked(_ sender: UIButton) {
        dropDownGender.show()
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
                self.delegate?.personalInfoStatic(name: self.txtName.text!, phone: self.txtPhone.text!, profession: self.txtProfession.text!, dob: self.txtDob.text!, edu: self.dropDownLastEduction.tag, level: self.dropDownLevel.tag, type: self.dropDownType.tag, exp: self.dropDownExperience.tag, setPro: 0,txtAboutDes: self.txtViewRichEditor.text,salary: self.dropDownSalary.tag,salaryType: self.dropDownSalaryType.tag,currency: self.dropDownCurrency.tag,gender:self.dropDownGender.tag)
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
        
        if Constants.isiPadDevice {
            actionSheet.popoverPresentationController?.sourceView = txtProfile
            actionSheet.popoverPresentationController?.sourceRect = txtProfile.bounds
            self.window?.rootViewController?.present(actionSheet, animated: true, completion: nil)
        }else{
            self.window?.rootViewController?.present(actionSheet, animated: true, completion: nil)
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        
        if textView == txtViewRichEditor {
            self.delegate?.personalInfoStatic(name: self.txtName.text!, phone: self.txtPhone.text!, profession: self.txtProfession.text!, dob: self.txtDob.text!, edu:  dropDownLastEduction.tag, level: self.dropDownLevel.tag, type: self.dropDownType.tag, exp: self.dropDownExperience.tag, setPro: self.dropDownSetProfile.tag,txtAboutDes :txtViewRichEditor.text,salary: dropDownSalary.tag,salaryType: dropDownSalaryType.tag,currency: dropDownCurrency.tag,gender:dropDownGender.tag)
        }
        
    }
    
    @IBAction func btnChangePassClicked(_ sender: UIButton) {
        let controller = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ChangePasswordViewController") as! ChangePasswordViewController
        
        controller.modalPresentationStyle = .overCurrentContext
        self.window?.rootViewController?.present(controller, animated: true, completion: nil)
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
            self.window?.rootViewController?.present(alert, animated: true, completion: nil)
        }
        self.window?.rootViewController?.present(imagePickerConroller,animated:true, completion:nil)
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
            let alert = UIAlertController(title: objExtraTxt?.alertName, message: objExtraTxt?.galleryNot, preferredStyle: UIAlertController.Style.alert)
            let OkAction = UIAlertAction(title: dataTabs.data.progressTxt.btnOk, style: UIAlertAction.Style.cancel, handler: nil)
            alert.addAction(OkAction)
            self.window?.rootViewController?.present(alert, animated: true, completion: nil)
        }
        self.window?.rootViewController?.present(imagePickerConroller,animated:true, completion:nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if (info[UIImagePickerController.InfoKey.originalImage] as? UIImage) != nil {
            if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                saveFileToDocumentDirectory(image: pickedImage)
                //self.removeFileFromDocumentsDirectory(fileUrl: self.imageUrl!)
                nokri_uploadImage()
            }
            self.window?.rootViewController?.dismiss(animated: true, completion: nil)
        }
    }
    
    func saveFileToDocumentDirectory(image: UIImage) {
        if let savedUrl = FileManager.default.saveFileToDocumentsDirectory(image: image, name: "logo_img", extention: ".png") {
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
        
        var lastEduSampleArr = [Int]()
        var lastEduKeyArr = [Int]()
        var levelKeyArr = [Int]()
        var typeKeyArr = [Int]()
        var expkeyArr = [Int]()
        var salarykeyArr = [Int]()
        var salaryTypekeyArr = [Int]()
        var currencykeyArr = [Int]()
        var genderkeyArr = [Int]()
        
        //        var setProArr = [Int]()
        //        var setProfileBool:Bool?
        //        var txtPublic = ""
        //        var txtPrivate = ""
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
                                        self.txtLastEducation.setTitle(value, for: .normal)
                                        if let key = otherInnerDict["key"] as? Int {
                                            dropDownLastEduction.tag = key
                                            lastEduSampleArr.append(key)
                                            self.delegate?.personalInfoStatic(name: self.txtName.text!, phone: self.txtPhone.text!, profession: self.txtProfession.text!, dob: self.txtDob.text!, edu:  dropDownLastEduction.tag, level: self.dropDownLevel.tag, type: self.dropDownType.tag, exp: self.dropDownExperience.tag, setPro: self.dropDownSetProfile.tag,txtAboutDes: txtViewRichEditor.text,salary: dropDownSalary.tag,salaryType: dropDownSalaryType.tag,currency: dropDownCurrency.tag,gender:dropDownGender.tag)
                                        }
                                    }
                                }
                            }
                            if let value = otherInnerDict["key"] as? Int {
                                lastEduKeyArr.append(value)
                            }
                        }
                    }
                }
                
                if field_type_name == "cand_gender" {
                    if let value = innerDict["value"] as? [NSDictionary] {
                        for obj in value{
                            let otherInnerDict = obj
                            if let value = otherInnerDict["key"] as? Int {
                                genderkeyArr.append(value)
                            }
                            if let selected = otherInnerDict["selected"] as? Bool {
                                if let value = otherInnerDict["value"] as? String {
                                    genderArray.append(value)
                                    if selected == true{
                                        self.txtGender.setTitle(value, for: .normal)
                                        if let key = otherInnerDict["key"] as? Int {
                                            dropDownGender.tag = key
                                            self.delegate?.personalInfoStatic(name: self.txtName.text!, phone: self.txtPhone.text!, profession: self.txtProfession.text!, dob: self.txtDob.text!, edu:  dropDownLastEduction.tag, level: self.dropDownLevel.tag, type: self.dropDownType.tag, exp: self.dropDownExperience.tag, setPro: self.dropDownSetProfile.tag,txtAboutDes :txtViewRichEditor.text,salary: dropDownSalary.tag,salaryType: dropDownSalaryType.tag,currency: dropDownCurrency.tag,gender:dropDownGender.tag)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                
                
                if field_type_name == "cand_salary_range" {
                    if let value = innerDict["value"] as? [NSDictionary] {
                        
                        for obj in value{
                            let otherInnerDict = obj
                            if let selected = otherInnerDict["selected"] as? Bool {
                                if let value = otherInnerDict["value"] as? String {
                                    salaryEduArray.append(value)
                                    if selected == true{
                                        self.txtSalary.setTitle(value, for: .normal)
                                        if let key = otherInnerDict["key"] as? Int {
                                            dropDownSalary.tag = key
                                            salarykeyArr.append(key)
                                            self.delegate?.personalInfoStatic(name: self.txtName.text!, phone: self.txtPhone.text!, profession: self.txtProfession.text!, dob: self.txtDob.text!, edu:  dropDownLastEduction.tag, level: self.dropDownLevel.tag, type: self.dropDownType.tag, exp: self.dropDownExperience.tag, setPro: self.dropDownSetProfile.tag,txtAboutDes: txtViewRichEditor.text,salary: dropDownSalary.tag,salaryType: dropDownSalaryType.tag,currency: dropDownCurrency.tag,gender:dropDownGender.tag)
                                        }
                                    }
                                }
                            }
                            if let value = otherInnerDict["key"] as? Int {
                                salarykeyArr.append(value)
                            }
                        }
                    }
                }
                
                
                if field_type_name == "cand_salary_type" {
                    if let value = innerDict["value"] as? [NSDictionary] {
                        for obj in value{
                            let otherInnerDict = obj
                            if let value = otherInnerDict["key"] as? Int {
                                salaryTypekeyArr.append(value)
                            }
                            if let selected = otherInnerDict["selected"] as? Bool {
                                if let value = otherInnerDict["value"] as? String {
                                    salaryTypeEduArray.append(value)
                                    if selected == true{
                                        self.txtSalaryType.setTitle(value, for: .normal)
                                        if let key = otherInnerDict["key"] as? Int {
                                            dropDownSalaryType.tag = key
                                            self.delegate?.personalInfoStatic(name: self.txtName.text!, phone: self.txtPhone.text!, profession: self.txtProfession.text!, dob: self.txtDob.text!, edu:  dropDownLastEduction.tag, level: self.dropDownLevel.tag, type: self.dropDownType.tag, exp: self.dropDownExperience.tag, setPro: self.dropDownSetProfile.tag,txtAboutDes :txtViewRichEditor.text,salary: dropDownSalary.tag,salaryType: dropDownSalaryType.tag,currency: dropDownCurrency.tag,gender:dropDownGender.tag)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                
                if field_type_name == "cand_salary_curren" {
                    if let value = innerDict["value"] as? [NSDictionary] {
                        for obj in value{
                            let otherInnerDict = obj
                            if let value = otherInnerDict["key"] as? Int {
                                currencykeyArr.append(value)
                            }
                            if let selected = otherInnerDict["selected"] as? Bool {
                                if let value = otherInnerDict["value"] as? String {
                                    currencyEduArray.append(value)
                                    if selected == true{
                                        self.txtCurrency.setTitle(value, for: .normal)
                                        if let key = otherInnerDict["key"] as? Int {
                                            dropDownCurrency.tag = key
                                            self.delegate?.personalInfoStatic(name: self.txtName.text!, phone: self.txtPhone.text!, profession: self.txtProfession.text!, dob: self.txtDob.text!, edu:  dropDownLastEduction.tag, level: self.dropDownLevel.tag, type: self.dropDownType.tag, exp: self.dropDownExperience.tag, setPro: self.dropDownSetProfile.tag,txtAboutDes :txtViewRichEditor.text,salary: dropDownSalary.tag,salaryType: dropDownSalaryType.tag,currency: dropDownCurrency.tag,gender:dropDownGender.tag)
                                        }
                                    }
                                }
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
                                        self.txtLevel.setTitle(value, for: .normal)
                                        if let key = otherInnerDict["key"] as? Int {
                                            dropDownLevel.tag = key
                                            self.delegate?.personalInfoStatic(name: self.txtName.text!, phone: self.txtPhone.text!, profession: self.txtProfession.text!, dob: self.txtDob.text!, edu:  dropDownLastEduction.tag, level: self.dropDownLevel.tag, type: self.dropDownType.tag, exp: self.dropDownExperience.tag, setPro: self.dropDownSetProfile.tag,txtAboutDes :txtViewRichEditor.text,salary: dropDownSalary.tag,salaryType: dropDownSalaryType.tag,currency: dropDownCurrency.tag,gender:dropDownGender.tag)
                                        }
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
                                        self.txtType.setTitle(value, for: .normal)
                                        if let key = otherInnerDict["key"] as? Int {
                                            dropDownType.tag = key
                                            self.delegate?.personalInfoStatic(name: self.txtName.text!, phone: self.txtPhone.text!, profession: self.txtProfession.text!, dob: self.txtDob.text!, edu:  dropDownLastEduction.tag, level: self.dropDownLevel.tag, type: self.dropDownType.tag, exp: self.dropDownExperience.tag, setPro: self.dropDownSetProfile.tag,txtAboutDes :txtViewRichEditor.text,salary: dropDownSalary.tag,salaryType: dropDownSalaryType.tag,currency: dropDownCurrency.tag,gender:dropDownGender.tag)
                                        }
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
                                    if selected == true{
                                        self.txtExperience.setTitle(value, for: .normal)
                                        if let key = otherInnerDict["key"] as? Int {
                                            dropDownExperience.tag = key
                                            self.delegate?.personalInfoStatic(name: self.txtName.text!, phone: self.txtPhone.text!, profession: self.txtProfession.text!, dob: self.txtDob.text!, edu:  dropDownLastEduction.tag, level: self.dropDownLevel.tag, type: self.dropDownType.tag, exp: self.dropDownExperience.tag, setPro: self.dropDownSetProfile.tag,txtAboutDes :txtViewRichEditor.text,salary: dropDownSalary.tag,salaryType: dropDownSalaryType.tag,currency: dropDownCurrency.tag,gender:dropDownGender.tag)
                                        }
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
                            //                            if let value = otherInnerDict["key"] as? Int {
                            //                                setProArr.append(value)
                            //                            }
                            if let selected = otherInnerDict["selected"] as? Bool {
                                if let value = otherInnerDict["value"] as? String {
                                    setProArrayVal.append(value)
                                    if selected == true{
                                        self.txtSetProValue.setTitle(value, for: .normal)
                                        if let key = otherInnerDict["key"] as? Int {
                                            dropDownSetProfile.tag = key
                                            self.delegate?.personalInfoStatic(name: self.txtName.text!, phone: self.txtPhone.text!, profession: self.txtProfession.text!, dob: self.txtDob.text!, edu:  dropDownLastEduction.tag, level: self.dropDownLevel.tag, type: self.dropDownType.tag, exp: self.dropDownExperience.tag, setPro: self.dropDownSetProfile.tag,txtAboutDes :txtViewRichEditor.text,salary: dropDownSalary.tag,salaryType: dropDownSalaryType.tag,currency: dropDownCurrency.tag,gender:dropDownGender.tag)
                                        }
                                    }
                                }
                                
                            }
                        }
                    }
                }
            }
        }
        
  
        dropDownLastEduction.dataSource = lastEduArray
        //self.dropDownType.tag = typeKeyArr[0]
        dropDownLastEduction.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.dropDownLastEduction.tag = typeKeyArr[index]
            self.txtLastEducation.setTitle(item, for: .normal)
            self.lastEduInt = lastEduKeyArr[index]
            self.delegate?.personalInfoStatic(name: self.txtName.text!, phone: self.txtPhone.text!, profession: self.txtProfession.text!, dob: self.txtDob.text!, edu: self.dropDownLastEduction.tag, level: self.dropDownLevel.tag, type: self.dropDownType.tag, exp: self.dropDownExperience.tag, setPro: self.dropDownSetProfile.tag,txtAboutDes:self.txtViewRichEditor.text,salary: self.dropDownSalary.tag,salaryType: self.dropDownSalaryType.tag,currency: self.dropDownCurrency.tag,gender:self.dropDownGender.tag)
            
        }
        
        dropDownType.dataSource = typeArray
        //self.dropDownType.tag = typeKeyArr[0]
        dropDownType.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.dropDownType.tag = typeKeyArr[index]
            self.txtType.setTitle(item, for: .normal)
            self.typeInt = typeKeyArr[index]
            self.delegate?.personalInfoStatic(name: self.txtName.text!, phone: self.txtPhone.text!, profession: self.txtProfession.text!, dob: self.txtDob.text!, edu: self.dropDownLastEduction.tag, level: self.dropDownLevel.tag, type: self.typeInt!, exp: self.dropDownExperience.tag, setPro: self.dropDownSetProfile.tag,txtAboutDes:self.txtViewRichEditor.text,salary: self.dropDownSalary.tag,salaryType: self.dropDownSalaryType.tag,currency: self.dropDownCurrency.tag,gender:self.dropDownGender.tag)
            
        }
        
        
        dropDownGender.dataSource = genderArray
        //self.dropDownGender.tag = lastEduKeyArr[0]
        dropDownGender.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.genderInt = genderkeyArr[index]
            self.txtGender.setTitle(item, for: .normal)
            self.delegate?.personalInfoStatic(name: self.txtName.text!, phone: self.txtPhone.text!, profession: self.txtProfession.text!, dob: self.txtDob.text!, edu: self.dropDownLastEduction.tag, level: self.dropDownLevel.tag, type: self.dropDownType.tag, exp: self.dropDownExperience.tag, setPro: self.dropDownSetProfile.tag,txtAboutDes:self.txtViewRichEditor.text,salary: self.dropDownSalary.tag,salaryType: self.dropDownSalaryType.tag,currency: self.dropDownCurrency.tag,gender:self.genderInt!)
        }

        dropDownSalary.dataSource = salaryEduArray
        //self.dropDownLastEduction.tag = lastEduKeyArr[0]
        dropDownSalary.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            //self.dropDownLastEduction.tag = lastEduKeyArr[index]
            self.salaryInt = salarykeyArr[index]
            self.txtSalary.setTitle(item, for: .normal)
            self.delegate?.personalInfoStatic(name: self.txtName.text!, phone: self.txtPhone.text!, profession: self.txtProfession.text!, dob: self.txtDob.text!, edu: self.dropDownLastEduction.tag, level: self.dropDownLevel.tag, type: self.dropDownType.tag, exp: self.dropDownExperience.tag, setPro: self.dropDownSetProfile.tag,txtAboutDes:self.txtViewRichEditor.text,salary: self.salaryInt!,salaryType: self.dropDownSalaryType.tag,currency: self.dropDownCurrency.tag,gender:self.dropDownGender.tag)
        }
        
        dropDownSalaryType.dataSource = salaryTypeEduArray
        //self.dropDownExperience.tag = expkeyArr[0]
        dropDownSalaryType.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.dropDownSalaryType.tag = salaryTypekeyArr[index]
            self.salaryTypeInt = salaryTypekeyArr[index]
            self.txtSalaryType.setTitle(item, for: .normal)
            self.delegate?.personalInfoStatic(name: self.txtName.text!, phone: self.txtPhone.text!, profession: self.txtProfession.text!, dob: self.txtDob.text!, edu: self.dropDownLastEduction.tag, level: self.dropDownLevel.tag, type: self.dropDownType.tag, exp: self.dropDownExperience.tag, setPro: self.dropDownSetProfile.tag,txtAboutDes:self.txtViewRichEditor.text,salary: self.dropDownSalary.tag,salaryType: self.salaryTypeInt!,currency: self.dropDownCurrency.tag,gender:self.dropDownGender.tag)
        }
        
        dropDownCurrency.dataSource = currencyEduArray
        //self.dropDownExperience.tag = expkeyArr[0]
        dropDownCurrency.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.dropDownCurrency.tag = currencykeyArr[index]
            self.currencyInt = currencykeyArr[index]
            self.txtCurrency.setTitle(item, for: .normal)
            self.delegate?.personalInfoStatic(name: self.txtName.text!, phone: self.txtPhone.text!, profession: self.txtProfession.text!, dob: self.txtDob.text!, edu: self.dropDownLastEduction.tag, level: self.dropDownLevel.tag, type: self.dropDownType.tag, exp: self.dropDownExperience.tag, setPro: self.dropDownSetProfile.tag,txtAboutDes:self.txtViewRichEditor.text,salary: self.dropDownSalary.tag,salaryType: self.dropDownSalaryType.tag,currency: self.currencyInt!,gender:self.dropDownGender.tag)
        }
        
        
        dropDownExperience.dataSource = experienceArray
        //self.dropDownExperience.tag = expkeyArr[0]
        dropDownExperience.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.dropDownExperience.tag = expkeyArr[index]
            self.expInt = expkeyArr[index]
            self.txtExperience.setTitle(item, for: .normal)
            self.delegate?.personalInfoStatic(name: self.txtName.text!, phone: self.txtPhone.text!, profession: self.txtProfession.text!, dob: self.txtDob.text!, edu: self.dropDownLastEduction.tag, level: self.dropDownLevel.tag, type: self.dropDownType.tag, exp: self.expInt!, setPro: self.dropDownSetProfile.tag,txtAboutDes:self.txtViewRichEditor.text,salary: self.dropDownSalary.tag,salaryType: self.dropDownSalaryType.tag,currency: self.dropDownCurrency.tag,gender:self.dropDownGender.tag)
        }
        
        dropDownLevel.dataSource = levelArray
        //self.dropDownLevel.tag = levelKeyArr[0]
        dropDownLevel.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.dropDownLevel.tag = levelKeyArr[index]
            self.txtLevel.setTitle(item, for: .normal)
            self.levelEduInt = levelKeyArr[index]
            self.delegate?.personalInfoStatic(name: self.txtName.text!, phone: self.txtPhone.text!, profession: self.txtProfession.text!, dob: self.txtDob.text!, edu: self.dropDownLastEduction.tag, level: self.levelEduInt!, type: self.dropDownType.tag, exp: self.dropDownExperience.tag, setPro: self.dropDownSetProfile.tag,txtAboutDes:self.txtViewRichEditor.text,salary: self.dropDownSalary.tag,salaryType: self.dropDownSalaryType.tag,currency: self.dropDownCurrency.tag,gender:self.dropDownGender.tag)
        }
        
        dropDownSetProfile.dataSource = setProArrayVal
        dropDownSetProfile.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.setProInt = index
            
            
            self.txtSetProValue.setTitle(item, for: .normal)
            self.delegate?.personalInfoStatic(name: self.txtName.text!, phone: self.txtPhone.text!, profession: self.txtProfession.text!, dob: self.txtDob.text!, edu: self.dropDownLastEduction.tag, level: self.dropDownLevel.tag, type: self.dropDownType.tag, exp: self.dropDownExperience.tag, setPro: self.setProInt!,txtAboutDes:self.txtViewRichEditor.text,salary: self.dropDownSalary.tag,salaryType: self.dropDownSalaryType.tag,currency: self.dropDownCurrency.tag,gender:self.dropDownGender.tag)
        }
        
        dropDownLastEduction.anchorView = txtLastEducation
        dropDownGender.anchorView = txtGender
        dropDownSalary.anchorView = txtSalary
        dropDownSalaryType.anchorView = txtSalaryType
        dropDownCurrency.anchorView = txtCurrency
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
        UserHandler.nokri_candidatePersonalInfo(success: { (successResponse) in
            if successResponse.success {
                self.dataArray = successResponse.data
                self.extraArray = successResponse.extras
                self.nokri_populateData()
            }
            else {
                let alert = Constants.showBasicAlert(message: successResponse.message)
                self.window?.rootViewController?.present(alert, animated: true, completion: nil)
            }
        }) { (error) in
            let alert = Constants.showBasicAlert(message: error.message)
            self.window?.rootViewController?.present(alert, animated: true, completion: nil)
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
                    //let messageResponse = responseData["message"] as! String
                    if success == true{
                        //self.tableView.isHidden = false
                        if let array = responseData["data"] as? NSArray {
                            self.nokri_dataParser(dataArray: array)
                        }
                        self.nokri_dropDownSetup()
                    }else{
                        //self.tableView.isHidden = true
                        //self.view.makeToast(messageResponse, duration: 1.5, position: .center)
                        //self.stopAnimating()
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
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.canPersonalInfo, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    guard let res = response.value else{return}
                    let responseData = res as! NSDictionary
                    let success = responseData["success"] as! Bool
                    // let messageResponse = responseData["message"] as! String
                    //success = false
                    if success == true{
                        if let array = responseData["data"] as? NSArray {
                            self.nokri_dataParser(dataArray: array)
                        }
                        self.nokri_dropDownSetup()
                    }else{
                        //self.view.makeToast(messageResponse, duration: 1.5, position: .center)
                        //self.stopAnimating()
                    }
            }
        }
    }
    
    func nokri_dataParser(dataArray:NSArray){
        self.dataParserArray.removeAllObjects()
        for item in dataArray{
            self.dataParserArray.add(item)
        }
    }
    
    func nokri_uploadImage() {
        uploadingProgressBar.progress = 0.0
        uploadingProgressBar.detailTextLabel.text = "0% Completed"
        uploadingProgressBar.show(in: contentView)
        UserHandler.nokri_uploadImage(fileName: "logo_img", fileUrl: imageUrl!, progress: { (uploadProgress) in
            let currentProgress = Float(uploadProgress)/100
            self.uploadingProgressBar.detailTextLabel.text = "\(uploadProgress)% Completed"
            self.uploadingProgressBar.setProgress(currentProgress, animated: true)
        }, success: { (successResponse) in
            self.uploadingProgressBar.dismiss(animated: true)
            self.removeFileFromDocumentsDirectory(fileUrl: self.imageUrl!)
            self.contentView.makeToast(successResponse.message, duration: 2.5, position: .center)
            UserDefaults.standard.set(successResponse.data.image, forKey: "updatedImage")
            UserDefaults.standard.set(10, forKey: "isUpdatedImage")
            self.nokri_populateData()
            //self.stopAnimating()
        }, failure: { (error) in
            self.uploadingProgressBar.dismiss(animated: true)
            let alert = Constants.showBasicAlert(message: error.message)
            self.window?.rootViewController!.present(alert, animated: true, completion: nil)
            //self.stopAnimating()
            //koooo
        })
    }
}
