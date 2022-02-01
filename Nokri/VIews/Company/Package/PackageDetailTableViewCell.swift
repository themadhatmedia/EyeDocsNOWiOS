//
//  PackageDetailTableViewCell.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 4/18/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import UIKit

class PackageDetailTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var lblSerialValue: UILabel!
    @IBOutlet weak var lblTitleValue: UILabel!
    @IBOutlet weak var lblDetailValue: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
