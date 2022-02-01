//
//  DashboardCompanyHeaderTableViewCell.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 5/5/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import UIKit


class DashboardCompanyHeaderTableViewCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var imgCurve: UIImageView!
    @IBOutlet weak var imageViewDashboard: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var viewBehindCell: UIView!
    @IBOutlet weak var lblName: UILabel!
    //@IBOutlet weak var btnChangePassword: UIButton!
    @IBOutlet weak var lblLocation: UILabel!
  
     var fb:String?
     var gogle:String?
     var twit:String?
     var link:String?
     var social:DashboardSocial?
     var arrayCount = 0
     var appColorNew = UserDefaults.standard.string(forKey: "app_Color")
  
    var socilImagesArray = [UIImage]()
    var socialArr = [String]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        nokri_roundedImage()
        nokri_dashboardData()
        imgCurve.image = imgCurve.image?.withRenderingMode(.alwaysTemplate)
        imgCurve.tintColor = UIColor(hex: appColorNew!)
        
        //self.btnChangePassword.setTitleColor(UIColor(hex:appColorNew!), for: .normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    //MARK:- CollectionView
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return socilImagesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SocialIconCollectionViewCell", for: indexPath) as! SocialIconCollectionViewCell
       
        cell.imageViewSocial.image = socilImagesArray[indexPath.row]
        cell.btnSocialIcon.setTitle(socialArr[indexPath.row], for: .normal)
        cell.btnSocialIcon.addTarget(self, action: #selector(DashboardCompanyHeaderTableViewCell.nokri_btnSocialClicked(_:)), for: .touchUpInside)
        if cell.imageViewSocial.image == #imageLiteral(resourceName: "facebookCircle") {
            cell.btnSocialIcon.tag = 1
        }
        if cell.imageViewSocial.image == #imageLiteral(resourceName: "instagram") {
            cell.btnSocialIcon.tag = 2
        }
        if cell.imageViewSocial.image == #imageLiteral(resourceName: "linkedInCircle") {
            cell.btnSocialIcon.tag = 3
        }
        if cell.imageViewSocial.image == #imageLiteral(resourceName: "twitter") {
            cell.btnSocialIcon.tag = 4
        }
        
        arrayCount = socialArr.count
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let padding: CGFloat = 0
        let collectionViewSize = collectionView.frame.size.width - padding
        return CGSize(width: collectionViewSize/4, height:25)
    }
    
    @objc func nokri_btnSocialClicked(_ sender: UIButton){
    
        var inValidUrl:String = ""
        
        if let userData = UserDefaults.standard.object(forKey: "settingsData") {
            let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
            let dataTabs = SplashRoot(fromDictionary: objData)
            inValidUrl = dataTabs.data.extra.invalid_url
            
        }
        
        if sender.tag == 1{
            print("Facebook")
            if #available(iOS 10.0, *) {
                if verifyUrl(urlString: fb!) == false {
                    self.viewBehindCell.makeToast(inValidUrl)
                }else{
                    UIApplication.shared.open(URL(string: fb!)!, options: [:], completionHandler: nil)
                }
                
            } else {
                if verifyUrl(urlString: fb!) == false {
                    self.viewBehindCell.makeToast(inValidUrl)
                }else{
                UIApplication.shared.openURL(URL(string: fb!)!)
                }
            }
        }
        
        if sender.tag == 2{
            print("google")
            if #available(iOS 10.0, *) {
                if verifyUrl(urlString: gogle!) == false {
                     self.viewBehindCell.makeToast(inValidUrl, duration: 2.5, position: .center)
                }else{
                     UIApplication.shared.open(URL(string: gogle!)!, options: [:], completionHandler: nil)
                }
               
            } else {
                if verifyUrl(urlString: gogle!) == false {
                     self.viewBehindCell.makeToast(inValidUrl, duration: 2.5, position: .center)
                }else{
                UIApplication.shared.openURL(URL(string: gogle!)!)
                }
            }
        }
        
        if sender.tag == 3{
            print("linked")
            if #available(iOS 10.0, *) {
                if verifyUrl(urlString: link!) == false {
                     self.viewBehindCell.makeToast(inValidUrl, duration: 2.5, position: .center)
                }else{
                UIApplication.shared.open(URL(string: link!)!, options: [:], completionHandler: nil)
                }
            } else {
                if verifyUrl(urlString: link!) == false {
                     self.viewBehindCell.makeToast(inValidUrl, duration: 2.5, position: .center)
                }else{
                UIApplication.shared.openURL(URL(string: link!)!)
                }
            }
        }
        
        if sender.tag == 4{
            print("twitter")
            if #available(iOS 10.0, *) {
                if verifyUrl(urlString: twit!) == false {
                     self.viewBehindCell.makeToast(inValidUrl, duration: 2.5, position: .center)
                }else{
                UIApplication.shared.open(URL(string: twit!)!, options: [:], completionHandler: nil)
                }
            } else {
                if verifyUrl(urlString: twit!) == false {
                     self.viewBehindCell.makeToast(inValidUrl, duration: 2.5, position: .center)
                }else{
                    UIApplication.shared.openURL(URL(string: twit!)!)
                }
            }
        }
      
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets.zero
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let width = collectionView.bounds.width
//        return CGSize(width: width/CGFloat(socialArr.count), height: 25)
//    }
    
     func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {


        let totalCellWidth = 30 * socilImagesArray.count
        let totalSpacingWidth = 10 * (socilImagesArray.count - 1)

        
        let leftInset = (collectionView.frame.size.width - CGFloat(totalCellWidth + totalSpacingWidth)) / 4
        let rightInset = leftInset

        return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)
    }
    
    
    func verifyUrl (urlString: String?) -> Bool {
        //Check for nil
        if let urlString = urlString {
            // create NSURL instance
            if let url = NSURL(string: urlString) {
                // check if your application can open the NSURL instance
                return UIApplication.shared.canOpenURL(url as URL)
            }
        }
        return false
    }
    
