//
//  JobPostDynamicFieldViewController.swift
//  Nokri
//
//  Created by apple on 7/24/19.
//  Copyright © 2019 Furqan Nadeem. All rights reserved.
//

import UIKit
import DropDown
import MobileCoreServices
import JGProgressHUD
import OpalImagePicker
import Photos

class JobPostDynamicFieldViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UIDocumentPickerDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,OpalImagePickerControllerDelegate {
   

    //MARK:- IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var btnBack: UIButton!
    
    //MARK:- Proporties
    
    private lazy var uploadingProgressBar: JGProgressHUD = {
        let progressBar = JGProgressHUD(style: .dark)
        if let userData = UserDefaults.standard.object(forKey: "settingsData") {
            let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
            let dataTabs = SplashRoot(fromDictionary: objData)
            let obj = dataTabs.data.progressTxt
            
            progressBar.indicatorView = JGProgressHUDRingIndicatorView()
            progressBar.textLabel.text = obj?.title
        }
        
        return progressBar
    }()
    
    var imageUrl:URL?
    var customArray = [JobPostCCustomData]()
    var fieldsArray = [JobPostCCustomData]()
    var dataArray = [JobPostCCustomData]()
    var customArraydata = [JobPostCCustomData]()
    
    var jobTitle = ""
    var jobCat = 0
    var desValue = ""
    var deadLineVa = ""
    
    var desText = ""
    var deadLineKe = ""
    
    var dropArr = [String]()
    var genericDropDownArray = NSMutableArray()
    var dropDown = DropDown()
    var appColorNew = UserDefaults.standard.string(forKey: "app_Color")
    var photoArray = [UIImage]()
    var isfromEdit:Bool = true
    
    var imageArray = [JobPostImageArray]()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.dataArray = customArray
        tableView.delegate = self
        tableView.dataSource = self
        print(customArray)
        print(dropArr.count)
        print(deadLineVa)
        print(deadLineKe)
        let titlejob = UserDefaults.standard.string(forKey: "jobPost")
        self.title = titlejob
    }
    
  
    
    //Mark:- IBAction

    @IBAction func btnBackClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnNextClicked(_ sender: UIButton) {
        let ctrl = storyboard?.instantiateViewController(withIdentifier: "JobPostLocationTableViewController") as! JobPostLocationTableViewController
                
        ctrl.jobTitle = jobTitle
        ctrl.jobCat = jobCat
        ctrl.descriptionValue = desValue
        ctrl.deadLineVal = deadLineVa
        ctrl.customArray = customArraydata
        self.navigationController?.pushViewController(ctrl, animated: true)
    }
    
    //MARK:- Table View
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fieldsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let objData = fieldsArray[indexPath.row]
    
        if objData.fieldType == "select"{
            let cell = tableView.dequeueReusableCell(withIdentifier: "DropDownTableViewCell") as! DropDownTableViewCell
            cell.lblKey.text = objData.mainTitle
            
                    
           // var i = 1
            for o in objData.values {
                   cell.lblName.text = o.name
                //if i == 1 {
                    print(cell.selectedValue)
              
                        
                     //   cell.selectedKey = String(item.value)
                        if isfromEdit == true{
                          //  for o in objData.values{
                                 if o.selected == true{
                                    cell.lblName.text = o.name
                                    var obj = JobPostCCustomData()
                                    obj.fieldType = "select"
                                    obj.fieldVal = o.value
                                    obj.fieldTypeName = objData.fieldTypeName
                                    self.dataArray.append(obj)
                                    self.fieldsArray.append(obj)
                                    self.customArray.append(obj)
                                    //objArray.append(obj)
                                    customArraydata.append(obj)
                                    print(obj)
                                 }
                           // }
                        }else{
                                if cell.selectedValue == ""{
                                    cell.lblName.text = objData.values[0].name
                                }
                        }
//                    }else{
//                        cell.lblName.text = cell.selectedValue
//                        cell.selectedKey = cell.selectedValue
//                    }
               // }
                //i = i + 1
            }
            cell.btnPopUpAction = { () in
                cell.dropDownKeysArray = []
                cell.dropDownValuesArray = []
                cell.fieldTypeNameArray = []
                for item in objData.values {
            
                    if item.value != nil{
                          cell.dropDownKeysArray.append(item.value)
                    }
                  
                    cell.dropDownValuesArray.append(item.name)
                    //cell.hasFieldsArr.append(item.hasTemplate)
                    cell.fieldTypeNameArray.append(objData.fieldTypeName)
                    //cell.isShowArr.append(item.isShow)
                    
                }
                cell.accountDropDown()
                cell.valueDropDown.show()
            }
            cell.param = objData.fieldTypeName
            //cell.selectedIndex = indexPath.row
            cell.indexP = indexPath.row
            cell.section = 2
            cell.fieldNam = objData.fieldTypeName
            cell.delegate = self
            
            return cell
            
        }else if objData.fieldType == "textfield" {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldTableViewCell") as! TextFieldTableViewCell
            cell.lblTxtKey.text = objData.title
            cell.textField.placeholder = objData.title
            cell.textField.font = UIFont(name:"Openans-Regular",size: 20)
            cell.fieldName = objData.fieldTypeName
            cell.inde = indexPath.row
            cell.section = 2
            cell.delegate = self
            
            if isfromEdit == true{
                cell.textField.text = objData.fieldVal
                var obj = JobPostCCustomData()
                obj.fieldType = "textfield"
                obj.fieldVal = objData.fieldVal
                obj.fieldTypeName = objData.fieldTypeName
               // self.fieldsArray[indexPath].fieldVal = value
                self.dataArray.append(obj)
                self.fieldsArray.append(obj)
                self.customArraydata.append(obj)
                //objArray.append(obj)
                customArray.append(obj)
                print(obj)
            }
    
            return cell
        }
            
