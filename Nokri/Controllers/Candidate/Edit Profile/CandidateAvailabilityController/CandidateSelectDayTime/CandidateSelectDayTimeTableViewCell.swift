//
//  CandidateSelectDayTimeTableViewCell.swift
//  Nokri
//
//  Created by Apple on 27/11/2020.
//  Copyright © 2020 Furqan Nadeem. All rights reserved.
//

import UIKit

class CandidateSelectDayTimeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblTo: UILabel!
    @IBOutlet weak var containerDays: UIView!
    @IBOutlet weak var btnEndTimePicker: UIButton!
    @IBOutlet weak var lblEndTimePicker: UILabel!
    @IBOutlet weak var imgEndTimePicker: UIImageView!
    @IBOutlet weak var containerEndTimePicker: UIView!
    @IBOutlet weak var btnStartTimePicker: UIButton!
    @IBOutlet weak var lblStartTimePicker: UILabel!
    @IBOutlet weak var imgStartTimePicker: UIImageView!
    @IBOutlet weak var containerStartTimePicker: UIView!
    @IBOutlet weak var containerTimePicker: UIView!
    @IBOutlet weak var btnMonday: UIButton!{
        didSet{
            
            btnMonday.backgroundColor = .clear
            btnMonday.layer.cornerRadius = 20
            btnMonday.layer.borderWidth = 1
            btnMonday.layer.borderColor = UIColor(hex: self.appColorNew!).cgColor
            btnMonday.setTitleColor(UIColor(hex: self.appColorNew!), for: .normal)
        }
        
    }
    @IBOutlet weak var btnSunday: UIButton!{
        didSet{
            
            btnSunday.backgroundColor = .clear
            btnSunday.layer.cornerRadius = 20
            btnSunday.layer.borderWidth = 1
            btnSunday.layer.borderColor = UIColor(hex: self.appColorNew!).cgColor
            btnSunday.setTitleColor(UIColor(hex: self.appColorNew!), for: .normal)
        }
    }
    
    @IBOutlet weak var btnFriday: UIButton!{
        didSet{
            
            btnFriday.backgroundColor = .clear
            btnFriday.layer.cornerRadius = 20
            btnFriday.layer.borderWidth = 1
            btnFriday.layer.borderColor = UIColor(hex: self.appColorNew!).cgColor
            btnFriday.setTitleColor(UIColor(hex: self.appColorNew!), for: .normal)
        }
    }
    @IBOutlet weak var btnThursday: UIButton!{
        didSet{
            
            btnThursday.backgroundColor = .clear
            btnThursday.layer.cornerRadius = 20
            btnThursday.layer.borderWidth = 1
            btnThursday.layer.borderColor = UIColor(hex: self.appColorNew!).cgColor
            btnThursday.setTitleColor(UIColor(hex: self.appColorNew!), for: .normal)
        }
    }
    @IBOutlet weak var btnWednesday: UIButton!{
        didSet{
            
            btnWednesday.backgroundColor = .clear
            btnWednesday.layer.cornerRadius = 20
            btnWednesday.layer.borderWidth = 1
            btnWednesday.layer.borderColor = UIColor(hex: self.appColorNew!).cgColor
            btnWednesday.setTitleColor(UIColor(hex: self.appColorNew!), for: .normal)

        }
    }
    @IBOutlet weak var btnTuesday: UIButton!{
        didSet{
            
            btnTuesday.backgroundColor = .clear
            btnTuesday.layer.cornerRadius = 20
            btnTuesday.layer.borderWidth = 1
            btnTuesday.layer.borderColor = UIColor(hex: self.appColorNew!).cgColor
            btnTuesday.setTitleColor(UIColor(hex: self.appColorNew!), for: .normal)
        }
    }
    @IBOutlet weak var btnSaturday: UIButton!{
        didSet{
            
            btnSaturday.backgroundColor = .clear
            btnSaturday.layer.cornerRadius = 20
            btnSaturday.layer.borderWidth = 1
            btnSaturday.layer.borderColor = UIColor(hex: self.appColorNew!).cgColor
            btnSaturday.setTitleColor(UIColor(hex: self.appColorNew!), for: .normal)

        }
    }
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var pointerMonday: UIImageView!
    
    @IBOutlet weak var pointerTuesday: UIImageView!
    
    @IBOutlet weak var pointerWednesday: UIImageView!
    
    @IBOutlet weak var pointerThursday: UIImageView!
    
    @IBOutlet weak var pointerFriday: UIImageView!
    
    @IBOutlet weak var pointerSaturday: UIImageView!
    
    @IBOutlet weak var pointerSunday: UIImageView!
    
    @IBOutlet weak var containerStartImg: UIView!
    
    @IBOutlet weak var containerEndImg: UIView!
    //MARK:-Properties
    var btnCalendarAction: (()->())?
    var btnEndCalendarAction: (()->())?
    var btnMondayAction: (()->())?
    var btnTuesdayAction: (()->())?
    var btnWednesdayAction: (()->())?
    var btnThursdayAction: (()->())?
    var btnFirdayAction: (()->())?
    var btnSaturdayAction: (()->())?
    var btnSundayAction: (()->())?
    var hintText = ""
    
    
    
    var selectedDay = [String]()
    var appColorNew = UserDefaults.standard.string(forKey: "app_Color")
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        containerTimePicker.backgroundColor = UIColor.clear
        containerTimePicker.isHidden = true
        containerStartTimePicker.layer.borderWidth = 2
        containerStartTimePicker.layer.cornerRadius = 2
        containerStartTimePicker.layer.borderColor = UIColor(hex: "#eeeeee").cgColor
        containerEndTimePicker.layer.borderWidth = 2
        containerEndTimePicker.layer.cornerRadius = 2
        containerEndTimePicker.layer.borderColor = UIColor(hex: "#eeeeee").cgColor
        containerStartImg.backgroundColor = UIColor(hex: "#eeeeee")
        containerEndImg.backgroundColor = UIColor(hex: "#eeeeee")
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    @IBAction func actionBtnStartCalendar(_ sender: UIButton) {
        
        self.btnCalendarAction?()
    }
    @IBAction func actionBtnEndCalendar(_ sender: UIButton) {
        self.btnEndCalendarAction?()
    }
    
    
    @IBAction func actionBtnMonday(_ sender: UIButton) {
        print(sender.isSelected)
        self.btnMondayAction?()
    }
    @IBAction func actionBtnTuesday(_ sender: UIButton) {
        self.btnTuesdayAction?()
    }
    @IBAction func actionBtnWednesday(_ sender: UIButton) {
        self.btnWednesdayAction?()
        
    }
    @IBAction func actionBtnThursday(_ sender: UIButton) {
        self.btnThursdayAction?()
        
    }
    @IBAction func actionBtnFriday(_ sender: UIButton) {
        self.btnFirdayAction?()
    }
    @IBAction func actionBtnSaturday(_ sender: UIButton) {
        self.btnSaturdayAction?()
    }
    @IBAction func actionBtnSunday(_ sender: UIButton) {
        self.btnSundayAction?()
    }
    
}
