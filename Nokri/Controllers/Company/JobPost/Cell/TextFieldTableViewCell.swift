//
//  TextFieldTableViewCell.swift
//  Nokri
//
//  Created by apple on 7/31/19.
//  Copyright © 2019 Furqan Nadeem. All rights reserved.
//

import UIKit
import TextFieldEffects


protocol textValDelegate {
    func textVal(value: String,indexPath: Int, fieldType:String, section: Int,fieldNam:String)
}

class TextFieldTableViewCell: UITableViewCell {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var separator: UIView!
    @IBOutlet weak var lblTxtKey: UILabel!
    
   
    var fieldName = ""
    var objSaved = JobPostCCustomData()
    var selectedIndex = 0
    //var delegate : textFieldValueDelegate?
    var inde = 0
    var section = 0
    var delegate : textValDelegate?
    var fieldType = "textfield"
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        separator.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor
//        separator.layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
//        separator.layer.shadowOpacity = 0.7
//        separator.layer.shadowRadius = 0.3
//        separator.layer.masksToBounds = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
   
       @IBAction func txtEditingChanged(_ sender: UITextField) {
           if let text = sender.text {
               delegate?.textVal(value: text, indexPath: inde,fieldType: "textfield",section:section,fieldNam: fieldName)
           }
       }
       
    

}
