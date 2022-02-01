//
//  CompanyOpenPositionTableViewCell.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 5/1/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import UIKit

class CompanyOpenPositionTableViewCell: UITableViewCell {

    @IBOutlet weak var viewBehindCell: UIView!
    
    @IBOutlet weak var lblJobType: UILabel!
    
    @IBOutlet weak var lblJobName: UILabel!
    
    @IBOutlet weak var lblJobExpiryKey: UILabel!
    
    @IBOutlet weak var lblJobExpiryValue: UILabel!
    
    @IBOutlet weak var lblLoation: UILabel!
    
    @IBOutlet weak var lblPrice: UILabel!
    
    @IBOutlet weak var btnJobDetail: UIButton!
    
    var appColorNew = UserDefaults.standard.string(forKey: "app_Color")
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        nokri_shadow()
        lblJobType.backgroundColor = UIColor(hex: appColorNew!)
        lblJobExpiryValue.textColor = UIColor(hex: appColorNew!)
        lblPrice.textColor = UIColor(hex: appColorNew!)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
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
