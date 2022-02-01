//
//  AppVersionTableViewCell.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 10/2/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import UIKit

class AppVersionTableViewCell: UITableViewCell {

    
    @IBOutlet weak var lblAppVersion: UILabel!
    @IBOutlet weak var btnAppVersion: UIButton!
    
    @IBOutlet weak var lblAppVersionDetail: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
