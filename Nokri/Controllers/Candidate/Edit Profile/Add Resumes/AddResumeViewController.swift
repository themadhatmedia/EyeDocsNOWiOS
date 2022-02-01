//
//  AddResumeViewController.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 4/26/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import UIKit
import Alamofire
import JGProgressHUD
import MobileCoreServices
import AVFoundation


class AddResumeViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIDocumentPickerDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate {
    
    //MARK:- IBOutlets
    
    @IBOutlet weak var lblStepNo: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var btnAddResume: UIButton!
    @IBOutlet weak var viewStepNo: UIView!
    @IBOutlet weak var lblAllowed: UILabel!
    @IBOutlet weak var txtVideoUrl: UITextField!
    @IBOutlet weak var btnSubmit: UIButton!
    
    //MARK:- Proporties
    
    var appColorNew = UserDefaults.standard.string(forKey: "app_Color")
    var message:String?
    var resumesArray = NSMutableArray()
    var extraArray = NSMutableArray()
    var extraArrayVid = NSMutableArray()
    var messageForResume:String?
    var videoCheck = "0"
    var videoLimit = ""
    var videoLimitMsg = ""
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
   
    //MARK:- View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        nokri_myResumesData()
        nokri_customeButton()
        viewStepNo.backgroundColor = UIColor(hex: appColorNew!)
        if let userData = UserDefaults.standard.object(forKey: "settingsData") {
            let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
            let dataTabs = SplashRoot(fromDictionary: objData)
            let obj = dataTabs.data.candTabs
            self.lblStepNo.text = obj?.resumes
//            let tabController = parent as? UITabBarController
//            tabController?.navigationItem.title = "def"
        }
    }
    
    //MARK:- IBActions
    
    @IBAction func btnAddResumesClicked(_ sender: UIButton) {
   
        let options = [kUTTypePDF as String, kUTTypeZipArchive  as String, kUTTypePNG as String, kUTTypeJPEG as String, kUTTypeText  as String, kUTTypePlainText as String]
        let documentPicker: UIDocumentPickerViewController = UIDocumentPickerViewController(documentTypes: options, in: .import)
        documentPicker.delegate = self
        documentPicker.modalPresentationStyle = .formSheet
        self.present(documentPicker, animated: true, completion: nil)
    }
    
    @objc func nokri_btnDeleteClicked(_ sender: UIButton){
        let resumeId = sender.tag
        print(resumeId)
        if let userData = UserDefaults.standard.object(forKey: "settingsData") {
            let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
            let alertData = SplashRoot(fromDictionary: objData)
            let obj = alertData.data.genericTxts
            let alert = UIAlertController(title: obj?.confirm, message: nil, preferredStyle: .alert)
            let okButton = UIAlertAction(title: obj?.btnConfirm, style: .default) { (ok) in
                let param: [String: Any] = [
                    "resume_id": resumeId,
                    ]
                print(param)
                self.nokri_deleteResume(parameter: param as NSDictionary)
            }
            let cancelButton = UIAlertAction(title: obj?.btnCancel, style: .default) { (cancel) in
            }
            alert.addAction(cancelButton)
            alert.addAction(okButton)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func btnSubmitClicked(_ sender: UIButton) {
        if videoCheck == "0"{
            let param : [String:Any] = [
                "cand_video":txtVideoUrl.text!
            ]
            nokri_SaveVideo(parameter: param as NSDictionary)
        }else{
            showImagePicker()
        }
    }
    
    func showImagePicker(){
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.mediaTypes = [kUTTypeMovie as String]
            self.present(picker, animated: true, completion: nil)
        }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
                picker.dismiss(animated: true, completion: nil)

        let videoU = info[UIImagePickerController.InfoKey.mediaURL] as? URL
        
        print(videoU!)
        
        
        let data = NSData(contentsOf: videoU! as URL)!
                print("File size before compression: \(Double(data.length / 1048576)) mb")
        let sizeBefore = Double(data.length / 1048576)
        let limit:Double = Double(self.videoLimit)!
       
        if sizeBefore <= limit{
            DispatchQueue.main.async {
                self.nokri_uploadVideo(videoUrl: videoU!)
            }
        }else{
            let alert = Constants.showBasicAlert(message: self.videoLimitMsg)
            self.present(alert, animated: true, completion: nil)
        }
        
        
        
        
//                let compressedURL = NSURL.fileURL(withPath: NSTemporaryDirectory() + NSUUID().uuidString + ".MOV")
//        compressVideo(inputURL: videoU!, outputURL: compressedURL) { (exportSession) in
//                        guard let session = exportSession else {
//                            return
//                        }
//                        switch session.status {
//                        case .unknown:
//                            break
//                        case .waiting:
//                            break
//                        case .exporting:
//                            break
//                        case .completed:
//                            guard let compressedData = NSData(contentsOf: compressedURL) else {
//                                return
//                            }
//                           print("File size after compression: \(Double(compressedData.length / 1048576)) mb")
//
//                            print(compressedURL)
//
//                            let sizeAfter = Double(compressedData.length / 1048576)
//                            let limit:Double = Double(self.videoLimit)!
//
//                            if sizeAfter <= limit{
//                                DispatchQueue.main.async {
//                                    self.nokri_uploadVideo(videoUrl: compressedURL)
//                                }
//                            }else{
//                                let alert = Constants.showBasicAlert(message: self.videoLimitMsg)
//                                self.present(alert, animated: true, completion: nil)
//                            }
//
//                        case .failed:
//                            break
//                        case .cancelled:
//                            break
//                        @unknown default:
//                            fatalError()
//                        }
//                    }

            
       // self.nokri_uploadVideo(videoUrl: videoU!)
       
            }
    
    //MARK:- Collection View
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return resumesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddResumeCollectionViewCell", for: indexPath) as! AddResumeCollectionViewCell
        let selectedActiveJob = self.resumesArray[indexPath.row] as? [NSDictionary]
        for itemDict in selectedActiveJob! {
            let innerDict = itemDict ;
            if let field_type_name = innerDict["field_type_name"] as? String{
                if field_type_name == "resume_name" {
                    if let value = innerDict["value"] as? String {
                        cell.lblResumeTitle.text = value
                        if value.contains(".pdf"){
                            cell.imageViewFile.image = #imageLiteral(resourceName: "pdf")
                        }else{
                            cell.imageViewFile.image = #imageLiteral(resourceName: "word")
                        }
                    }
                }
                if field_type_name == "resume_id" {
                    if let value = innerDict["value"] as? String {
                        cell.btnDelete.tag = Int(value)!
                    }
                }
            }
        }
        
        let extraObj = self.extraArray as? [NSDictionary]
        for itemDict in extraObj! {
            let innerDict = itemDict ;
            if let field_type_name = innerDict["field_type_name"] as? String{
                
                if field_type_name == "dwnld_resume" {
//                    if let value = innerDict["value"] as? String {
//                        //cell.btnDownload.setTitle(value, for: .normal)
//                    }
                }
                if field_type_name == "del_resume" {
                    if let value = innerDict["value"] as? String {
                        cell.btnDelete.setTitle(value, for: .normal)
                    }
                }
                

            }
        }
        cell.btnDelete.addTarget(self, action: #selector(AddResumeViewController.nokri_btnDeleteClicked(_:)), for: .touchUpInside)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 0
        let collectionViewSize = collectionView.frame.size.width - padding
        return CGSize(width: collectionViewSize/4, height:133)
    }
    
    //MARK:- Custome Function
 
    func nokri_customeButton(){
        btnSubmit.setTitleColor(UIColor(hex: appColorNew!), for: .normal)
        btnSubmit.layer.cornerRadius = 15
        btnSubmit.layer.borderWidth = 1
        btnSubmit.layer.borderColor = UIColor(hex:appColorNew!).cgColor
        btnSubmit.layer.masksToBounds = false
        btnSubmit.backgroundColor = UIColor.white
    }
    
    func nokri_populateData(){
        
        var btnTitle = ""
        var btnTitle2 = ""
        
        
        let extraObj = self.extraArray as? [NSDictionary]
        for itemDict in extraObj! {
            let innerDict = itemDict ;
            if let field_type_name = innerDict["field_type_name"] as? String{
                if field_type_name == "section_text" {
                    if let value = innerDict["value"] as? String {
                        lblAllowed.text = value
                    }
                }
                if field_type_name == "not_added" {
                    if let value = innerDict["value"] as? String {
                        messageForResume = value
                    }
                }
               
            }
        }
        
        if self.resumesArray.count == 0{
            nokri_tableViewHelper()
        }else{
            nokri_tableViewHelper2()
        }
        print("\(self.resumesArray.count)");
        let extraObjVid = self.extraArrayVid as? [NSDictionary]
        for itemDict in extraObjVid! {
            let innerDict = itemDict ;
            if let field_type_name = innerDict["field_type_name"] as? String{
                if field_type_name == "video_url" {
                    if let value = innerDict["key"] as? String {
                        txtVideoUrl.placeholder = value
                    }
                    if let value = innerDict["value"] as? String {
                        txtVideoUrl.text = value
                    }
                }
                if field_type_name == "video_save_btn" {
                    if let value = innerDict["value"] as? String {
                        btnTitle = value
                       // btnSubmit.setTitle(value, for: .normal)
                    }
                }
                if field_type_name == "is_video_upload" {
                    if let value = innerDict["value"] as? String {
                        videoCheck = value
                    }
                    if let value = innerDict["key"] as? String {
                        btnTitle2 = value
                    }
                }
                if field_type_name == "video_limit" {
                    if let value = innerDict["value"] as? String {
                        videoLimit = value
                    }
                    if let key = innerDict["key"] as? String {
                        videoLimitMsg = key
                    }
                    
                    
                }

            }
        }
        
        if videoCheck == "0"{
            txtVideoUrl.isHidden = false
            btnSubmit.setTitle(btnTitle, for: .normal)
        }else{
            btnSubmit.setTitle(btnTitle2, for: .normal)
            txtVideoUrl.isHidden = true
        }
        
        self.collectionView.reloadData()
    }
    
    func nokri_tableViewHelper(){
        let rect = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: self.view.bounds.size.width, height: self.view.bounds.size.height))
        let messageLabel = UILabel(frame: rect)
        messageLabel.text = messageForResume
        messageLabel.textColor = UIColor.lightGray
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont(name: "TrebuchetMS", size: 20)
        messageLabel.sizeToFit()
        collectionView.backgroundView = messageLabel
    }
    
    func nokri_tableViewHelper2(){
        let rect = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: self.view.bounds.size.width, height: self.view.bounds.size.height))
        let messageLabel = UILabel(frame: rect)
        messageLabel.text = ""
        messageLabel.textAlignment = .center;
        collectionView.backgroundView = messageLabel
    }
    
    //MARK:- Delegates For UIDocumentPicker
    
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        self.saveFileToDocumentDirectory(document: url)
        self.nokri_uploadResume(documentUrl: url)
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
    
    func nokri_myResumesData(){
        
        var langCode = UserDefaults.standard.string(forKey: "langCode")
        if langCode == nil {
            langCode = "en"
        }
        
        self.viewStepNo.isHidden = true
        self.collectionView.isHidden = true
        self.btnAddResume.isHidden = true
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
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.myResumes, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    let responseData = response.value as! NSDictionary
                    self.message = responseData["message"] as? String
                    let success = responseData["success"] as! Bool
                    if success == true{
                        self.viewStepNo.isHidden = false
                        self.collectionView.isHidden = false
                        self.btnAddResume.isHidden = false
                        let data = responseData["data"] as! NSDictionary
                        if let resumeArr = data["resumes"] as? NSArray {
                            self.nokri_ResumesDataParser(resumeArray: resumeArr)
                        }
                        if let exArray = data["extras"] as? NSArray {
                            self.nokri_extraDataParser(extraDataArray: exArray)
                        }
                        if let exArrayVideo = data["extra"] as? NSArray {
                            self.nokri_extraDataParserideoVideo(extraDataArray: exArrayVideo)
                        }
                    }else{
                        self.btnAddResume.isHidden = true
                        let alert = Constants.showBasicAlert(message: self.message!)
                        self.present(alert, animated: true, completion: nil)
                        self.stopAnimating()
                    }
                    self.nokri_populateData()
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
            Alamofire.request(Constants.URL.baseUrl+Constants.URL.myResumes, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    let responseData = response.value as! NSDictionary
                    self.message = responseData["message"] as? String
                    let success = responseData["success"] as! Bool
                    if success == true{
                        //isTimeOut = true
                        self.viewStepNo.isHidden = false
                        self.btnAddResume.isHidden = false
                        self.collectionView.isHidden = false
                        let data = responseData["data"] as! NSDictionary
                        if let resumeArr = data["resumes"] as? NSArray {
                            self.nokri_ResumesDataParser(resumeArray: resumeArr)
                        }
                        if let exArray = data["extras"] as? NSArray {
                            self.nokri_extraDataParser(extraDataArray: exArray)
                        }
                        if let exArrayVideo = data["extra"] as? NSArray {
                            self.nokri_extraDataParserideoVideo(extraDataArray: exArrayVideo)
                        }
                    }else{
                        self.btnAddResume.isHidden = true
                        self.viewStepNo.isHidden = true
                        let alert = Constants.showBasicAlert(message: self.message!)
                        self.present(alert, animated: true, completion: nil)
                        self.stopAnimating()
                    }
                    self.nokri_populateData()
                    self.stopAnimating()
            }
        }
    }
    
    func nokri_extraDataParser(extraDataArray:NSArray){
        self.extraArray.removeAllObjects()
        for item in extraDataArray{
            self.extraArray.add(item)
        }
        print(extraArray)
    }
    
    func nokri_extraDataParserideoVideo(extraDataArray:NSArray){
          self.extraArrayVid.removeAllObjects()
          for item in extraDataArray{
              self.extraArrayVid.add(item)
          }
          print(extraArrayVid)
      }
    
    func nokri_ResumesDataParser(resumeArray:NSArray){
        self.resumesArray.removeAllObjects()
        for item in resumeArray{
            print(item)
            var arrayOfDictionaries = [NSDictionary]();
            if let innerArray = item as? NSArray{
                for innerItem in innerArray{
                    print(innerItem);
                    if let innerDictionary = innerItem as? NSDictionary{
                        arrayOfDictionaries.append(innerDictionary);
                    }
                }
            }
            self.resumesArray.add(arrayOfDictionaries);
        }
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
            self.nokri_myResumesData()
            self.stopAnimating()
        }, failure: { (error) in
            let alert = Constants.showBasicAlert(message: error.message)
            self.present(alert, animated: true, completion: nil)
            self.stopAnimating()
        })
    }
    
    func nokri_deleteResume(parameter: NSDictionary) {
        self.showLoader()
        UserHandler.nokri_deleteResume(parameter: parameter as NSDictionary, success: { (successResponse) in
            self.stopAnimating()
            if successResponse.success == true{
                //self.view.makeToast(successResponse.message as? String, duration: 1.5, position: .center)
                let hud = JGProgressHUD(style: .dark)
                hud.textLabel.text = successResponse.message as? String
                hud.detailTextLabel.text = nil
                hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                hud.position = .bottomCenter
                hud.show(in: self.view)
                hud.dismiss(afterDelay: 2.0)
                self.nokri_myResumesData()
            }
            else {
                let alert = Constants.showBasicAlert(message: successResponse.message as! String)
                self.present(alert, animated: true, completion: nil)
                self.stopAnimating()
            }
            
        }) { (error) in
            let alert = Constants.showBasicAlert(message: error.message)
            self.present(alert, animated: true, completion: nil)
            self.stopAnimating()
        }
    }
    
    func nokri_SaveVideo(parameter: NSDictionary) {
           self.showLoader()
           UserHandler.nokri_videoUrlCand(parameter: parameter as NSDictionary, success: { (successResponse) in
               self.stopAnimating()
            if successResponse.success == true{
                let hud = JGProgressHUD(style: .dark)
                hud.textLabel.text = successResponse.message!
                hud.detailTextLabel.text = nil
                hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                hud.position = .bottomCenter
                hud.show(in: self.view)
                hud.dismiss(afterDelay: 2.0)
                //self.view.makeToast(successResponse.message, duration: 2.5, position: .center)
                self.stopAnimating()
            }
            else {
                let alert = Constants.showBasicAlert(message: successResponse.message!)
                self.present(alert, animated: true, completion: nil)
                self.stopAnimating()
            }
           }) { (error) in
               let alert = Constants.showBasicAlert(message: error.message)
               self.present(alert, animated: true, completion: nil)
               self.stopAnimating()
           }
       }
    
    
    func nokri_uploadVideo(videoUrl:URL) {
        uploadingProgressBar.progress = 0.0
        uploadingProgressBar.detailTextLabel.text = "0% Completed"
        uploadingProgressBar.show(in: view)
        UserHandler.nokri_videoUpload(fileName: "resume_video", vUrl:videoUrl, progress: { (uploadProgress) in
            let currentProgress = Float(uploadProgress)/100
            self.uploadingProgressBar.detailTextLabel.text = "\(uploadProgress)% Completed"
            self.uploadingProgressBar.setProgress(currentProgress, animated: true)
        }, success: { (successResponse) in
           
            self.uploadingProgressBar.dismiss(animated: true)
            let hud = JGProgressHUD(style: .dark)
            hud.textLabel.text = successResponse.message!
            hud.detailTextLabel.text = nil
            hud.indicatorView = JGProgressHUDSuccessIndicatorView()
            hud.position = .center
            hud.show(in: self.view)
            hud.dismiss(afterDelay: 2.0)
    
        }, failure: { (error) in
            self.uploadingProgressBar.dismiss(animated: true)
            let alert = Constants.showBasicAlert(message: error.message)
            self.present(alert, animated: true, completion: nil)
        })
    }

    func compressVideo(inputURL: URL, outputURL: URL, handler:@escaping (_ exportSession: AVAssetExportSession?)-> Void) {
            let urlAsset = AVURLAsset(url: inputURL, options: nil)
            guard let exportSession = AVAssetExportSession(asset: urlAsset, presetName: AVAssetExportPresetMediumQuality) else {
                handler(nil)

                return
            }

            exportSession.outputURL = outputURL
            exportSession.outputFileType = AVFileType.mov
            exportSession.shouldOptimizeForNetworkUse = true
            exportSession.exportAsynchronously { () -> Void in
                handler(exportSession)
            }
        }


}


//mp4,m4v,avi,3gp,mov
