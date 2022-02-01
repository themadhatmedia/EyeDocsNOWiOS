//
//  JobNotificationTableViewCell.swift
//  Nokri
//
//  Created by apple on 4/27/20.
//  Copyright © 2020 Furqan Nadeem. All rights reserved.
//

import UIKit

class JobNotificationTableViewCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblComName: UILabel!
    @IBOutlet weak var lblPosted: UILabel!
    @IBOutlet weak var lblJobName: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var btnJobDetail: UIButton!
    
     var appColorNew = UserDefaults.standard.string(forKey: "app_Color")
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        nokri_roundedImage()
    }
    
    func nokri_roundedImage(){
        imgView.layer.borderWidth = 2
        imgView.layer.masksToBounds = false
        imgView.layer.borderColor = UIColor(hex:appColorNew!).cgColor
        imgView.layer.cornerRadius = imgView.frame.height/2
        imgView.clipsToBounds = true
    }
    
}

