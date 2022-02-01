//
//  RegisterDateTableViewCell.swift
//  Nokri
//
//  Created by apple on 2/19/20.
//  Copyright © 2020 Furqan Nadeem. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0
import IQKeyboardManagerSwift


protocol registerDateFieldPro {
    func registerDatefieldVal(value: String,indexPath: Int, fieldType:String, section: Int,fieldNam:String)
}

class RegisterDateTableViewCell: UITableViewCell,UITextFieldDelegate {

    
    
    @IBOutlet weak var dateField: UITextField!
    @IBOutlet weak var viewDate: UIView!
    
    
    var fieldName = ""
    //var objSaved = JobPostCCustomData()
    var selectedIndex = 0
    var inde = 0
    var section = 0
    var delegate : registerDateFieldPro?
    var fieldType = "date"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        viewDate.layer.cornerRadius = 20
        viewDate.layer.borderWidth = 1
        viewDate.layer.borderColor = UIColor.groupTableViewBackground.cgColor
        IQKeyboardManager.shared.enable = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnDateClicked(_ sender: UIButton) {
        let datePicker = ActionSheetDatePicker(title: "Select Date:", datePickerMode: UIDatePicker.Mode.date, selectedDate: Date(), doneBlock: {
            picker, value, index in
            
            print("value = \(String(describing: value))")
            print("index = \(String(describing: index))")
            print("picker = \(String(describing: picker))")
            let fullName = "\(String(describing: value!))"
            let fullNameArr = fullName.components(separatedBy: " ")
            let name  = "\(fullNameArr[0])" + " " + "\(fullNameArr[1])"
            print(name)
            let dateFormatterGet = DateFormatter()
            dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let dateFormatterPrint = DateFormatter()
            //dateFormatterPrint.dateFormat = "MMM yyyy"
            dateFormatterPrint.dateFormat = "MM/dd/yyyy"
            if let date = dateFormatterGet.date(from:  name){
                print(dateFormatterPrint.string(from: date))
                self.dateField.text = dateFormatterPrint.string(from: date)
            }
            else {
                print("There was an error decoding the string")
            }
            let dText = self.dateField.text
            print(dText!)
            
            self.delegate?.registerDatefieldVal(value: dText! , indexPath: self.inde, fieldType: "date", section: self.section,fieldNam:self.fieldName)
            return
        }, cancel: { ActionStringCancelBlock in return }, origin: (sender as AnyObject).superview!?.superview)
        let secondsInWeek: TimeInterval = 15000 * 24 * 60 * 60;
        datePicker?.minimumDate = Date(timeInterval: -secondsInWeek, since: Date())
        datePicker?.maximumDate = Date(timeInterval: secondsInWeek, since: Date())
        datePicker?.minuteInterval = 20
        datePicker?.show()
    }
    
}
