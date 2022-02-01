//
//  ResumeReceivedTableViewCell.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 4/19/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import UIKit
import DropDown

class ResumeReceivedTableViewCell: UITableViewCell {

    
    @IBOutlet weak var btnDropDown: UIButton!
    @IBOutlet weak var viewBehindCell: UIView!
    @IBOutlet weak var imageViewResumeRecv: UIImageView!
    @IBOutlet weak var lblRecv: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    let dropDown = DropDown()
    
    @IBOutlet weak var iconDropDown: UIImageView!
    @IBOutlet weak var iconLocation: UIImageView!
    var appColorNew = UserDefaults.standard.string(forKey: "app_Color")
    override func awakeFromNib() {
        super.awakeFromNib()
        nokri_shadow()
        lblRecv.backgroundColor = UIColor(hex: appColorNew!)
        nokri_roundedImage()
        iconDropDown.image = iconDropDown.image?.withRenderingMode(.alwaysTemplate)
        iconDropDown.tintColor = UIColor(hex: appColorNew!)
        iconLocation.image = iconLocation.image?.withRenderingMode(.alwaysTemplate)
        iconLocation.tintColor = UIColor(hex: appColorNew!)
        lblRecv.layer.cornerRadius = 10
        lblRecv?.layer.masksToBounds = true
        
    }

//    func nokri_dropDownSetup(){
//
//        dropDown.dataSource = ["Take Action", "Download","View Profile"]
//        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
//            print("Selected item: \(item) at index: \(index)")
//        }
//        // dropDown.width = 190
//        dropDown.anchorView = btnDropDown
//        DropDown.startListeningToKeyboard()
//        DropDown.appearance().textColor = UIColor.black
//        DropDown.appearance().textFont = UIFont.systemFont(ofSize: 12)
//        DropDown.appearance().backgroundColor = UIColor.white
//        DropDown.appearance().selectionBackgroundColor = UIColor(hex:appColorNew!)
//        DropDown.appearance().cellHeight = 40       
//    }
    
    
    func nokri_roundedImage(){
        
        imageViewResumeRecv.layer.borderWidth = 2
        imageViewResumeRecv.layer.masksToBounds = false
        imageViewResumeRecv.layer.borderColor = UIColor.white.cgColor
        imageViewResumeRecv.layer.cornerRadius = imageViewResumeRecv.frame.height/2
        imageViewResumeRecv.clipsToBounds = true
        
    }
    
    func nokri_shadow(){
        viewBehindCell.layer.borderColor = UIColor.gray.cgColor
        viewBehindCell.layer.cornerRadius = 0
        viewBehindCell.layer.shadowColor = UIColor(white: 0.0, alpha: 0.5).cgColor
        viewBehindCell.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        viewBehindCell.layer.shadowOpacity = 0.8
        viewBehindCell.layer.shadowRadius = 1
    }
}
