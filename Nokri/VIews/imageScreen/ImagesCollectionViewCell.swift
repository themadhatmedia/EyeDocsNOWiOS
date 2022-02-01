//
//  ImagesCollectionViewCell.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 5/30/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import UIKit

class ImagesCollectionViewCell: UICollectionViewCell,UIScrollViewDelegate {
   
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        scrollView.delegate = self
        self.scrollView.minimumZoomScale = 1.0
        self.scrollView.maximumZoomScale = 5.0
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
    
}
