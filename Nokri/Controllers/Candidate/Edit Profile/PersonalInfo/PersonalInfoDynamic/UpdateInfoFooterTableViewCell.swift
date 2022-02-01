//
//  UpdateInfoFooterTableViewCell.swift
//  Nokri
//
//  Created by apple on 3/4/20.
//  Copyright © 2020 Furqan Nadeem. All rights reserved.
//

import UIKit

class UpdateInfoFooterTableViewCell: UITableViewCell {

    
    @IBOutlet weak var btnSaveInfo: UIButton!
    @IBOutlet weak var btnDeleteAcc: UIButton!
    
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var appColorNew = UserDefaults.standard.string(forKey: "app_Color")
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        nokri_customeButton()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        
    }

    func nokri_customeButton(){
        btnSaveInfo.layer.cornerRadius = 15
        btnSaveInfo.layer.borderWidth = 1
        btnSaveInfo.layer.borderColor = UIColor(hex:appColorNew!).cgColor
        //btnSaveInfo.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor
        //btnSaveInfo.layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
        //btnSaveInfo.layer.shadowOpacity = 0.7
        btnSaveInfo.layer.shadowRadius = 0.3
        btnSaveInfo.layer.masksToBounds = false
        btnSaveInfo.backgroundColor = UIColor.white
        btnSaveInfo.setTitleColor(UIColor(hex: appColorNew!), for: .normal)
    }

    
    
}
