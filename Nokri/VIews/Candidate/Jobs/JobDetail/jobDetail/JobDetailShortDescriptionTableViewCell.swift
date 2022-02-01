//
//  JobDetailShortDescriptionTableViewCell.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 5/2/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import UIKit

class JobDetailShortDescriptionTableViewCell: UITableViewCell {

    @IBOutlet weak var lblKey: UILabel!
    @IBOutlet weak var lblValue: UILabel!
    @IBOutlet weak var btnLink: UIButton!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        btnLink.titleLabel?.textColor = UIColor.clear
    }

    
    @IBAction func btnLinkClicked(_ sender: Any) {
        
        UIApplication.shared.open(URL(string: (btnLink.titleLabel?.text)!)!)
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
