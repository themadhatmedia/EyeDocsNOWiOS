//
//  ReplyAlertViewController.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 7/26/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import UIKit
import TextFieldEffects
import JGProgressHUD

protocol tableHightDelegate {
    func tableHeightReturn(height:Bool)
}

class ReplyAlertViewController: UIViewController {

     @IBOutlet weak var lblPostComment: UILabel!
     @IBOutlet weak var txtCommentField: UITextField!
     @IBOutlet weak var btnPostComment: UIButton!
     @IBOutlet weak var btnCancelComment: UIButton!
     @IBOutlet weak var imageViewReply: UIImageView!
    
    var commentiD:Int?
    var postId:Int?
    var blogExtra:BlogDetailExtra?
    var delegate:tableHightDelegate?
    var appColorNew = UserDefaults.standard.string(forKey: "app_Color")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblPostComment.text = blogExtra?.commentForm.title
        txtCommentField.placeholder = blogExtra?.commentForm.textarea
        btnPostComment.setTitle(blogExtra?.commentForm.btnSubmit, for: .normal)
        btnCancelComment.setTitle(blogExtra?.commentForm.btnCancel, for: .normal)
        btnPostComment.backgroundColor = UIColor(hex: appColorNew!)
        btnCancelComment.backgroundColor = UIColor(hex:appColorNew!)
        imageViewReply.image = imageViewReply.image?.withRenderingMode(.alwaysTemplate)
        imageViewReply.tintColor = UIColor(hex: appColorNew!)
    }
    
    @IBAction func btnPostCommentClicked(_ sender: UIButton) {
       
        if txtCommentField.text == ""{
   
            if let userData = UserDefaults.standard.object(forKey: "settingsData") {
                let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
                let dataTabs = SplashRoot(fromDictionary: objData)
            let Alert = UIAlertController(title: "Alert", message:dataTabs.data.extra.reply, preferredStyle: .alert)
            let okButton = UIAlertAction(title: dataTabs.data.genericTxts.btnConfirm, style: .default) { _ in
                
            }
            Alert.addAction(okButton)
                self.present(Alert, animated: true, completion: nil)
            }
        }else{
            nokri_blogReply()
        }

    }
    @IBAction func btnCancelCommentClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func txtClicked(_ sender: UITextField) {
    }
    
    func nokri_blogReply() {
        let param : [String:Any] = [
            "comment_id":commentiD!,
            "post_id":postId!,
            "message":txtCommentField.text!
        ]
        self.showLoader()
        UserHandler.nokri_blogReply(parameter: param as NSDictionary, success: { (successResponse) in
            self.stopAnimating()
            if successResponse.success == true{
                self.delegate?.tableHeightReturn(height: true)
                let hud = JGProgressHUD(style: .dark)
                hud.textLabel.text = successResponse.message!
                hud.detailTextLabel.text = nil
                hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                hud.position = .bottomCenter
                hud.show(in: self.view)
                hud.dismiss(afterDelay: 2.0)
                self.perform(#selector(self.nokri_showBlogController), with: nil, afterDelay: 2)
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
    
    @objc func nokri_showBlogController(){
     self.dismiss(animated: true, completion: nil)
    }
}
