//
//  LinkTableViewCell.swift
//  Nokri
//
//  Created by apple on 7/31/19.
//  Copyright © 2019 Furqan Nadeem. All rights reserved.
//

import UIKit
import TextFieldEffects

protocol textValLinkDelegate {
    func textValLink(value: String,indexPath: Int, fieldType:String, section: Int,fieldNam:String)
}

class LinkTableViewCell: UITableViewCell {

    
    @IBOutlet weak var lblLinkKey: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    var fieldName = ""
    var objSaved = JobPostCCustomData()
    var selectedIndex = 0
    //var delegate : textFieldValueDelegate?
    var inde = 0
    var section = 0
    var delegate : textValLinkDelegate?
    var fieldType = "link"
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func txtEditingChanged(_ sender: UITextField) {
        if let text = sender.text {
            delegate?.textValLink(value: text, indexPath: inde,fieldType: "link",section:section,fieldNam: fieldName)
        }
    }
    
}