//        else if objData.fieldType == "attachment" {
//
//            let cell = tableView.dequeueReusableCell(withIdentifier: "AttachementTableViewCell") as! AttachementTableViewCell
//
//            cell.lblAttachement.text = objData.title
//            cell.imageArray = self.imageArray
//            cell.collectionView.reloadData()
//
//            cell.btnAttachement.addTarget(self, action:  #selector(JobPostDynamicFieldViewController.nokri_btnAttachedClicked), for: .touchUpInside)
//            cell.btnCamera.addTarget(self, action:  #selector(JobPostDynamicFieldViewController.nokri_btnCameraClicked), for: .touchUpInside)
//
//            return cell
//
//        }
        else if objData.fieldType == "checkbox"{
            let cell = tableView.dequeueReusableCell(withIdentifier: "CheckBoxTableViewCell") as! CheckBoxTableViewCell
            cell.indexP = indexPath.row
            cell.section = 2
            cell.fieldName = objData.fieldTypeName
            cell.delegate = self
            cell.lblKey.text = objData.title
            //cell.btnCheckBox.setTitle(objData.title, for: .normal)
            cell.skillArray = objData.values

            cell.heightConstraintRadioTable.constant = CGFloat(objData.values.count * 70)
            return cell
        }
        else if objData.fieldType == "multi_select"{
            let cell = tableView.dequeueReusableCell(withIdentifier: "MultiSelectTableViewCell") as! MultiSelectTableViewCell
            
            cell.indexP = indexPath.row
            cell.section = 2
            cell.fieldName = objData.fieldTypeName
            cell.delegate = self
            cell.lblKey.text = objData.title
            cell.btnCheckBox.setTitle(objData.title, for: .normal)
            cell.skillArray = objData.values
            
            return cell
        }
        else if objData.fieldType == "date"{
            let cell = tableView.dequeueReusableCell(withIdentifier: "DateTableViewCell") as! DateTableViewCell
            
            cell.lblDateKey.text = objData.title
            cell.lblDateValue.text = objData.title
            cell.indexP = indexPath.row
            cell.section = 2
            cell.fieldName = objData.fieldTypeName
            cell.delegate = self
            
            if isfromEdit == true{
                cell.lblDateValue.text = objData.fieldVal
            }
            
            
            return cell
        }
        else if objData.fieldType == "link"{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "LinkTableViewCell") as! LinkTableViewCell
            
            cell.lblLinkKey.text = objData.title
            cell.textField.placeholder = objData.title
            cell.fieldName = objData.fieldTypeName
            cell.inde = indexPath.row
            cell.section = 2
            cell.delegate = self
            
            if isfromEdit == true{
                cell.textField.text = objData.fieldVal
            }
            
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let objData = customArray[indexPath.row]
        if objData.fieldType == "textfield"{
            return 80
        }else if objData.fieldType == "link"{
            return 80
        }
