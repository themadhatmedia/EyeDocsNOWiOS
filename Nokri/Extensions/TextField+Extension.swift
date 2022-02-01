//
//  TextField+Extension.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 8/7/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    
    func nokri_addBottomBorder() {
        let border = CALayer()
        border.borderColor = UIColor.groupTableViewBackground.cgColor
        layer.addSublayer(border)
        layer.masksToBounds = true
    }
    
    func nokri_updateBottomBorderColor(isTextFieldSelected: Bool) {
        
        if let borderLayer = layer.sublayers?.first {
            if isTextFieldSelected {
                borderLayer.borderColor = UIColor.lightGray.cgColor//(hex: Constants.AppColor.appColor).cgColor
            } else {
                borderLayer.borderColor = UIColor.groupTableViewBackground.cgColor
            }
        }
        
    }
    
    func nokri_updateBottomBorderSize() {

        if let borderLayer = layer.sublayers?.first {
            let width = CGFloat(2.0)
            borderLayer.frame = CGRect(x: 0, y: bounds.height - width, width: bounds.width, height: bounds.height)
            borderLayer.borderWidth = width
        }

    }
    
}
