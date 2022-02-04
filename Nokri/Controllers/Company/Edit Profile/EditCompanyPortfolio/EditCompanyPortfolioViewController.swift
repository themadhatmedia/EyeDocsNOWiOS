//
//  EditCompanyPortfolioViewController.swift
//  Nokri
//
//  Created by apple on 4/8/20.
//  Copyright © 2020 Furqan Nadeem. All rights reserved.
//

import UIKit
import Photos
import OpalImagePicker
import NVActivityIndicatorView
import JGProgressHUD

class EditCompanyPortfolioViewController: UITableViewController,OpalImagePickerControllerDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout, UINavigationControllerDelegate,UITextFieldDelegate {

    //MARK:- IBOutlets
    
    @IBOutlet weak var lblStepNo: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var lblAllowed: UILabel!
    @IBOutlet weak var viewStepNo: UIView!
    @IBOutlet weak var txtVideo: UITextField!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var btnAdd: UIButton!
    
    //MARK:- Proporties
    
    var appColorNew = UserDefaults.standard.string(forKey: "app_Color")
    fileprivate var longPressGesture: UILongPressGestureRecognizer!
    var imagesArray = [String]()
    var imagesExtraArray = [CanPortfolionExtra]()
    var extraArray = [CanPortfolionExtra]()
    var selectedImageArr = [UIImage]()
    var keyArray = [String]()
    var message:String?
    private lazy var uploadingProgressBar: JGProgressHUD = {
        let progressBar = JGProgressHUD(style: .dark)
        progressBar.indicatorView = JGProgressHUDRingIndicatorView()
        progressBar.textLabel.text = "Uploading"
        return progressBar
    }()
    var isUpdateImage:Bool = false
    
