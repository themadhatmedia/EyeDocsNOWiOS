//
//  RameBounceAnimation.swift
//  Nokri
//
//  Created by Furqan Nadeem on 23/04/2019.
//  Copyright © 2019 Furqan Nadeem. All rights reserved.
//

import Foundation
import RAMAnimatedTabBarController

class RAMBounceAnimation : RAMItemAnimation {
    
    override func playAnimation(_ icon: UIImageView, textLabel: UILabel) {
        playBounceAnimation(icon)
        textLabel.tintColor = UIColor.black
        icon.tintColor = UIColor.black
    }
    
    override func deselectAnimation(_ icon: UIImageView, textLabel: UILabel, defaultTextColor: UIColor, defaultIconColor: UIColor) {
        textLabel.textColor = UIColor.white
        icon.tintColor = UIColor.white
        textLabel.tintColor = UIColor.white
        
        
    }
    
    override func selectedState(_ icon: UIImageView, textLabel: UILabel) {
        textLabel.textColor =  UIColor.white  //textSelectedColor
        icon.tintColor = UIColor.black
        textLabel.tintColor = UIColor.black
    }
    
    func playBounceAnimation(_ icon : UIImageView) {
        
        let bounceAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        bounceAnimation.values = [1.0 ,1.4, 0.9, 1.15, 0.95, 1.02, 1.0]
        bounceAnimation.duration = TimeInterval(duration)
        bounceAnimation.calculationMode = CAAnimationCalculationMode.cubic
        
        icon.layer.add(bounceAnimation, forKey: "bounceAnimation")
    }
}
