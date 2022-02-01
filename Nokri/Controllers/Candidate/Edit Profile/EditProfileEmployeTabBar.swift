//
//  EditProfileEmployeTabBar.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 4/26/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import UIKit

class EditProfileEmployeTabBar: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Edit Profile"
        let isRtl = UserDefaults.standard.string(forKey: "isRtl")
        if isRtl == "0"{
            self.addLeftBarButtonWithImage(#imageLiteral(resourceName: "menu"))
        }else{
            self.addRightBarButtonWithImage(#imageLiteral(resourceName: "menu"))
        }
    }
}
