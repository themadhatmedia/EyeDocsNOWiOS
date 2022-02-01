//
//  SubmitRatingViewController.swift
//  Nokri
//
//  Created by Apple on 28/12/2020.
//  Copyright © 2020 Furqan Nadeem. All rights reserved.
//

import UIKit
import Cosmos
class SubmitRatingViewController: UIViewController {
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var txtViewWriteReviewField: UITextView!{
        didSet{
            txtViewWriteReviewField.layer.borderWidth = 1
            txtViewWriteReviewField.layer.borderColor = UIColor.gray.cgColor
            
        }
    }
    @IBOutlet weak var lblYourReviewTitle: UILabel!
    @IBOutlet weak var txtFieldReviewTitle: UITextField!
    @IBOutlet weak var lblWriteReviewTitle: UILabel!
    @IBOutlet weak var mainContainerReview: UIView!
    @IBOutlet weak var cosmosGrowth: CosmosView!{
        didSet {
            cosmosGrowth.settings.updateOnTouch = true
            cosmosGrowth.settings.fillMode = .full
            cosmosGrowth.didTouchCosmos = didTouchGrowthCosmos
            cosmosGrowth.didFinishTouchingCosmos = didFinishTouchingGrowthCosmos
            cosmosGrowth.settings.filledColor = Constants.hexStringToUIColor(hex: Constants.AppColor.ratingColor)
            
            //Constants.hexStringToUIColor(hex: Constants.AppColor.ratingColor)
            
        }
    }
    @IBOutlet weak var lblGrowth: UILabel!
    @IBOutlet weak var lblCulture: UILabel!
    @IBOutlet weak var cosmosCulture: CosmosView!{
        didSet {
            cosmosCulture.settings.updateOnTouch = true
            cosmosCulture.settings.fillMode = .full
            cosmosCulture.didTouchCosmos = didTouchCultureCosmos
            cosmosCulture.didFinishTouchingCosmos = didFinishTouchingCultureCosmos
            cosmosCulture.settings.filledColor = Constants.hexStringToUIColor(hex: Constants.AppColor.ratingColor)

            
            //Constants.hexStringToUIColor(hex: Constants.AppColor.ratingColor)
            
        }
    }
    @IBOutlet weak var cosmosSlary: CosmosView!{
        
        didSet {
            cosmosSlary.settings.updateOnTouch = true
            cosmosSlary.settings.fillMode = .full
            cosmosSlary.didTouchCosmos = didTouchCosmos
            cosmosSlary.didFinishTouchingCosmos = didFinishTouchingCosmos
            cosmosSlary.settings.filledColor = Constants.hexStringToUIColor(hex: Constants.AppColor.ratingColor)
            
            //Constants.hexStringToUIColor(hex: Constants.AppColor.ratingColor)
            
        }
        
    }
    @IBOutlet weak var lblSalaryTransfer: UILabel!
    @IBOutlet weak var reviewItemsContainer: UIView!
    @IBOutlet weak var mainContainer: UIView!
    @IBOutlet weak var lblScreenHeading: UILabel!
    
    
    //MARK:-Properties
    
    var appColorNew = UserDefaults.standard.string(forKey: "app_Color")
    var withOutLogin = UserDefaults.standard.string(forKey: "aType")
    var cultureRating : Double = 0
    var salaryRating :  Double = 0
    var growthrating :  Double = 0
    var empId : Int!
    var btnSubmitAction: (()->())?
    var writeReviewSectionTitle = ""
    var firstRating = ""
    var secondRating = ""
    var thirdRating = ""
    var reviewFieldTitle = ""
    var yourReviewFieldTitle = ""
    var btnSubmitReview = ""
    var loginFirst = ""
    var enterTitle = ""
    var enterMessage = ""
    var candId : Int!
    var screenTitle = ""
    var celledFromEmploy = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        btnSubmit.layer.cornerRadius = 15
        btnSubmit.backgroundColor = UIColor(hex:self.appColorNew!)
        
