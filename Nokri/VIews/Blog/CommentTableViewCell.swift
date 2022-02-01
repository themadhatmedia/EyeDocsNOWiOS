//
//  CommentTableViewCell.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 7/23/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    
    @IBOutlet weak var imageCommentView: UIImageView!
    @IBOutlet weak var lblTitleName: UILabel!
    @IBOutlet weak var lblTimeAgo: UILabel!
    @IBOutlet weak var lblCommentDesc: UILabel!
    @IBOutlet weak var leftConstraintImageView: NSLayoutConstraint!
    @IBOutlet weak var btnReply: UIButton!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        nokri_roundedImage()
    }
    
    func nokri_roundedImage(){
        
        imageCommentView.layer.borderWidth = 3.0
        imageCommentView.layer.masksToBounds = false
        imageCommentView.layer.borderColor = UIColor.lightGray.cgColor
        imageCommentView.layer.cornerRadius = imageCommentView.frame.height/2
        imageCommentView.clipsToBounds = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
