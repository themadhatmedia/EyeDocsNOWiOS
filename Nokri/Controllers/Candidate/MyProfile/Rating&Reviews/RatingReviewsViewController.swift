//
//  RatingReviewsViewController.swift
//  Nokri
//
//  Created by Apple on 28/12/2020.
//  Copyright © 2020 Furqan Nadeem. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class RatingReviewsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    
    @IBOutlet weak var lblHeaderScreenTitle: UILabel!
    @IBOutlet weak var imgHeaderScreen: UIImageView!
    @IBOutlet weak var containerHeaderScreen: UIView!
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.separatorStyle = .none
            
        }
    }
    @IBOutlet weak var lblHeadingScreen: UILabel!
    @IBOutlet weak var lblMainContainer: UIView!
    //MARK:-Properties
    var dataArray = [ReviewsData]()
    var appColorNew = UserDefaults.standard.string(forKey: "app_Color")

    var  userId : Int!
    var replyBtnText = ""
    var cancelBtnText = ""
    var addReviewtext = ""
    var btnSubmitText = ""
    var loginFirst = ""
    var enterTitle = ""
    var pageTitle = ""
    var reviewCardHeight = false
    var calledforEmploye = false
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showBackButton()

        // Do any additional setup after loading the view.
        self.tableView.register(UINib(nibName: "RatingsList", bundle: nil), forCellReuseIdentifier: "RatingsList")

