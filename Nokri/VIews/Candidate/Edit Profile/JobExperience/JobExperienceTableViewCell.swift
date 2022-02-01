//
//  JobExperienceTableViewCell.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 4/27/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import UIKit
//import UICheckbox_Swift
import ActionSheetPicker_3_0

class JobExperienceTableViewCell: UITableViewCell,UITextViewDelegate {

    @IBOutlet weak var btnCheckBox: UIButton!
    @IBOutlet weak var lblDegreeDetailKey: UILabel!
    @IBOutlet weak var lblRoleKey: UILabel!
    @IBOutlet weak var lblJobStart: UILabel!
    @IBOutlet weak var lblOrganizationKey: UILabel!
    @IBOutlet weak var txtRole: UITextField!
    @IBOutlet weak var txtOrganizationName: UITextField!
    @IBOutlet weak var lblJobEnd: UILabel!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var viewJobStart: UIView!
    @IBOutlet weak var viewJobEnd: UIView!
    @IBOutlet weak var txtDegreeStart: UITextField!
    @IBOutlet weak var txtDegreeEnd: UITextField!
    @IBOutlet weak var viewJobEndHeightContraint: NSLayoutConstraint!
    @IBOutlet weak var viewJobEndBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var txtViewRichEditor: UITextView!
    @IBOutlet weak var iconJobStart: UIImageView!
    @IBOutlet weak var iconJobEnd: UIImageView!
    @IBOutlet weak var imageViewCheckBox: UIImageView!
    
    let cellBGView = UIView()
   
    var currentIndexPath: IndexPath?
    var jobExperienceFieldDelegate: JobExperienceFieldDelegate?
    var appColorNew = UserDefaults.standard.string(forKey: "app_Color")
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       
        btnCheckBox.layer.borderWidth = 2.0
        btnCheckBox.layer.borderColor = UIColor.lightGray.cgColor
        self.imageViewCheckBox.image = imageViewCheckBox.image?.withRenderingMode(.alwaysTemplate)
        self.imageViewCheckBox.tintColor = UIColor(hex: appColorNew!)
        imageViewCheckBox.isHidden = true
        
        iconJobStart.image = iconJobStart.image?.withRenderingMode(.alwaysTemplate)
        iconJobStart.tintColor = UIColor(hex: appColorNew!)
        iconJobEnd.image = iconJobEnd.image?.withRenderingMode(.alwaysTemplate)
        iconJobEnd.tintColor = UIColor(hex: appColorNew!)
        nokri_shadow()
//        btnCheckBox.onSelectStateChanged = { (checkbox, selected) in
//            debugPrint("Clicked - \(selected)")
//            if checkbox.isSelected == true{
//                checkbox.layer.borderColor = UIColor(hex:Constants.AppColor.appColor).cgColor
//                self.viewJobEnd.isHidden = true
//               // self.viewJobEndHeightContraint.constant = 0
//                self.viewJobEndBottomConstraint.constant -= 75
//            }
//            else{
//                checkbox.layer.borderColor = UIColor.lightGray.cgColor
//                 self.viewJobEnd.isHidden = false
//                 self.viewJobEndBottomConstraint.constant += 75
//            }
//        }
        
