//
//  EditProfileCompanyTabBarController.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 4/16/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import UIKit

class EditProfileCompanyTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Edit Profile"
        self.addLeftBarButtonWithImage(#imageLiteral(resourceName: "menu"))
        self.tabBar.barTintColor = UIColor(hex: Constants.AppColor.appColor)
    
    }

}
