//
//  BasiInfoHeaderTableViewCell.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 5/11/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import UIKit

class BasiInfoHeaderTableViewCell: UITableViewCell {

  
    @IBOutlet weak var imageViewHeader: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
