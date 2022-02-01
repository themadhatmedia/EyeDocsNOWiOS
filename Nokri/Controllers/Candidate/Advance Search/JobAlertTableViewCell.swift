//
//  JobAlertTableViewCell.swift
//  Nokri
//
//  Created by apple on 3/26/20.
//  Copyright © 2020 Furqan Nadeem. All rights reserved.
//

import UIKit

class JobAlertTableViewCell: UITableViewCell {
        @IBOutlet weak var btnRemove: UIButton!
        @IBOutlet weak var lblName: UILabel!
        @IBOutlet weak var lblRole: UILabel!
        @IBOutlet weak var viewBehindCell: UIView!
        
    @IBOutlet weak var lblDelete: UILabel!
    @IBOutlet weak var lblFreq: UILabel!
    var appColorNew = UserDefaults.standard.string(forKey: "app_Color")
        
        override func awakeFromNib() {
            super.awakeFromNib()
            nokri_shadow()
            //btnRemove.setTitleColor(UIColor.white, for: .normal)
            //btnRemove.layer.borderWidth = 2
            //btnRemove.layer.borderColor = UIColor(hex: appColorNew!).cgColor
            //btnRemove.backgroundColor = UIColor(hex: appColorNew!)
            btnRemove.layer.cornerRadius = 5
            lblDelete.textColor = UIColor.white
            lblDelete.backgroundColor = UIColor(hex: appColorNew!)
            btnRemove.backgroundColor = UIColor.clear
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
