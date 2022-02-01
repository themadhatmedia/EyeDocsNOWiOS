//
//  AlertBuyTableViewCell.swift
//  Nokri
//
//  Created by Apple on 12/10/2020.
//  Copyright © 2020 Furqan Nadeem. All rights reserved.
//

import UIKit

class AlertBuyTableViewCell: UITableViewCell {

    @IBOutlet weak var lblCount: UILabel!
    
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var lblSubDetail: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
