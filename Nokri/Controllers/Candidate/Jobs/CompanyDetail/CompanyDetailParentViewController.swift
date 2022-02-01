//
//  CompanyDetailParentViewController.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 5/1/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class CompanyDetailParentViewController: ButtonBarPagerTabStripViewController {
    
    
    let purpleInspireColor = UIColor(hex:UserDefaults.standard.string(forKey: "app_Color")!)
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    override func viewDidLoad() {
    
        settings.style.buttonBarBackgroundColor = .white
        settings.style.buttonBarItemBackgroundColor = .white
        settings.style.selectedBarBackgroundColor = purpleInspireColor
        settings.style.buttonBarItemFont = .boldSystemFont(ofSize: 14)
        settings.style.selectedBarHeight = 2.0
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemTitleColor = .black
        settings.style.buttonBarItemsShouldFillAvailableWidth = true
        settings.style.buttonBarLeftContentInset = 0
        settings.style.buttonBarRightContentInset = 0
        changeCurrentIndexProgressive = { [weak self] (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = .lightGray
            newCell?.label.textColor = self?.purpleInspireColor
        }
        super.viewDidLoad()
    }
 
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let child_1 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CompanyOpenPositionViewController")
    
    
        let child_2 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CompanyDetailChildViewController")
        
        
        return [child_1, child_2]
    }
    
    override func viewDidLayoutSubviews() {
        
       
//            let tableViewHight = UserDefaults.standard.float(forKey: "tableViewHight")
//            self.scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: CGFloat(tableViewHight))
//
    }
   
}