//        else if objData.fieldType == "attachment"{
//            return 290
//        }
        else if objData.fieldType == "checkbox"{
            return CGFloat(75 * objData.values.count)
        }else if objData.fieldType == "multi_select"{
             return 100
        }
        else if objData.fieldType == "select" {
            return 110
        }
        else{
            return 130
        }
    }
    
    //MARK:- Delegates For UIDocumentPicker
    
    @objc func nokri_btnAttachedClicked(){
        let options = [kUTTypePDF as String, kUTTypeZipArchive  as String, kUTTypePNG as String, kUTTypeJPEG as String, kUTTypeText  as String, kUTTypePlainText as String]
        let documentPicker: UIDocumentPickerViewController = UIDocumentPickerViewController(documentTypes: options, in: .import)
        documentPicker.delegate = self
        documentPicker.modalPresentationStyle = .formSheet
        self.present(documentPicker, animated: true, completion: nil)
        //self.navigationController?.pushViewController(documentPicker, animated: true)
    }
    
    
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        self.saveFileToDocumentDirectory(document: url)
        //self.nokri_uploadResume(documentUrl: url)
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
            self.nokri_uploadResume(documentUrl: fileUrl)
        }
    }
    
    func removeFileFromDocumentsDirectory(fileUrl: URL) {
        _ = FileManager.default.removeFileFromDocumentsDirectory(fileUrl: fileUrl)
    }
    
    
    
    @objc func nokri_btnCameraClicked(){
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
        
        let imagePickerConroller = UIImagePickerController()
        imagePickerConroller.delegate = self
        
        let imagePicker = OpalImagePickerController()
        imagePicker.navigationBar.tintColor = UIColor.white
        imagePicker.maximumSelectionsAllowed = 10 //self.maximumImagesAllowed
        //print(self.maximumImagesAllowed)
        imagePicker.allowedMediaTypes = Set([PHAssetMediaType.image])
        // maximum message
        let configuration = OpalImagePickerConfiguration()
        configuration.maximumSelectionsAllowedMessage = NSLocalizedString((""), comment: "")
        imagePicker.configuration = configuration
        imagePicker.imagePickerDelegate = self
        self.present(imagePicker, animated: true, completion: nil)
    
        self.present(imagePickerConroller,animated:true, completion:nil)
    }
    
    func saveFileToDocumentDirectory(image: UIImage) {
        if let savedUrl = FileManager.default.saveFileToDocumentsDirectory(image: image, name: "", extention: ".png") {
            self.imageUrl = savedUrl
            print("Library \(String(describing: imageUrl))")
        }
    }
    
    func imagePicker(_ picker: OpalImagePickerController, didFinishPickingImages images: [UIImage]) {
        
        if images.isEmpty {
        }
        else {
            let jobid = UserDefaults.standard.string(forKey: "JobId")
            self.photoArray = images
            let param: [String: Any] = [ "job_id": String(jobid!)]
            print(param)
            self.nokri_uploadImages(param: param as NSDictionary, images: self.photoArray)
        }
        presentedViewController?.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerDidCancel(_ picker: OpalImagePickerController) {
        //self.dismissVC(completion: nil)
    }
    
    
      func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
           if (info[UIImagePickerController.InfoKey.originalImage] as? UIImage) != nil {
               if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                let jobid = UserDefaults.standard.string(forKey: "JobId")
                self.photoArray = [pickedImage]
                let param: [String: Any] = [ "job_id": String(jobid!)]
                print(param)
                self.nokri_uploadImages(param: param as NSDictionary, images: self.photoArray)
                
               }
               dismiss(animated: true, completion: nil)
              
           }
       }
    
      //MARK:- API Call
    
    func nokri_uploadImages(param: NSDictionary, images: [UIImage]) {
        //self.showLoader()
        uploadingProgressBar.progress = 0.0
        uploadingProgressBar.detailTextLabel.text = "0% Completed"
        uploadingProgressBar.show(in: view)
        
        adPostUploadImages(parameter: param, imagesArray: images, fileName: "custom_upload", uploadProgress: { (uploadProgress) in
            
        }, success: { (successResponse) in
            self.uploadingProgressBar.dismiss(animated: true)
            //self.stopAnimating()
            if successResponse.success {
                self.imageArray = successResponse.data.adImages
                //add image id to array to send to next View Controller and hit to server
//                for item in self.imageArray {
//                    self.imageIDArray.append(item.imgId)
//                }
                //self.maximumImagesAllowed = successResponse.data.images.numbers
                //self.imagesMsg = successResponse.data.images.message
                //UserDefaults.standard.set( self.imagesMsg, forKey: "imgMsg")
                self.tableView.reloadData()
            }
            else {
                let alert = Constants.showBasicAlert(message: successResponse.message)
                self.present(alert, animated: true, completion: nil)
            }
        }) { (error) in
            self.stopAnimating()
            let alert = Constants.showBasicAlert(message: error.message)
            self.present(alert, animated: true, completion: nil)
        }
    }
       
    func adPostUploadImages(parameter: NSDictionary , imagesArray: [UIImage], fileName: String, uploadProgress: @escaping(Int)-> Void, success: @escaping(ImageUploadRootMulti)-> Void, failure: @escaping(NetworkError)-> Void) {
        
        let url = Constants.URL.baseUrl+Constants.URL.multiImages
        print(url)
        NetworkHandler.uploadImageArray(url: url, imagesArray: imagesArray, fileName: "custom_upload", params: parameter as? [String: Any]  , uploadProgress: { (uploadProgress) in
            print(uploadProgress)
            let currentProgress = Float(uploadProgress)/100
            self.uploadingProgressBar.detailTextLabel.text = "\(uploadProgress)% Completed"
            self.uploadingProgressBar.setProgress(currentProgress, animated: true)
        }, success: { (successResponse) in
            let dictionary = successResponse as! [String: Any]
            let objImg = ImageUploadRootMulti(fromDictionary: dictionary)
            success(objImg)
        }) { (error) in
            failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
        }
    }
    
      //post images
      
