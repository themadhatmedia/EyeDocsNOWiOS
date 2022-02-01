//
//  MyResumeTableViewCell.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 4/30/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import UIKit

class MyResumeTableViewCell: UITableViewCell {

    @IBOutlet weak var btnDownload: UIButton!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var lblSrKeyValue: UILabel!
    @IBOutlet weak var lblNameValue: UILabel!
    @IBOutlet weak var lblDownloadValue: UIButton!
    @IBOutlet weak var lblDeleteValue: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.btnDownload.layer.borderWidth = 1
        self.btnDownload.layer.borderColor = UIColor.darkGray.cgColor
        
        self.btnDelete.layer.borderWidth = 1
        self.btnDelete.layer.borderColor = UIColor.darkGray.cgColor
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
