//
//  RadioButtonTableViewCell.swift
//  Nokri
//
//  Created by apple on 2/6/20.
//  Copyright © 2020 Furqan Nadeem. All rights reserved.
//

import UIKit

class RadioButtonTableViewCell: UITableViewCell {

    @IBOutlet weak var btnRadio: UIButton!
    @IBOutlet weak var imgRadio: UIImageView!
    @IBOutlet weak var lblRadio: UILabel!
    
    
    var appColorNew = UserDefaults.standard.string(forKey: "app_Color")
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imgRadio.image = imgRadio.image?.withRenderingMode(.alwaysTemplate)
        imgRadio.tintColor = UIColor(hex: appColorNew!)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