//    func nokri_uploadImage() {
//
//           uploadingProgressBar.progress = 0.0
//           uploadingProgressBar.detailTextLabel.text = "0% Completed"
//           uploadingProgressBar.show(in: view)
//           UserHandler.nokri_uploadImageCompany(fileName: "logo_img", fileUrl: imageUrl!, progress: { (uploadProgress) in
//               let currentProgress = Float(uploadProgress)/100
//               self.uploadingProgressBar.detailTextLabel.text = "\(uploadProgress)% Completed"
//               self.uploadingProgressBar.setProgress(currentProgress, animated: true)
//           }, success: { (successResponse) in
//               self.uploadingProgressBar.dismiss(animated: true)
//               self.removeFileFromDocumentsDirectory(fileUrl: self.imageUrl!)
//               self.view.makeToast(successResponse.message, duration: 2.5, position: .center)
//
//               UserDefaults.standard.set(successResponse.data.image, forKey: "updatedImage")
//               UserDefaults.standard.set(5, forKey: "isUpdatedImage")
//               UserDefaults.standard.set(5, forKey: "loginCheck")
//               //self.nokri_populateData()
//               self.stopAnimating()
//           }, failure: { (error) in
//               self.uploadingProgressBar.dismiss(animated: true)
//               let alert = Constants.showBasicAlert(message: error.message)
//               self.present(alert, animated: true, completion: nil)
//               self.stopAnimating()
//           })
//
//       }
    
    
    func nokri_uploadResume(documentUrl: URL) {
        uploadingProgressBar.progress = 0.0
        uploadingProgressBar.detailTextLabel.text = "0% Completed"
        uploadingProgressBar.show(in: view)
        //startActivityIndicator()
        UserHandler.nokri_uploadResumeJobPost(fileName: "my_cv_upload", fileUrl: documentUrl, progress: { (uploadProgress) in
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
            //self.nokri_myResumesData()
            self.stopAnimating()
        }, failure: { (error) in
            let alert = Constants.showBasicAlert(message: error.message)
            self.present(alert, animated: true, completion: nil)
            self.stopAnimating()
        })
    }
}

