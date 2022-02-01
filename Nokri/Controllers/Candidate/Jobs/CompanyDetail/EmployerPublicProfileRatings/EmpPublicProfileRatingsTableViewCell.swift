//
//  EmpPublicProfileRatingsTableViewCell.swift
//  Nokri
//
//  Created by Apple on 31/12/2020.
//  Copyright © 2020 Furqan Nadeem. All rights reserved.
//

import UIKit
import Cosmos
class EmpPublicProfileRatingsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var btnReply: UIButton!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var imgCalender: UIImageView!
    @IBOutlet weak var containerdate: UIView!{
        didSet{
            containerdate.backgroundColor = UIColor(hex:"#f5f5f5")
        }
    }
    @IBOutlet weak var lblContent: UILabel!
    @IBOutlet weak var rating: CosmosView!{
        didSet{
            rating.settings.updateOnTouch = false
            rating.settings.fillMode = .precise
//            rating.didTouchCosmos = didTouchCosmos
//            rating.didFinishTouchingCosmos = didFinishTouchingCosmos
            rating.settings.filledColor = Constants.hexStringToUIColor(hex: Constants.AppColor.ratingColor)
            rating.backgroundColor  = UIColor(hex:"#f5f5f5")
        }
    }
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var contianerUserInfo: UIView!
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var imgRoundBorder: UIImageView!{
        didSet{
            imgRoundBorder.makeRounded()
        }
    }
    
    @IBOutlet weak var imgContainer: UIView!{
        didSet{
            imgContainer.backgroundColor = UIColor(hex:"#f5f5f5")
        }
    }
    @IBOutlet weak var mainCOntainer: UIView!
    {
        didSet{
            mainCOntainer.backgroundColor = UIColor(hex:"#f5f5f5")
        }
    }
//
    @IBOutlet weak var containerReply: UIView!
    {
        didSet{
            containerReply.backgroundColor = UIColor(hex:"#f5f5f5")
        }
    }
    @IBOutlet weak var lblReplierHeading: UILabel!
    
    @IBOutlet weak var lblReplierText: UILabel!
    
    @IBOutlet weak var mainView: UIView!{
        didSet{
            mainView.addShadowToView()
        }
    }
    @IBOutlet weak var mainUIview: UIView!
    {
        didSet{
            mainUIview.backgroundColor = UIColor(hex:"#f5f5f5")
        }
    }
    @IBOutlet weak var viewsperatorReplier: UIView!
    //MARK:-Properties
    var btnReplyAction : (()->())?
    var commentId = ""
    override func awakeFromNib() {
        super.awakeFromNib()

        // Initialization code
//        rating.rating = 4
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    //MARK:- IBActions
    
    @IBAction func actionReply(_ sender: UIButton) {
        self.btnReplyAction?()
    }

    private func didTouchCosmos(_ rating: Double) {
        
        print("Start \(rating)")
        self.rating.text = String(rating)
    }
    
    private func didFinishTouchingCosmos(_ rating: Double) {
        print("End \(rating)")
        self.rating.text = String(rating)
        
    }
}
