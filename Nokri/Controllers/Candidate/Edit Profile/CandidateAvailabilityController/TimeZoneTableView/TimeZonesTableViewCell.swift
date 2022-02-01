//
//  TimeZonesTableViewCell.swift
//  Nokri
//
//  Created by Apple on 16/12/2020.
//  Copyright © 2020 Furqan Nadeem. All rights reserved.
//

import UIKit

class TimeZonesTableViewCell: UITableViewCell {

    @IBOutlet weak var btnClick: UIButton!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
