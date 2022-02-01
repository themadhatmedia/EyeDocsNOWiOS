//
//  Faq'sExpandableTableViewCell.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 4/25/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import UIKit

class Faq_sExpandableTableViewCell: UITableViewCell {

    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnExpand: UIButton!
    @IBOutlet weak var viewBehindExpand: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        nokri_shadow()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func nokri_shadow(){
        
        viewBehindExpand.layer.borderColor = UIColor.gray.cgColor
        viewBehindExpand.layer.cornerRadius = 0
        viewBehindExpand.layer.shadowColor = UIColor(white: 0.0, alpha: 0.5).cgColor
        viewBehindExpand.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        viewBehindExpand.layer.shadowOpacity = 0.8
        viewBehindExpand.layer.shadowRadius = 1
        
    }

}
