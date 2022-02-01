//
//  BlogDetailViewController.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 4/24/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import UIKit
import TextFieldEffects
import JGProgressHUD

class BlogDetailViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,tableHightDelegate {
  
   
    var tableHeight:Bool = false
    var appColorNew = UserDefaults.standard.string(forKey: "app_Color")
    
    func tableHeightReturn(height: Bool) {
        tableHeight = height
    }
    
    //MARK:- IBOutlets
    
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewBlogDetail: UIImageView!
    @IBOutlet weak var lblWeb: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblSkill: UILabel!
    @IBOutlet weak var lblCommentKey: UILabel!
    @IBOutlet weak var lblCommentValue: UILabel!
    @IBOutlet weak var txtCommentField: UITextField!
    @IBOutlet weak var btnPublish: UIButton!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblCommentCount: UILabel!
    @IBOutlet weak var fullView: UIView!
    @IBOutlet weak var topContraintToWeb: NSLayoutConstraint!
    @IBOutlet weak var lblWebTitle: UILabel!
    @IBOutlet weak var heightConstrainFullView: NSLayoutConstraint!
    @IBOutlet weak var heightConstraintTableView: NSLayoutConstraint!
    @IBOutlet weak var lblComme: UILabel!
    @IBOutlet weak var heightConstraintView: NSLayoutConstraint!
    @IBOutlet weak var lblHeaderTitle: UILabel!
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var heighConstraintImage: NSLayoutConstraint!
    //MARK:- Proporties
    
    var id:Int?
    var post:BlogDetailPost?
    var extra : BlogDetailExtra?
    var commentArray = [CommentBlogDetail]()
    var replyArray = [ReplyBlogDetail]()
    var hasChild:Bool = false
    var message:String?
    var isFromHome = "0"
    var titleIs = ""
    
    //MARK:- View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        blogData()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        nokri_customeButton()
        self.showBackButton()
        if isFromHome == "5"{
            topConstraint.constant = 45
             btnBack.isHidden = false
             viewHeader.isHidden = false
        }else{
            btnBack.isHidden = true
            topConstraint.constant = 0
            viewHeader.isHidden = true
        }
        viewHeader.backgroundColor = UIColor(hex: appColorNew!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if tableHeight == true{
              blogData()
        }
    }
    
    //MARK:- IBActions
    
    @IBAction func txtCommentClicked(_ sender: UITextField) {
       //txtCommentField.borderActiveColor = UIColor(hex: appColorNew!)
    }
    
