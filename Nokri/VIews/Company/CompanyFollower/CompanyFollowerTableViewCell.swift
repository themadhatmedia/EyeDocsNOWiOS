//
//  CompanyFollowerTableViewCell.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 4/18/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import UIKit

class CompanyFollowerTableViewCell: UITableViewCell {

    
    @IBOutlet weak var viewBehindCell: UIView!
    
    @IBOutlet weak var imageViewCompanyFollower: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblRole: UILabel!
    @IBOutlet weak var btnRemove: UIButton!
    @IBOutlet weak var btnfollowerDetail: UIButton!
    
    var appColorNew = UserDefaults.standard.string(forKey: "app_Color")
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        nokri_shadow()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        self.btnRemove.backgroundColor = UIColor(hex: appColorNew!)
    }
    
    func nokri_shadow(){
        viewBehindCell.layer.borderColor = UIColor.darkGray.cgColor
        viewBehindCell.layer.cornerRadius = 0
        viewBehindCell.layer.shadowColor = UIColor.darkGray.cgColor
        viewBehindCell.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        viewBehindCell.layer.shadowOpacity = 0.8
        viewBehindCell.layer.shadowRadius = 1
    }

}
