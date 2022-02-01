//
//  JobTabBarViewController.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 4/17/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import UIKit

class JobTabBarViewController: UITabBarController {

    var tabBarAppearence = UITabBar.appearance()
    var appColorNew = UserDefaults.standard.string(forKey: "app_Color")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let isRtl = UserDefaults.standard.string(forKey: "isRtl")
        if isRtl == "0"{
            self.addLeftBarButtonWithImage(#imageLiteral(resourceName: "menu"))
        }else{
            self.addRightBarButtonWithImage(#imageLiteral(resourceName: "menu"))
        }
        tabBarAppearence.barTintColor = UIColor(hex:appColorNew!)
        self.tabBar.barTintColor = UIColor(hex: appColorNew!)
        showSearchButton()
    }
}
