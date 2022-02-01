//
//  CompanyJobInActiveTableViewCell.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 4/18/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import UIKit
import DropDown

class CompanyJobInActiveTableViewCell: UITableViewCell {

    //MARK:- IBOutlets
    
    
    @IBOutlet weak var viewBehindCell: UIView!
    @IBOutlet weak var lblJobTitle: UILabel!
    @IBOutlet weak var lblJobExpiry: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var btnInActive: UIButton!
    @IBOutlet weak var lblJobType: UILabel!
    @IBOutlet weak var lblBtnInactive: UILabel!
    
    @IBOutlet weak var iconLocation: UIImageView!
    @IBOutlet weak var btnActiveBg: UIView!
    //MARK:- Proporties
    var appColorNew = UserDefaults.standard.string(forKey: "app_Color")
    var dropDownArray = [String]()
    
    //MARK:- View Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        lblJobType.textColor = UIColor(hex: appColorNew!)
        //self.lblJobType.backgroundColor = UIColor(hex:appColorNew!)
        self.lblDate.textColor = UIColor(hex:appColorNew!)
        self.btnActiveBg.backgroundColor = UIColor(hex:appColorNew!)
        //nokri_shadow()
        iconLocation.image = iconLocation.image?.withRenderingMode(.alwaysTemplate)
        iconLocation.tintColor = UIColor(hex: appColorNew!)
        //lblJobType.layer.cornerRadius = 10
        lblJobType?.layer.masksToBounds = true
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
