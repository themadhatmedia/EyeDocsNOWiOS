//
//  SaveResumeTableViewCell.swift
//  Nokri
//
//  Created by apple on 3/19/20.
//  Copyright © 2020 Furqan Nadeem. All rights reserved.
//

import UIKit

class SaveResumeTableViewCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var btnViewProfile: UIButton!
    @IBOutlet weak var btnRemove: UIButton!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblRole: UILabel!
    @IBOutlet weak var viewBehindCell: UIView!
    
    var appColorNew = UserDefaults.standard.string(forKey: "app_Color")
    
    override func awakeFromNib() {
        super.awakeFromNib()
        nokri_shadow()
        btnRemove.setTitleColor(UIColor.white, for: .normal)
        btnViewProfile.setTitleColor(UIColor.white, for: .normal)
        btnRemove.layer.borderWidth = 1
        btnViewProfile.layer.borderWidth = 1
        btnRemove.layer.borderColor = UIColor(hex: appColorNew!).cgColor
        btnViewProfile.layer.borderColor = UIColor(hex: appColorNew!).cgColor
        btnRemove.backgroundColor = UIColor(hex: appColorNew!)
        btnViewProfile.backgroundColor = UIColor(hex: appColorNew!)
        btnRemove.layer.cornerRadius = 10
        btnViewProfile.layer.cornerRadius = 10
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
