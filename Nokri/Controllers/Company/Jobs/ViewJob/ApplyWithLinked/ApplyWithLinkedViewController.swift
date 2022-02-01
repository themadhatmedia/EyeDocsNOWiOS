//
//  ApplyWithLinkedViewController.swift
//  Nokri
//
//  Created by Furqan Nadeem on 20/08/2020.
//  Copyright © 2020 Furqan Nadeem. All rights reserved.
//

import UIKit
import Alamofire
import JGProgressHUD

class ApplyWithLinkedViewController: UIViewController {
    
    
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnApply: UIButton!
    @IBOutlet weak var txtFieldUrl: UITextField!
    
    
    var jobId = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        print(jobId)
        
        if let userData = UserDefaults.standard.object(forKey: "settingsData") {
            let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
            let dataTabs = SplashRoot(fromDictionary: objData)
            let objExtraTxt = dataTabs.data.extra
            txtFieldUrl.placeholder = objExtraTxt?.linkedinurl
        }
        
    }
    
    
    @IBAction func btnCancelClicked(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
            self.view.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
        }) { (success) in
            self.dismiss(animated: true, completion: nil)            
        }
    }
    
    @IBAction func btnApplyClicked(_ sender: Any) {
        
        let param: [String: Any] = [
            "job_id": self.jobId,
            "url":self.txtFieldUrl.text!
        ]
        print(param)
        self.nokri_applyPost(parameter: param as NSDictionary)
        
    }
    
    
    func nokri_applyPost(parameter: NSDictionary) {
        self.showLoader()
        UserHandler.nokri_applyJobPost(parameter: parameter as NSDictionary, success: { (successResponse) in
            self.stopAnimating()
            if successResponse.success == true{
                let hud = JGProgressHUD(style: .dark)
                hud.textLabel.text = successResponse.message
                hud.detailTextLabel.text = nil
                hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                hud.position = .bottomCenter
                hud.show(in: self.view)
                hud.dismiss(afterDelay: 2.0)
                self.perform(#selector(self.dis), with: nil, afterDelay: 2.5)
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
    
    @objc func dis(){
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
            self.view.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
        }) { (success) in
            self.dismiss(animated: true, completion: nil)
        }
    }
    
}
