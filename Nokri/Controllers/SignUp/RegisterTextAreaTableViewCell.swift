//
//  RegisterTextAreaTableViewCell.swift
//  Nokri
//
//  Created by apple on 2/20/20.
//  Copyright © 2020 Furqan Nadeem. All rights reserved.
//

import UIKit

protocol registerTxtAreaFieldPro {
    func registerTxtAreafieldVal(value: String,indexPath: Int, fieldType:String, section: Int,fieldNam:String)
}

class RegisterTextAreaTableViewCell: UITableViewCell,UITextViewDelegate {

    
    @IBOutlet weak var txtView: UITextView!
    
    
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
        
        txtView.layer.borderWidth = 1.0
        txtView.layer.borderColor = UIColor.lightGray.cgColor
        txtView.layer.cornerRadius = 10
        txtView.toolbarPlaceholder = "Type here.."
        txtView.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    func textViewDidChange(_ textView: UITextView) {
        if let text = txtView.text {
            delegate?.registerTxtAreafieldVal(value: text, indexPath: inde,fieldType: "textView",section:section,fieldNam: fieldName)
        }
    }
    

    
}
