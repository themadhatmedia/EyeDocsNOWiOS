//
//  HomeTabBar.swift
//  Nokri
//
//  Created by Furqan Nadeem on 24/04/2019.
//  Copyright © 2019 Furqan Nadeem. All rights reserved.
//

import UIKit
import RAMAnimatedTabBarController


class HomeTabBar: RAMAnimatedTabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
       // nokri_ltrRtl()
        addLeftBarButtonWithImage(#imageLiteral(resourceName: "menu"))
        showSearchButton()
       // tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0)
    }
    
    func nokri_ltrRtl(){
        let isRtl = UserDefaults.standard.string(forKey: "isRtl")
        if isRtl == "0"{
            self.addLeftBarButtonWithImage(#imageLiteral(resourceName: "menu"))
        }else{
            self.addRightBarButtonWithImage(#imageLiteral(resourceName: "menu"))
        }
    }
    
}

