//
//  NearbyByJobsCollectionViewCell.swift
//  Nokri
//
//  Created by Apple on 02/01/2021.
//  Copyright © 2021 Furqan Nadeem. All rights reserved.
//

import UIKit

class NearbyByJobsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var btnViewJob: UIButton!
    @IBOutlet weak var imgJob: UIImageView!
    @IBOutlet weak var lblDistance: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var mainContainer: UIView!
    {
        didSet{
            mainContainer.addShadowToView()
        }
    }
//MARK:-Properties
    var viewJobAction : (()->())?

    //MARK:- IBActions

    @IBAction func ViewJobAction(_ sender: UIButton){
        self.viewJobAction?()

    }
    
}
