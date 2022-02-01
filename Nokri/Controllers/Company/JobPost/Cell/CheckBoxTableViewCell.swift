//
//  CheckBoxTableViewCell.swift
//  Nokri
//
//  Created by apple on 7/31/19.
//  Copyright © 2019 Furqan Nadeem. All rights reserved.
//

import UIKit
import SwiftCheckboxDialog

protocol radioBoxValues {
     func radioValues(value: String,indexPath: Int, fieldType:String, section: Int,fieldName:String,isShow:Bool)
}

class CheckBoxTableViewCell: UITableViewCell,CheckboxDialogViewDelegate,UITableViewDelegate,UITableViewDataSource {
   
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblKey: UILabel!
    @IBOutlet weak var btnCheckBox: UIButton!
    @IBOutlet weak var lblRadVal: UILabel!
    @IBOutlet weak var heightConstraintRadioTable: NSLayoutConstraint!
    
    var checkboxDialogViewController: CheckboxDialogViewController!
    typealias TranslationTuple = (name: String, translated: String)
    typealias TranslationDictionary = [String : String]
    var skillArray = [JobPostCustomeValues]()
    
    var skilKeyArr = [String]()
    var delegate:radioBoxValues?
    var indexP = 0
    var section = 0
    var fieldName = ""
    var isfromEdit = true
    var skilBoolArr = [String]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        print(skillArray)
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    @IBAction func btnCheckBoxClicked(_ sender: Any) {
        multiCheckboxData()
    }
    
    func multiCheckboxData(){
        
        //var tableData :[(name: String, translated: String)]?
        //var jobSkillArr = [String]()
        var jobData = [(name: String, translated: String)]();
        let jobSkill = self.skillArray
        
        for itemDict in jobSkill {
            if let jobSkillObj = itemDict.value{
                //jobData.append((name: jobSkillObj, translated: jobSkillObj))
                if let jobskey = itemDict.name{
                    jobData.append((name: "\(jobskey)", translated: jobSkillObj))
                }
            }
        }
        print (jobData)
      
        if let userData = UserDefaults.standard.object(forKey: "settingsData") {
            let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
            let dataTabs = SplashRoot(fromDictionary: objData)
            self.checkboxDialogViewController.titleDialog = dataTabs.data.extra.skillT
        }
                   
        self.checkboxDialogViewController = CheckboxDialogViewController()
        //self.checkboxDialogViewController.titleDialog = "Skills"
        self.checkboxDialogViewController.tableData = jobData
        self.checkboxDialogViewController.componentName = DialogCheckboxViewEnum.countries
        self.checkboxDialogViewController.delegateDialogTableView = self
        self.checkboxDialogViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
       // self.present(self.checkboxDialogViewController, animated: false, completion: nil)
        self.window?.rootViewController?.present(self.checkboxDialogViewController, animated: true, completion: nil)
    }
    
    
    func onCheckboxPickerValueChange(_ component: DialogCheckboxViewEnum, values: TranslationDictionary) {
        var allselectedString : String = "";
        print(values.keys)
        for value in values.keys {
            print("\(value)");
            skilKeyArr.append(value)
            self.btnCheckBox.setTitle(value, for: .normal)
        }
        for value in values.values {
            print("\(value)");
            allselectedString += "\(value),"
        }
        if allselectedString != ""{
            self.btnCheckBox.setTitle(allselectedString, for: .normal)
        }
        print(allselectedString)
        //delegate?.checkValues(valueName: allselectedString, value: allselectedString, indexPath: indexP, fieldType: "checkbox", section: section, fieldName: fieldName, isShow: true)
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        skillArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RadioButtonTableViewCell", for: indexPath) as! RadioButtonTableViewCell
        cell.lblRadio.text = skillArray[indexPath.row].name
        cell.imgRadio.image = UIImage(named: "dot")
        
        if isfromEdit == true{
            if skillArray[indexPath.row].selected == true{
                cell.imgRadio.image = UIImage(named: "radio")
                delegate?.radioValues(value:cell.lblRadio.text!, indexPath: indexP, fieldType: "checkbox", section: section, fieldName: fieldName, isShow: true)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Select..")
        let indexPath = IndexPath(row: indexPath.row, section: 0)
        let cell = tableView.cellForRow(at: indexPath) as! RadioButtonTableViewCell
        cell.imgRadio.image = UIImage(named: "radio")
        delegate?.radioValues(value:cell.lblRadio.text!, indexPath: indexP, fieldType: "checkbox", section: section, fieldName: fieldName, isShow: true)
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        print("DeSelect..")
        let indexPath = IndexPath(row: indexPath.row, section: 0)
        let cell = tableView.cellForRow(at: indexPath) as! RadioButtonTableViewCell
        cell.imgRadio.image = UIImage(named: "dot")
    }
}
