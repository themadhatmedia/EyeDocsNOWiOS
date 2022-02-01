//
//  ViewJobViewController.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 4/19/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import UIKit

class ViewJobViewController: UIViewController {

    //MARK:- IBOutlets
    
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var viewField: UIView!
    @IBOutlet weak var viewWeb: UIView!
    @IBOutlet weak var viewFooter: UIView!
    @IBOutlet weak var lblJobTitle: UILabel!
    @IBOutlet weak var lblJobSubTitle: UILabel!
    @IBOutlet weak var lblLastDateKey: UILabel!
    @IBOutlet weak var lblLastDateValue: UILabel!
    @IBOutlet weak var lblShortDesc: UILabel!
    @IBOutlet weak var lblExpKey: UILabel!
    @IBOutlet weak var lblExpValue: UILabel!
    @IBOutlet weak var lblShiftKey: UILabel!
    @IBOutlet weak var lblShiftValue: UILabel!
    @IBOutlet weak var lblJobQualificationKey: UILabel!
    @IBOutlet weak var lblJobQualificationValue: UILabel!
    @IBOutlet weak var lblJobSalaryKey: UILabel!
    @IBOutlet weak var lblJobSalaryValue: UILabel!
    @IBOutlet weak var lblJobCurrencyKey: UILabel!
    @IBOutlet weak var lblJobCurrencyValue: UILabel!
    @IBOutlet weak var lblPostedOnKey: UILabel!
    @IBOutlet weak var lblPostedOnDate: UILabel!
    @IBOutlet weak var lblNoOfOpeningKey: UILabel!
    @IBOutlet weak var lblNoOfOpeningValue: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblCompanyName: UILabel!
    @IBOutlet weak var lblCompanyEmail: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblJobDesc: UILabel!
    @IBOutlet weak var lbbDescValue: UILabel!
    @IBOutlet weak var viewDate: UIView!
    @IBOutlet weak var viewClose: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    //MARK:- Proporties
    
