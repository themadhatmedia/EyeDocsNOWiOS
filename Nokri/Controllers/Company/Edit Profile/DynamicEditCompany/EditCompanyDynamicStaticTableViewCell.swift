//
//  EditCompanyDynamicStaticTableViewCell.swift
//  Nokri
//
//  Created by apple on 3/9/20.
//  Copyright © 2020 Furqan Nadeem. All rights reserved.
//

import UIKit
import DropDown
import JGProgressHUD
import Alamofire

protocol companyStaticProtocol {
    func companyStaticValues(emplName:String,empPhone:String,empHeadline:String,empIntro:String,empWeb:String,empStatus:String)
}

class EditCompanyDynamicStaticTableViewCell: UITableViewCell,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate
{
    
    //MARK:- IBOutlets
    
    @IBOutlet weak var imageViewBasicInfo: UIImageView!
    @IBOutlet weak var lblCompanyName: UILabel!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtHeadline: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtWeb: UITextField!
    @IBOutlet weak var txtImage: UITextField!
    @IBOutlet weak var lblDegreeDetail: UILabel!
    @IBOutlet weak var richEditor: UITextView!
    @IBOutlet weak var viewTop: UIView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblHeadline: UILabel!
    @IBOutlet weak var lblPhone: UILabel!
    @IBOutlet weak var lblWeb: UILabel!
    @IBOutlet weak var lblImage: UILabel!
    @IBOutlet weak var lblCompanySubTitle: UILabel!
    @IBOutlet weak var heightConstraintRichEditor: NSLayoutConstraint!
    
    @IBOutlet weak var btnProfileImage: UIButton!
    @IBOutlet weak var lblSetProfile: UILabel!
    @IBOutlet weak var txtSetProfile: UITextField!
    @IBOutlet weak var iconDropDown: UIImageView!
    @IBOutlet weak var txtSetProValue: UITextField!
    @IBOutlet weak var btnUpdatePassword: UIButton!
    @IBOutlet weak var btnDeleteAcc: UIButton!
    @IBOutlet weak var lblStepNo: UILabel!
    @IBOutlet weak var btnSetPro: UIButton!
    
    //MARK:- Proporties
    
    var dataArray  = [CandidateEditData]()
    var extraArray  = [CandidateEditExtra]()
    var imageUrl:URL?
    let dropDownSetProfile = DropDown()
    var setProInt:Int?
    var delegate:companyStaticProtocol?
    
    //MARK:- Proporties
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var appColorNew = UserDefaults.standard.string(forKey: "app_Color")
    var name:String?
    var email:String?
    var headline:String?
    var phone:String?
    var web:String?
    var intro:String?
    var profileImage:String?
    
    private lazy var uploadingProgressBar: JGProgressHUD = {
        let progressBar = JGProgressHUD(style: .dark)
        progressBar.indicatorView = JGProgressHUDRingIndicatorView()
        progressBar.textLabel.text = "Uploading"
        return progressBar
    }()
    
    //MARK:- View Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
     
