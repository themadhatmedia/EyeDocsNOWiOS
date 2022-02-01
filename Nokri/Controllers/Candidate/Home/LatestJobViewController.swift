//
//  LatestJobViewController.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 5/4/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class LatestJobViewController: UIViewController,IndicatorInfoProvider {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Latest Jobs")
    }
  
}
