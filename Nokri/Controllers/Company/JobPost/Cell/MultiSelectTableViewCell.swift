//
//  MultiSelectTableViewCell.swift
//  Nokri
//
//  Created by apple on 7/31/19.
//  Copyright © 2019 Furqan Nadeem. All rights reserved.
//

import UIKit
import SwiftCheckboxDialog

protocol checkBoxValues {
     func checkValues(valueName:String,value: String,indexPath: Int, fieldType:String, section: Int,fieldName:String,isShow:Bool)
}

class MultiSelectTableViewCell: UITableViewCell,CheckboxDialogViewDelegate {

    @IBOutlet weak var lblKey: UILabel!
    @IBOutlet weak var btnCheckBox: UIButton!
    
   var checkboxDialogViewController: CheckboxDialogViewController!
        typealias TranslationTuple = (name: String, translated: String)
        typealias TranslationDictionary = [String : String]
        var skillArray = [JobPostCustomeValues]()
        
        var skilKeyArr = [String]()
        var delegate:checkBoxValues?
        var indexP = 0
        var section = 0
        var fieldName = ""
        var isFromEdit : Bool = true
        
        override func awakeFromNib() {
            super.awakeFromNib()
            // Initialization code
            print(skillArray)
            
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
            
            print (jobData)
        
//            if isFromEdit == true{
//                for itemDict in jobSkill {
//                    if itemDict.selected == true{
//                        if let jobSkillObj = itemDict.name{
//                            //jobData.append((name: jobSkillObj, translated: jobSkillObj))
//                            if let jobskey = itemDict.name{
//                                jobData.append((name: "\(jobskey)", translated: jobSkillObj))
//                            }
//                        }
//                    }
//
//                }
//                 self.checkboxDialogViewController.tableData = jobData
//            }else{
                for itemDict in jobSkill {
                    if let jobSkillObj = itemDict.name{
                        //jobData.append((name: jobSkillObj, translated: jobSkillObj))
                        if let jobskey = itemDict.name{
                            jobData.append((name: "\(jobskey)", translated: jobSkillObj))
                        }
                    }
                }
            
          
          
             let userData = UserDefaults.standard.object(forKey: "settingsData")
             let objData = NSKeyedUnarchiver.unarchiveObject(with: userData as! Data) as! [String: Any]
             let dataTabs = SplashRoot(fromDictionary: objData)
             self.checkboxDialogViewController = CheckboxDialogViewController()
             self.checkboxDialogViewController.titleDialog = dataTabs.data.extra.skillT
             self.checkboxDialogViewController.tableData = jobData
            //self.checkboxDialogViewController.titleDialog = "Skills"
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
            delegate?.checkValues(valueName: allselectedString, value: allselectedString, indexPath: indexP, fieldType: "checkbox", section: section, fieldName: fieldName, isShow: true)
        }
        
        
    }

