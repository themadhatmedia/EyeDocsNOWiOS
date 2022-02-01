//
//  RegisterRadioTableViewCell.swift
//  Nokri
//
//  Created by apple on 2/20/20.
//  Copyright © 2020 Furqan Nadeem. All rights reserved.
//

import UIKit

protocol registerradioBoxValues {
     func registerradioValues(value: String,indexPath: Int, fieldType:String, section: Int,fieldName:String,isShow:Bool)
}

class RegisterRadioTableViewCell: UITableViewCell,UITableViewDelegate,UITableViewDataSource  {
    
    

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var heightConstraintRadioTable: NSLayoutConstraint!
    
    var skilKeyArr = [String]()
    var delegate:registerradioBoxValues?
    var indexP = 0
    var section = 0
    var fieldName = ""
    var isfromEdit = true
    var skilBoolArr = [String]()
    var fieldsArray = [JobPostCCustomData]()
    var selectedArr = [Bool]()
    var isFromRegister = true
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        tableView.delegate = self
        tableView.dataSource = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return skilKeyArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isFromRegister == false{
        let selectarrbool = selectedArr[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "RegisterSubRadioTableViewCell", for: indexPath) as! RegisterSubRadioTableViewCell
        cell.lblRadio.text = skilKeyArr[indexPath.row]
            if selectarrbool == true{
                cell.imgRadio.image = UIImage(named: "radio")
                delegate?.registerradioValues(value:cell.lblRadio.text!, indexPath: indexP, fieldType: "checkbox", section: section, fieldName: fieldName, isShow: true)
            }else{
                cell.imgRadio.image = UIImage(named: "dot")
            }
            return cell
            
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "RegisterSubRadioTableViewCell", for: indexPath) as! RegisterSubRadioTableViewCell
            cell.lblRadio.text = skilKeyArr[indexPath.row]
            cell.imgRadio.image = UIImage(named: "dot")
            return cell
        }
        
    }
      
      func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          print("Select..")
          let indexPath = IndexPath(row: indexPath.row, section: 0)
          let cell = tableView.cellForRow(at: indexPath) as! RegisterSubRadioTableViewCell
          cell.imgRadio.image = UIImage(named: "radio")
          delegate?.registerradioValues(value:cell.lblRadio.text!, indexPath: indexP, fieldType: "checkbox", section: section, fieldName: fieldName, isShow: true)
      }
      
      func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
          print("DeSelect..")
          let indexPath = IndexPath(row: indexPath.row, section: 0)
          let cell = tableView.cellForRow(at: indexPath) as! RegisterSubRadioTableViewCell
          cell.imgRadio.image = UIImage(named: "dot")
      }

}

