//
//  ImageViewRounded.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 4/12/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import Foundation
import UIKit


extension UIImageView {
    
    public func maskCircle(anyImage: UIImage) {
        self.contentMode = UIView.ContentMode.scaleAspectFill
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.masksToBounds = false
        self.clipsToBounds = true
        
        // make square(* must to make circle),
        // resize(reduce the kilobyte) and
        // fix rotation.
        self.image = anyImage
    }
    
}
