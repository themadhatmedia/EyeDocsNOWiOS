//
//  SearchedJobTableViewCell.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 4/30/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import UIKit

class SearchedJobTableViewCell: UITableViewCell {

    @IBOutlet weak var viewBehindCell: UIView!
    @IBOutlet weak var lblPartOrFullTime: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubTitle: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var imageViewJobList: UIImageView!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var btnCompanyDetail: UIButton!
    @IBOutlet weak var btnJobDetail: UIButton!
    
    var appColorNew = UserDefaults.standard.string(forKey: "app_Color")
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //lblPartOrFullTime.backgroundColor = UIColor(hex: appColorNew!)
        lblPrice.textColor = UIColor(hex: appColorNew!)
        lblPartOrFullTime.textColor = UIColor(hex: appColorNew!)
        nokri_roundedImage()
        nokri_viewShadow()
      //lblPartOrFullTime.layer.cornerRadius = 10
      //lblPartOrFullTime?.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func nokri_viewShadow(){
        
        viewBehindCell.layer.borderColor = UIColor.gray.cgColor
        viewBehindCell.layer.cornerRadius = 0
        viewBehindCell.layer.shadowColor = UIColor(white: 0.0, alpha: 0.5).cgColor
        viewBehindCell.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        viewBehindCell.layer.shadowOpacity = 0.8
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
