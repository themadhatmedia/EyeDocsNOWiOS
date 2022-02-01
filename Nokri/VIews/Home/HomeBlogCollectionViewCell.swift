//
//  HomeBlogCollectionViewCell.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 5/4/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import UIKit

class HomeBlogCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var viewBehindCell: UIView!
    @IBOutlet weak var imageViewBlog: UIImageView!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblCommentCount: UILabel!
    @IBOutlet weak var lblBlogTitle: UILabel!
     @IBOutlet weak var btnBlogDetail: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //nokri_shadow()
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
