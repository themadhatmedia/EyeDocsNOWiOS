//
//  PkgHeaderTableViewCell.swift
//  Nokri
//
//  Created by Furqan Nadeem on 10/23/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import UIKit

class PkgHeaderTableViewCell: UITableViewCell {

    
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var imgViewHeader: UIImageView!
    
    @IBOutlet weak var lblValueHeader: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
