//
//  DateTableViewCell.swift
//  Nokri
//
//  Created by apple on 7/31/19.
//  Copyright © 2019 Furqan Nadeem. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0

protocol textValDateDelegate {
    func textValDate(value: String,indexPath: Int, fieldType:String, section: Int,fieldNam:String)
}

class DateTableViewCell: UITableViewCell {

    
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var lblDateKey: UILabel!
    @IBOutlet weak var lblDateValue: UILabel!
    @IBOutlet weak var btnDate: UIButton!
    
    var currentDate = ""
    var maxDate = ""
    var fieldName = ""
    var indexP = 0
    let bgColor = UserDefaults.standard.string(forKey: "mainColor")
    var delegate: textValDateDelegate?
    var index = 0
    var section = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
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
                self.lblDateValue.text = dateFormatterPrint.string(from: date)
            }
            else {
                print("There was an error decoding the string")
            }
            self.delegate?.textValDate(value: self.lblDateValue.text!, indexPath: self.indexP, fieldType: "date", section: self.section,fieldNam:self.fieldName)
            return
        }, cancel: { ActionStringCancelBlock in return }, origin: (sender as AnyObject).superview!?.superview)
        let secondsInWeek: TimeInterval = 15000 * 24 * 60 * 60;
        datePicker?.minimumDate = Date(timeInterval: -secondsInWeek, since: Date())
        datePicker?.maximumDate = Date(timeInterval: secondsInWeek, since: Date())
        datePicker?.minuteInterval = 20
        datePicker?.show()
        
        //self.txtDate.text = selectedDate
        //self.currentDate = selectedDate
        
        
    }
    
    

}
