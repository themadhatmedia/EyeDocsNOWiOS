//
//  CandidateAvailabilityHeader.swift
//  Nokri
//
//  Created by Apple on 21/12/2020.
//  Copyright © 2020 Furqan Nadeem. All rights reserved.
//

import UIKit

class CandidateAvailabilityHeader: UITableViewCell {

    
    @IBOutlet weak var btnViewAll: UIButton!
    @IBOutlet weak var lblheadingScheduleHour: UILabel!
    @IBOutlet weak var containerView: UIView!{
        didSet{
            containerView.addShadowToView()
        }
    }
    //MARK:Properties
    var btnViewAllAction: (()->())?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func actionBtnViewAll(_ sender: UIButton) {
        
        self.btnViewAllAction?()
    }


}
extension UIButton {
    func circularButton() {
        layer.masksToBounds = false
        layer.cornerRadius = frame.width / 2
        clipsToBounds = true
    }
}
extension UIView {
    func addShadowToView() {
        backgroundColor = UIColor.white
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 2
        layer.cornerRadius = 3
    }
}
