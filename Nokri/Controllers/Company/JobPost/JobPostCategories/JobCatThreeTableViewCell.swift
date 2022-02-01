//
//  JobCatThreeTableViewCell.swift
//  Nokri
//
//  Created by apple on 1/8/20.
//  Copyright © 2020 Furqan Nadeem. All rights reserved.
//

import UIKit

class JobCatThreeTableViewCell: UITableViewCell {

    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
     let appColorNew = UserDefaults.standard.string(forKey: "app_Color")
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnClicked(_ sender: Any) {
        UserDefaults.standard.set(lblTitle.text, forKey:"caName")
        lblTitle.textColor = UIColor(hex: appColorNew!)
    }

}
