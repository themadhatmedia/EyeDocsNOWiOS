//
//  CandidateSearchedTableViewCell.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 7/9/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import UIKit

class CandidateSearchedTableViewCell: UITableViewCell {

    
    @IBOutlet weak var imgFea: UIImageView!
    @IBOutlet weak var imageViewCanSearched: UIImageView!
  
    @IBOutlet weak var lblFullName: UILabel!
    @IBOutlet weak var lblSubName: UILabel!
    
    @IBOutlet weak var btnClickedCandidate: UIButton!
    
    @IBOutlet weak var viewBehindCell: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        nokri_shadow()
    }
    
    func nokri_shadow(){
    
    viewBehindCell.layer.borderColor = UIColor.gray.cgColor
    viewBehindCell.layer.cornerRadius = 0
    viewBehindCell.layer.shadowColor = UIColor(white: 0.0, alpha: 0.5).cgColor
    viewBehindCell.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
    viewBehindCell.layer.shadowOpacity = 0.8
    viewBehindCell.layer.shadowRadius = 2
}

}
