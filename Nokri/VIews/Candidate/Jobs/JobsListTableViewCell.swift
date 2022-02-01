//
//  JobsListTableViewCell.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 4/13/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import UIKit

class JobsListTableViewCell: UITableViewCell {

    //MARK:- IBOutlets
    
    @IBOutlet weak var viewBehindCell: UIView!
    @IBOutlet weak var lblPartOrFullTime: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubTitle: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var imageViewJobList: UIImageView!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var btnImageTapped: UIButton!
    @IBOutlet weak var btnCompanyDetail: UIButton!
    @IBOutlet weak var btnJobDetail: UIButton!
    @IBOutlet weak var iconTime: UIImageView!
    @IBOutlet weak var iconLocation: UIImageView!
    var appColorNew = UserDefaults.standard.string(forKey: "app_Color")
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
        //lblPartOrFullTime.backgroundColor = UIColor(hex: appColorNew!)
        lblPartOrFullTime.textColor = UIColor(hex: appColorNew!)
        lblPrice.textColor = UIColor(hex: appColorNew!)
        //nokri_shadow()
        nokri_roundedImage()
        //lblPartOrFullTime.layer.cornerRadius = 10
        //lblPartOrFullTime?.layer.masksToBounds = true
        iconTime.image = iconTime.image?.withRenderingMode(.alwaysTemplate)
        iconTime.tintColor = UIColor(hex: appColorNew!)
        iconLocation.image = iconLocation.image?.withRenderingMode(.alwaysTemplate)
        iconLocation.tintColor = UIColor(hex: appColorNew!)
    }
    
    func nokri_shadow(){
        
        viewBehindCell.layer.borderColor = UIColor.gray.cgColor
        viewBehindCell.layer.cornerRadius = 0
        viewBehindCell.layer.shadowColor = UIColor(white: 0.0, alpha: 0.5).cgColor
        viewBehindCell.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        viewBehindCell.layer.shadowOpacity = 0.6
        viewBehindCell.layer.shadowRadius = 2
    }

    func nokri_roundedImage(){
        
        imageViewJobList.layer.borderWidth = 2
        imageViewJobList.layer.masksToBounds = false
        imageViewJobList.layer.borderColor = UIColor.white.cgColor
        imageViewJobList.layer.cornerRadius = imageViewJobList.frame.height/2
        imageViewJobList.clipsToBounds = true
        
    }
 
}
