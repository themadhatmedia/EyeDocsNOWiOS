//
//  TextField.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 8/6/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import Foundation
import  UIKit

class BorderedTextField:UITextField{
    
    override func awakeFromNib() {
        
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.lightGray.cgColor
        border.frame = CGRect(x: 0, y: frame.size.height - width, width: frame.size.width, height: frame.size.height)
        
        border.borderWidth = width
        layer.addSublayer(border)
        layer.masksToBounds = true
        
    }
    
}
