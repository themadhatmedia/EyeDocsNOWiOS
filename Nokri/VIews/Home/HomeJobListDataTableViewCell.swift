//
//  HomeJobListDataTableViewCell.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 5/4/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import UIKit

class HomeJobListDataTableViewCell: UITableViewCell {

    
    @IBOutlet weak var viewBehindCell: UIView!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblJobType: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblCompany: UILabel!
    @IBOutlet weak var imageViewFeature: UIImageView!
    
    @IBOutlet weak var lblJobTitle: UILabel!
    
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
        
        viewBehindCell.layer.borderColor = UIColor.gray.cgColor
        viewBehindCell.layer.cornerRadius = 0
        viewBehindCell.layer.shadowColor = UIColor(white: 0.0, alpha: 0.5).cgColor
        viewBehindCell.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        viewBehindCell.layer.shadowOpacity = 0.8
        viewBehindCell.layer.shadowRadius = 1
    }

}
