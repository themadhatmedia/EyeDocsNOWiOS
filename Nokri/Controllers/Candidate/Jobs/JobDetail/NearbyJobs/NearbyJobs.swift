//
//  NearbyJobs.swift
//  Nokri
//
//  Created by Apple on 01/01/2021.
//  Copyright © 2021 Furqan Nadeem. All rights reserved.
//

import UIKit
protocol JobDetailDelegate{
    func goToJobDetail(job_id : Int)
}

class NearbyJobs: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collcetionView: UICollectionView!{
        didSet{
            collcetionView.delegate = self
            collcetionView.dataSource = self
            //            collcetionView.hori
        }
    }
    
    @IBOutlet weak var mainContainer: UIView!
    //MARK:-Properties
    var dataArray = [NearByJobsDataArray]()
    var  height :  CGFloat = 0
    var jobId : Int = 0
    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
    var delegate: JobDetailDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    //MARK:- CollectionView
    
    func reloadData() {
        collcetionView.reloadData()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NearbyByJobsCollectionViewCell", for: indexPath) as! NearbyByJobsCollectionViewCell
        //            if(indexPath.row > nearByInfoArr.count-1){
        //                return UITableViewCell()
        //            }
        let objData  = dataArray[indexPath.row]
        if let title = objData.jobTitle{
            cell.lblTitle.text = title
        }
        if let distance = objData.distance{
            cell.lblDistance.text = distance
        }
        if let  jobImg  = objData.compImage {
            if let imageUrl = URL(string: jobImg){
                cell.imgJob.sd_setImage(with: imageUrl, completed: nil)
                cell.imgJob.sd_setShowActivityIndicatorView(true)
                cell.imgJob.sd_setIndicatorStyle(.gray)
            }
        }
        jobId = objData.jobID
        cell.viewJobAction = { () in
            self.delegate?.goToJobDetail(job_id: self.dataArray[indexPath.row].jobID)
//            //            let nextViewController = self.storyBoard.instantiateViewController(withIdentifier: "JobDetailViewController") as! JobDetailViewController
//            //            nextViewController.jobIdNearBY = self.jobId
//            //            self.pushVC(nextViewController, completion: nil)
//            //present(nextViewController, animated: true, completion: nil)
//
//            //            self.navigationController?.pushViewController(nextViewController, animated: true)
//
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:collectionView.frame.width,height: 110)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
////        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NearbyByJobsCollectionViewCell", for: indexPath) as! NearbyByJobsCollectionViewCell
////
////        cell.viewJobAction = { () in
//            self.delegate?.goToJobDetail(job_id: self.dataArray[indexPath.row].jobID)
//
////        }
//    }
    
    
}