        nokri_basicInfoData()
        nokri_customeButton()
        //nokri_textFieldAddBorder()
        nokri_roundedImage()
        
    }
    
    func nokri_roundedImage(){
        imageViewBasicInfo.layer.borderWidth = 2
        imageViewBasicInfo.layer.masksToBounds = false
        imageViewBasicInfo.layer.borderColor = UIColor(hex:appColorNew!).cgColor
        imageViewBasicInfo.layer.cornerRadius = imageViewBasicInfo.frame.height/2
        imageViewBasicInfo.clipsToBounds = true
    }
    
    @IBAction func txtfieldwebchanged(_ sender: UITextField) {
        delegate?.companyStaticValues(emplName: txtName.text!, empPhone: txtPhone.text!, empHeadline: txtHeadline.text!, empIntro: richEditor.text, empWeb: txtWeb.text!, empStatus: "Public")
    }
    
    @IBAction func txtfieldHeadlinechanged(_ sender: UITextField) {
        delegate?.companyStaticValues(emplName: txtName.text!, empPhone: txtPhone.text!, empHeadline: txtHeadline.text!, empIntro: richEditor.text, empWeb: txtWeb.text!, empStatus: "Public")
    }
    
    @IBAction func txtfieldPhoneChanged(_ sender: UITextField) {
        delegate?.companyStaticValues(emplName: txtName.text!, empPhone: txtPhone.text!, empHeadline: txtHeadline.text!, empIntro: richEditor.text, empWeb: txtWeb.text!, empStatus: "Public")
    }
    
    @IBAction func txtFieldChanged(_ sender: UITextField) {
        delegate?.companyStaticValues(emplName: txtName.text!, empPhone: txtPhone.text!, empHeadline: txtHeadline.text!, empIntro: richEditor.text, empWeb: txtWeb.text!, empStatus: "Public")
    }
    
    @IBAction func btnSetProClicked(_ sender: UIButton) {
        dropDownSetProfile.show()
    }
    
    @IBAction func btnProfileImageClicked(_ sender: Any) {
        
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
            actionSheet.popoverPresentationController?.sourceView = btnProfileImage
            actionSheet.popoverPresentationController?.sourceRect = btnProfileImage.bounds
            self.window?.rootViewController?.present(actionSheet, animated: true, completion: nil)
        }else{
            self.window?.rootViewController?.present(actionSheet, animated: true, completion: nil)
        }
    }
    
    @IBAction func btnUpdatePasswordClicked(_ sender: UIButton) {
        
        let controller = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ChangePasswordViewController") as! ChangePasswordViewController
        controller.modalPresentationStyle = .overCurrentContext
        controller.modalTransitionStyle = .flipHorizontal
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
            let alert = UIAlertController(title: objExtraTxt?.alertName, message: dataTabs.data.progressTxt.btnOk, preferredStyle: UIAlertController.Style.alert)
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
    
    //MARK:- Custome Functions
    
    func nokri_dropDownSetup(){
        
        // var setProArr = [Int]()
        var setProSrings = [String]()
        
        for obj in dataArray{
            if obj.fieldTypeName == "emp_prof_stat"{
                
                for ab in obj.vaalue{
                    setProSrings.append(ab.value)
                    if ab.selected == true{
                        //self.txtSetProValue.text = ab.value
                        self.btnSetPro.setTitle(ab.value, for: .normal)
                    }
                }
                
            }
        }
        
        dropDownSetProfile.dataSource = setProSrings //["Public","Private"]
        //self.txtSetProValue.text = "Public"
        //self.dropDownLevel.tag = levelKeyArr[0]
        dropDownSetProfile.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            //self.dropDownSetProfile.tag = setProArr[index]
            //self.setProInt = setProArr[index]
            // self.txtSetProValue.text = item
            self.btnSetPro.setTitle(item, for: .normal)
            self.delegate?.companyStaticValues(emplName: self.txtName.text!, empPhone: self.txtPhone.text!, empHeadline: self.txtHeadline.text!, empIntro: self.richEditor.text, empWeb: self.txtWeb.text!, empStatus: self.btnSetPro.currentTitle!)
        }
        
        dropDownSetProfile.anchorView = btnSetPro
        DropDown.startListeningToKeyboard()
        DropDown.appearance().textColor = UIColor.black
        DropDown.appearance().textFont = UIFont.systemFont(ofSize: 12)
        DropDown.appearance().backgroundColor = UIColor.white
        DropDown.appearance().selectionBackgroundColor = UIColor(hex:appColorNew!)
        DropDown.appearance().cellHeight = 40
        
    }
    
    func nokri_customeButton(){
        richEditor.layer.borderWidth = 1
        richEditor.layer.borderColor = UIColor.lightGray.cgColor
        richEditor.layer.cornerRadius = 10
    }
    
    //-->> Custome Text Fields
    
    func nokri_textFieldAddBorder(){
        txtName.delegate = self
        txtEmail.delegate = self
        txtHeadline.delegate = self
        txtWeb.delegate = self
        txtImage.delegate = self
        txtPhone.delegate = self
        //txtSetProfile.delegate = self
        txtName.nokri_addBottomBorder()
        txtEmail.nokri_addBottomBorder()
        txtHeadline.nokri_addBottomBorder()
        txtPhone.nokri_addBottomBorder()
        txtImage.nokri_addBottomBorder()
        txtWeb.nokri_addBottomBorder()
        txtSetProfile.nokri_addBottomBorder()
    }
    
    func nokri_textFieldUpdateBottomBorderSize(){
        txtName.nokri_updateBottomBorderSize()
        txtEmail.nokri_updateBottomBorderSize()
        txtHeadline.nokri_updateBottomBorderSize()
        txtPhone.nokri_updateBottomBorderSize()
        txtImage.nokri_updateBottomBorderSize()
        txtWeb.nokri_updateBottomBorderSize()
        txtSetProfile.nokri_updateBottomBorderSize()
    }
    
    func nokri_populateData() {
        
        let isUpdatedImage = UserDefaults.standard.integer(forKey: "isUpdatedImage")
        if isUpdatedImage == 5{
            let updateImage = UserDefaults.standard.string(forKey: "updatedImage")
            if updateImage != nil{
                imageViewBasicInfo.sd_setImage(with: URL(string:updateImage!), completed: nil)
                imageViewBasicInfo.sd_setShowActivityIndicatorView(true)
                imageViewBasicInfo.sd_setIndicatorStyle(.gray)
            }
            
        }else{
            let image = UserDefaults.standard.string(forKey: "img")
            imageViewBasicInfo.sd_setImage(with: URL(string: image!), completed: nil)
        }
        for ab in dataArray{
            if ab.fieldTypeName == "emp_name" {
                lblName.text = ab.key
                txtName.placeholder = ab.key
                txtName.text = ab.value
                lblCompanyName.text = ab.value
                UserDefaults.standard.set(ab.value, forKey: "updateName")
                UserDefaults.standard.set(10, forKey: "isUpdat")
                //  print(ab.value!)
            }
            if ab.fieldTypeName == "emp_phone" {
                lblPhone.text = ab.key
                txtPhone.placeholder = ab.key
                txtPhone.text = ab.value
            }
            if ab.fieldTypeName == "emp_email" {
                lblEmail.text = ab.key
                txtEmail.placeholder = ab.key
                txtEmail.text = ab.value
            }
            if ab.fieldTypeName == "emp_headline" {
                lblHeadline.text = ab.key
                txtHeadline.placeholder = ab.key
                txtHeadline.text = ab.value
                //lblCompanySubTitle.text = ab.value
            }
            if ab.fieldTypeName == "emp_web" {
                lblWeb.text = ab.key
                txtWeb.placeholder = ab.key
                txtWeb.text = ab.value
            }
            if ab.fieldTypeName == "emp_dp" {
                lblImage.text = ab.key
                btnProfileImage.setTitle(ab.key, for: .normal)
                //txtImage.placeholder = ab.key
                //txtImage.text = ab.key
            }
            if ab.fieldTypeName == "emp_intro" {
                lblDegreeDetail.text = ab.key
                richEditor.text = ab.value
            }
            //--> Uncomment this
            if ab.fieldTypeName == "emp_prof_stat"{
                lblSetProfile.text = ab.key
            }
            
        }
        for ac in extraArray{
            if ac.fieldTypeName == "btn_name" {
                //btnSaveSection.setTitle(ac.value, for: .normal)
            }
            if ac.fieldTypeName == "change_pasword"{
                btnUpdatePassword.setTitle(ac.value, for: .normal)
                btnUpdatePassword.setTitleColor(UIColor(hex: appColorNew!), for: .normal)
            }
        
        }
        
        delegate?.companyStaticValues(emplName: txtName.text!, empPhone: txtPhone.text!, empHeadline: txtHeadline.text!, empIntro: richEditor.text, empWeb: txtWeb.text!, empStatus: "Public")
        
    }
   
    //MARK:- API Calls
    
    func nokri_basicInfoData() {
        //self.showLoader()
        self.imageViewBasicInfo.isHidden = true
        UserHandler.nokri_updateBasiInfo(success: { (successResponse) in
            //self.stopAnimating()
            if successResponse.success{
                self.imageViewBasicInfo.isHidden = false
                self.dataArray =  successResponse.data
                self.extraArray = successResponse.extras
                self.nokri_populateData()
                self.nokri_dropDownSetup()
                //self.stopAnimating()
            }
            else {
                self.imageViewBasicInfo.isHidden = true
                let alert = Constants.showBasicAlert(message: successResponse.message)
                self.window?.rootViewController?.present(alert, animated: true, completion: nil)
                //self.stopAnimating()
            }
        }) { (error) in
            self.imageViewBasicInfo.isHidden = true
            let alert = Constants.showBasicAlert(message: error.message)
            self.window?.rootViewController?.present(alert, animated: true, completion: nil)
            //self.stopAnimating()
        }
    }

    func nokri_uploadImage() {
        uploadingProgressBar.progress = 0.0
        uploadingProgressBar.detailTextLabel.text = "0% Completed"
        uploadingProgressBar.show(in: self.contentView)
        UserHandler.nokri_uploadImageCompany(fileName: "logo_img", fileUrl: imageUrl!, progress: { (uploadProgress) in
            let currentProgress = Float(uploadProgress)/100
            self.uploadingProgressBar.detailTextLabel.text = "\(uploadProgress)% Completed"
            self.uploadingProgressBar.setProgress(currentProgress, animated: true)
        }, success: { (successResponse) in
            self.uploadingProgressBar.dismiss(animated: true)
            self.removeFileFromDocumentsDirectory(fileUrl: self.imageUrl!)
            self.contentView.makeToast(successResponse.message, duration: 2.5, position: .center)
            UserDefaults.standard.set(successResponse.data.image, forKey: "updatedImage")
            UserDefaults.standard.set(5, forKey: "isUpdatedImage")
            UserDefaults.standard.set(5, forKey: "loginCheck")
            self.nokri_populateData()
            //self.stopAnimating()
        }, failure: { (error) in
            self.uploadingProgressBar.dismiss(animated: true)
            let alert = Constants.showBasicAlert(message: error.message)
            self.window?.rootViewController?.present(alert, animated: true, completion: nil)
            //self.stopAnimating()
        })
    }
}
