//
//  MyProfileSkillTableViewCell.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 4/30/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import UIKit
import TGPControls
import RangeSeekSlider


class MyProfileSkillTableViewCell: UITableViewCell {

    @IBOutlet weak var lblSkill: UILabel!
    @IBOutlet weak var rangeSlider: RangeSeekSlider!
    
    @IBOutlet weak var btnSkill: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
