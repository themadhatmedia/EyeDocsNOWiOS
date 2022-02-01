//
//  UpdateInfoDropDownTableViewCell.swift
//  Nokri
//
//  Created by apple on 3/4/20.
//  Copyright © 2020 Furqan Nadeem. All rights reserved.
//

import UIKit
import DropDown

class UpdateInfoDropDownTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var lblDropDownKey: UILabel!
    @IBOutlet weak var btnDropDown: UIButton!
    
    
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
            var delegate: registerSelectDropDown?
            
            
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
              //btnDropDown.layer.borderWidth = 1.0
              //btnDropDown.layer.cornerRadius = 20
              //btnDropDown.layer.borderColor = UIColor.groupTableViewBackground.cgColor
            }

            override func setSelected(_ selected: Bool, animated: Bool) {
                super.setSelected(selected, animated: animated)
            }
            
            //MARK:- Custom
            
            //MARK:- SetUp Drop Down
            func accountDropDown() {
                valueDropDown.anchorView = btnDropDown
                valueDropDown.dataSource = dropDownValuesArray
                
                valueDropDown.selectionAction = { [unowned self]
                    (index, item) in
                    self.btnDropDown.setTitle(item, for: .normal)
                    self.selectedValue = item
                    self.selectedIndex = self.dropDownKeysArray[index]
                    self.selectedValue = self.dropDownValuesArray[index]
                    self.param = self.fieldTypeNameArray[index]
                    self.bidOnOfCell = index
                    self.defaults.set(item, forKey: "value")
                    self.delegate?.registertextValSelecrDrop(valueName:item,value: self.selectedIndex, indexPath: self.indexP, fieldType: "select", section: self.section,fieldName : self.fieldNam,isShow: self.isShow)
                    self.defaults.synchronize()
                    print(self.fieldNam,self.bidOnOfCell)
                    
                }
            }
            
            @IBAction func actionPopup(_ sender: Any) {
                self.btnPopUpAction?()
            }
        }


