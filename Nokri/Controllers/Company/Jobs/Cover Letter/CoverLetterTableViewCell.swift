//
//  CoverLetterTableViewCell.swift
//  Nokri
//
//  Created by Furqan Nadeem on 19/05/2020.
//  Copyright © 2020 Furqan Nadeem. All rights reserved.
//

import UIKit

class CoverLetterTableViewCell: UITableViewCell {

    
    @IBOutlet weak var lblQuestion: UILabel!
    @IBOutlet weak var lblAnswer: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
