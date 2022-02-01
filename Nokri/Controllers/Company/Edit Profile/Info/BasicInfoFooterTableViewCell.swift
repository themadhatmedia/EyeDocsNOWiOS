//
//  BasicInfoFooterTableViewCell.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 5/11/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import UIKit

class BasicInfoFooterTableViewCell: UITableViewCell {

    @IBOutlet weak var lblDegreeDetail: UILabel!
    @IBOutlet weak var richEditor: UITextView!
    @IBOutlet weak var btnSaveSection: UIButton!
    
    let cellBGView = UIView()
  
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
         customeButton()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    func customeButton(){
        
        btnSaveSection.layer.cornerRadius = 15
        btnSaveSection.layer.borderWidth = 1
        btnSaveSection.layer.borderColor = UIColor(hex:"1DA3F4").cgColor
        richEditor.layer.borderWidth = 1
        richEditor.layer.borderColor = UIColor.lightGray.cgColor
        
    }
    
}