        lblSalaryTransfer.text = secondRating
        lblCulture.text = firstRating
        lblGrowth.text = thirdRating
        lblWriteReviewTitle.text = self.yourReviewFieldTitle
        lblYourReviewTitle.text = self.reviewFieldTitle
        lblScreenHeading.text = self.screenTitle
        btnSubmit.setTitle(btnSubmitReview, for: .normal)
        btnSubmit.setTitleColor(UIColor.white, for: .normal)
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    func nokri_ratingPost(){
        if  withOutLogin == "5"{
            
            self.view.makeToast(self.loginFirst, duration: 1.5, position: .bottom)
        }else{
            
            if txtFieldReviewTitle.text == ""{
                let alert = Constants.showBasicAlert(message: self.enterTitle)
                self.present(alert, animated: true, completion: nil)
                
            }
            else if txtViewWriteReviewField.text == ""{
                let alert = Constants.showBasicAlert(message: self.enterMessage)
                
                self.present(alert, animated: true, completion: nil)
                
            }
            
            else{
                if celledFromEmploy == true {
                    let param: [String: Any] = [
                        "review_title": txtFieldReviewTitle.text!,
                        "review_message": txtViewWriteReviewField.text!,
                        "rating_service": cultureRating,
                        "rating_process": salaryRating,
                        "rating_selection": growthrating,
                        "emp_id": candId!
                        
                    ]
                    print(param)
                    self.nokri_postEmployeeReview(params: param as NSDictionary)
                }
                else {
                    let param: [String: Any] = [
                        "review_title": txtFieldReviewTitle.text!,
                        "review_message": txtViewWriteReviewField.text!,
                        "rating_service": cultureRating,
                        "rating_process": salaryRating,
                        "rating_selection": growthrating,
                        "cand_id": candId!
                        
                    ]
                    print(param)
                    
                    self.nokri_postReviews(params: param as NSDictionary)
                }
            }
        }
    }
    private func didTouchCosmos(_ rating: Double) {
        
        print("Start \(rating)")
        //                self.salaryRating = rating
    }
    
    private func didFinishTouchingCosmos(_ rating: Double) {
        print("End \(rating)")
        self.salaryRating = rating
    }
    private func didTouchCultureCosmos(_ rating: Double) {
        
        print("Start \(rating)")
        //        self.rating = rating
    }
    
    private func didFinishTouchingCultureCosmos(_ rating: Double) {
        print("End \(rating)")
        self.cultureRating = rating
    }
    private func didTouchGrowthCosmos(_ rating: Double) {
        
        print("Start \(rating)")
        //        self.rating = rating
    }
    
    private func didFinishTouchingGrowthCosmos(_ rating: Double) {
        print("End \(rating)")
        self.growthrating = rating
        
    }
    @IBAction func btnSubmitClicked(_ sender: UIButton) {
        self.nokri_ratingPost()
        //        self.btnSubmitAction?()
    }
    //nokri_PostEmployeReviews
    //MARK:- Post EmployeeReview
    func nokri_postEmployeeReview(params:NSDictionary){
        self.showLoader()
        UserHandler.nokri_PostEmployeReviews(parameter: params, success: {(successResponse)      in
            if successResponse.success == true{
                self.stopAnimating()
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
                
                
                
            }
            else{self.stopAnimating()
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
                
            }
        }) { (error) in
            self.stopAnimating()
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
            self.present(alert, animated: true, completion: nil)        }
    }
    //MARK:- Post CandidateReview
    func nokri_postReviews(params:NSDictionary){
        self.showLoader()
        UserHandler.nokri_PostReviews(parameter: params, success: {(successResponse)      in
            if successResponse.success == true{
                self.stopAnimating()
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
                
                
                
            }
            else{self.stopAnimating()
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
                
            }
        }) { (error) in
            self.stopAnimating()
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
            self.present(alert, animated: true, completion: nil)        }
    }
    
}

