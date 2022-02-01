//
//  Faq'sViewController.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 4/25/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import UIKit

class Faq_sViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    //MARK:- IBOutlets
    
    @IBOutlet weak var tableView: UITableView!

    //MARK:- Proporties
    
    var appColorNew = UserDefaults.standard.string(forKey: "app_Color")
    var aboutCellHeight : CGFloat = 0.0;
    
    struct Section {
        var name: String!
        var items: [String]!
        var collapsed: Bool!
        init(name: String, items: [String], collapsed: Bool = true) {
            self.name = name
            self.items = items
            self.collapsed = collapsed
        }
    }
    var sections = [Section]()
    var dataArray = [FaqData]()
    
    //MARK:- View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        nokri_faqData()
        self.addLeftBarButtonWithImage(#imageLiteral(resourceName: "menu"))
        if let userData = UserDefaults.standard.object(forKey: "settingsData") {
            let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
            let dataTabs = SplashRoot(fromDictionary: objData)
            let obj = dataTabs.data.guestTabs
            self.title = obj?.faq
        }
    }

    //MARK:- Custome Functions
    
  func nokri_ltrRtl(){
        let isRtl = UserDefaults.standard.string(forKey: "isRtl")
        if isRtl == "0"{
            self.addLeftBarButtonWithImage(#imageLiteral(resourceName: "menu"))
        }else{
            self.addRightBarButtonWithImage(#imageLiteral(resourceName: "menu"))
        }
    }

    func nokri_populateData(){
        for obj in dataArray{
            print("obje \(obj)")
            let oneSection = Section(name:obj.title , items: [obj.descriptionField]);
            self.sections.append(oneSection);
        }
    }
    
    //MARK:- TableView
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:  return ""
        default: return ""
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = sections.count
        for section in sections {
            count += section.items.count
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        self.tableView.estimatedRowHeight = 120.0;
        let section = nokri_getSectionIndex(indexPath.row)
        let row = nokri_getRowIndex(indexPath.row)
        if row == 0 {
            return 70.0
        }

        return sections[section].collapsed! ? 0 : UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let section = nokri_getSectionIndex(indexPath.row)
        let row = nokri_getRowIndex(indexPath.row)
        let isRtl = UserDefaults.standard.string(forKey: "isRtl")
        
        if row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Faq_sExpandableTableViewCell") as! Faq_sExpandableTableViewCell
            
            cell.lblTitle.text = sections[section].name
            cell.btnExpand.tag = section
            cell.btnExpand.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
            cell.btnExpand.setTitle(sections[section].collapsed! ? "+" : "-", for: UIControl.State())
            if isRtl == "1"{
                cell.btnExpand.contentHorizontalAlignment = .left
            }else{
                 cell.btnExpand.contentHorizontalAlignment = .right
            }
            cell.btnExpand.addTarget(self, action: #selector(Faq_sViewController.nokri_toggleCollapse), for: .touchUpInside)
            if sections[section].collapsed {
                cell.viewBehindExpand.backgroundColor = UIColor(hex:"EFEFF4")
                cell.lblTitle.textColor = UIColor.black
                cell.btnExpand.setTitleColor(UIColor.black, for: .normal)
            }else{
                cell.viewBehindExpand.backgroundColor = UIColor(hex:appColorNew!)
                cell.lblTitle.textColor = UIColor.white
                cell.btnExpand.setTitleColor(UIColor.white, for: .normal)
            }
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Faq_sExpandedTableViewCell") as? Faq_sExpandedTableViewCell
            if isRtl == "1"{
                cell?.lblDetail.textAlignment = .right
            }else{
                cell?.lblDetail.textAlignment = .left
            }
            cell?.lblDetail?.font = UIFont(name:"OpenSans",size:15)
            cell?.lblDetail?.text = sections[section].items[row - 1]
            self.aboutCellHeight = (cell?.lblDetail.attributedText?.height(withConstrainedWidth: self.view.frame.size.width))!+32;
            
            return cell!
        }
    }
    
    // MARK: - Event Handlers
    //
    @objc func nokri_toggleCollapse(_ sender: UIButton) {
        let section = sender.tag
        let collapsed = sections[section].collapsed
        sections[section].collapsed = !collapsed!
        let indices = nokri_getHeaderIndices()
        let start = indices[section]
        let end = start + sections[section].items.count
        tableView.beginUpdates()
        for i in start ..< end + 1 {
            tableView.reloadRows(at: [IndexPath(row: i, section: 0)], with: .automatic)
        }
        tableView.endUpdates()
    }
    
    // MARK: - Helper Functions
    
    func nokri_getSectionIndex(_ row: NSInteger) -> Int {
        let indices = nokri_getHeaderIndices()
        
        for i in 0..<indices.count {
            if i == indices.count - 1 || row < indices[i + 1] {
                return i
            }
        }
        
        return -1
    }
    
    func nokri_getRowIndex(_ row: NSInteger) -> Int {
        var index = row
        let indices = nokri_getHeaderIndices()
        
        for i in 0..<indices.count {
            if i == indices.count - 1 || row < indices[i + 1] {
                index -= indices[i]
                break
            }
        }
        return index
    }
    
    func nokri_getHeaderIndices() -> [Int] {
        var index = 0
        var indices: [Int] = []
        
        for section in sections {
            indices.append(index)
            index += section.items.count + 1
        }
        return indices
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if tableView.isDragging {
            cell.transform = CGAffineTransform.init(scaleX: 0.5, y: 0.5)
            UIView.animate(withDuration: 0.3, animations: {
                cell.transform = CGAffineTransform.identity
            })
        }
    }

    //MARK:- API Calls
    
    func nokri_faqData() {
        
        self.showLoader()
        UserHandler.nokri_faqData(success: { (successResponse) in
            self.stopAnimating()
            if successResponse.success {
            self.dataArray = successResponse.data
            self.nokri_populateData()
            self.tableView.reloadData()
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