    var appColorNew = UserDefaults.standard.string(forKey: "app_Color")
    var jobId:Int?
    var jobInfoArr = [ViewCompanyInfo]()
    var jobContentArr = [VIewJobContent]()
    var companyInfo = [viewCompInfo]()
    var extraArr = [ViewJobExtra]()
    var aboutCellHeight:CGFloat?
    var isCandidate:String?
    @IBOutlet weak var heightConstraintDescView: NSLayoutConstraint!
    @IBOutlet var mainView: UIView!
    
    
    //MARK:- View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nokri_shadow()
        nokri_roundedImage()
        nokri_viewJob()
        viewClose.backgroundColor = UIColor(hex:appColorNew!)
        viewDate.backgroundColor = UIColor(hex: appColorNew!)
    }

    //MARK:- IBActions
    
    @IBAction func btnCloseClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    //MARK:- Custome Function
    
    func nokri_shadow(){
        
//        viewHeader.layer.borderColor = UIColor.gray.cgColor
//        viewHeader.layer.cornerRadius = 0
//        viewHeader.layer.shadowColor = UIColor(white: 0.0, alpha: 0.5).cgColor
//        viewHeader.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
//        viewHeader.layer.shadowOpacity = 0.8
//        viewHeader.layer.shadowRadius = 1

        viewField.layer.borderColor = UIColor.gray.cgColor
        viewField.layer.cornerRadius = 0
        viewField.layer.shadowColor = UIColor(white: 0.0, alpha: 0.5).cgColor
        viewField.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        viewField.layer.shadowOpacity = 0.8
        viewField.layer.shadowRadius = 1
        
        viewWeb.layer.borderColor = UIColor.gray.cgColor
        viewWeb.layer.cornerRadius = 0
        viewWeb.layer.shadowColor = UIColor(white: 0.0, alpha: 0.5).cgColor
        viewWeb.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        viewWeb.layer.shadowOpacity = 0.8
        viewWeb.layer.shadowRadius = 1
        
        viewFooter.layer.borderColor = UIColor.gray.cgColor
        viewFooter.layer.cornerRadius = 0
        viewFooter.layer.shadowColor = UIColor(white: 0.0, alpha: 0.5).cgColor
        viewFooter.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        viewFooter.layer.shadowOpacity = 0.8
        viewFooter.layer.shadowRadius = 1
        
    }
    
    func nokri_roundedImage(){
        
        imgView.layer.borderWidth = 5
        imgView.layer.masksToBounds = false
        imgView.layer.borderColor = UIColor.white.cgColor
        imgView.layer.cornerRadius = imgView.frame.height/2
        imgView.clipsToBounds = true
        
    }

    
    func nokri_populateData(){
        
        for obj in jobInfoArr{
            
            if obj.fieldTypeName == "job_title"{
                self.lblJobTitle.text = obj.value
            }
            if obj.fieldTypeName == "job_last"{
                self.lblLastDateKey.text = obj.key
                self.lblLastDateValue.text = obj.value
            }
            if obj.fieldTypeName == "job_cat"{
                self.lblJobSubTitle.text = obj.value
            }
            if obj.fieldTypeName == "job_exp"{
                self.lblExpKey.text = obj.key
                self.lblExpValue.text = obj.value
            }
            if obj.fieldTypeName == "job_shift"{
                self.lblShiftKey.text = obj.key
                self.lblShiftValue.text = obj.value
            }
            if obj.fieldTypeName == "job_qualifications"{
                self.lblJobQualificationKey.text = obj.key
                self.lblJobQualificationValue.text = obj.value
            }
            if obj.fieldTypeName == "job_salary"{
                self.lblJobSalaryKey.text = obj.key
                self.lblJobSalaryValue.text = obj.value
            }
            if obj.fieldTypeName == "job_currency"{
                self.lblJobCurrencyKey.text = obj.key
                self.lblJobCurrencyValue.text = obj.value
            }
            if obj.fieldTypeName == "job_posted"{
                self.lblPostedOnKey.text = obj.key
                self.lblPostedOnDate.text = obj.value
            }
            if obj.fieldTypeName == "job_vacancy"{
                self.lblNoOfOpeningKey.text = obj.key
                self.lblNoOfOpeningValue.text = obj.value
            }
            if obj.fieldTypeName == "is_candidate"{
                isCandidate = obj.value
            }
            
        }

        for obj in companyInfo{
            
            if obj.fieldTypeName == "comp_web"{
                self.lblCompanyEmail.text = obj.value
            }
            if obj.fieldTypeName == "comp_img"{
                if let url = URL(string: obj.value){
                    self.imgView.sd_setImage(with: url, completed: nil)
                }
               
            }
            if obj.fieldTypeName == "company_adress"{
                self.lblLocation.text = obj.value
            }
            
        }
        
        for obj in jobContentArr{
            if obj.fieldTypeName == "job_content"{
                let htmlString = obj.value
                let data = htmlString?.data(using: String.Encoding.unicode.rawValue)!
                let attrStr = try? NSAttributedString(
                    data: data!,
                    options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html],
                    documentAttributes: nil)
                lbbDescValue.attributedText = attrStr
                self.aboutCellHeight = (lbbDescValue.attributedText?.height(withConstrainedWidth: self.view.frame.size.width))!
              
                //mainView.frame.size.height += CGFloat(aboutCellHeight!) - 200
                //heightConstraintDescView.constant +=  aboutCellHeight! - 200
                scrollView.contentSize.height += aboutCellHeight!
            }
        }
        
        for obj in extraArr{
            if obj.fieldTypeName == "short_desc"{
             self.lblShortDesc.text = obj.key
            }
            if obj.fieldTypeName == "job_desc"{
                self.lblJobDesc.text = obj.key
            }
        }
        
    }
    
    //MARK:- Api Calls
    
    func nokri_viewJob() {
        let params:NSDictionary = ["job_id":jobId!]
        print(params)
        self.showLoader()
        UserHandler.nokri_viewJob(parameter: params as NSDictionary, success: { (successResponse) in
           self.stopAnimating()
            if successResponse.success == true{
                self.jobInfoArr = successResponse.data.jobInfo
                self.jobContentArr = successResponse.data.jobContent
                self.companyInfo = successResponse.data.compInfo
                self.extraArr = successResponse.data.extras
                self.nokri_populateData()
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

}


