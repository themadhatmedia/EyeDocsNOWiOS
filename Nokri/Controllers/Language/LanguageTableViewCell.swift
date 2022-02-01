//
//  LanguageTableViewCell.swift
//  Nokri
//
//  Created by Apple on 14/09/2020.
//  Copyright © 2020 Furqan Nadeem. All rights reserved.
//

import UIKit

class LanguageTableViewCell: UITableViewCell {

    @IBOutlet weak var imgViewBg: UIImageView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblLanguage: UILabel!
    
    @IBOutlet weak var btnSelectLang: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lblLanguage.flash()
    }


}
