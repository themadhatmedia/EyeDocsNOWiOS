//
//  ReplyTableViewCell.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 7/23/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import UIKit

class ReplyTableViewCell: UITableViewCell {

    @IBOutlet weak var imageViewReply: UIImageView!
    @IBOutlet weak var lblTitleName: UILabel!
    @IBOutlet weak var lblTimeAgo: UILabel!
    @IBOutlet weak var lblReplyDesc: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func nokri_roundedImage(){
        
        imageViewReply.layer.borderWidth = 3.0
        imageViewReply.layer.masksToBounds = false
        imageViewReply.layer.borderColor = UIColor.lightGray.cgColor
        imageViewReply.layer.cornerRadius = imageViewReply.frame.height/2
        imageViewReply.clipsToBounds = true
        
    }

}
