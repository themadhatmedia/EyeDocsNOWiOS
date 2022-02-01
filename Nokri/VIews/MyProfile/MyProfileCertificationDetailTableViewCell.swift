//
//  MyProfileCertificationDetailTableViewCell.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 4/30/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import UIKit

class MyProfileCertificationDetailTableViewCell: UITableViewCell {

    
    @IBOutlet weak var lblCertificationName: UILabel!
    @IBOutlet weak var lblCertKey: UILabel!
    @IBOutlet weak var lblCerValue: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var topConstraintDetail: NSLayoutConstraint!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
