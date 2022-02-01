//
//  CandPackageInnerTableViewCell.swift
//  Nokri
//
//  Created by apple on 4/3/20.
//  Copyright © 2020 Furqan Nadeem. All rights reserved.
//

import UIKit

class CandPackageInnerTableViewCell: UITableViewCell {
    
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

}
