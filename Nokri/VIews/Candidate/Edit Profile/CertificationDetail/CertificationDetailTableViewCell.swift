//
//  CertificationDetailTableViewCell.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 4/27/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0

class CertificationDetailTableViewCell: UITableViewCell,UITextViewDelegate {

    @IBOutlet weak var lblCertificationTitle: UILabel!
    @IBOutlet weak var txtCertificationTitle: UITextField!
    @IBOutlet weak var lblCertificationStart: UILabel!
    @IBOutlet weak var txtCertificationStart: UITextField!
    @IBOutlet weak var lblCertificationEnd: UILabel!
    @IBOutlet weak var lblCertificationDuration: UILabel!
    @IBOutlet weak var txtCerticationDuration: UITextField!
    @IBOutlet weak var lblCertificationIndtitute: UILabel!
    @IBOutlet weak var txtCertificationInstitute: UITextField!
    @IBOutlet weak var lblDetain: UILabel!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var txtViewRichEditor: UITextView!
    @IBOutlet weak var txtCertificationEnd: UITextField!
    @IBOutlet weak var iconJobStart: UIImageView!
    @IBOutlet weak var iconJobEnd: UIImageView!
    
    
    let cellBGView = UIView()
 
    var currentIndexPath: IndexPath?
    var jobCertificationFieldDelegate: JobCertificationFieldDelegate?
    var appColorNew = UserDefaults.standard.string(forKey: "app_Color")
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        iconJobStart.image = iconJobStart.image?.withRenderingMode(.alwaysTemplate)
        iconJobStart.tintColor = UIColor(hex: appColorNew!)
        iconJobEnd.image = iconJobEnd.image?.withRenderingMode(.alwaysTemplate)
        iconJobEnd.tintColor = UIColor(hex: appColorNew!)
        nokri_shadow()
     
