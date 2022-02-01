//
//  MatchedResumeTableViewCell.swift
//  Nokri
//
//  Created by apple on 3/31/20.
//  Copyright © 2020 Furqan Nadeem. All rights reserved.
//

import UIKit
import DropDown
import QuartzCore

class MatchedResumeTableViewCell: UITableViewCell {

    
    @IBOutlet weak var btnDropDown: UIButton!
    @IBOutlet weak var viewBehindCell: UIView!
    @IBOutlet weak var lblJobTitle: UILabel!
    @IBOutlet weak var lblJobExpiry: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var btnInActive: UIButton!
    @IBOutlet weak var lblJobType: UILabel!
    @IBOutlet weak var lblBtnInactive: UILabel!
    @IBOutlet weak var btnInactiveBg: UIView!
    @IBOutlet weak var iconDropDown: UIImageView!
    @IBOutlet weak var iconLocation: UIImageView!
    @IBOutlet weak var lblJobPost: UILabel!
    @IBOutlet weak var lblJobPostedVal: UILabel!
    
    
    
    let dropDown = DropDown()
    var dropDownArray = [String]()
    var appColorNew = UserDefaults.standard.string(forKey: "app_Color")
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
        self.lblDate.textColor = UIColor(hex:appColorNew!)
        self.btnInactiveBg.backgroundColor = UIColor(hex:appColorNew!)
        lblJobType.layer.cornerRadius = 20
        lblJobType?.layer.masksToBounds = true
        lblJobType.textColor = UIColor(hex: appColorNew!)
        btnInActive.layer.cornerRadius = 20
        btnInactiveBg.layer.cornerRadius = 20
        
    }
    func nokri_dropDownIcons(){
        iconDropDown.image = iconDropDown.image?.withRenderingMode(.alwaysTemplate)
        iconDropDown.tintColor = UIColor.lightGray
        iconLocation.image = iconLocation.image?.withRenderingMode(.alwaysTemplate)
        iconLocation.tintColor = UIColor(hex: appColorNew!)
    }
    func nokri_shadow(){
        
        viewBehindCell.layer.borderColor = UIColor.gray.cgColor
        viewBehindCell.layer.cornerRadius = 0
        viewBehindCell.layer.shadowColor = UIColor(white: 0.0, alpha: 0.5).cgColor
        viewBehindCell.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        viewBehindCell.layer.shadowOpacity = 0.8
        viewBehindCell.layer.shadowRadius = 1
    }
    
    
    
}
