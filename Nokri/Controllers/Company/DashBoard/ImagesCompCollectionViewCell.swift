//
//  ImagesCollectionViewCell.swift
//  Nokri
//
//  Created by apple on 4/9/20.
//  Copyright © 2020 Furqan Nadeem. All rights reserved.
//

import UIKit

class ImagesCompCollectionViewCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    var dataArray = [String]()
    var delegate:imagesDelegate?
    var notPortfo:String?
    var datImgArr = [DashboardExtra]()
    @IBOutlet weak var lblPortfolio: UILabel!
  
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.delegate = self
        collectionView.dataSource = self
        if dataArray.count == 0{
            nokri_tableViewHelper()
        }else{
            nokri_tableViewHelper2()
        }
      
    }

    //MARK:- Collection View
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  datImgArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyPortfolioCollectionViewCell", for: indexPath) as! MyPortfolioCollectionViewCell
        if let url = URL(string: datImgArr[indexPath.row].value){
            cell.imgView.sd_setImage(with: url, completed: nil)
            cell.imgView.sd_setShowActivityIndicatorView(true)
            cell.imgView.sd_setIndicatorStyle(.gray)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellWidth = self.collectionView.bounds.width
        return CGSize(width: cellWidth/6, height: 75)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedIndex = indexPath.row
        
        self.delegate?.nokri_images(img: [dataArray[selectedIndex]] + dataArray)
    }

    func nokri_tableViewHelper(){
        let rect = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 200, height: 200))
        let messageLabel = UILabel(frame: rect)
        messageLabel.text = self.notPortfo
        messageLabel.textColor = UIColor.lightGray
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont(name: "TrebuchetMS", size: 20)
        messageLabel.sizeToFit()
        collectionView.backgroundView = messageLabel
    }
    func nokri_tableViewHelper2(){
        let rect = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 200, height: 200))
        let messageLabel = UILabel(frame: rect)
        messageLabel.text = ""
        messageLabel.textAlignment = .center;
        collectionView.backgroundView = messageLabel
    }
    
}