        txtViewRichEditor.delegate = self
        txtCertificationTitle.delegate = self
        txtCertificationEnd.delegate = self
        txtCertificationStart.delegate = self
        txtCerticationDuration.delegate = self
        txtCertificationInstitute.delegate = self
        txtCertificationInstitute.nokri_addBottomBorder()
        txtCertificationTitle.nokri_addBottomBorder()
        txtCertificationEnd.nokri_addBottomBorder()
        txtCertificationStart.nokri_addBottomBorder()
        txtCerticationDuration.nokri_addBottomBorder()
        txtCertificationTitle.addTarget(self, action: #selector(nokri_valueChanged(sender:)), for: .editingChanged)
        txtCertificationEnd.addTarget(self, action: #selector(nokri_valueChanged(sender:)), for: .editingDidEnd)
        txtCertificationStart.addTarget(self, action: #selector(nokri_valueChanged(sender:)), for: .editingDidEnd)
        txtCerticationDuration.addTarget(self, action: #selector(nokri_valueChanged(sender:)), for: .editingChanged)
        txtCertificationInstitute.addTarget(self, action: #selector(nokri_valueChanged(sender:)), for: .editingChanged)
        
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        txtCertificationTitle.nokri_updateBottomBorderSize()
        txtCertificationEnd.nokri_updateBottomBorderSize()
        txtCertificationStart.nokri_updateBottomBorderSize()
        txtCerticationDuration.nokri_updateBottomBorderSize()
        txtCertificationInstitute.nokri_updateBottomBorderSize()
    }
    
    @objc func nokri_valueChanged(sender: UITextField) {
        if sender == txtCertificationTitle {
            jobCertificationFieldDelegate?.nokri_didUpdateText(indexPath: currentIndexPath!, txtCertificationTitle: sender, txtCerticationDuration: nil, txtCertificationStart: nil, txtCertificationEnd: nil, degreDetail: "", txtCertificationInstitute: nil)
        } else if sender == txtCertificationInstitute {
            jobCertificationFieldDelegate?.nokri_didUpdateText(indexPath: currentIndexPath!, txtCertificationTitle: nil, txtCerticationDuration: nil, txtCertificationStart: nil, txtCertificationEnd: nil, degreDetail: "", txtCertificationInstitute: sender)
        } else if sender == txtCerticationDuration {
            jobCertificationFieldDelegate?.nokri_didUpdateText(indexPath: currentIndexPath!, txtCertificationTitle: nil, txtCerticationDuration: sender, txtCertificationStart: nil, txtCertificationEnd: nil, degreDetail: "", txtCertificationInstitute: nil)
        }else if sender == txtCertificationStart {
           jobCertificationFieldDelegate?.nokri_didUpdateText(indexPath: currentIndexPath!, txtCertificationTitle: nil, txtCerticationDuration: nil, txtCertificationStart: sender, txtCertificationEnd: nil, degreDetail: "", txtCertificationInstitute: nil)
        }
        else if sender == txtCertificationEnd {
            jobCertificationFieldDelegate?.nokri_didUpdateText(indexPath: currentIndexPath!, txtCertificationTitle: nil, txtCerticationDuration: nil, txtCertificationStart: nil, txtCertificationEnd: sender, degreDetail: "", txtCertificationInstitute: nil)
        }
    }
    
    @IBAction func btncertStartClicked(_ sender: UIButton) {
        
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
                self.txtCertificationStart.text = dateFormatterPrint.string(from: date)
                self.jobCertificationFieldDelegate?.nokri_didUpdateText(indexPath: self.currentIndexPath!, txtCertificationTitle: nil, txtCerticationDuration: nil, txtCertificationStart: self.txtCertificationStart, txtCertificationEnd: nil, degreDetail: "", txtCertificationInstitute: nil)
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
    
    @IBAction func btnCertEndClicked(_ sender: UIButton) {
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
                self.txtCertificationEnd.text = dateFormatterPrint.string(from: date)
                self.jobCertificationFieldDelegate?.nokri_didUpdateText(indexPath: self.currentIndexPath!, txtCertificationTitle: nil, txtCerticationDuration: nil, txtCertificationStart: nil, txtCertificationEnd: self.txtCertificationEnd, degreDetail: "", txtCertificationInstitute: nil)
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
    @IBAction func startDateClicked(_ sender: UITextField) {
      
    }
    
    @IBAction func endDateClicked(_ sender: UITextField) {
        
        
        
    }
    
    func textViewDidChange(_ textView: UITextView) {
        
        if textView == txtViewRichEditor{
            jobCertificationFieldDelegate?.nokri_didUpdateText(indexPath: currentIndexPath!, txtCertificationTitle: nil, txtCerticationDuration: nil, txtCertificationStart: nil, txtCertificationEnd: nil, degreDetail: textView.text, txtCertificationInstitute: nil)
        }
        
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


extension CertificationDetailTableViewCell :UITextFieldDelegate{
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == txtCertificationInstitute {
            txtCertificationInstitute.nokri_updateBottomBorderColor(isTextFieldSelected: true)
        } else {
            txtCertificationInstitute.nokri_updateBottomBorderColor(isTextFieldSelected: false)
        }
        if textField == txtCerticationDuration {
            txtCerticationDuration.nokri_updateBottomBorderColor(isTextFieldSelected: true)
        } else {
            txtCerticationDuration.nokri_updateBottomBorderColor(isTextFieldSelected: false)
        }
        if textField == txtCertificationTitle {
            txtCertificationTitle.nokri_updateBottomBorderColor(isTextFieldSelected: true)
        } else {
            txtCertificationTitle.nokri_updateBottomBorderColor(isTextFieldSelected: false)
        }
        if textField == txtCertificationStart {
            txtCertificationStart.nokri_updateBottomBorderColor(isTextFieldSelected: true)
        } else {
            txtCertificationStart.nokri_updateBottomBorderColor(isTextFieldSelected: false)
        }
        if textField == txtCertificationEnd {
            txtCertificationEnd.nokri_updateBottomBorderColor(isTextFieldSelected: true)
        } else {
            txtCertificationEnd.nokri_updateBottomBorderColor(isTextFieldSelected: false)
        }
        return true
    }
    
}



