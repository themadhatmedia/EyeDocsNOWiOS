//
//  DropDownTableViewCell.swift
//  Nokri
//
//  Created by apple on 7/30/19.
//  Copyright © 2019 Furqan Nadeem. All rights reserved.
//

import UIKit
import DropDown


protocol textSelectDropDown {
    func textValSelecrDrop(valueName:String,value: String,indexPath: Int, fieldType:String, section: Int,fieldName:String,isShow:Bool)
}

class DropDownTableViewCell: UITableViewCell {

     
        @IBOutlet weak var lblKey: UILabel!
        @IBOutlet weak var lblName: UILabel!
        @IBOutlet weak var oltPopup: UIButton!
        //MARK:- Properties
        let defaults = UserDefaults.standard
        var btnPopUpAction : (()->())?
        var dropDownValuesArray = [String]()
        var dropDownKeysArray = [String]()
        var dropDownKeysArrayInt = [Int]()
        var fieldTypeNameArray = [String]()
        var hasFieldsArr = [Bool]()
        var isShowArr = [Bool]()
        var isShow = true
        
        var selectedKey = ""
        var selectedValue = ""
        var param = ""
        var indexP = 0
        var section = 0
        //var delegate:textSelectDropDown?
        var fieldNam = ""
        var bidOnOfCell = 0
        var hasSub:Bool = true
        
        var selectedIndex = "0"
        //var objSaved = AdPostField()
        var delegate: textSelectDropDown?
        
        
        let valueDropDown = DropDown()
        lazy var dropDowns : [DropDown] = {
            return [
                self.valueDropDown
            ]
        }()
        
        //MARK:- View Life Cycle
        override func awakeFromNib() {
            super.awakeFromNib()
            selectionStyle = .none
        }

        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)
        }
        
        //MARK:- Custom
        
        //MARK:- SetUp Drop Down
        func accountDropDown() {
            valueDropDown.anchorView = oltPopup
            valueDropDown.dataSource = dropDownValuesArray
            
            valueDropDown.selectionAction = { [unowned self]
                (index, item) in

                self.lblName.text = item
                self.selectedValue = item
                self.selectedIndex = self.dropDownKeysArray[index]
                self.selectedValue = self.dropDownValuesArray[index]
                
                self.param = self.fieldTypeNameArray[index]
                //self.hasSub = self.hasFieldsArr[index]
                //self.isShow = self.isShowArr[index]
                //print(self.hasSub)
                //print(self.param, self.selectedKey)
                self.bidOnOfCell = index
               // self.objSaved.fieldVal = item
        
                self.defaults.set(item, forKey: "value")
                self.delegate?.textValSelecrDrop(valueName:item,value: self.selectedIndex, indexPath: self.indexP, fieldType: "select", section: self.section,fieldName : self.fieldNam,isShow: self.isShow)
                self.defaults.synchronize()
                print(self.fieldNam,self.bidOnOfCell)
                
            }
        }
        
        @IBAction func actionPopup(_ sender: Any) {
            self.btnPopUpAction?()
        }
    }
