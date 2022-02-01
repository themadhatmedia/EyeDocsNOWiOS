//
//  EducationalDetailTableViewCell.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 4/26/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0
import TextFieldEffects
//import SwiftValidator

class EducationalDetailTableViewCell: UITableViewCell,UITextViewDelegate {

    
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var lblDegreeStart: UILabel!
    @IBOutlet weak var lblDegreeEndKey: UILabel!
    @IBOutlet weak var txtViewRichEditor: UITextView!
    @IBOutlet weak var txtDegreeTitle: UITextField!
    @IBOutlet weak var txtDegreeInstitute: UITextField!
    @IBOutlet weak var txtDegreePercent: UITextField!
    @IBOutlet weak var txtDegreeGrade: UITextField!
    @IBOutlet weak var lblDegreeDetails: UILabel!
    @IBOutlet weak var separatorDegreeStart: UIView!
    @IBOutlet weak var separatorDegreeEnd: UIView!
    @IBOutlet weak var lblDegreeTitle: UILabel!
    @IBOutlet weak var lblDegreeIntitute: UILabel!
    @IBOutlet weak var lblDegreePercent: UILabel!
    @IBOutlet weak var lblDegreeGrade: UILabel!
    @IBOutlet weak var txtDegreeStart: UITextField!
    @IBOutlet weak var txtDegreeEnd: UITextField!
    @IBOutlet weak var iconDropdownStart: UIImageView!
    @IBOutlet weak var iconDropDownEnd: UIImageView!
    
    let cellBGView = UIView()
 
    var currentIndexPath: IndexPath?
    var degreeTextFieldDelegate: DegreeTextFieldDelegate?
    let dateFormatter = DateFormatter()
    //let validator = Validator()
    var appColorNew = UserDefaults.standard.string(forKey: "app_Color")
    
    
    var senderStart = UITextField()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        iconDropdownStart.image = iconDropdownStart.image?.withRenderingMode(.alwaysTemplate)
        iconDropdownStart.tintColor = UIColor(hex: appColorNew!)
        iconDropDownEnd.image = iconDropDownEnd.image?.withRenderingMode(.alwaysTemplate)
        iconDropDownEnd.tintColor = UIColor(hex: appColorNew!)
        nokri_shadow()
      
