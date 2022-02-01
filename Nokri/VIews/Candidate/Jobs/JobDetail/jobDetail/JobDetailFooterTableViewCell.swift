//
//  JobDetailFooterTableViewCell.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 5/2/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import UIKit

class JobDetailFooterTableViewCell: UITableViewCell {

    
    @IBOutlet weak var imageViewJobDetailFooter: UIImageView!
    @IBOutlet weak var lblCompanyName: UILabel!
    @IBOutlet weak var lblCompEmail: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var btnCompDetail: UIButton!
    @IBOutlet weak var lblAddress: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        nokri_roundedImage()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func nokri_roundedImage(){
        
        imageViewJobDetailFooter.layer.borderWidth = 2.8
        imageViewJobDetailFooter.layer.masksToBounds = false
        imageViewJobDetailFooter.layer.borderColor = UIColor.white.cgColor
        imageViewJobDetailFooter.layer.cornerRadius = imageViewJobDetailFooter.frame.height/2
        imageViewJobDetailFooter.clipsToBounds = true
        
    }
    

}
