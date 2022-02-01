//
//  AttachementTableViewCell.swift
//  Nokri
//
//  Created by apple on 7/31/19.
//  Copyright © 2019 Furqan Nadeem. All rights reserved.
//

import UIKit

class AttachementTableViewCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var lblAttachement: UILabel!
    @IBOutlet weak var btnAttachement: UIButton!
    @IBOutlet weak var viewBg: UIView!
    @IBOutlet weak var btnCamera: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var appColorNew = UserDefaults.standard.string(forKey: "app_Color")
   // var imagesArray = [String]()
    var imageArray = [JobPostImageArray]()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
        collectionView.delegate = self
        collectionView.dataSource = self
        
//        viewBg.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor
//        viewBg.layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
//        viewBg.layer.shadowOpacity = 0.7
//        viewBg.layer.shadowRadius = 0.3
//        viewBg.layer.masksToBounds = false
        
        //self.viewBg.applyGradient(colours: [UIColor.groupTableViewBackground,UIColor.white])
        viewBg.backgroundColor = UIColor.groupTableViewBackground
        //self.viewBg.setGradientBackground(colorTop: .green, colorBottom: .orange)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func btnAttachmentClicked(_ sender: Any) {

    }
    
    
    //MARK:- Collection View
       
       func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           return imageArray.count
       }
       
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImagesJobPostCollectionViewCell", for: indexPath) as! ImagesJobPostCollectionViewCell
           let images = imageArray[indexPath.row]
        cell.multiImageView.sd_setImage(with: URL(string: images.value), completed: nil)
           cell.multiImageView.sd_setShowActivityIndicatorView(true)
           cell.multiImageView.sd_setIndicatorStyle(.gray)
          // cell.btnDelete.tag = Int(keyArray[indexPath.row])!
           //cell.btnDelete.addTarget(self, action:  #selector(AddPortfolioViewController.nokri_btnDeleteClicked), for: .touchUpInside)
           return cell
       }
       
//       @objc func nokri_btnDeleteClicked( _ sender: UIButton){
//           var confirmString:String?
//           var btnOk:String?
//           var btnCncel:String?
//           if let userData = UserDefaults.standard.object(forKey: "settingsData") {
//               let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
//               let dataTabs = SplashRoot(fromDictionary: objData)
//               confirmString = dataTabs.data.genericTxts.confirm
//               btnOk = dataTabs.data.genericTxts.btnConfirm
//               btnCncel = dataTabs.data.genericTxts.btnCancel
//           }
//           let alert = UIAlertController(title:confirmString, message: "", preferredStyle: .alert)
//           let okbtn = UIAlertAction(title: btnOk, style: .default) { (ok) in
//               let param : [String:Any] = [
//                   "portfolio_id":sender.tag
//               ]
//               self.nokri_portfolioDelete(parameter: param as NSDictionary)
//           }
//           let cancelbtn = UIAlertAction(title: btnCncel, style: .default) { (cancel) in
//               print("Cancel")
//           }
//           alert.addAction(okbtn)
//           alert.addAction(cancelbtn)
//           self.present(alert, animated: true, completion: nil)
//
//       }
       
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           let cellWidth = self.collectionView.bounds.width
           return CGSize(width: cellWidth/5, height: 150)
       }

//       func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
//           return true
//       }
//
//       func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
//           let temp = imagesArray.remove(at: sourceIndexPath.item)
//           imagesArray.insert(temp, at: destinationIndexPath.item)
//       }
       
    
    
}

extension UIView {
   
    func applyGradient(colours: [UIColor]) -> Void {
        self.applyGradient(colours: colours, locations: nil)
    }
    
    func applyGradient(colours: [UIColor], locations: [NSNumber]?) -> Void {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.locations = locations
        self.layer.insertSublayer(gradient, at: 0)
    }
    
    func setGradientBackground(colorTop: UIColor, colorBottom: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorBottom.cgColor, colorTop.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.locations = [0, 0]
        gradientLayer.frame = bounds
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
}