        txtDegreeTitle.delegate = self
        txtDegreeInstitute.delegate = self
        txtDegreeGrade.delegate = self
        txtDegreePercent.delegate = self
        txtDegreeStart.delegate = self
        txtDegreeEnd.delegate = self
        txtViewRichEditor.delegate = self
        txtDegreeTitle.nokri_addBottomBorder()
        txtDegreeInstitute.nokri_addBottomBorder()
        txtDegreeGrade.nokri_addBottomBorder()
        txtDegreePercent.nokri_addBottomBorder()
        txtDegreeTitle.addTarget(self, action: #selector(nokri_valueChanged(sender:)), for: .editingChanged)
        txtDegreeInstitute.addTarget(self, action: #selector(nokri_valueChanged(sender:)), for: .editingChanged)
        txtDegreeGrade.addTarget(self, action: #selector(nokri_valueChanged(sender:)), for: .editingChanged)
        txtDegreePercent.addTarget(self, action: #selector(nokri_valueChanged(sender:)), for: .editingChanged)
        txtDegreeStart.addTarget(self, action: #selector(nokri_valueChanged(sender:)), for: .editingDidEnd)
        txtDegreeEnd.addTarget(self, action: #selector(nokri_valueChanged(sender:)), for: .editingDidEnd)
        //validator.registerField(textField: txtDegreeTitle, rules: [RequiredRule(), FullNameRule()])
        //validator.validateField(textField: txtDegreeTitle) { (error) in
            //print ("Error")
       // }

    }
    
    @objc func nokri_valueChanged(sender: UITextField) {
        if sender == txtDegreeTitle {
            degreeTextFieldDelegate?.nokri_didUpdateText(indexPath: currentIndexPath!, txtDegreetTitle: sender, txtDegreeInstitute: nil, txtDegreetGrade: nil, txtDegreePercent: nil, txtDegreeStart: nil, txtDegreeEnd: nil, degreDetail: "")
        } else if sender == txtDegreeInstitute {
            degreeTextFieldDelegate?.nokri_didUpdateText(indexPath: currentIndexPath!, txtDegreetTitle: nil, txtDegreeInstitute: sender, txtDegreetGrade: nil, txtDegreePercent: nil, txtDegreeStart: nil, txtDegreeEnd: nil, degreDetail: "")
        } else if sender == txtDegreeGrade {
            degreeTextFieldDelegate?.nokri_didUpdateText(indexPath: currentIndexPath!, txtDegreetTitle: nil, txtDegreeInstitute: nil, txtDegreetGrade: sender, txtDegreePercent: nil, txtDegreeStart: nil, txtDegreeEnd: nil, degreDetail: "")
        } else if sender == txtDegreePercent {
            degreeTextFieldDelegate?.nokri_didUpdateText(indexPath: currentIndexPath!, txtDegreetTitle: nil, txtDegreeInstitute: nil, txtDegreetGrade: nil, txtDegreePercent: sender, txtDegreeStart: nil, txtDegreeEnd: nil, degreDetail: "")
        }else if sender == txtDegreeStart {
            degreeTextFieldDelegate?.nokri_didUpdateText(indexPath: currentIndexPath!, txtDegreetTitle: nil, txtDegreeInstitute: nil, txtDegreetGrade: nil, txtDegreePercent: nil, txtDegreeStart: sender, txtDegreeEnd: nil, degreDetail: "")
        }else if sender == txtDegreeEnd {
            degreeTextFieldDelegate?.nokri_didUpdateText(indexPath: currentIndexPath!, txtDegreetTitle: nil, txtDegreeInstitute: nil, txtDegreetGrade: nil, txtDegreePercent: nil, txtDegreeStart: nil, txtDegreeEnd: sender, degreDetail: "")
        }
    }
    
    
    func textViewDidChange(_ textView: UITextView) {
        
        degreeTextFieldDelegate?.nokri_didUpdateText(indexPath: currentIndexPath!, txtDegreetTitle: nil, txtDegreeInstitute: nil, txtDegreetGrade: nil, txtDegreePercent: nil, txtDegreeStart: nil, txtDegreeEnd: nil, degreDetail: textView.text)
        
        
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        txtDegreeTitle.nokri_updateBottomBorderSize()
        txtDegreeInstitute.nokri_updateBottomBorderSize()
        txtDegreeGrade.nokri_updateBottomBorderSize()
        txtDegreePercent.nokri_updateBottomBorderSize()
    }
    
    @IBAction func btnDegreeStartClicked(_ sender: UIButton) {
    
        separatorDegreeStart.frame.size.height = 2
        self.separatorDegreeStart.backgroundColor = UIColor(hex: appColorNew!)
        UIView.animate(withDuration: 1.0, animations: { () -> Void in
            self.separatorDegreeStart.backgroundColor = UIColor.lightGray
            self.separatorDegreeStart.frame.size.height = 1
        })
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
            dateFormatterPrint.dateFormat = "MMM yyyy"
            if let date = dateFormatterGet.date(from:  name){
                print(dateFormatterPrint.string(from: date))
                self.txtDegreeStart.text = dateFormatterPrint.string(from: date)
                self.degreeTextFieldDelegate?.nokri_didUpdateText(indexPath: self.currentIndexPath!, txtDegreetTitle: nil, txtDegreeInstitute: nil, txtDegreetGrade: nil, txtDegreePercent: nil, txtDegreeStart: self.txtDegreeStart, txtDegreeEnd: nil, degreDetail: "")
            }
            else {
                print("There was an error decoding the string")
            }
            return
        }, cancel: { ActionStringCancelBlock in return }, origin: (sender as AnyObject).superview!?.superview)
        let secondsInWeek: TimeInterval = 15000 * 24 * 60 * 60;
        datePicker?.minimumDate = Date(timeInterval: -secondsInWeek, since: Date())
        datePicker?.maximumDate = Date(timeInterval: secondsInWeek, since: Date())
        datePicker?.minuteInterval = 20
        datePicker?.show()
    }
    
    
    
    @IBAction func DateStartEndEdit(_ sender: UITextField) {
        degreeTextFieldDelegate?.nokri_didUpdateText(indexPath: currentIndexPath!, txtDegreetTitle: nil, txtDegreeInstitute: nil, txtDegreetGrade: nil, txtDegreePercent: nil, txtDegreeStart: sender, txtDegreeEnd: nil, degreDetail: "")
    }
    
    @IBAction func startDateClicked(_ sender: UITextField) {
        
//       separatorDegreeStart.frame.size.height = 2
//              self.separatorDegreeStart.backgroundColor = UIColor(hex: appColorNew!)
//              UIView.animate(withDuration: 1.0, animations: { () -> Void in
//                  self.separatorDegreeStart.backgroundColor = UIColor.lightGray
//                  self.separatorDegreeStart.frame.size.height = 1
//              })
//              let datePicker = ActionSheetDatePicker(title: "Select Date:", datePickerMode: UIDatePicker.Mode.date, selectedDate: Date(), doneBlock: {
//                  picker, value, index in
//                  print("value = \(String(describing: value))")
//                  print("index = \(String(describing: index))")
//                  print("picker = \(String(describing: picker))")
//                  let fullName = "\(String(describing: value!))"
//                  let fullNameArr = fullName.components(separatedBy: " ")
//                  let name  = "\(fullNameArr[0])" + " " + "\(fullNameArr[1])"
//                  print(name)
//                  let dateFormatterGet = DateFormatter()
//                  dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
//                  let dateFormatterPrint = DateFormatter()
//                  dateFormatterPrint.dateFormat = "MMM yyyy"
//                  if let date = dateFormatterGet.date(from:  name){
//                      print(dateFormatterPrint.string(from: date))
//                      self.txtDegreeStart.text = dateFormatterPrint.string(from: date)
//                  }
//                  else {
//                      print("There was an error decoding the string")
//                  }
//                  return
//              }, cancel: { ActionStringCancelBlock in return }, origin: (sender as AnyObject).superview!?.superview)
//              let secondsInWeek: TimeInterval = 15000 * 24 * 60 * 60;
//              datePicker?.minimumDate = Date(timeInterval: -secondsInWeek, since: Date())
//              datePicker?.maximumDate = Date(timeInterval: secondsInWeek, since: Date())
//              datePicker?.minuteInterval = 20
//              datePicker?.show()
    }
    
    @IBAction func btnDegreeEndClicked(_ sender: UIButton) {
       self.separatorDegreeStart.backgroundColor = UIColor.lightGray
                   separatorDegreeEnd.frame.size.height = 2
                   self.separatorDegreeEnd.backgroundColor = UIColor(hex: appColorNew!)
                   UIView.animate(withDuration: 1.0, animations: { () -> Void in
                       self.separatorDegreeEnd.frame.size.height = 1
                       self.separatorDegreeEnd.backgroundColor = UIColor.lightGray
                   })
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
                       dateFormatterPrint.dateFormat = "MMM yyyy"
                       if let date = dateFormatterGet.date(from:  name){
                           print(dateFormatterPrint.string(from: date))
                           self.txtDegreeEnd.text = dateFormatterPrint.string(from: date)
                        self.degreeTextFieldDelegate?.nokri_didUpdateText(indexPath: self.currentIndexPath!, txtDegreetTitle: nil, txtDegreeInstitute: nil, txtDegreetGrade: nil, txtDegreePercent: nil, txtDegreeStart: nil, txtDegreeEnd: self.txtDegreeEnd, degreDetail: "")
                       }
                       else {
                           print("There was an error decoding the string")
                       }
                       return
                   }, cancel: { ActionStringCancelBlock in return }, origin: (sender as AnyObject).superview!?.superview)
                   let secondsInWeek: TimeInterval = 15000 * 24 * 60 * 60;
                   datePicker?.minimumDate = Date(timeInterval: -secondsInWeek, since: Date())
                   datePicker?.maximumDate = Date(timeInterval: secondsInWeek, since: Date())
                   datePicker?.minuteInterval = 20
                   datePicker?.show()
    }
    @IBAction func endDateClicked(_ sender: UITextField) {
             
            
    }
    
    func nokri_shadow(){
        txtViewRichEditor.layer.borderColor = UIColor.gray.cgColor
        txtViewRichEditor.layer.cornerRadius = 0
        txtViewRichEditor.layer.shadowColor = UIColor(white: 0.0, alpha: 0.5).cgColor
        txtViewRichEditor.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        txtViewRichEditor.layer.shadowOpacity = 0.8
        txtViewRichEditor.layer.shadowRadius = 1
    }
}


extension EducationalDetailTableViewCell :UITextFieldDelegate{
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == txtDegreeTitle {
            txtDegreeTitle.nokri_updateBottomBorderColor(isTextFieldSelected: true)
        } else {
            txtDegreeTitle.nokri_updateBottomBorderColor(isTextFieldSelected: false)
        }
        if textField == txtDegreeInstitute {
            txtDegreeInstitute.nokri_updateBottomBorderColor(isTextFieldSelected: true)
        } else {
            txtDegreeInstitute.nokri_updateBottomBorderColor(isTextFieldSelected: false)
        }
        if textField == txtDegreePercent {
            txtDegreePercent.nokri_updateBottomBorderColor(isTextFieldSelected: true)
        } else {
            txtDegreePercent.nokri_updateBottomBorderColor(isTextFieldSelected: false)
        }
        if textField == txtDegreeGrade {
            txtDegreeGrade.nokri_updateBottomBorderColor(isTextFieldSelected: true)
        } else {
            txtDegreeGrade.nokri_updateBottomBorderColor(isTextFieldSelected: false)
        }
        return true
    }
    
}



