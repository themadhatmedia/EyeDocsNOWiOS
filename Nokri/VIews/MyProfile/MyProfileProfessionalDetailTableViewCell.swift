//
//  MyProfileProfessionalDetailTableViewCell.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 4/30/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import UIKit

class MyProfileProfessionalDetailTableViewCell: UITableViewCell {

    
    @IBOutlet weak var lblProfessionalInstituteName: UILabel!
    
    @IBOutlet weak var lblNameKey: UILabel!
    @IBOutlet weak var lblDateValue: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