    //MARK:- View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        nokri_customeButton()
        if #available(iOS 11.0, *) {
            collectionView.dragInteractionEnabled = true
        } else {
            // Fallback on earlier versions
        }
        longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.nokri_handleLongGesture(gesture:)))
        collectionView.addGestureRecognizer(longPressGesture)
        self.navigationController?.navigationBar.isHidden = false
        viewStepNo.backgroundColor = UIColor(hex: appColorNew!)
        nokri_candPortfolioGet()
        nokri_addBottomBorder()
        self.addLeftBarButtonWithImage(#imageLiteral(resourceName: "menu"))
        if let userData = UserDefaults.standard.object(forKey: "settingsData") {
            let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
            let dataTabs = SplashRoot(fromDictionary: objData)
            let obj = dataTabs.data.candTabs
            self.lblStepNo.text = obj?.portfolio
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        nokri_addBottomBorderSize()
    }
    
    //MARK:- Custome Functions
    
    func nokri_populateData(){
        imagesArray.removeAll()
        for obj in imagesExtraArray{
                imagesArray.append(obj.value)
                keyArray.append(obj.fieldname)
        }
        for obj in extraArray{
            if obj.fieldTypeName == "section_txt"{
                lblAllowed.text = obj.value
            }
            if obj.fieldTypeName == "not_added"{
                message = obj.value
            }
            if obj.fieldTypeName == "video_url"{
               txtVideo.placeholder = obj.key
                txtVideo.text = obj.value
            }
            if obj.fieldTypeName == "video_save_btn"{
                btnSave.setTitle(obj.value, for: .normal)
            }
        }
        if imagesExtraArray.count == 0{
            nokri_tableViewHelper()
        }else{
            nokri_tableViewHelper2()
        }
    }
    
    func nokri_tableViewHelper(){
        let rect = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: self.view.bounds.size.width, height: self.view.bounds.size.height))
        let messageLabel = UILabel(frame: rect)
        messageLabel.text = self.message
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
    
    func nokri_addBottomBorder(){
        txtVideo.delegate = self
        txtVideo.nokri_addBottomBorder()
    }
    
    func nokri_addBottomBorderSize(){
        txtVideo.nokri_updateBottomBorderSize()
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == txtVideo {
            txtVideo.nokri_updateBottomBorderColor(isTextFieldSelected: true)
        } else {
            txtVideo.nokri_updateBottomBorderColor(isTextFieldSelected: false)
        }
        return true
    }
    
    //MARK:- IBActions
    
    @IBAction func btnSaveClicked(_ sender: UIButton) {
        
        let param : [String:Any] = [
            "video_url":txtVideo.text!
        ]
        
        nokri_SaveVideo(parameter: param as NSDictionary)
    }
    
    @IBAction func btnAddlicked(_ sender: UIButton) {
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
            //Show error to user?
            return
        }
        let imagePicker = OpalImagePickerController()
        imagePicker.imagePickerDelegate = self
        imagePicker.maximumSelectionsAllowed = 10
        present(imagePicker, animated: true, completion: nil)
    }

    func nokri_customeButton(){
        btnSave.layer.cornerRadius = 15
        btnSave.layer.borderWidth = 1
        btnSave.layer.borderColor = UIColor(hex:appColorNew!).cgColor
        btnSave.setTitleColor(UIColor(hex:appColorNew!), for: .normal)
        //btnSave.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor
        //btnSave.layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
        //btnSave.layer.shadowOpacity = 0.7
        //btnSave.layer.shadowRadius = 0.3
        btnSave.layer.masksToBounds = false
        btnSave.backgroundColor = UIColor.white
    }
    
    //MARK:- Collection View
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddPortfolioCollectionViewCell", for: indexPath) as! AddPortfolioCollectionViewCell
        let images = imagesArray[indexPath.row]
        cell.multiImageView.sd_setImage(with: URL(string: images), completed: nil)
        cell.multiImageView.sd_setShowActivityIndicatorView(true)
        cell.multiImageView.sd_setIndicatorStyle(.gray)
        cell.btnDelete.tag = Int(keyArray[indexPath.row])!
        cell.btnDelete.addTarget(self, action:  #selector(AddPortfolioViewController.nokri_btnDeleteClicked), for: .touchUpInside)
        return cell
    }
    
    @objc func nokri_btnDeleteClicked( _ sender: UIButton){
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
        let alert = UIAlertController(title:confirmString, message: "", preferredStyle: .alert)
        let okbtn = UIAlertAction(title: btnOk, style: .default) { (ok) in
            let param : [String:Any] = [
                "portfolio_id":sender.tag
            ]
            self.nokri_portfolioDelete(parameter: param as NSDictionary)
        }
        let cancelbtn = UIAlertAction(title: btnCncel, style: .default) { (cancel) in
            print("Cancel")
        }
        alert.addAction(okbtn)
        alert.addAction(cancelbtn)
        self.present(alert, animated: true, completion: nil)
       
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = self.collectionView.bounds.width
        return CGSize(width: cellWidth/3.5, height: 115)
    }

    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let temp = imagesArray.remove(at: sourceIndexPath.item)
        imagesArray.insert(temp, at: destinationIndexPath.item)
    }
    
    @objc func nokri_handleLongGesture(gesture: UILongPressGestureRecognizer) {
        switch(gesture.state) {
        case UIGestureRecognizer.State.began:
            guard let selectedIndexPath = self.collectionView.indexPathForItem(at: gesture.location(in: self.collectionView)) else {
                break
            }
            collectionView.beginInteractiveMovementForItem(at: selectedIndexPath)
        case UIGestureRecognizer.State.changed:
            collectionView.updateInteractiveMovementTargetPosition(gesture.location(in: gesture.view!))
        case UIGestureRecognizer.State.ended:
            collectionView.endInteractiveMovement()
        default:
            collectionView.cancelInteractiveMovement()
        }
    }

    // MARK: - Select image
    
    func imagePickerDidCancel(_ picker: OpalImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePicker(_ picker: OpalImagePickerController, didFinishPickingImages images: [UIImage]) {
        if images.isEmpty {
        }
        else {
            nokri_uploadImages(images: images)
        }
        presentedViewController?.dismiss(animated: true, completion: nil)
    }
    
    //MARK:- API Calls
    func nokri_candPortfolioGet() {
        self.btnSave.isHidden = true
        self.viewStepNo.isHidden = true
        self.btnAdd.isHidden = true
        if isUpdateImage == false{
             self.showLoader()
        }
        UserHandler.nokri_compPortfolioGet(success: { (successResponse) in
            self.stopAnimating()
            if successResponse.success {
                self.btnSave.isHidden = false
                self.viewStepNo.isHidden = false
                self.btnAdd.isHidden = false
                self.imagesExtraArray = successResponse.data.img
                self.extraArray = successResponse.data.extra
                DispatchQueue.main.async {
                    self.nokri_populateData()
                    self.collectionView.reloadData()
                }
            }
            else {
                self.btnSave.isHidden = true
                self.viewStepNo.isHidden = true
                self.btnAdd.isHidden = true
                let alert = Constants.showBasicAlert(message: successResponse.extras)
                self.present(alert, animated: true, completion: nil)
            }
        }) { (error) in
            self.btnSave.isHidden = true
            self.viewStepNo.isHidden = true
            self.btnAdd.isHidden = true
            let alert = Constants.showBasicAlert(message: error.message)
            self.present(alert, animated: true, completion: nil)
            self.stopAnimating()
        }
    }
    
    func nokri_uploadImages(images:[UIImage]) {
        uploadingProgressBar.progress = 0.0
        uploadingProgressBar.detailTextLabel.text = "0% Completed"
        uploadingProgressBar.show(in: view)
        UserHandler.nokri_CompUploadImageArr(fileName: "File", images:images, progress: { (uploadProgress) in
            let currentProgress = Float(uploadProgress)/100
            self.uploadingProgressBar.detailTextLabel.text = "\(uploadProgress)% Completed"
            self.uploadingProgressBar.setProgress(currentProgress, animated: true)
        }, success: { (successResponse) in
            self.isUpdateImage = true
            self.uploadingProgressBar.dismiss(animated: true)
            let hud = JGProgressHUD(style: .dark)
            hud.textLabel.text = successResponse.message!
            hud.detailTextLabel.text = nil
            hud.indicatorView = JGProgressHUDSuccessIndicatorView()
            hud.position = .center
            hud.show(in: self.view)
            hud.dismiss(afterDelay: 2.0)
            //self.view.makeToast(successResponse.message, duration: 2.5, position: .center)
            self.nokri_candPortfolioGet()
        }, failure: { (error) in
            self.uploadingProgressBar.dismiss(animated: true)
            let alert = Constants.showBasicAlert(message: error.message)
            self.present(alert, animated: true, completion: nil)
        })
    }
    
    func nokri_portfolioDelete(parameter: NSDictionary) {
        self.showLoader()
        UserHandler.nokri_compPortfolioDel(parameter: parameter as NSDictionary, success: { (successResponse) in
            self.stopAnimating()
            if successResponse.success == true{
                self.nokri_candPortfolioGet()
                let hud = JGProgressHUD(style: .dark)
                hud.textLabel.text = successResponse.message! as! String
                hud.detailTextLabel.text = nil
                hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                hud.position = .center
                hud.show(in: self.view)
                hud.dismiss(afterDelay: 2.0)
                //self.view.makeToast(successResponse.message as? String, duration: 2.5, position: .center)
                self.stopAnimating()
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
        UserHandler.nokri_videoUrlCompany(parameter: parameter as NSDictionary, success: { (successResponse) in
            self.stopAnimating()
            if successResponse.success == true{
                let hud = JGProgressHUD(style: .dark)
                hud.textLabel.text = successResponse.message!
                hud.detailTextLabel.text = nil
                hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                hud.position = .center
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
}

// Resolved client issue.
//

