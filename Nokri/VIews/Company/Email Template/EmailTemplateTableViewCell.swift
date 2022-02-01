//
//  EmailTemplateTableViewCell.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 4/19/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import UIKit

class EmailTemplateTableViewCell: UITableViewCell {

    @IBOutlet weak var lblSrNumValue: UILabel!
    @IBOutlet weak var lblNameValue: UILabel!
    @IBOutlet weak var btnUPdateValue: UIButton!
    @IBOutlet weak var btnDeleteValue: UIButton!
    @IBOutlet weak var btnUpdateForTempID: UIButton!
    @IBOutlet weak var btnDelForTempId: UIButton!
 
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
