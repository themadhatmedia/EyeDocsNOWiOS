//
//  UpdateInfoTextfieldTableViewCell.swift
//  Nokri
//
//  Created by apple on 3/4/20.
//  Copyright © 2020 Furqan Nadeem. All rights reserved.
//

import UIKit

class UpdateInfoTextfieldTableViewCell: UITableViewCell {

    
    @IBOutlet weak var lblKey: UILabel!
    @IBOutlet weak var txtFieldValue: UITextField!
    
    var fieldName = ""
    //var objSaved = JobPostCCustomData()
    var selectedIndex = 0
    var inde = 0
    var section = 0
    var delegate : registerTxtFieldPro?
    var fieldType = "textfield"
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

  @IBAction func txtEditingChanged(_ sender: UITextField) {
        if let text = sender.text {
            delegate?.registerTxtfieldVal(value: text, indexPath: inde,fieldType: "textfield",section:section,fieldNam: fieldName)
        }
    }

}
