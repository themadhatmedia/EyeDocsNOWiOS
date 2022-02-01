//
//  CustomRegisterStaticTableViewCell.swift
//  Nokri
//
//  Created by apple on 2/20/20.
//  Copyright © 2020 Furqan Nadeem. All rights reserved.
//

import UIKit

class CustomRegisterStaticTableViewCell: UITableViewCell {

    @IBOutlet weak var btnCheckBox: UIButton!
    @IBOutlet weak var lblTermsText: UILabel!
    @IBOutlet weak var imageViewCheckBox: UIImageView!
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var lblNewsletter: UILabel!
    @IBOutlet weak var imgNewsCheckBox: UIImageView!
    @IBOutlet weak var btnlblNewsCheckBox: UIButton!
    @IBOutlet weak var btnNewsCheckBox: UIButton!
    @IBOutlet weak var containerNewsLetter: UIView!
    var appColorNew = UserDefaults.standard.string(forKey: "app_Color")
    var showNewsLetter = ""
    var subscribeNow = "off"
    override func awakeFromNib() {
        super.awakeFromNib()
        btnCheckBox.layer.borderWidth = 2.0
        btnCheckBox.layer.borderColor = UIColor.lightGray.cgColor
        btnNewsCheckBox.layer.borderWidth = 2.0
        btnNewsCheckBox.layer.borderColor = UIColor.lightGray.cgColor

        btnSignUp.setTitleColor(UIColor.white, for: .normal)
        btnSignUp.backgroundColor = UIColor(hex: appColorNew!)
        btnSignUp.layer.cornerRadius = 22
        imageViewCheckBox.isHidden = true
       
        let userData = UserDefaults.standard.object(forKey: "settingsData")
        let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
        let dataTabs = SplashRoot(fromDictionary: objData)
        lblTermsText.text = dataTabs.data.extra.agreeTerm
        btnSignUp.setTitle(dataTabs.data.guestTabs.signup, for: .normal)
     
    }

    @IBAction func btnCheckBoxClicked(_ sender: UIButton) {
           if imageViewCheckBox.isHidden == true{
               imageViewCheckBox.isHidden = false
           }else{
               imageViewCheckBox.isHidden = true
           }
       }
    @IBAction func btnNewsCheckBoxClicked(_ sender: UIButton) {
        if imgNewsCheckBox.isHidden == true{
            imgNewsCheckBox.isHidden = false
            subscribeNow = "on"
        }else{
            imgNewsCheckBox.isHidden = true
        }
    }
}
