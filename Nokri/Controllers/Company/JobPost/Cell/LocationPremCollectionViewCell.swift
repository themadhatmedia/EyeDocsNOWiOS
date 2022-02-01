//
//  LocationPremCollectionViewCell.swift
//  Nokri
//
//  Created by apple on 1/16/20.
//  Copyright © 2020 Furqan Nadeem. All rights reserved.
//

import UIKit
import UICheckbox_Swift

class LocationPremCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var btnCheckBox: UICheckbox!
     @IBOutlet weak var lblTitle: UILabel!
     @IBOutlet weak var lblRemaining: UILabel!
     @IBOutlet weak var viewBg: UIView!
     @IBOutlet weak var lblValue: UILabel!
     
     var appColorNew = UserDefaults.standard.string(forKey: "app_Color")
     override func awakeFromNib() {
         super.awakeFromNib()
         // Initialization code
//         btnCheckBox.onSelectStateChanged = { (checkbox, selected) in
//             debugPrint("Clicked - \(selected)")
//             if checkbox.isSelected == true{
//                 checkbox.layer.borderColor = UIColor(hex:self.appColorNew!).cgColor
//                 //checkbox.layer.backgroundColor = UIColor(hex:self.appColorNew!).cgColor
//                 //checkbox.tintColor = UIColor.white
//             }
//             else{
//                 self.btnCheckBox.imageView?.image = UIImage(named: "")
//                 checkbox.layer.backgroundColor = UIColor.clear.cgColor
//                 checkbox.layer.borderColor = UIColor.lightGray.cgColor
//             }
//         }
     }

    
    
}
