//
//  JobDetailHeaderTableViewCell.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 5/2/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import UIKit

class JobDetailHeaderTableViewCell: UITableViewCell {

    var appColorNew = UserDefaults.standard.string(forKey: "app_Color")
    @IBOutlet weak var lblJobTitle: UILabel!
    @IBOutlet weak var lblJobType: UILabel!
    @IBOutlet weak var lblLastDateKey: UILabel!
    @IBOutlet weak var lblLastDateValue: UILabel!
    @IBOutlet weak var viewDate: UIView!
    @IBOutlet weak var lblExpiry: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        viewDate.backgroundColor = UIColor(hex:appColorNew!)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