    @IBAction func btnCloseClicked(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnPublishClicked(_ sender: UIButton) {
        print("Clicked..!")
        
        let withOutLogin = UserDefaults.standard.integer(forKey: "aType")
        if withOutLogin == 5{
            let hud = JGProgressHUD(style: .dark)
            hud.textLabel.text = extra?.publish.msg
            hud.detailTextLabel.text = nil
            hud.indicatorView = JGProgressHUDSuccessIndicatorView()
            hud.position = .bottomCenter
            hud.show(in: self.view)
            hud.dismiss(afterDelay: 2.0)
        }else{
            if txtCommentField.text == ""{
            
                if let userData = UserDefaults.standard.object(forKey: "settingsData") {
                    let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
                    let dataTabs = SplashRoot(fromDictionary: objData)
       
                let Alert = UIAlertController(title: "Alert", message:dataTabs.data.extra.comment, preferredStyle: .alert)
                let okButton = UIAlertAction(title: "ok", style: .default) { _ in
                   
                }
                Alert.addAction(okButton)
                self.present(Alert, animated: true, completion: nil)
            }
            }else{
                 nokri_blogComment()
            }
        }
    }
    
    //MARK:- Table View
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentTableViewCell", for: indexPath) as! CommentTableViewCell
        let objComment = commentArray[indexPath.row]
        if objComment.canReply == false{
            cell.btnReply.isHidden = true
            cell.leftConstraintImageView.constant += 10
            if let url = objComment.img{
                cell.imageCommentView.sd_setImage(with: URL(string: url), completed: nil)
                cell.imageCommentView.sd_setShowActivityIndicatorView(true)
                cell.imageCommentView.sd_setIndicatorStyle(.gray)
            }
            if let comentAuthor = objComment.commentAuthor{
                cell.lblTitleName.text = comentAuthor
            }
            if let comentDesc = objComment.commentContent{
                cell.lblCommentDesc.text = comentDesc
            }
            if let comentTime = objComment.commentDate{
                cell.lblTimeAgo.text = comentTime
            }
            if let replyBtnText = objComment.replyBtnText{
                cell.btnReply.setTitle(replyBtnText, for: .normal)
            }
        }else{
            cell.btnReply.isHidden = false
            cell.leftConstraintImageView.constant = 0
            if let url = objComment.img{
                cell.imageCommentView.sd_setImage(with: URL(string: url), completed: nil)
                cell.imageCommentView.sd_setShowActivityIndicatorView(true)
                cell.imageCommentView.sd_setIndicatorStyle(.gray)
            }
            if let comentAuthor = objComment.commentAuthor{
                cell.lblTitleName.text = comentAuthor
            }
            if let comentDesc = objComment.commentContent{
                cell.lblCommentDesc.text = comentDesc
            }
            if let comentTime = objComment.commentDate{
                cell.lblTimeAgo.text = comentTime
            }
            if let replyBtnText = objComment.replyBtnText{
                cell.btnReply.setTitle(replyBtnText, for: .normal)
            }
            if let comentId = objComment.commentId{
                cell.btnReply.tag =  Int(comentId)!
            }
        }
        cell.btnReply.addTarget(self, action: #selector(BlogDetailViewController.nokri_btnReplyClicked(_:)), for: .touchUpInside)
        cell.btnReply.backgroundColor = UIColor(hex: appColorNew!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if tableView.isDragging {
            cell.transform = CGAffineTransform.init(scaleX: 0.5, y: 0.5)
            UIView.animate(withDuration: 0.6, animations: {
                cell.transform = CGAffineTransform.identity
            })
        }
    }
    
    @objc func nokri_btnReplyClicked(_ sender: UIButton){
        let senderButtonTag = sender.tag
        print(senderButtonTag)
        let withOutLogin = UserDefaults.standard.integer(forKey: "aType")
        if withOutLogin == 5{
            let hud = JGProgressHUD(style: .dark)
            hud.textLabel.text = extra?.publish.msg
            hud.detailTextLabel.text = nil
            hud.indicatorView = JGProgressHUDSuccessIndicatorView()
            hud.position = .bottomCenter
            hud.show(in: self.view)
            hud.dismiss(afterDelay: 2.0)
        }else{
            let controller = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ReplyAlertViewController") as! ReplyAlertViewController
            controller.modalPresentationStyle = .overCurrentContext
            controller.modalTransitionStyle = .flipHorizontal
            controller.commentiD = senderButtonTag
            controller.postId = id
            controller.blogExtra = extra
            controller.delegate = self
            self.present(controller, animated: true, completion: nil)
        }
    }
    
    //MARK:- Custome Functions
    
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
        
    func nokri_customeButton(){
        btnPublish.layer.cornerRadius = 15
        btnPublish.backgroundColor = UIColor(hex: appColorNew!)
    }
    
    func nokri_populateData(){
        if let image = URL(string: (post?.image)!){
            self.imageViewBlogDetail.sd_setImage(with: image, completed: nil)
            imageViewBlogDetail.sd_setShowActivityIndicatorView(true)
            imageViewBlogDetail.sd_setIndicatorStyle(.gray)
           
            if Constants.isiPadDevice {
                heightConstraintView.constant += 130
                heighConstraintImage.constant += 130
            }
        }
        if let date = post?.date{
            self.lblDate.text = date
        }
        if let commentCount = post?.commentCount{
            self.lblCommentCount.text = " (\(commentCount))"
            self.lblComme.text = "Comments \(commentCount)"
            self.lblCommentCount.textColor = UIColor(hex: appColorNew!)
        }
        
        if let pageTitle = extra?.pageTitle{
            self.title = pageTitle
            lblHeaderTitle.text = pageTitle
        }
        
        if let WebTitle = post?.title{
            
            let strokeTextAttributes: [NSAttributedString.Key: Any] = [
                .foregroundColor : UIColor.black,
                .font : UIFont(name:"Montserrat-SemiBold",size:14)!
            ]
            let data = WebTitle.data(using: String.Encoding.unicode)!
            let attrStr = try? NSAttributedString(
                data: data,
                options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html],
                documentAttributes: nil)
              lblWebTitle.attributedText = NSMutableAttributedString(string: (attrStr?.string)!, attributes: strokeTextAttributes)
        }
        
        if let messageNoComment = post?.commentMesage{
            message = messageNoComment
        }
        
        if let webData = post?.desc{
        
            let strokeTextAttributes: [NSAttributedString.Key: Any] = [
                .foregroundColor : UIColor.gray,
                .font : UIFont(name:"Open Sans",size:13)!
            ]
            let data = webData.data(using: String.Encoding.unicode)!
            let attrStr = try? NSAttributedString(
                data: data,
                options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html],
                documentAttributes: nil)
            
            lblWeb.attributedText = NSMutableAttributedString(string: (attrStr?.string)!, attributes: strokeTextAttributes)
            
            let height = (lblWeb.attributedText?.height(withConstrainedWidth: self.view.frame.size.width))!;
            lblWeb.frame.size.height
                = height
            heightConstrainFullView.constant += height
            self.view.layoutIfNeeded()

        }
        
        if let comment = extra?.commentTitle{
            lblCommentKey.text = comment
        }
        if let postComment = extra?.commentForm.title{
            txtCommentField.placeholder = postComment
        }
        if let btnPub = extra?.publish.btn{
            btnPublish.setTitle(btnPub, for: .normal)
        }
        var tagString = [String]()
        if let objTags = post?.tags{
            for obj in objTags{
                tagString.append(obj.name)
            }
        }
        print(tagString)
        lblSkill.text = tagString.joined(separator: ",")
        if self.commentArray.count == 0{
            self.heightConstraintTableView.constant = 30
            self.heightConstrainFullView.constant -= 100
            self.nokri_tableViewHelper()
        }else{
            self.nokri_tableViewHelper2()
            self.heightConstraintTableView.constant = self.tableView.contentSize.height
            
        }
    }
    