//    @IBAction func btnChangePasswordClicked(_ sender: UIButton) {
//        let controller = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ChangePasswordViewController") as! ChangePasswordViewController
//        controller.modalPresentationStyle = .overCurrentContext
//        controller.modalTransitionStyle = .flipHorizontal
//        self.window?.rootViewController?.present(controller, animated: true, completion: nil)
//    }
    
    
    //MARK:- Image Round
    
    func nokri_roundedImage(){
        imageViewDashboard.layer.borderWidth = 2.8
        imageViewDashboard.layer.masksToBounds = false
        imageViewDashboard.layer.borderColor = UIColor(hex:appColorNew!).cgColor
        imageViewDashboard.layer.cornerRadius = imageViewDashboard.frame.height/2
        imageViewDashboard.clipsToBounds = true
    }
    
    func nokri_populateData(){
        
        if let fb = self.fb{
            if fb != ""{
                 socialArr.append(fb)
                 socilImagesArray.append(#imageLiteral(resourceName: "facebookCircle"))
            }
        }
        if let googl = self.gogle{
            if googl != ""{
                socialArr.append(googl)
                socilImagesArray.append(#imageLiteral(resourceName: "instagram"))
            }
        }
        if let linkedIn = self.link{
            if linkedIn != ""{
                 socialArr.append(linkedIn)
                socilImagesArray.append(#imageLiteral(resourceName: "linkedInCircle"))
            }
        }
        if let twit = self.twit{
            if twit != ""{
                socialArr.append(twit)
                socilImagesArray.append(#imageLiteral(resourceName: "twitter"))
            }
        }
        print(socialArr.count)
    }
    
    func nokri_dashboardData() {
    
        UserHandler.nokri_dashboardCompany(success: { (successResponse) in
            if successResponse.success {
                self.fb = successResponse.data.social.facebook
                self.gogle = successResponse.data.social.googlePlus
                self.twit = successResponse.data.social.twitter
                self.link = successResponse.data.social.linkedin
                self.nokri_populateData()
                self.collectionView.reloadData()
            }
            else {
                let alert = Constants.showBasicAlert(message: successResponse.message)
                self.window?.rootViewController?.present(alert, animated: true, completion: nil)
            }
        }) { (error) in
            let alert = Constants.showBasicAlert(message: error.message)
            self.window?.rootViewController?.present(alert, animated: true, completion: nil)
        }
    }
}
