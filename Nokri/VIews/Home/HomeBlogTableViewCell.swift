//
//  HomeBlogTableViewCell.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 5/4/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import UIKit

class HomeBlogTableViewCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var blogArr = [BlogPost]()
    var blogExrtra:BlogExtra?
    var extra:BlogExtra?
    var catId:Int?
    var message:String?
    var nextPage:Int?
    var hasNextPage:Bool?
    var catMessage = ""
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        //nokri_homeData()
        nokri_blogData()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return blogArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeBlogCollectionViewCell", for: indexPath) as! HomeBlogCollectionViewCell
     
        let obj = blogArr[indexPath.row]
        if let name = obj.title{
            //cell.lblBlogTitle.text = name
            let data = name.data(using: String.Encoding.unicode)!
            let attrStr = try? NSAttributedString(
                data: data,
                options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html],
                documentAttributes: nil)
            cell.lblBlogTitle.font = UIFont(name:"Montserrat-SemiBold",size:16)
            cell.lblBlogTitle.attributedText = attrStr
        }
        if let date = obj.date{
            cell.lblDate.text = date
        }
        if let image = URL(string: obj.image){
            cell.imageViewBlog.sd_setImage(with: image, completed: nil)
            cell.imageViewBlog.sd_setShowActivityIndicatorView(true)
            cell.imageViewBlog.sd_setIndicatorStyle(.gray)
        }
        if let comment = obj.comments{
            let stringComm = String(comment)
            print(stringComm)
            if  comment == "0" {
                cell.lblCommentCount.text = "\(String(describing: blogExrtra!.commentTitle!)) " + "\(0)"
            }else if stringComm != "0"{
                cell.lblCommentCount.text = "\(String(describing: blogExrtra!.commentTitle!)) " + " \(stringComm)"
            }
            
        }
        if let blogId = obj.postId{
            cell.btnBlogDetail.tag = blogId
        }
      
        cell.btnBlogDetail.addTarget(self, action: #selector(HomeViewController.nokri_btnBlogClicked(_:)), for: .touchUpInside)
        return cell
    }
    
    @objc func nokri_btnBlogClicked(_ sender: UIButton){
        
       
        let senderButtonTag = sender.tag
        print(senderButtonTag)
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "BlogDetailViewController") as! BlogDetailViewController
        
        nextViewController.id = senderButtonTag
        nextViewController.isFromHome = "5"
        
        
        self.window?.rootViewController?.present(nextViewController, animated: true, completion: nil)
        
        
        
        
        //self.inputViewController?.navigationController?.pushViewController(nextViewController, animated: true)
       // self.window?.rootViewController?.navigationController?.pushViewController(nextViewController, animated: true)
      
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  0
        let collectionViewSize = collectionView.frame.size.width - padding
        return CGSize(width: collectionViewSize/2 - 5 , height:250)
       // if Constants.isiPadDevice{
            //return CGSize(width: collectionViewSize/2 - 3, height:350)
        //}
        //else{
            //return CGSize(width: collectionViewSize/2 - 3, height:232)
        //}
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if collectionView.isDragging {
            cell.transform = CGAffineTransform.init(scaleX: 0.5, y: 0.5)
            UIView.animate(withDuration: 0.8, animations: {
                cell.transform = CGAffineTransform.identity
            })
        }
    }
    
    //MARK:- API Calls
    
    func nokri_blogData() {
        let param : [String:Any] = [
            "page_num":"1"
        ]
       // self.showLoader()
        UserHandler.nokri_blog(parameter: param as NSDictionary, success: { (successResponse) in
           // self.stopAnimating()
            if successResponse.success == true{
                self.blogArr = successResponse.data.post
                self.blogExrtra = successResponse.extra
                //self.title = self.extra?.pageTitle
                self.collectionView.reloadData()
            }
            else {
                //let alert = Constants.showBasicAlert(message: successResponse.message)
                //self.present(alert, animated: true, completion: nil)
                //self.stopAnimating()
            }
        }) { (error) in
            //let alert = Constants.showBasicAlert(message: error.message)
           // self.present(alert, animated: true, completion: nil)
           // self.stopAnimating()
        }
    }
    
   
    
    func nokri_tableViewHelper(){
        
        let rect = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: self.collectionView.bounds.size.width, height: self.collectionView.bounds.size.height))
        let messageLabel = UILabel(frame: rect)
        messageLabel.text = "No data to show"
        messageLabel.textColor = UIColor.lightGray
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont(name: "TrebuchetMS", size: 20)
        messageLabel.sizeToFit()
        collectionView.backgroundView = messageLabel
        
    }
    func nokri_tableViewHelper2(){
        
        let rect = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: self.collectionView.bounds.size.width, height: self.collectionView.bounds.size.height))
        let messageLabel = UILabel(frame: rect)
        messageLabel.text = ""
        messageLabel.textAlignment = .center;
        collectionView.backgroundView = messageLabel
        
    }
    
    
}



