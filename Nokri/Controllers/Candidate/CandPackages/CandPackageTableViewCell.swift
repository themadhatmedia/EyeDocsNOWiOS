//
//  CandPackageTableViewCell.swift
//  Nokri
//
//  Created by apple on 4/3/20.
//  Copyright © 2020 Furqan Nadeem. All rights reserved.
//

import UIKit
import DropDown

class CandPackageTableViewCell: UITableViewCell,UITableViewDataSource,UITableViewDelegate {

    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewBehindCell: UIView!
    @IBOutlet weak var btnDropDown: UIButton!
    @IBOutlet weak var lblDropDown: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblProductPrice: UILabel!
    @IBOutlet weak var viewDropDown: UIView!
    @IBOutlet weak var viewTop: UIView!
    @IBOutlet weak var imageCircle: UIImageView!
    @IBOutlet weak var iconDropDown: UIImageView!
    @IBOutlet weak var lblDays: UILabel!
    @IBOutlet weak var lblTxtValidity: UILabel!
    @IBOutlet weak var lblNoOfCand: UILabel!
    @IBOutlet weak var lblCandSearch: UILabel!
    @IBOutlet weak var lblFeatureText: UILabel!
    @IBOutlet weak var lblFeatureValu: UILabel!
    
    //MARK:- Proporties
    
    var premiumArray = [BuyPackagePremiumJob]()
 
    var proArray = [BuyPackageProduct]()
    var appColorNew = UserDefaults.standard.string(forKey: "app_Color")
  
    override func awakeFromNib() {
        super.awakeFromNib()
        nokri_shadow()
        viewDropDown.layer.cornerRadius = 20
        self.viewTop.backgroundColor = UIColor(hex: appColorNew!)
        self.viewDropDown.backgroundColor = UIColor(hex: appColorNew!)
        imageCircle.image = imageCircle.image?.withRenderingMode(.alwaysTemplate)
        imageCircle.tintColor = UIColor(hex: appColorNew!)
        print(premiumArray)
       
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return premiumArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CandPackageInnerTableViewCell", for: indexPath) as! CandPackageInnerTableViewCell
        cell.lblNo.text = premiumArray[indexPath.row].noOfJobs
        cell.lblName.text = premiumArray[indexPath.row].name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
  
    func nokri_shadow(){
        viewBehindCell.layer.borderColor = UIColor.gray.cgColor
        viewBehindCell.layer.cornerRadius = 0
        viewBehindCell.layer.shadowColor = UIColor(white: 0.0, alpha: 0.5).cgColor
        viewBehindCell.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        viewBehindCell.layer.shadowOpacity = 0.8
        viewBehindCell.layer.shadowRadius = 2
    }
    
}