//                self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "vekh veeeer", style: .plain, target: nil, action: nil)
//        navigationController?.navigationBar.backItem?.backBarButtonItem?.title = "vekh veer"
        self.nokri_ReviewsRatingsData()
        
    }
    func nokri_ReviewsRatingsData(){
        if calledforEmploye == true{
            let param: [String: Any] = [
                "user_id":userId!,
            ]
            print(param)
            self.nokri_EmployeeReviews(params: param as NSDictionary)
        }else{
            let param: [String: Any] = [
                "user_id":userId!,
            ]
            print(param)
            self.nokri_Reviews_data(params: param as NSDictionary)
            
        }
        
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    func showLoading(){
        self.startAnimating(Constants.activitySize.size, message: Constants.loaderMessages.loadingMessage.rawValue,messageFont: UIFont.systemFont(ofSize: 14), type: NVActivityIndicatorType.orbit)
    }
    func createSpinnerView() {
        let child = SpinnerViewController()

        // add the spinner view controller
        addChild(child)
        child.view.frame = view.frame
        view.addSubview(child.view)
        child.didMove(toParent: self)

        // wait two seconds to simulate some work happening
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
            // then remove the spinner view controller
            child.willMove(toParent: nil)
            child.view.removeFromSuperview()
            child.removeFromParent()
        }
    }
    //MARK:- CandidateReviews
    func nokri_Reviews_data(params: NSDictionary){
        self.showLoading()
        createSpinnerView()
        UserHandler.nokri_RatingReviewsData(parameter: params , success: { (successResponse) in
                                                self.stopAnimating()
                                                if successResponse.success {
                                                    self.title = successResponse.data.userReviewsData.extra.pageTitle
                                                    self.dataArray = successResponse.data.userReviewsData.reviewsArray
                                                    self.replyBtnText = successResponse.data.userReviewsData.extra.replyBtnText
                                                    self.cancelBtnText = successResponse.data.userReviewsData.extra.cancelBtnText
                                                    self.addReviewtext = successResponse.data.userReviewsData.extra.addReviewtext
                                                    self.btnSubmitText = successResponse.data.userReviewsData.extra.submit
                                                    self.loginFirst = successResponse.data.userReviewsData.extra.loginFirst
                                                    self.enterTitle = successResponse.data.userReviewsData.extra.enterTitle
                                                    self.pageTitle = successResponse.data.userReviewsData.extra.pageTitle
                                                    self.lblHeaderScreenTitle.text = self.pageTitle
                                                    self.tableView.reloadData()
                                                }else{
                                                    let alert = Constants.showBasicAlert(message: successResponse.message)
                                                    self.present(alert, animated: true, completion: nil)
                                                    self.stopAnimating()
                                                    
                                                }})
        { (error) in
            let alert = Constants.showBasicAlert(message: error.message)
            self.present(alert, animated: true, completion: nil)
            self.stopAnimating()
        }
        
    }
    //MARK:-EmployeeReviews
    func nokri_EmployeeReviews(params: NSDictionary){
        self.showLoading()
        createSpinnerView()
        UserHandler.nokri_EMployeRatingReviewsData(parameter: params , success: { (successResponse) in
                                                self.stopAnimating()
                                                if successResponse.success {
                                                    self.title = successResponse.data.userReviewsData.extra.pageTitle
                                                    self.dataArray = successResponse.data.userReviewsData.reviewsArray
                                                    self.replyBtnText = successResponse.data.userReviewsData.extra.replyBtnText
                                                    self.cancelBtnText = successResponse.data.userReviewsData.extra.cancelBtnText
                                                    self.addReviewtext = successResponse.data.userReviewsData.extra.addReviewtext
                                                    self.btnSubmitText = successResponse.data.userReviewsData.extra.submit
                                                    self.loginFirst = successResponse.data.userReviewsData.extra.loginFirst
                                                    self.enterTitle = successResponse.data.userReviewsData.extra.enterTitle
                                                    self.pageTitle = successResponse.data.userReviewsData.extra.pageTitle
                                                    self.lblHeaderScreenTitle.text = self.pageTitle
                                                    self.tableView.reloadData()
                                                }else{
                                                    let alert = Constants.showBasicAlert(message: successResponse.message)
                                                    self.present(alert, animated: true, completion: nil)
                                                    self.stopAnimating()
                                                    
                                                }})
        { (error) in
            let alert = Constants.showBasicAlert(message: error.message)
            self.present(alert, animated: true, completion: nil)
            self.stopAnimating()
        }
        
    }

    
    //MARK:-Table View Delegate Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return pageTitle
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40

    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            if dataArray.count == 0{
                return 0
            }
            else{
                if reviewCardHeight == true{
                    return UITableView.automaticDimension

                }
                else{
//                    150
                    return UITableView.automaticDimension
                }
            }
        }
        return 150
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RatingsList", for: indexPath) as! RatingsList
        let objData = dataArray[indexPath.row]
        if let title = objData.ratingPoster {
            cell.lblUserName.text = title
        }
        if let ratingStars = objData.ratingAverage {
            cell.rating.rating = Double(ratingStars)
        }
        if let ratingMessage = objData.ratingDescription {
            cell.lblContent.text = ratingMessage
        }
        if let ratingDate = objData.ratingDate {
            cell.lblDate.text = ratingDate
            
        }
        if let img = objData.userImage{
            if let url = URL(string: img){
                cell.imgUser.sd_setImage(with: url, completed: nil)
                cell.imgUser.sd_setShowActivityIndicatorView(true)
                cell.imgUser.sd_setIndicatorStyle(.gray)
            }
        }
        if let canReply = objData.canReply{
            if canReply == true {
                cell.replyButton.isHidden = false
                cell.replyButton.setTitle(self.replyBtnText, for: .normal)
                cell.replyButton.backgroundColor = UIColor(hex: appColorNew!)
                cell.replyButton.setTitleColor(UIColor.white, for: .normal)
                //btnReplyCommentAction
                cell.btnReplyCommentAction = { () in
                    let commentVC = self.storyboard?.instantiateViewController(withIdentifier: "ReplyCommentController") as! ReplyCommentController
                    commentVC.modalPresentationStyle = .overCurrentContext
                    commentVC.modalTransitionStyle = .flipHorizontal
                    commentVC.replyBtnText = self.replyBtnText
                    commentVC.cancelBtnText = self.cancelBtnText
                    commentVC.addReviewtext = self.addReviewtext
                    commentVC.btnSubmitText = self.btnSubmitText
                    commentVC.addReviewtext = self.addReviewtext
                    commentVC.comment_id = objData.commentId
                    commentVC.loginFirst = self.loginFirst
                    commentVC.enterTitle = self.enterTitle
                    self.present(commentVC, animated: true, completion: nil)
                }
            }else{
                cell.replyButton.isHidden = true
            }
            
        }
        if let hasReply = objData.hasReply {
            
            if hasReply == true {
                reviewCardHeight = true
//                cell.viewsperatorReplier.isHidden = false
                cell.containerReply.isHidden = false
                if let repliertext = objData.repliedTxt{
                    cell.lblReplierText.text = repliertext
                }
                if let replierHeading = objData.repliedHeadingTxt{
                    cell.lblReplierHeading.text = replierHeading
                }
            }
            else{
                cell.containerReply.isHidden = true
//                cell.viewsperatorReplier.isHidden = true


            }
        }
        return cell
    }
    
}
class SpinnerViewController: UIViewController {
    var spinner = UIActivityIndicatorView(style: .whiteLarge)

    override func loadView() {
        view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.7)

        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        view.addSubview(spinner)

        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
