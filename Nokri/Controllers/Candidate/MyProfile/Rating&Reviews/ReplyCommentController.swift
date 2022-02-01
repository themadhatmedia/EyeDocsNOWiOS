//
//  ReplyCommentController.swift
//  Nokri
//
//  Created by Apple on 30/12/2020.
//  Copyright © 2020 Furqan Nadeem. All rights reserved.
//

import UIKit

class ReplyCommentController: UIViewController {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var containerTitleField: UIView!
    @IBOutlet weak var txtReplyComment: UITextField!
    @IBOutlet weak var containerTxtField: UIView!{
        didSet{
            containerTxtField.layer.borderWidth = 1
            containerTxtField.layer.borderColor = UIColor.gray.cgColor
            
        }
    }
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var imgMessage: UIImageView!
    @IBOutlet weak var viewImg: UIView!{
        didSet{
            viewImg.circularView()
        }
    }
    @IBOutlet weak var mainContainer: UIView!
    @IBOutlet weak var bigbtn: UIButton!
    
    //MARK:-Porperties
    var replyBtnText = ""
    var cancelBtnText = ""
    var addReviewtext = ""
    var btnSubmitText = ""
    var comment_id = ""
    var appColorNew = UserDefaults.standard.string(forKey: "app_Color")
    var withOutLogin = UserDefaults.standard.string(forKey: "aType")
    var loginFirst = ""
    var enterTitle = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        txtReplyComment.placeholder  = self.addReviewtext
        lblTitle.text = self.addReviewtext
        btnSubmit.setTitle(self.btnSubmitText, for: .normal)
        btnCancel.setTitle(self.cancelBtnText, for: .normal)
        btnSubmit.backgroundColor = UIColor(hex: appColorNew!)
        btnCancel.backgroundColor = UIColor(hex: appColorNew!)
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    //MARK:- IBActions
    @IBAction func actionBigButton(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
            self.view.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
        }) { (success) in
            self.dismiss(animated: true, completion: nil)
        }
    }
    @IBAction func actionBtnSubmit(_ sender: UIButton) {
        if  withOutLogin == "5"{
            
            self.view.makeToast(self.loginFirst, duration: 1.5, position: .bottom)
        }else{
            
            if txtReplyComment.text == ""{
                let alert = Constants.showBasicAlert(message: self.enterTitle)
                self.present(alert, animated: true, completion: nil)
                
            }
            
            else{
                
                let param: [String: Any] = [
                    "reply_text": txtReplyComment.text!,
                    "cid": comment_id,
                    
                ]
                print(param)
                self.nokri_postReplyReviews(params: param as NSDictionary)
            }
        }
    }
    @IBAction func actionBtnCancel(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        
    }
    func nokri_postReplyReviews(params: NSDictionary){
        self.showLoader()
        UserHandler.nokri_PostReplyReviews(parameter: params, success: { (successResponse) in
            self.stopAnimating()
            if successResponse.success {
                let userData = UserDefaults.standard.object(forKey: "settingsData")
                let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
                let dataTabs = SplashRoot(fromDictionary: objData)
                let alert = UIAlertController(title: dataTabs.data.extra.alertName, message: successResponse.message, preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: dataTabs.data.progressTxt.btnOk, style: .default, handler: { action in
                                                switch action.style{
                                                case .default:
                                                    print("default")
                                                    self.dismiss(animated: true, completion: nil)
                                                    
                                                case .cancel:
                                                    print("cancel")
                                                    
                                                case .destructive:
                                                    print("destructive")
                                                    
                                                    
                                                }}))
                self.present(alert, animated: true, completion: nil)
                self.stopAnimating()
            }
            else{
                let userData = UserDefaults.standard.object(forKey: "settingsData")
                let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
                let dataTabs = SplashRoot(fromDictionary: objData)
                let alert = UIAlertController(title: dataTabs.data.extra.alertName, message: successResponse.message, preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: dataTabs.data.progressTxt.btnOk, style: .default, handler: { action in
                                                switch action.style{
                                                case .default:
                                                    print("default")
                                                    self.dismiss(animated: true, completion: nil)
                                                    
                                                case .cancel:
                                                    print("cancel")
                                                    
                                                case .destructive:
                                                    print("destructive")
                                                    
                                                    
                                                }}))
                self.present(alert, animated: true, completion: nil)
                self.stopAnimating()
                
            }
        })
        { (error) in
            let userData = UserDefaults.standard.object(forKey: "settingsData")
            let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
            let dataTabs = SplashRoot(fromDictionary: objData)
            let alert = UIAlertController(title: dataTabs.data.extra.alertName, message: error.message, preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: dataTabs.data.progressTxt.btnOk, style: .default, handler: { action in
                                            switch action.style{
                                            case .default:
                                                print("default")
                                                self.dismiss(animated: true, completion: nil)
                                                
                                            case .cancel:
                                                print("cancel")
                                                
                                            case .destructive:
                                                print("destructive")
                                                
                                                
                                            }}))
            self.present(alert, animated: true, completion: nil)
            self.stopAnimating()
            
        }
        
        
        
        
    }
    
}
extension UIView {
    func circularView() {
        layer.cornerRadius = frame.size.width/2
        clipsToBounds = true
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 0.5
    }
}
