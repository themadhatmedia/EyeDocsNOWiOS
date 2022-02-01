//
//  ApplyNowQuestionTableViewCell.swift
//  Nokri
//
//  Created by apple on 4/20/20.
//  Copyright © 2020 Furqan Nadeem. All rights reserved.
//


import UIKit
import TextFieldEffects

protocol questionsProtocolApply {
    func questionsDa(indexP:Int,questionString: String)
}


class ApplyNowQuestionTableViewCell: UITableViewCell,UITextFieldDelegate {

    
    @IBOutlet weak var txtQuestion: UITextField!
    
    
    var delegate:questionsProtocolApply?
    var index = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        txtQuestion.delegate = self as UITextFieldDelegate
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    @IBAction func txtQuestionClick(_ sender: Any) {
        delegate?.questionsDa(indexP: index, questionString: (sender as AnyObject).text)
    }
    
}
