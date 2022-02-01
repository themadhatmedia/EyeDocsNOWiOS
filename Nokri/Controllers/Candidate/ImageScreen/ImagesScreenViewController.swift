//
//  ImagesScreenViewController.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 5/30/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import UIKit

class ImagesScreenViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
   
    //MARK:- IBOutlets
    
    @IBOutlet weak var collectionView: UICollectionView!

    //MARK:- Proporties
    
    var imagesArray = [String]()
  
    //MARK:- View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    //MARK:- CollectionView
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return imagesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImagesCollectionViewCell", for: indexPath) as! ImagesCollectionViewCell
        
        if let url = URL(string: imagesArray[indexPath.section]){
           cell.imageView.sd_setImage(with: url, completed: nil)
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellWidth = self.collectionView.bounds.width
        return CGSize(width: cellWidth, height: 545)
        
    }
    
    @IBAction func btnClosedClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
