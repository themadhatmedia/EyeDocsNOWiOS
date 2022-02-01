//
//  CoverLetterViewController.swift
//  Nokri
//
//  Created by Furqan Nadeem on 10/01/2019.
//  Copyright © 2019 Furqan Nadeem. All rights reserved.
//

import UIKit

class CoverLetterViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    ///Mark:- IBOutlets
    
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var lblTitleCoverLetter: UILabel!
    @IBOutlet weak var lblDetailCoverLetter: UILabel!
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var btnFullClose: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    
    // Mark:- Proporties
    
    var appColorNew = UserDefaults.standard.string(forKey: "app_Color")
    var titleCover:String = ""
    var valueCoverLetter:String = ""
    var questionArr = [String]()
    var answersArr = [String]()
    
    //Mark:- View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblTitleCoverLetter.text = titleCover
        lblDetailCoverLetter.text = valueCoverLetter
        viewHeader.backgroundColor = UIColor(hex: appColorNew!)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    //Mark:- IBActions
    
    @IBAction func btnCloseCliced(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnFullCloseClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK:- TableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CoverLetterTableViewCell", for: indexPath) as! CoverLetterTableViewCell
        
        let ques = questionArr[indexPath.row]
        let ans = answersArr[indexPath.row]
        
        cell.lblQuestion.text = "Question: " + "\(ques)"
        cell.lblAnswer.text = "Answer:: " + "\(ans)"
        
        
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 100
        
    }
    
}