extension JobPostDynamicFieldViewController:textSelectDropDown,textValDelegate,textValDateDelegate,textValLinkDelegate,checkBoxValues,radioBoxValues{
     
    func textValSelecrDrop(valueName: String ,value: String, indexPath: Int, fieldType: String, section: Int, fieldName: String, isShow: Bool) {
        if fieldType == "select"{
            var obj = JobPostCCustomData()
            obj.fieldType = "select"
            obj.fieldVal = String(value)
            obj.fieldTypeName = fieldName
            //isShowPrice = isShow
            self.fieldsArray[indexPath].fieldVal = valueName
            self.dataArray.append(obj)
            self.fieldsArray.append(obj)
            self.customArray.append(obj)
            customArraydata.append(obj)
            print(obj)
        }
    }
    
    func textVal(value: String, indexPath: Int,fieldType:String,section:Int,fieldNam:String) {
        if fieldType == "textfield"{
            var obj = JobPostCCustomData()
            obj.fieldType = "textfield"
            obj.fieldVal = value
            obj.fieldTypeName = fieldNam
            self.fieldsArray[indexPath].fieldVal = value
            self.dataArray.append(obj)
            self.fieldsArray.append(obj)
            self.customArraydata.append(obj)
            //objArray.append(obj)
            customArray.append(obj)
            print(obj)
        }
    }
    
    func textValDate(value: String, indexPath: Int, fieldType: String, section: Int,fieldNam:String) {
           if fieldType == "date"{
               var obj = JobPostCCustomData()
               obj.fieldType = "date"
               obj.fieldVal = value
               obj.fieldTypeName = fieldNam //"date_input"
               self.fieldsArray[indexPath].fieldVal = value
               self.dataArray.append(obj)
               self.fieldsArray.append(obj)
               self.customArraydata.append(obj)
               //objArray.append(obj)
               customArray.append(obj)
               print(obj)
           }
       }
    
    func textValLink(value: String, indexPath: Int,fieldType:String,section:Int,fieldNam:String) {
        if fieldType == "link"{
            var obj = JobPostCCustomData()
            obj.fieldType = "link"
            obj.fieldVal = value
            obj.fieldTypeName = fieldNam //fieldType
            self.fieldsArray[indexPath].fieldVal = value
            self.dataArray.append(obj)
            self.fieldsArray.append(obj)
            self.customArraydata.append(obj)
            //objArray.append(obj)
            customArray.append(obj)
            print(obj)
        }
    }
    
    func checkValues(valueName: String, value: String, indexPath: Int, fieldType: String, section: Int, fieldName: String, isShow: Bool) {
          if fieldType == "multi_select"{
              var obj = JobPostCCustomData()
              obj.fieldType = "multi_select"
              obj.fieldVal = String(value)
              obj.fieldTypeName = fieldName
              //isShowPrice = isShow
              self.fieldsArray[indexPath].fieldVal = valueName
              //self.dataArray.append(obj)
              self.fieldsArray.append(obj)
              self.customArray.append(obj)
              customArraydata.append(obj)
              print(obj)
          }
      }
    
    func radioValues(value: String, indexPath: Int, fieldType: String, section: Int, fieldName: String, isShow: Bool) {
            if fieldType == "checkbox"{
                var obj = JobPostCCustomData()
                obj.fieldType = "checkbox"
                obj.fieldVal = String(value)
                obj.fieldTypeName = fieldName
                //isShowPrice = isShow
                self.fieldsArray[indexPath].fieldVal = value
                //self.dataArray.append(obj)
                self.fieldsArray.append(obj)
                self.customArray.append(obj)
                customArraydata.append(obj)
                print(obj)
            }
        }
}
