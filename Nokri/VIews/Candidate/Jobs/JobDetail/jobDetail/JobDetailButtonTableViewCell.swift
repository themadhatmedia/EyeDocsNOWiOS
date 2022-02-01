//
//  JobDetailButtonTableViewCell.swift
//  Nokri
//
//  Created by Furqan Nadeem on 29/04/2019.
//  Copyright © 2019 Furqan Nadeem. All rights reserved.
//

import UIKit

class JobDetailButtonTableViewCell: UITableViewCell {

    @IBOutlet weak var btnBookrMark: UIButton!
    @IBOutlet weak var btnShare: UIButton!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
