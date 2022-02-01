//
//  DashboardCompanyInfoTableViewCell.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 5/5/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import UIKit

class DashboardCompanyInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var lblKey: UILabel!
    @IBOutlet weak var lblValue: UILabel!
    @IBOutlet weak var btnLink: UIButton!
    
    @IBOutlet weak var viewSeparator: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        btnLink.titleLabel?.textColor = UIColor.clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func btnLinkClicked(_ sender: UIButton) {
//        print(btnLink.titleLabel?.text)
//        UIApplication.shared.open(URL(string: (btnLink.titleLabel?.text)!)!)
    }
}
