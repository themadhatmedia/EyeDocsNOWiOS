//
//  PackageDetailViewController.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 4/18/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import UIKit
import Alamofire

class PackageDetailViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    //MARK:- IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableVieHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var lblSerialKey: UILabel!
    @IBOutlet weak var lblTitleKey: UILabel!
    @IBOutlet weak var lblDetailKey: UILabel!
    @IBOutlet weak var lblPackageExp: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblPackage: UILabel!
    @IBOutlet weak var viewTop: UIView!
    
    
    //MARK:- Proporties
    
    var message:String?
    var infoDict:PackageDetailInfo?
    var resumesDict:PackageDetailResumes?
    var packagegArr = [PackageDetailPackage]()
    var packagegArrBumpUp = [PackageDetailPackage]()

    var data:PackageDetailData?
    var titleKeyArr = [String]()
    var detailArr = [String]()
    var appColorNew = UserDefaults.standard.string(forKey: "app_Color")
    //var message:String?
    
    //MARK:- View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        //nokri_packageDetail()
        showSearchButton()
        let isRtl = UserDefaults.standard.string(forKey: "isRtl")
        if isRtl == "0"{
            self.addLeftBarButtonWithImage(#imageLiteral(resourceName: "menu"))
        }else{
            self.addRightBarButtonWithImage(#imageLiteral(resourceName: "menu"))
        }
        self.viewTop.backgroundColor = UIColor(hex: appColorNew!)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableVieHeightConstraint.constant = tableView.contentSize.height
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
       
        nokri_packageDetail()
        
    }
  

    //MARK:- Table View
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleKeyArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PackageDetailTableViewCell", for: indexPath) as! PackageDetailTableViewCell
//        let pkjArr = packagegArr[indexPath.row]
//        cell.lblTitleValue.text = pkjArr.name
//        cell.lblDetailValue.text = pkjArr.noOfJobs
        cell.lblTitleValue.text = titleKeyArr[indexPath.row]
        cell.lblDetailValue.text = detailArr[indexPath.row]
        cell.lblSerialValue.text = String(indexPath.row + 1)
       
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if tableView.isDragging {
            cell.transform = CGAffineTransform.init(scaleX: 0.5, y: 0.5)
            UIView.animate(withDuration: 0.3, animations: {
                cell.transform = CGAffineTransform.identity
            })
        }
    }
    
    //MARK:- Custome Functions
    
    func nokri_populateData(){
        
        guard let name = infoDict?.name else {
            return
        }
        guard let serialKey = infoDict?.number else {
            return
        }
        guard let detail = infoDict?.details else {
            return
        }
        guard let pkgExp = infoDict?.expiry else {
            return
        }
        guard let dateExp = data?.expiry else {
            return
        }
        guard let pageTitle = data?.pageTitle else {
            return
        }
        
        self.lblTitleKey.text = name
        self.lblSerialKey.text = serialKey
        self.lblDetailKey.text = detail
        self.lblPackageExp.text = pkgExp
        self.lblDate.text = dateExp
        self.title = pageTitle
        self.lblPackage.text = pageTitle
        if packagegArr.count == 0{
            nokri_tableViewHelper()
        }else{
            nokri_tableViewHelper2()
        }
        print("\(self.packagegArr.count)")
    }
    
    func nokri_tableViewHelper(){
        
        let rect = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: self.view.bounds.size.width, height: self.view.bounds.size.height))
        let messageLabel = UILabel(frame: rect)
        messageLabel.text = self.message
        messageLabel.textColor = UIColor.lightGray
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont(name: "TrebuchetMS", size: 20)
        messageLabel.sizeToFit()
        tableView.backgroundView = messageLabel
        
    }
    func nokri_tableViewHelper2(){
        
        let rect = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: self.view.bounds.size.width, height: self.view.bounds.size.height))
        let messageLabel = UILabel(frame: rect)
        messageLabel.text = ""
        messageLabel.textAlignment = .center;
        tableView.backgroundView = messageLabel
        
    }
    
    //MARK:- API Calls

    func nokri_packageDetail() {
        
        self.showLoader()
        UserHandler.nokri_packageDetail(success: { (successResponse) in
            self.stopAnimating()
            if successResponse.success {
                self.infoDict = successResponse.data.info
                self.packagegArr = successResponse.data.packages
                self.packagegArrBumpUp = successResponse.data.packagesBumpUp
                
                self.resumesDict = successResponse.data.resumes
                for obj in self.packagegArrBumpUp{
                    self.titleKeyArr.append(obj.name)
                    self.detailArr.append(obj.noOfJobs)
                }
                for obj in self.packagegArr{
                    self.titleKeyArr.append(obj.name)
                    self.detailArr.append(obj.noOfJobs)
                }
                if successResponse.data.resumes.isRequired == true{
                    self.titleKeyArr.append(successResponse.data.resumes.title)
                    self.detailArr.append(successResponse.data.resumes.nos)
                }
                self.data = successResponse.data
                self.message = successResponse.message
                self.nokri_populateData()
                self.tableView.reloadData()
            }
            else {
                let alert = Constants.showBasicAlert(message: successResponse.message)
                self.present(alert, animated: true, completion: nil)
            }
        }) { (error) in
            let alert = Constants.showBasicAlert(message: error.message)
            self.present(alert, animated: true, completion: nil)
            self.stopAnimating()
        }
        
    }
    
    
}
