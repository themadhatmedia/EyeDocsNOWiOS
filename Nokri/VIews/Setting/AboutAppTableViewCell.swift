//
//  AboutAppTableViewCell.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 10/2/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import UIKit

class AboutAppTableViewCell: UITableViewCell {

    
    @IBOutlet weak var lblAbout: UILabel!
    @IBOutlet weak var lblAboutDetail: UILabel!
    @IBOutlet weak var btnAboutApp: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
