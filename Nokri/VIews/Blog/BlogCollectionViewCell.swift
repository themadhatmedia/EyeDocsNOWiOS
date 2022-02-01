//
//  BlogCollectionViewCell.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 4/13/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import UIKit

class BlogCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var viewBehindCell: UIView!
    @IBOutlet weak var imageViewBlog: UIImageView!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblCommentCount: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDetail: UILabel!
    @IBOutlet weak var heightConstraintImage: NSLayoutConstraint!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        nokri_shadow()
        
    }
    
    func nokri_shadow(){
        
        viewBehindCell.layer.borderColor = UIColor.gray.cgColor
        viewBehindCell.layer.cornerRadius = 0
        viewBehindCell.layer.shadowColor = UIColor.groupTableViewBackground.cgColor //(white: 0.0, alpha: 0.5).cgColor
        //viewBehindCell.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        viewBehindCell.layer.shadowOpacity = 0.5
        viewBehindCell.layer.shadowRadius = 1
    }
    
}
