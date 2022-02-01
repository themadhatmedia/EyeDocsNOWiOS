//
//  MyProfileVideoTableViewCell.swift
//  Nokri
//
//  Created by Furqan Nadeem on 11/16/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import UIKit
import YoutubePlayer_in_WKWebView

class MyProfileVideoTableViewCell: UITableViewCell {

   @IBOutlet weak var youTubePlayer: WKYTPlayerView!
    
    @IBOutlet weak var lblNot: UILabel!
    @IBOutlet weak var lblNotVideo: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
