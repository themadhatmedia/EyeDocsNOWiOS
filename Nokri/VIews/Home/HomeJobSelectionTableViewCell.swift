//
//  HomeJobSelectionTableViewCell.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 7/30/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import UIKit
import TTSegmentedControl

class HomeJobSelectionTableViewCell: UITableViewCell {

    
    @IBOutlet weak var segmentedControl: TTSegmentedControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
