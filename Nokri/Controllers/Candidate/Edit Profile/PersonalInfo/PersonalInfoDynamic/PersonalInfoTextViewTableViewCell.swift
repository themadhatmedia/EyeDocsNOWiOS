//
//  PersonalInfoTextViewTableViewCell.swift
//  Nokri
//
//  Created by apple on 3/4/20.
//  Copyright © 2020 Furqan Nadeem. All rights reserved.
//

import UIKit

class PersonalInfoTextViewTableViewCell: UITableViewCell,UITextViewDelegate {

    
    @IBOutlet weak var lblTxtViewkEY: UILabel!
    @IBOutlet weak var txtArea: UITextView!
    

  var fieldName = ""
        //var objSaved = JobPostCCustomData()
        var selectedIndex = 0
        var inde = 0
        var section = 0
        var delegate : registerTxtAreaFieldPro?
        var fieldType = "textArea"
        
        override func awakeFromNib() {
            super.awakeFromNib()
            // Initialization code
            
            txtArea.layer.borderWidth = 1.0
            txtArea.layer.borderColor = UIColor.lightGray.cgColor
            txtArea.layer.cornerRadius = 10
            txtArea.toolbarPlaceholder = "Type here.."
            txtArea.delegate = self
        }

        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)

            // Configure the view for the selected state
        }

        
        func textViewDidChange(_ textView: UITextView) {
            if let text = txtArea.text {
                delegate?.registerTxtAreafieldVal(value: text, indexPath: inde,fieldType: "textView",section:section,fieldNam: fieldName)
            }
        }
        
      
        
    }