    //MARK:- Blog
    
    func blogData() {
        let param : [String:Any] = [
            "post_id":id!
        ]
        self.showLoader()
        UserHandler.nokri_blogDetail(parameter: param as NSDictionary, success: { (successResponse) in
            self.stopAnimating()
            if successResponse.success == true{
                self.post = successResponse.data.post
                self.extra = successResponse.extra
                if successResponse.data.post.comments != nil{
                    for obj in successResponse.data.post.comments.comments{
                        print(obj)
                        self.commentArray.append(obj)
                        if obj.hasChilds == true{
                            for obj2 in obj.reply{
                                print(obj2)
                                self.commentArray.append(obj2)
                                self.hasChild = true
                            }
                        }
                    }
                }
                self.nokri_populateData()
                self.tableView.reloadData()
                self.heightConstraintTableView.constant = self.tableView.contentSize.height + 120
                let height = self.tableView.contentSize.height + 120
                self.heightConstrainFullView.constant += height
            }
            else {
                let alert = Constants.showBasicAlert(message: successResponse.message)
                self.present(alert, animated: true, completion: nil)
                self.stopAnimating()
            }
        }) { (error) in
            let alert = Constants.showBasicAlert(message: error.message)
            self.present(alert, animated: true, completion: nil)
            self.stopAnimating()
        }
    }
    
    func nokri_blogComment() {
        let param : [String:Any] = [
            "post_id":id!,
            "message":txtCommentField.text!
        ]
        self.showLoader()
        UserHandler.nokri_blogComment(parameter: param as NSDictionary, success: { (successResponse) in
            self.stopAnimating()
            if successResponse.success == true{
                let hud = JGProgressHUD(style: .dark)
                hud.textLabel.text = successResponse.message!
                hud.detailTextLabel.text = nil
                hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                hud.position = .bottomCenter
                hud.show(in: self.view)
                hud.dismiss(afterDelay: 2.0)
                self.heightConstraintTableView.constant += 80
                self.tableView.reloadData()
                self.blogData()
            }
            else {
                let alert = Constants.showBasicAlert(message: successResponse.message)
                self.present(alert, animated: true, completion: nil)
                self.stopAnimating()
            }
        }) { (error) in
            let alert = Constants.showBasicAlert(message: error.message)
            self.present(alert, animated: true, completion: nil)
            self.stopAnimating()
        }
    }
}




