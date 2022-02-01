//
//  AddQuestionairTableViewCell.swift
//  Nokri
//
//  Created by apple on 4/15/20.
//  Copyright © 2020 Furqan Nadeem. All rights reserved.
//

import UIKit

protocol questionsProtocol {
    func questionsData (indexP:Int,questionString: String)
}

class AddQuestionairTableViewCell: UITableViewCell {

    
    @IBOutlet weak var viewBg: UIView!
    @IBOutlet weak var lblQuestion: UILabel!
        @IBOutlet weak var txtFieldQuestion: UITextField!
    
    var delegate:questionsProtocol?
    var index = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        viewBg.layer.cornerRadius = 12
    }
    
    
    @IBAction func txtQuestion(_ sender: UITextField) {
        delegate?.questionsData(indexP: index, questionString: sender.text!)
    }
    
}


