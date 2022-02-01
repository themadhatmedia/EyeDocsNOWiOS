//
//  CandidateSelectTimeTableViewCell.swift
//  Nokri
//
//  Created by Apple on 26/11/2020.
//  Copyright © 2020 Furqan Nadeem. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0

class CandidateSelectTimeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgNextDropSelctTime: UIImageView!
    @IBOutlet weak var btnSelectTimeDrop: UIButton!
    @IBOutlet weak var lblDropSelectTime: UILabel!
    @IBOutlet weak var containerViewMainDrop: UIView!
    @IBOutlet weak var lblSelectTIme: UILabel!
    
    
    var btnPopUpAction: (()->())?

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        // Initialization code

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    //MARK:- IBActions
    
    @IBAction func actionPopup(_ sender: Any) {
        self.btnPopUpAction?()
    }

    
}
