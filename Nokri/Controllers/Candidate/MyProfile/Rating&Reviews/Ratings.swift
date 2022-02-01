//
//  Ratings.swift
//  Nokri
//
//  Created by Apple on 22/12/2020.
//  Copyright © 2020 Furqan Nadeem. All rights reserved.
//

import UIKit
import Cosmos

class Ratings: UITableViewCell {
    
    
    
    
    
    @IBOutlet weak var btnSubmit: UIButton!
    
    
    
    @IBOutlet weak var lblHeading: UILabel!
    @IBOutlet weak var imgReview: UIImageView!
    @IBOutlet weak var imgRound: UIImageView!{
    didSet{
        imgRound.makeRounded()
    }
    }
    @IBOutlet weak var mainContainer: UIView!{
        didSet{
            mainContainer.addShadowToView()
        }
    }
    
    //MARK:-Properties
    
    var appColorNew = UserDefaults.standard.string(forKey: "app_Color")
    var withOutLogin = UserDefaults.standard.string(forKey: "aType")
    var cultureRating : Double = 0
    var salaryRating :  Double = 0
    var growthrating :  Double = 0
    var empId : Int!
    var btnSubmitAction: (()->())?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        btnSubmit.layer.cornerRadius = 5
        btnSubmit.backgroundColor = UIColor(hex:appColorNew!)
        btnSubmit.setTitleColor(UIColor.white, for: .normal)
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func btnSubmitClicked(_ sender: UIButton) {
        self.btnSubmitAction?()

    }
    
    
    
}
