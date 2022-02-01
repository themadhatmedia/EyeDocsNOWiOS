//
//  FollowedCompanyListTableViewCell.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 4/13/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import UIKit

class FollowedCompanyListTableViewCell: UITableViewCell {

    @IBOutlet weak var imageViewCompany: UIImageView!
    
    @IBOutlet weak var lblCompanyName: UILabel!
    @IBOutlet weak var lblCompanyLocation: UILabel!
    
    @IBOutlet weak var lblOpenPosition: UILabel!
    
    @IBOutlet weak var btnCompanyDetail: UIButton!
    @IBOutlet weak var btnUnfollow: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        nokri_roundedImage()
    }

    func nokri_roundedImage(){
        imageViewCompany.layer.borderWidth = 2
        imageViewCompany.layer.masksToBounds = false
        imageViewCompany.layer.borderColor = UIColor(hex:Constants.AppColor.appColor).cgColor
        imageViewCompany.layer.cornerRadius = imageViewCompany.frame.height/2
        imageViewCompany.clipsToBounds = true
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
