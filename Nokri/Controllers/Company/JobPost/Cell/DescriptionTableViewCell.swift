//
//  DescriptionTableViewCell.swift
//  Nokri
//
//  Created by apple on 7/30/19.
//  Copyright © 2019 Furqan Nadeem. All rights reserved.
//

import UIKit

class DescriptionTableViewCell: UITableViewCell {

    @IBOutlet weak var lblJobDesc: UILabel!
    @IBOutlet weak var richEditor: UITextView!
    @IBOutlet weak var viewBg: UIView!
    
    
    var desText = ""
    var desValue = ""
    
    var appColorNew = UserDefaults.standard.string(forKey: "app_Color")
 
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        lblJobDesc.text = desText
        nokri_shadow()
        
    }

    func nokri_shadow(){
        richEditor.layer.borderColor = UIColor.groupTableViewBackground.cgColor
        richEditor.layer.cornerRadius = 0
        richEditor.layer.shadowColor = UIColor(white: 0.0, alpha: 0.5).cgColor
        richEditor.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        richEditor.layer.shadowOpacity = 0.8
        richEditor.layer.shadowRadius = 1
        richEditor.layer.borderWidth = 1
    }
  
    
   
}


