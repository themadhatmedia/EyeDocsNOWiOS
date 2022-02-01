//
//  PackagesInnerTableViewCell.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 5/4/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import UIKit

class PackagesInnerTableViewCell: UITableViewCell {

    
    @IBOutlet weak var lblNo: UILabel!
    @IBOutlet weak var lblName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let isRtl = UserDefaults.standard.string(forKey: "isRtl")
        if isRtl == "0"{
          lblNo.textAlignment = .right
        }else{
          lblNo.textAlignment = .left
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
