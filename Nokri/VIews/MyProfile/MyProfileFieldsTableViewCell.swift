//
//  MyProfileFieldsTableViewCell.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 6/7/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import UIKit

class MyProfileFieldsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var lblKey: UILabel!
    @IBOutlet weak var lblValue: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
