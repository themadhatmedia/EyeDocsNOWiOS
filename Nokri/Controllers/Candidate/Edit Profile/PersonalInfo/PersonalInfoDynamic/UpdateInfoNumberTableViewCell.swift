//
//  UpdateInfoNumberTableViewCell.swift
//  Nokri
//
//  Created by apple on 3/4/20.
//  Copyright © 2020 Furqan Nadeem. All rights reserved.
//

import UIKit

class UpdateInfoNumberTableViewCell: UITableViewCell {

    
    @IBOutlet weak var lblNumberKey: UILabel!
    @IBOutlet weak var txtFieldNumber: UITextField!
    
  var fieldName = ""
        //var objSaved = JobPostCCustomData()
        var selectedIndex = 0
        var inde = 0
        var section = 0
        var delegate : registerNumberFieldPro?
        var fieldType = "number"
        
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
                delegate?.registerNumberfieldVal(value: text, indexPath: inde,fieldType: "number",section:section,fieldNam: fieldName)
            }
        }
    }
