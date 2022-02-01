//
//  HomeJobsListTableViewCell.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 5/3/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import TTSegmentedControl
import Alamofire


class HomeJobsListTableViewCell: UITableViewCell {

  //  @IBOutlet weak var segmentControl: TTSegmentedControl!
//    var activeJobArray = NSMutableArray()
//
//    var message:String?
//    var senderButtonTag:Int?
//    var featureTitle:String = ""
    
    @IBOutlet weak var viewBehindCell: UIView!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblJobType: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblCompany: UILabel!
    @IBOutlet weak var imageViewFeature: UIImageView!
    
    @IBOutlet weak var iconLocation: UIImageView!
    @IBOutlet weak var iconTime: UIImageView!
    @IBOutlet weak var lblJobTitle: UILabel!
    @IBOutlet weak var btnJobDetail: UIButton!
    @IBOutlet weak var btnCompanyDetail: UIButton!
    var appColorNew = UserDefaults.standard.string(forKey: "app_Color")
    override func awakeFromNib() {
          super.awakeFromNib()
        nokri_roundedImage()
        iconTime.image = iconTime.image?.withRenderingMode(.alwaysTemplate)
        iconTime.tintColor = UIColor(hex: appColorNew!)
        iconLocation.image = iconLocation.image?.withRenderingMode(.alwaysTemplate)
        iconLocation.tintColor = UIColor(hex: appColorNew!)
        lblJobType.layer.cornerRadius = 10
        lblJobType.layer.masksToBounds = true
        lblJobType.textColor = UIColor(hex:appColorNew!)
        
      // nokri_customeButtons()
//        jobData()
//        segmentControl.didSelectItemWith = { (index, title) -> () in
//            print("Selected item \(index)")
//            if index == 0{
//                self.jobData()
//            }else{
//                self.jobDataAll()
//            }
//        }
       // nokri_shadow()
    }
    
    func nokri_shadow(){
        
        viewBehindCell.layer.borderColor = UIColor.gray.cgColor
        viewBehindCell.layer.cornerRadius = 0
        viewBehindCell.layer.shadowColor = UIColor(white: 0.0, alpha: 0.5).cgColor
        viewBehindCell.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        viewBehindCell.layer.shadowOpacity = 0.8
        viewBehindCell.layer.shadowRadius = 1
    }
    
    func nokri_roundedImage(){
        imageViewFeature.layer.borderWidth = 2
        imageViewFeature.layer.masksToBounds = false
        imageViewFeature.layer.borderColor = UIColor(hex:appColorNew!).cgColor
        imageViewFeature.layer.cornerRadius = imageViewFeature.frame.height/2
        imageViewFeature.clipsToBounds = true
    }
    
    func nokri_customeButtons(){
        
//      self.segmentControl.itemTitles = ["Fea", "Latest Jobs"]
//       segmentControl.defaultTextColor = UIColor.darkGray
//       segmentControl.selectedTextColor = UIColor.white
//       segmentControl.thumbGradientColors = [UIColor(hex:Constants.AppColor.appColor), UIColor(hex:Constants.AppColor.appColor)]
//       segmentControl.useShadow = true
//       segmentControl.layer.borderColor = UIColor(hex: Constants.AppColor.appColor).cgColor
//       segmentControl.selectedTextFont = UIFont(name: "HelveticaNeue-Bold", size: 14.0)!
        
    }

    
//    //Mark:- TableView
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//
//        return activeJobArray.count
//
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeJobListDataTableViewCell", for: indexPath) as! HomeJobListDataTableViewCell
//        let selectedActiveJob = self.activeJobArray[indexPath.row] as? [NSDictionary];
//        for itemDict in selectedActiveJob! {
//            let innerDict = itemDict ;
//            if let field_type_name = innerDict["field_type_name"] as? String{
//                if field_type_name == "job_name" {
//                    if let value = innerDict["value"] as? String {
//                        cell.lblJobTitle.text = value
//                    }
//                }
//                if field_type_name == "company_name" {
//                    if let value = innerDict["value"] as? String {
//                        cell.lblCompany.text = value
//                    }
//                }
//                if field_type_name == "job_salary" {
//                    if let value = innerDict["value"] as? String {
//                        cell.lblPrice.text = value
//                    }
//                }
//                if field_type_name == "job_posted" {
//                    if let value = innerDict["value"] as? String {
//                        cell.lblDate.text = value
//                    }
//                }
//                if field_type_name == "job_type" {
//                    if let value = innerDict["value"] as? String {
//                        cell.lblJobType.text = value
//                    }
//                }
//                if field_type_name == "job_location" {
//                    if let value = innerDict["value"] as? String {
//                        cell.lblLocation.text = value
//                    }
//                }
//                if field_type_name == "company_logo" {
//                    if let value = innerDict["value"] as? String {
//                       cell.imageViewFeature.sd_setImage(with: URL(string: value), completed: nil)
//                    }
//                }
//                if field_type_name == "job_id" {
//                    if let value = innerDict["value"] as? Int {
//                        //cell.btnInActive.tag = value
//                        //cell.btnDropDown.tag = value
//                        //print(value)
//                    }
//                }
//            }
//        }
//
//
//        return cell
//    }
//
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//
//        return 187
//
//    }
    
    //MARK:- API Calls
   
 
    
}
