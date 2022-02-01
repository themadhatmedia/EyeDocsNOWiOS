//
//  MyProfileResumeVideoTableViewCell.swift
//  Nokri
//
//  Created by Apple on 16/10/2020.
//  Copyright © 2020 Furqan Nadeem. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit
import YoutubePlayer_in_WKWebView

class MyProfileResumeVideoTableViewCell: UITableViewCell {

    @IBOutlet weak var youTubePlayer: WKYTPlayerView!
    @IBOutlet weak var btnPlay: UIButton!
    
     @IBOutlet weak var lblNot: UILabel!
    @IBOutlet weak var viewCustomVid: UIView!
    @IBOutlet weak var lblNotVideo: UILabel!
    
    
    
     override func awakeFromNib() {
         super.awakeFromNib()
         // Initialization code
     }

    @IBAction func btnPlayClicked(_ sender: UIButton) {
        let vid = UserDefaults.standard.string(forKey: "vid")!
        let videoURL = URL(string: vid)
        let player = AVPlayer(url: videoURL!)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.window?.rootViewController!.present(playerViewController, animated: true) {
            playerViewController.player!.play()
        }
        
    }
    
}
