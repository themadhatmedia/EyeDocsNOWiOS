//
//  RegisterTxtFieldTableViewCell.swift
//  Nokri
//
//  Created by apple on 2/19/20.
//  Copyright © 2020 Furqan Nadeem. All rights reserved.
//

import UIKit

protocol registerTxtFieldPro {
    func registerTxtfieldVal(value: String,indexPath: Int, fieldType:String, section: Int,fieldNam:String)
}

class RegisterTxtFieldTableViewCell: UITableViewCell {

    @IBOutlet weak var viewText: UIView!
    @IBOutlet weak var txtField: UITextField!
    var fieldName = ""
    //var objSaved = JobPostCCustomData()
    var selectedIndex = 0
    var inde = 0
    var section = 0
    var delegate : registerTxtFieldPro?
    var fieldType = "textfield"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewText.layer.cornerRadius = 20
        viewText.layer.borderWidth = 1
        viewText.layer.borderColor = UIColor.groupTableViewBackground.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func txtEditingChanged(_ sender: UITextField) {
        if let text = sender.text {
            delegate?.registerTxtfieldVal(value: text, indexPath: inde,fieldType: "textfield",section:section,fieldNam: fieldName)
        }
    }
    

}
