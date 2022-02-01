//
//  MyProfileScoringTableViewCell.swift
//  Nokri
//
//  Created by apple on 4/10/20.
//  Copyright © 2020 Furqan Nadeem. All rights reserved.
//

import UIKit
import TGPControls
import RangeSeekSlider


class MyProfileScoringTableViewCell: UITableViewCell {

    @IBOutlet weak var lblSkillValue: UILabel!
    @IBOutlet weak var lblSkill: UILabel!
    @IBOutlet weak var rangeSlider: RangeSeekSlider!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
