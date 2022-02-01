//
//  MyProfileEducationalDetailTableViewCell.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 4/30/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import UIKit

class MyProfileEducationalDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var lblInstituteName: UILabel!
    @IBOutlet weak var lblDegreeOneKey: UILabel!
    @IBOutlet weak var lblDegreeTwoKey: UILabel!
    @IBOutlet weak var lblDegreeThreeKey: UILabel!
    @IBOutlet weak var lblDegreeOneVal: UILabel!
    @IBOutlet weak var lblDegreeTwoVal: UILabel!
    @IBOutlet weak var lblDegreeThreeVal: UILabel!
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