        txtViewRichEditor.delegate = self
        txtOrganizationName.delegate = self
        txtRole.delegate = self
        txtDegreeStart.delegate = self
        txtDegreeEnd.delegate = self
        txtOrganizationName.nokri_addBottomBorder()
        txtRole.nokri_addBottomBorder()
        txtDegreeStart.nokri_addBottomBorder()
        txtDegreeEnd.nokri_addBottomBorder()
        txtOrganizationName.addTarget(self, action: #selector(nokri_valueChanged(sender:)), for: .editingChanged)
        txtRole.addTarget(self, action: #selector(nokri_valueChanged(sender:)), for: .editingChanged)
        txtDegreeStart.addTarget(self, action: #selector(nokri_valueChanged(sender:)), for: .editingDidEnd)
        txtDegreeEnd.addTarget(self, action: #selector(nokri_valueChanged(sender:)), for: .editingDidEnd)
        
    }

    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        txtOrganizationName.nokri_updateBottomBorderSize()
        txtRole.nokri_updateBottomBorderSize()
        txtDegreeStart.nokri_updateBottomBorderSize()
        txtDegreeEnd.nokri_updateBottomBorderSize()
    }
    
    @objc func nokri_valueChanged(sender: UITextField) {
        if sender == txtOrganizationName {
            jobExperienceFieldDelegate?.nokri_didUpdateText(indexPath: currentIndexPath!, txtOrganizationName: sender,txtRole:nil ,txtDegreeStart: nil, txtDegreeEnd: nil, degreDetail: "", isChecked: "")
        } else if sender == txtRole {
            jobExperienceFieldDelegate?.nokri_didUpdateText(indexPath: currentIndexPath!, txtOrganizationName: nil, txtRole: sender, txtDegreeStart: nil, txtDegreeEnd: nil, degreDetail: "", isChecked: "")
        } else if sender == txtDegreeStart {
            jobExperienceFieldDelegate?.nokri_didUpdateText(indexPath: currentIndexPath!, txtOrganizationName: nil, txtRole: nil, txtDegreeStart: sender, txtDegreeEnd: nil, degreDetail: "", isChecked: "")
        }else if sender == txtDegreeEnd {
            jobExperienceFieldDelegate?.nokri_didUpdateText(indexPath: currentIndexPath!, txtOrganizationName: nil, txtRole: nil, txtDegreeStart: nil, txtDegreeEnd: sender, degreDetail: "", isChecked: "")
        }
    }
    
    @IBAction func btnCheckBoxClicked(_ sender: UIButton) {
        if imageViewCheckBox.isHidden == true{
            imageViewCheckBox.isHidden = false
            self.viewJobEnd.isHidden = true
            // self.viewJobEndHeightContraint.constant = 0
            self.viewJobEndBottomConstraint.constant -= 75
            txtDegreeEnd.text = "Currently working"
            jobExperienceFieldDelegate?.nokri_didUpdateText(indexPath: currentIndexPath!, txtOrganizationName: nil, txtRole: nil, txtDegreeStart: txtDegreeStart, txtDegreeEnd: txtDegreeEnd, degreDetail: "", isChecked: "true")
        }else{
            imageViewCheckBox.isHidden = true
            self.viewJobEnd.isHidden = false
            self.viewJobEndBottomConstraint.constant += 75
        }
    }
    
    @IBAction func btnJobStartClicked(_ sender: UIButton) {
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
                self.jobExperienceFieldDelegate?.nokri_didUpdateText(indexPath: self.currentIndexPath!, txtOrganizationName: nil, txtRole: nil, txtDegreeStart: self.txtDegreeStart, txtDegreeEnd: nil, degreDetail: "", isChecked: "")
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
    
    @IBAction func btnJobEndClicked(_ sender: UIButton) {
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
                self.jobExperienceFieldDelegate?.nokri_didUpdateText(indexPath: self.currentIndexPath!, txtOrganizationName: nil, txtRole: nil, txtDegreeStart: nil, txtDegreeEnd: self.txtDegreeEnd, degreDetail: "", isChecked: "")
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
    
    
    func textViewDidChange(_ textView: UITextView) {
        
        if textView == txtViewRichEditor{
            jobExperienceFieldDelegate?.nokri_didUpdateText(indexPath: currentIndexPath!, txtOrganizationName: nil, txtRole: nil, txtDegreeStart: nil, txtDegreeEnd: nil, degreDetail: textView.text, isChecked: "")
        }
        
    }
    
    
    @IBAction func startDateClicked(_ sender: UITextField) {
        
       
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

extension JobExperienceTableViewCell :UITextFieldDelegate{
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == txtOrganizationName {
            txtOrganizationName.nokri_updateBottomBorderColor(isTextFieldSelected: true)
        } else {
            txtOrganizationName.nokri_updateBottomBorderColor(isTextFieldSelected: false)
        }
        if textField == txtRole {
            txtRole.nokri_updateBottomBorderColor(isTextFieldSelected: true)
        } else {
            txtRole.nokri_updateBottomBorderColor(isTextFieldSelected: false)
        }
        if textField == txtDegreeStart {
            txtDegreeStart.nokri_updateBottomBorderColor(isTextFieldSelected: true)
        } else {
            txtDegreeStart.nokri_updateBottomBorderColor(isTextFieldSelected: false)
        }
        if textField == txtDegreeEnd {
            txtDegreeEnd.nokri_updateBottomBorderColor(isTextFieldSelected: true)
        } else {
            txtDegreeEnd.nokri_updateBottomBorderColor(isTextFieldSelected: false)
        }
        return true
    }
}





