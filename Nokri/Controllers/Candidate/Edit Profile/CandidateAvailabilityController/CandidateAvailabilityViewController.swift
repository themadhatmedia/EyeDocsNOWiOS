//
//  CandidateAvailabilityViewController.swift
//  Nokri
//
//  Created by Apple on 26/11/2020.
//  Copyright © 2020 Furqan Nadeem. All rights reserved.
//

import UIKit
import DropDown
import ActionSheetPicker_3_0
import Alamofire
class CandidateAvailabilityViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,TimeZonesDelegate {
        
    
    
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var containerViewRadioBtns: UIView!
    @IBOutlet weak var btnSelectedHours: UIButton!
    @IBOutlet weak var btnAllTime: UIButton!
    @IBOutlet weak var btnNA: UIButton!
    @IBOutlet weak var lblSelctedHours: UILabel!
    @IBOutlet weak var lblAllTime: UILabel!
    @IBOutlet weak var lblNotAvailable: UILabel!
    @IBOutlet weak var headinglblHours: UILabel!
    @IBOutlet weak var lblScreenTitle: UILabel!
    @IBOutlet weak var screenTitleView: UIView!
    
    @IBOutlet weak var btnclickTzones: UIButton!
    @IBOutlet weak var imgNxtIcon: UIImageView!
    @IBOutlet weak var lblTimeZone: UILabel!
    @IBOutlet weak var containerTzones: UIView!
    @IBOutlet weak var lblTZones: UILabel!
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.tableFooterView = UIView()
            tableView.showsVerticalScrollIndicator = false
            tableView.separatorStyle = .none
            tableView.backgroundColor = UIColor.yellow
            tableView.isScrollEnabled = false
        }
    }
    //MARK:- Properties
    
    
    //StringfromApi
    var heading: String!
    var headingTimeType: String!
    var timeZonesHeading: String!
    var btnSubmit: String!
    var to: String!
    var openAllTime: String!
    var selectiveHours: String!
    var notAvailableHeading: String!

    
    var appColorNew = UserDefaults.standard.string(forKey: "app_Color")
    var dates : String!
    var checked : String!
//    var extraArray = [AdvanceSearchExtra]()

    var TimeZones = [CandidateAvailabilityTimeZones]()
    var daysArray = [CandidateAvailabilityDays]()
    var selectedTimes = [String]()
    var selectedEndTimes = [String]()
    var selectedTimeZone: String!
    var selctedDays = [String]()
    var TimeTableArray = [String]()
    var dict = [[String]]()
    var keys = [String]()
    var values = [[String]]()
    
    var checkedDay:[Bool] = []
    
    //asal saman
    var addInfoDictionary = [String: Any]()
    var customDictionary = [String: Any]()
    var customDaysDictionary = [String: Any]()
    var localDictionary = [String: Any]()


    //final Array to POST Data
    var candAvailDict = [String: Any]()

    var availabilitiesDict = [String: Any]()
    
    var timeStart: String!
    
    var notAvailable = false
    var allTime = true
    var availabilityType : String!
    var nameDays : String!
    var currentIndex = 0

    
    //Daysboolean
    var Mon = false
    var Tues = false
    var Wed = false
    var Thurs = false
    var Fri = false
    var Sat = false
    var Sun = false
    var btnStartTimeAction: (()->())?
    var btnEndTimeAction: (()->())?
    var btnMndayAction: (()->())?
    var btnTusdayAction: (()->())?
    var btnWdnesdayAction: (()->())?
    var btnThrsdayAction: (()->())?
    var btnFrdayAction: (()->())?
    var btnSturdayAction: (()->())?
    var btnSndayAction: (()->())?
    //    var myArray = [[String:AnyObject]]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationController?.navigationBar.isHidden = true
        screenTitleView.backgroundColor = UIColor(hex: appColorNew!)
        lblScreenTitle.textColor = UIColor.white
        tableView.isHidden = true
        containerTzones.isHidden = true
        lblTZones.isHidden = true
        lblSelctedHours.layer.borderWidth = 1
        lblSelctedHours.layer.borderColor = UIColor(hex: appColorNew!).cgColor
        
        lblAllTime.layer.borderWidth = 1
        lblAllTime.layer.borderColor = UIColor(hex: appColorNew!).cgColor
        
        lblNotAvailable.layer.borderWidth = 1
        lblNotAvailable.layer.borderColor = UIColor(hex: appColorNew!).cgColor
        
        //actions
        btnNA.addTarget(self, action: #selector(btnNAtapped), for: .touchUpInside)
        btnAllTime.addTarget(self, action: #selector(btnAllTimetapped), for: .touchUpInside)
        btnSelectedHours.addTarget(self, action: #selector(btnSelectedHourstapped), for: .touchUpInside)
        submitBtn.addTarget(self, action: #selector(btnSubmitTapped), for: .touchUpInside)
        
        self.nokri_customeButton()
        self.candidateAvailablilityData()
        
        // Do any additional setup after loading the view.
    }
   

    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear()
//        self.candidateAvailablilityData()
//        tableView.reloadData()
//        self.lblTimeZone.text = selectedTimeZone

    }
    func nokri_customeButton(){
        submitBtn.layer.cornerRadius = 15
        submitBtn.layer.borderWidth = 1
        submitBtn.layer.borderColor = UIColor(hex:appColorNew!).cgColor
        submitBtn.setTitleColor(UIColor(hex:appColorNew!), for: .normal)
        submitBtn.layer.masksToBounds = false
        submitBtn.backgroundColor = UIColor.white
    }
    @IBAction func btnTzAction(_ sender: UIButton!) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "TimeZonesControllerViewController") as? TimeZonesControllerViewController
        vc!.delegate = self
//        vc!.timeZones = self.TimeZones.map {$0.value}
                 
        self.navigationController?.pushViewController(vc!, animated: true)
    
    }
    @objc func btnNAtapped(){
        self.availabilityType = "0"

        lblNotAvailable.layer.borderWidth = 3
        lblNotAvailable.backgroundColor = UIColor(hex: appColorNew!)
        lblNotAvailable.textColor = UIColor.white
        tableView.isHidden = true
        notAvailable = true
        allTime = false
        containerTzones.isHidden = true
        lblTZones.isHidden = true
        for subview in self.tableView.subviews {
            subview.removeFromSuperview()
        }
        if selctedDays != nil {
            selctedDays.removeAll()
        }
        if selectedTimes != nil {
            selectedTimes.removeAll()
        }
        if selectedEndTimes != nil{
            selectedEndTimes.removeAll()
        }
        if selectedTimeZone != nil {
            selectedTimeZone.removeAll()
        }
        //others
        lblSelctedHours.layer.borderWidth = 1
        lblSelctedHours.layer.borderColor = UIColor(hex: appColorNew!).cgColor
        lblSelctedHours.backgroundColor = UIColor.clear
        lblSelctedHours.textColor = UIColor.black
        
        lblAllTime.layer.borderWidth = 1
        lblAllTime.layer.borderColor = UIColor(hex: appColorNew!).cgColor
        lblAllTime.backgroundColor = UIColor.clear
        lblAllTime.textColor = UIColor.black
    }
    @objc func btnAllTimetapped(){
        tableView.isHidden = true
        containerTzones.isHidden = true
        lblTZones.isHidden = true
        allTime = true
        notAvailable = false
        self.availabilityType = "1"
        if selctedDays != nil {
            selctedDays.removeAll()
        }
        if selectedTimes != nil {
            selectedTimes.removeAll()
        }
        if selectedEndTimes != nil{
            selectedEndTimes.removeAll()
        }
        if selectedTimeZone != nil {
            selectedTimeZone.removeAll()
            
        }
        for subview in self.tableView.subviews {
            subview.removeFromSuperview()
        }
        lblAllTime.layer.borderWidth = 3
        lblAllTime.backgroundColor = UIColor(hex: appColorNew!)
        lblAllTime.textColor = UIColor.white
        //others
        lblSelctedHours.layer.borderWidth = 1
        lblSelctedHours.layer.borderColor = UIColor(hex: appColorNew!).cgColor
        lblSelctedHours.backgroundColor = UIColor.clear
        lblSelctedHours.textColor = UIColor.black
        
        
        lblNotAvailable.layer.borderWidth = 1
        lblNotAvailable.layer.borderColor = UIColor(hex: appColorNew!).cgColor
        lblNotAvailable.backgroundColor = UIColor.clear
        lblNotAvailable.textColor = UIColor.black
    }
    @objc func btnSelectedHourstapped(){
        notAvailable = false
        self.availabilityType = "2"

        allTime = false
        tableView.isHidden = false
        containerTzones.isHidden = false
        lblTZones.isHidden = false
        tableView.reloadData()
        
        //        for subview in self.tableView.subviews {
        //               subview.addSubview(subview)
        //        }
        lblSelctedHours.layer.borderWidth = 3
        lblSelctedHours.backgroundColor = UIColor(hex: appColorNew!)
        lblSelctedHours.textColor = UIColor.white
        //others
        lblAllTime.layer.borderWidth = 1
        lblAllTime.layer.borderColor = UIColor(hex: appColorNew!).cgColor
        lblAllTime.backgroundColor = UIColor.clear
        lblAllTime.textColor = UIColor.black
        
        
        lblNotAvailable.layer.borderWidth = 1
        lblNotAvailable.layer.borderColor = UIColor(hex: appColorNew!).cgColor
        lblNotAvailable.backgroundColor = UIColor.clear
        lblNotAvailable.textColor = UIColor.black
        
        
        
    }
    
    //get TimeZOne via delegat from TableViewCell
    
    
    func sendTimeZone(timeZone: String, isSelected: Bool) {
                print("\(timeZone): \(isSelected)")
                selectedTimeZone = timeZone
                self.lblTimeZone.text = selectedTimeZone

    }
    
    
//    func sendTimeZone(timeZone: String) {
//        print(timeZone)
//        selectedTimeZone = timeZone
//        self.lblTimeZone.text = selectedTimeZone
//
//    }

    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var value = 0

        if section == 0 {
            value =  daysArray.count
        }
//        if section == 1 {
//            value =  daysArray.count
//        }
//        if section == 2{
//            return 1
//        }
        return value
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
//        if section == 0{
//            let cell: CandidateSelectTimeTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CandidateSelectTimeTableViewCell", for: indexPath) as! CandidateSelectTimeTableViewCell
//
//            cell.btnPopUpAction = { [self] () in
//                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "TimeZonesControllerViewController") as? TimeZonesControllerViewController
//                vc!.delegate = self
//                vc!.timeZones = self.TimeZones.map {$0.value}
//
//                self.navigationController?.pushViewController(vc!, animated: true)
//
//                let catKey = UserDefaults.standard.string(forKey: "timeZoneTitle")
//
//                cell.lblDropSelectTime.text = catKey
////                let dropDown = DropDown()
////
////                // The view to which the drop down will appear on
////                dropDown.anchorView = cell.btnSelectTimeDrop // UIView or UIBarButtonItem
////
////                // The list of items to display. Can be changed dynamically
////
////                //                if let t = TimeZone.random {
////                //                    print(t)
////                //                }
////
////                dropDown.dataSource = self.TimeZones.map {$0.value}
////
////                    //TimeZone.knownTimeZoneIdentifiers
////                //knownTimeZoneIdentifiers
////                //["Car", "Motorcycle", "Truck"]
////                //[TimeZone.random as! String?]
////                //["Car", "Motorcycle", "Truck"]
////
////
////                //            Optional properties:
////                cell.lblDropSelectTime.text = "SelectTime Static text"
////                    //dropDown.accessibilityHint
////                    //dropDown.dataSource.startIndex.description
////                //accessibilityHint
////
////                // Action triggered on selection
////                dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
////
////                    cell.lblDropSelectTime.text = item
////                    selectedTimeZone = item
////                    print("Selected item: \(item) at index: \(index)")
////                }
////
////                // Will set a custom width instead of the anchor view width
////                //            dropDownLeft.width = 200
////                //            Display actions:
////
////                dropDown.show()
////                //            dropDown.hide()
////                DropDown.startListeningToKeyboard()
////                dropDown.direction = .bottom
//                //cell.btnMonday.addTarget(self, action: #selector(self.actionCalendar), for: .touchUpInside)
//
//            }
//
//            return cell
//        }
        if section == 0 {
            let cell: CandidateSelectDayTimeTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CandidateSelectDayTimeTableViewCell", for: indexPath) as! CandidateSelectDayTimeTableViewCell
            var objdata = daysArray[indexPath.row]
//            for item in objdata.dayName{
//                print(item)
////                break
//                currentIndex += 1
//                   nameDays = String(item)
//                print(nameDays)
                
//            for  items in daysArray.enumerated() {
//
//                nameDays = items.element.dayName
//            }
//            for (index, element) in daysArray.enumerated() {
//                print(index, ":", element.dayName)
            
            cell.btnMonday.setTitle(daysArray[0].dayName, for: .normal)
            cell.btnTuesday.setTitle(daysArray[1].dayName, for: .normal)
            cell.btnWednesday.setTitle(daysArray[2].dayName, for: .normal)
            cell.btnThursday.setTitle(daysArray[3].dayName, for: .normal)
            cell.btnFriday.setTitle(daysArray[4].dayName, for: .normal)
            cell.btnSaturday.setTitle(daysArray[5].dayName, for: .normal)
            cell.btnSunday.setTitle(daysArray[6].dayName, for: .normal)
//            }
            cell.lblTo.text = to!
            for days in daysArray{
                self.selctedDays.append(days.dayName)
                print(days)
                if days.closedDay == true {
                    if days.dayKey == "Monday"{
                        cell.containerTimePicker.isHidden = false
                        //                    cell.containerTimePicker.removeFromSuperview()
                        //                    cell.containerTimePicker.translatesAutoresizingMaskIntoConstraints = false
                        //                    self.view.addSubview(cell.containerTimePicker)
                        //                    cell.containerTimePicker.topAnchor.constraint(equalTo:cell.containerDays.bottomAnchor,constant: 0).isActive = true
                        //                    cell.containerTimePicker.centerXAnchor.constraint(equalTo: cell.containerDays.centerXAnchor).isActive = true
                        cell.lblStartTimePicker.text = self.daysArray[0].startTime
                        cell.lblEndTimePicker.text = self.daysArray[0].EndTime
                        
                        cell.btnMonday.layer.borderWidth = 3
                        cell.btnMonday.layer.borderColor = UIColor(hex: self.appColorNew!).cgColor
                        cell.btnMonday.backgroundColor = UIColor(hex: self.appColorNew!)
                        cell.btnMonday.setTitleColor(.white, for: .normal)
                    }
                    if days.dayKey == "Tuesday"{
                        cell.containerTimePicker.isHidden = false
                        //                    cell.containerTimePicker.removeFromSuperview()
                        //                    cell.containerTimePicker.translatesAutoresizingMaskIntoConstraints = false
                        //                    self.view.addSubview(cell.containerTimePicker)
                        //                    cell.containerTimePicker.topAnchor.constraint(equalTo:cell.containerDays.bottomAnchor,constant: 0).isActive = true
                        //                    cell.containerTimePicker.centerXAnchor.constraint(equalTo: cell.containerDays.centerXAnchor).isActive = true
                        cell.lblStartTimePicker.text = self.daysArray[1].startTime
                        cell.lblEndTimePicker.text = self.daysArray[1].EndTime
                        
                        cell.btnTuesday.layer.borderWidth = 3
                        cell.btnTuesday.layer.borderColor = UIColor(hex: self.appColorNew!).cgColor
                        cell.btnTuesday.backgroundColor = UIColor(hex: self.appColorNew!)
                        cell.btnTuesday.setTitleColor(.white, for: .normal)

                    }
                    
                    if days.dayKey == "Wednesday"{
                        cell.containerTimePicker.isHidden = false
                        //                    cell.containerTimePicker.removeFromSuperview()
                        //                    cell.containerTimePicker.translatesAutoresizingMaskIntoConstraints = false
                        //                    self.view.addSubview(cell.containerTimePicker)
                        //                    cell.containerTimePicker.topAnchor.constraint(equalTo:cell.containerDays.bottomAnchor,constant: 0).isActive = true
                        //                    cell.containerTimePicker.centerXAnchor.constraint(equalTo: cell.containerDays.centerXAnchor).isActive = true
                        cell.lblStartTimePicker.text = self.daysArray[2].startTime
                        cell.lblEndTimePicker.text = self.daysArray[2].EndTime
                        
                        cell.btnWednesday.layer.borderWidth = 3
                        cell.btnWednesday.layer.borderColor = UIColor(hex: self.appColorNew!).cgColor
                        cell.btnWednesday.backgroundColor = UIColor(hex: self.appColorNew!)
                        cell.btnWednesday.setTitleColor(.white, for: .normal)

                    }
                    
                    if days.dayKey == "Thursday"{
                        cell.containerTimePicker.isHidden = false
                        //                    cell.containerTimePicker.removeFromSuperview()
                        //                    cell.containerTimePicker.translatesAutoresizingMaskIntoConstraints = false
                        //                    self.view.addSubview(cell.containerTimePicker)
                        //                    cell.containerTimePicker.topAnchor.constraint(equalTo:cell.containerDays.bottomAnchor,constant: 0).isActive = true
                        //                    cell.containerTimePicker.centerXAnchor.constraint(equalTo: cell.containerDays.centerXAnchor).isActive = true
                        cell.lblStartTimePicker.text = self.daysArray[3].startTime
                        cell.lblEndTimePicker.text = self.daysArray[3].EndTime
                        
                        cell.btnThursday.layer.borderWidth = 3
                        cell.btnThursday.layer.borderColor = UIColor(hex: self.appColorNew!).cgColor
                        cell.btnThursday.backgroundColor = UIColor(hex: self.appColorNew!)
                        cell.btnThursday.setTitleColor(.white, for: .normal)

                    }
                    if days.dayKey == "Friday"{
                        cell.containerTimePicker.isHidden = false
                        //                    cell.containerTimePicker.removeFromSuperview()
                        //                    cell.containerTimePicker.translatesAutoresizingMaskIntoConstraints = false
                        //                    self.view.addSubview(cell.containerTimePicker)
                        //                    cell.containerTimePicker.topAnchor.constraint(equalTo:cell.containerDays.bottomAnchor,constant: 0).isActive = true
                        //                    cell.containerTimePicker.centerXAnchor.constraint(equalTo: cell.containerDays.centerXAnchor).isActive = true
                        cell.lblStartTimePicker.text = self.daysArray[4].startTime
                        cell.lblEndTimePicker.text = self.daysArray[4].EndTime
                        
                        cell.btnFriday.layer.borderWidth = 3
                        cell.btnFriday.layer.borderColor = UIColor(hex: self.appColorNew!).cgColor
                        cell.btnFriday.backgroundColor = UIColor(hex: self.appColorNew!)
                        cell.btnFriday.setTitleColor(.white, for: .normal)

                    }
                    if days.dayKey == "Saturday"{
                        cell.containerTimePicker.isHidden = false
                        //                    cell.containerTimePicker.removeFromSuperview()
                        //                    cell.containerTimePicker.translatesAutoresizingMaskIntoConstraints = false
                        //                    self.view.addSubview(cell.containerTimePicker)
                        //                    cell.containerTimePicker.topAnchor.constraint(equalTo:cell.containerDays.bottomAnchor,constant: 0).isActive = true
                        //                    cell.containerTimePicker.centerXAnchor.constraint(equalTo: cell.containerDays.centerXAnchor).isActive = true
                        cell.lblStartTimePicker.text = self.daysArray[5].startTime
                        cell.lblEndTimePicker.text = self.daysArray[5].EndTime
                        
                        cell.btnSaturday.layer.borderWidth = 3
                        cell.btnSaturday.layer.borderColor = UIColor(hex: self.appColorNew!).cgColor
                        cell.btnSaturday.backgroundColor = UIColor(hex: self.appColorNew!)
                        cell.btnSaturday.setTitleColor(.white, for: .normal)

                    }
                    if days.dayKey == "Sunday"{
                        cell.containerTimePicker.isHidden = false
                        //                    cell.containerTimePicker.removeFromSuperview()
                        //                    cell.containerTimePicker.translatesAutoresizingMaskIntoConstraints = false
                        //                    self.view.addSubview(cell.containerTimePicker)
                        //                    cell.containerTimePicker.topAnchor.constraint(equalTo:cell.containerDays.bottomAnchor,constant: 0).isActive = true
                        //                    cell.containerTimePicker.centerXAnchor.constraint(equalTo: cell.containerDays.centerXAnchor).isActive = true
                        cell.lblStartTimePicker.text = self.daysArray[6].startTime
                        cell.lblEndTimePicker.text = self.daysArray[6].EndTime
                        
                        cell.btnSunday.layer.borderWidth = 3
                        cell.btnSunday.layer.borderColor = UIColor(hex: self.appColorNew!).cgColor
                        cell.btnSunday.backgroundColor = UIColor(hex: self.appColorNew!)
                        cell.btnSunday.setTitleColor(.white, for: .normal)

                    }
                    
                }
            }
            
            
            cell.btnMondayAction = { [self]()in
                guard let button = cell.btnMonday as? UIButton else { return }
                if self.selectedTimes != nil{
                    cell.lblStartTimePicker.text = daysArray[0].startTime
                        //objdata.startTime
                        //self.selectedTimes[optional:0]
                }
                if self.selectedEndTimes != nil {
                    cell.lblEndTimePicker.text = daysArray[0].EndTime
                        //objdata.EndTime
                        //self.selectedEndTimes[optional:0]
                    
                }
                
                if !button.isSelected{
                    cell.pointerMonday.isHidden = false
                    cell.pointerTuesday.isHidden = true
                    cell.pointerWednesday.isHidden = true
                    cell.pointerThursday.isHidden = true
                    cell.pointerFriday.isHidden = true
                    cell.pointerSaturday.isHidden = true
                    cell.pointerSunday.isHidden = true
                    cell.pointerMonday.tintColor = UIColor(hex: self.appColorNew!)
                    //                    cell.selectedDay.append("Monday")
                    //                    self.selctedDays.append(contentsOf: cell.selectedDay)
                    //                    print(self.selctedDays)
//                    self.selctedDays.insert(daysArray[0].dayName, at: 0)

                    self.selctedDays.append(self.daysArray[0].dayName)
                    print(cell.selectedDay)
                   
                    objdata.closedDay = true
                    self.checkedDay.append(objdata.closedDay)
                    print(self.checkedDay)
                    
                    self.Mon = true
                    
                    
                    //                    if self.timeStart != nil{
                    //                        cell.lblStartTimePicker.text = self.timeStart
                    //                    }else{
                    //                        cell.lblStartTimePicker.text = "shitttttttt"
                    //                    }
                    cell.containerTimePicker.isHidden = false
                    cell.containerTimePicker.removeFromSuperview()
                    cell.containerTimePicker.translatesAutoresizingMaskIntoConstraints = false
                    self.view.addSubview(cell.containerTimePicker)
                    cell.containerTimePicker.topAnchor.constraint(equalTo:cell.containerDays.bottomAnchor,constant: 0).isActive = true
                    cell.containerTimePicker.centerXAnchor.constraint(equalTo: cell.containerDays.centerXAnchor).isActive = true
                    cell.lblStartTimePicker.text = self.daysArray[0].startTime
                    cell.lblEndTimePicker.text = self.daysArray[0].EndTime
                    
                    button.isSelected = true
                    button.tintColor = UIColor.clear
                    cell.btnMonday.layer.borderWidth = 3
                    cell.btnMonday.layer.borderColor = UIColor(hex: self.appColorNew!).cgColor
                    cell.btnMonday.backgroundColor = UIColor(hex: self.appColorNew!)
                    cell.btnMonday.setTitleColor(.white, for: .normal)
                }
                else{
                    cell.pointerMonday.isHidden = false
                    cell.pointerTuesday.isHidden = true
                    cell.pointerWednesday.isHidden = true
                    cell.pointerThursday.isHidden = true
                    cell.pointerFriday.isHidden = true
                    cell.pointerSaturday.isHidden = true
                    cell.pointerSunday.isHidden = true
                    self.selctedDays.append(self.daysArray[0].dayName)
                    print(cell.selectedDay)

//                    self.selctedDays.remove(object: "M")
                    //                    cell.selectedDay.remove(object: "Monday")
                    
//                    print(self.selctedDays)
                    self.checkedDay.remove(object: true)
                    print(self.checkedDay)
                    //                    print(cell.selectedDay)
                    if self.selectedTimes != nil{
                        cell.lblStartTimePicker.text = daysArray[0].startTime
                            //objdata.startTime
                            //self.selectedTimes[optional:0]
                    }
                    if self.selectedEndTimes != nil {
                        cell.lblEndTimePicker.text = daysArray[0].EndTime
                            //objdata.EndTime
                            //self.selectedEndTimes[optional:0]
                        
                    }
//                    cell.lblStartTimePicker.text = ""
//                    cell.lblEndTimePicker.text = ""
                    
                    //                    if (cell.lblStartTimePicker.text != nil) && (cell.lblEndTimePicker.text != nil) {
                    //                        let removedVal = self.selectedTimes.remove(at: 0)
                    //                        print("removed value is \(removedVal)")
                    //                        print(self.selectedTimes)
//                    if self.selectedTimes.count != 0 {
//                        self.selectedTimes.remove(at: 0)
//                    }
//                    if self.selectedEndTimes.count != 0 {
//                        self.selectedEndTimes.remove(at: 0)
//
//                    }
//                    if self.daysArray.count != 0 {
//                        self.daysArray[0].startTime.remove(at: 0)
//                        self.daysArray[0].EndTime.remove(at: 0)
//
//                    }
                    self.Mon = false
                    button.isSelected = false
                    cell.btnMonday.backgroundColor = .clear
                    cell.btnMonday.layer.cornerRadius = 20
                    cell.btnMonday.layer.borderWidth = 1
                    cell.btnMonday.layer.borderColor = UIColor(hex: self.appColorNew!).cgColor
                    cell.btnMonday.setTitleColor(UIColor(hex: self.appColorNew!), for: .normal)
                    
                }
            }
            cell.btnTuesdayAction = {() in
                guard  let button = cell.btnTuesday as? UIButton else{return}
                if self.selectedTimes != nil{
                    cell.lblStartTimePicker.text = self.daysArray[1].startTime
                        //objdata.startTime
                        //self.selectedTimes[optional:1]
                }
                if self.selectedEndTimes != nil {
                    cell.lblEndTimePicker.text = self.daysArray[1].EndTime
                        //objdata.EndTime
                        //self.selectedEndTimes[optional:1]
                    
                }
                if !button.isSelected{
                    cell.pointerTuesday.isHidden = false
                    cell.pointerMonday.isHidden = true
                    cell.pointerWednesday.isHidden = true
                    cell.pointerThursday.isHidden = true
                    cell.pointerFriday.isHidden = true
                    cell.pointerSaturday.isHidden = true
                    cell.pointerSunday.isHidden = true
                    cell.pointerTuesday.tintColor = UIColor(hex: self.appColorNew!)
                    //                    cell.selectedDay.append("Tuesday")
                    self.selctedDays.append(self.daysArray[1].dayName)
                    print(self.selctedDays)
                    objdata.closedDay = true

                    self.checkedDay.append(objdata.closedDay)
                    print(self.checkedDay)
                    self.Tues = true
                    //                    print(cell.selectedDay)
                    cell.containerTimePicker.isHidden = false
                    cell.containerTimePicker.removeFromSuperview()
                    cell.containerTimePicker.translatesAutoresizingMaskIntoConstraints = false
                    self.view.addSubview(cell.containerTimePicker)
                    //
                    cell.containerTimePicker.topAnchor.constraint(equalTo: cell.containerDays.bottomAnchor,constant: 0).isActive = true
                    cell.containerTimePicker.centerXAnchor.constraint(equalTo: cell.containerDays.centerXAnchor).isActive = true
                    
                    button.isSelected = true
                    button.tintColor = UIColor.clear
                    cell.btnTuesday.layer.borderWidth = 3
                    cell.btnTuesday.layer.borderColor = UIColor(hex: self.appColorNew!).cgColor
                    cell.btnTuesday.setTitleColor(.white, for: .normal)
                    cell.btnTuesday.backgroundColor = UIColor(hex: self.appColorNew!)
                }
                else{
                    cell.pointerTuesday.isHidden = false
                    cell.pointerMonday.isHidden = true
                    cell.pointerWednesday.isHidden = true
                    cell.pointerThursday.isHidden = true
                    cell.pointerFriday.isHidden = true
                    cell.pointerSaturday.isHidden = true
                    cell.pointerSunday.isHidden = true
                    self.selctedDays.append(self.daysArray[1].dayName)
                    print(cell.selectedDay)

//                    self.selctedDays.remove(object: "T")
//                    //                    cell.selectedDay.remove(object: "Tuesday")
//                    //                    print(cell.selectedDay)
//                    print(self.selctedDays)
                    self.checkedDay.remove(object: true)
                    print(self.checkedDay)
//                    if self.selectedTimes.count != 0 {
//                        self.selectedTimes.remove(at: 1)
//                    }
//                    if self.selectedEndTimes.count != 0 {
//                        self.selectedEndTimes.remove(at: 1)
//
//                    }
                    if self.selectedTimes != nil{
                        cell.lblStartTimePicker.text = self.daysArray[1].startTime
                            //objdata.startTime
                            //self.selectedTimes[optional:1]
                    }
                    if self.selectedEndTimes != nil {
                        cell.lblEndTimePicker.text = self.daysArray[1].EndTime
                            //objdata.EndTime
                            //self.selectedEndTimes[optional:1]
                        
                    }
//                    cell.lblStartTimePicker.text = ""
//                    cell.lblEndTimePicker.text = ""
                    self.Tues = false
                    button.isSelected = false
                    cell.btnTuesday.backgroundColor = .clear
                    cell.btnTuesday.layer.cornerRadius = 20
                    cell.btnTuesday.layer.borderWidth = 1
                    cell.btnTuesday.layer.borderColor = UIColor(hex: self.appColorNew!).cgColor
                    cell.btnTuesday.setTitleColor(UIColor(hex: self.appColorNew!), for: .normal)
                    
                }
                
            }
            
            cell.btnWednesdayAction = { [self]() in
                
                guard  let button = cell.btnWednesday as? UIButton else{return}
                if self.selectedTimes != nil{
                    cell.lblStartTimePicker.text = daysArray[2].startTime
                        //objdata.startTime
                        //self.selectedTimes[optional:2]
                }
                if self.selectedEndTimes != nil {
                    cell.lblEndTimePicker.text = daysArray[2].EndTime
                        //objdata.EndTime
                        //self.selectedEndTimes[optional:2]
                    
                }
                if !button.isSelected{
                    
                    cell.pointerWednesday.isHidden = false
                    cell.pointerMonday.isHidden = true
                    cell.pointerTuesday.isHidden = true
                    cell.pointerThursday.isHidden = true
                    cell.pointerFriday.isHidden = true
                    cell.pointerSaturday.isHidden = true
                    cell.pointerSunday.isHidden = true
                    cell.pointerWednesday.tintColor = UIColor(hex: self.appColorNew!)
                    
                    //                    cell.selectedDay.append("Wednesday")
//                    self.selctedDays.append("Wednesday")
//                    print(self.selctedDays)
//                    self.checkedDay.append("true")
//                    print(self.checkedDay)
                    self.selctedDays.append(self.daysArray[2].dayName)
                    print(self.selctedDays)
                    objdata.closedDay = true

                    self.checkedDay.append(objdata.closedDay)

                    //                    print(cell.selectedDay)
                    self.Wed = true
                    cell.containerTimePicker.isHidden = false
                    cell.containerTimePicker.removeFromSuperview()
                    cell.containerTimePicker.translatesAutoresizingMaskIntoConstraints = false
                    self.view.addSubview(cell.containerTimePicker)
                    cell.containerTimePicker.topAnchor.constraint(equalTo: cell.containerDays.bottomAnchor,constant: 0).isActive = true
                    cell.containerTimePicker.centerXAnchor.constraint(equalTo: cell.containerDays.centerXAnchor).isActive = true
                    
                    button.isSelected = true
                    button.tintColor = UIColor.clear
                    cell.btnWednesday.layer.borderWidth = 3
                    cell.btnWednesday.layer.borderColor = UIColor(hex: self.appColorNew!).cgColor
                    cell.btnWednesday.setTitleColor(.white, for: .normal)
                    cell.btnWednesday.backgroundColor = UIColor(hex: self.appColorNew!)
                }else{
                    cell.pointerWednesday.isHidden = false
                    cell.pointerMonday.isHidden = true
                    cell.pointerTuesday.isHidden = true
                    cell.pointerThursday.isHidden = true
                    cell.pointerFriday.isHidden = true
                    cell.pointerSaturday.isHidden = true
                    cell.pointerSunday.isHidden = true
                    self.selctedDays.append(self.daysArray[2].dayName)
                    print(cell.selectedDay)

                    //                    cell.selectedDay.remove(object: "Wednesday")
                    
//                    self.selctedDays.remove(object: "Wednesday")
//                    print(self.selctedDays)
                    self.checkedDay.remove(object: true)
                    print(self.checkedDay)
//                    if self.selectedTimes.count != 0 {
//                        self.selectedTimes.remove(at: 2)
//                    }
//                    if self.selectedEndTimes.count != 0 {
//                        self.selectedEndTimes.remove(at: 2)
//
//                    }
//
                    self.Wed = false
                    if self.selectedTimes != nil{
                        cell.lblStartTimePicker.text = daysArray[2].startTime
                            //objdata.startTime
                            //self.selectedTimes[optional:2]
                    }
                    if self.selectedEndTimes != nil {
                        cell.lblEndTimePicker.text = daysArray[2].EndTime
                            //objdata.EndTime
                            //self.selectedEndTimes[optional:2]
                        
                    }
//                    cell.lblStartTimePicker.text = ""
//                    cell.lblEndTimePicker.text = ""
                    
                    //                    print(cell.selectedDay)
                    
                    button.isSelected = false
                    cell.btnWednesday.backgroundColor = .clear
                    cell.btnWednesday.layer.cornerRadius = 20
                    cell.btnWednesday.layer.borderWidth = 1
                    cell.btnWednesday.layer.borderColor = UIColor(hex: self.appColorNew!).cgColor
                    cell.btnWednesday.setTitleColor(UIColor(hex: self.appColorNew!), for: .normal)
                    
                }
                
                
            }
            cell.btnThursdayAction = {() in
                guard  let button = cell.btnThursday as? UIButton else{return}
                if self.selectedTimes != nil{
                    cell.lblStartTimePicker.text = self.daysArray[3].startTime
                        //objdata.startTime
                        //self.selectedTimes[optional:3]
                }
                if self.selectedEndTimes != nil {
                    cell.lblEndTimePicker.text = self.daysArray[3].EndTime
                        //objdata.EndTime
                        //self.selectedEndTimes[optional:3]
                    
                }
                if !button.isSelected{
                    cell.pointerThursday.isHidden = false
                    cell.pointerMonday.isHidden = true
                    cell.pointerWednesday.isHidden = true
                    cell.pointerTuesday.isHidden = true
                    cell.pointerFriday.isHidden = true
                    cell.pointerSaturday.isHidden = true
                    cell.pointerSunday.isHidden = true
                    cell.pointerThursday.tintColor = UIColor(hex: self.appColorNew!)
                    
                    //                    cell.selectedDay.append("Thursday")
//                    self.selctedDays.append("Thursday")
//                    print(self.selctedDays)
//                    self.checkedDay.append("true")
//                    print(self.checkedDay)
                    self.selctedDays.append(self.daysArray[3].dayName)
                    print(self.selctedDays)
                    objdata.closedDay = true

                    self.checkedDay.append(objdata.closedDay)

                    //                    print(cell.selectedDay)
                    self.Thurs = true
                    cell.containerTimePicker.isHidden = false
                    
                    cell.containerTimePicker.removeFromSuperview()
                    cell.containerTimePicker.translatesAutoresizingMaskIntoConstraints = false
                    self.view.addSubview(cell.containerTimePicker)
                    cell.containerTimePicker.topAnchor.constraint(equalTo: cell.containerDays.bottomAnchor,constant: 0).isActive = true
                    cell.containerTimePicker.centerXAnchor.constraint(equalTo: cell.containerDays.centerXAnchor).isActive = true
                    
                    button.isSelected = true
                    button.tintColor = UIColor.clear
                    cell.btnThursday.layer.borderWidth = 3
                    cell.btnThursday.layer.borderColor = UIColor(hex: self.appColorNew!).cgColor
                    cell.btnThursday.setTitleColor(.white, for: .normal)
                    cell.btnThursday.backgroundColor = UIColor(hex: self.appColorNew!)
                }else{
                    cell.pointerThursday.isHidden = false
                    cell.pointerMonday.isHidden = true
                    cell.pointerWednesday.isHidden = true
                    cell.pointerTuesday.isHidden = true
                    cell.pointerFriday.isHidden = true
                    cell.pointerSaturday.isHidden = true
                    cell.pointerSunday.isHidden = true
                    self.selctedDays.append(self.daysArray[3].dayName)
                    print(cell.selectedDay)

                    //                    cell.selectedDay.remove(object: "Thursday")
//                    self.selctedDays.remove(object: "Thursday")
//
//                    //                    self.selctedDays = self.selctedDays.filter(){$0 != "Thursday"}
//                    print(self.selctedDays)
                    self.checkedDay.remove(object: true)
                    print(self.checkedDay)
//                    if self.selectedTimes.count != 0 {
//                        self.selectedTimes.remove(at: 3)
//                    }
//                    if self.selectedEndTimes.count != 0 {
//                        self.selectedEndTimes.remove(at: 3)
//
//                    }
                    self.Thurs = false
//                    cell.lblStartTimePicker.text = ""
//                    cell.lblEndTimePicker.text = ""
                    if self.selectedTimes != nil{
                        cell.lblStartTimePicker.text = self.daysArray[3].startTime
                            //objdata.startTime
                            //self.selectedTimes[optional:3]
                    }
                    if self.selectedEndTimes != nil {
                        cell.lblEndTimePicker.text = self.daysArray[3].EndTime
                            //objdata.EndTime
                            //self.selectedEndTimes[optional:3]
                        
                    }
                    
                    //                    print(cell.selectedDay)
                    //                    var animals = ["cats", "dogs", "chimps", "moose", "chimps"]
                    //
                    //                    animals = animals.filter(){$0 != "chimps"}
                    //                    print(animals)
                    button.isSelected = false
                    cell.btnThursday.backgroundColor = .clear
                    cell.btnThursday.layer.cornerRadius = 20
                    cell.btnThursday.layer.borderWidth = 1
                    cell.btnThursday.layer.borderColor = UIColor(hex: self.appColorNew!).cgColor
                    cell.btnThursday.setTitleColor(UIColor(hex: self.appColorNew!), for: .normal)
                    
                }
            }
            
            cell.btnFirdayAction = {() in
                
                guard  let button = cell.btnFriday as? UIButton else{return}
                if self.selectedTimes != nil{
                    cell.lblStartTimePicker.text = self.daysArray[4].startTime
                        //objdata.startTime
                        //self.selectedTimes[optional:4]
                }
                if self.selectedEndTimes != nil {
                    cell.lblEndTimePicker.text = self.daysArray[4].EndTime
                        //objdata.EndTime
                        //self.selectedEndTimes[optional:4]
                    
                }
                if !button.isSelected{
                    cell.pointerFriday.isHidden = false
                    cell.pointerMonday.isHidden = true
                    cell.pointerWednesday.isHidden = true
                    cell.pointerThursday.isHidden = true
                    cell.pointerTuesday.isHidden = true
                    cell.pointerSaturday.isHidden = true
                    cell.pointerSunday.isHidden = true
                    cell.pointerFriday.tintColor = UIColor(hex: self.appColorNew!)
                    
                    //                    cell.selectedDay.append("Firday")
//                    self.selctedDays.append("Firday")
//                    print(self.selctedDays)
//                    self.checkedDay.append("true")
//                    print(self.checkedDay)
                    self.selctedDays.append(self.daysArray[4].dayName)
                    print(self.selctedDays)
                    objdata.closedDay = true

                    self.checkedDay.append(objdata.closedDay)

                    //                    print(cell.selectedDay)
                    self.Fri = true
                    cell.containerTimePicker.isHidden = false
                    
                    cell.containerTimePicker.removeFromSuperview()
                    cell.containerTimePicker.translatesAutoresizingMaskIntoConstraints = false
                    self.view.addSubview(cell.containerTimePicker)
                    cell.containerTimePicker.topAnchor.constraint(equalTo: cell.containerDays.bottomAnchor,constant: 0).isActive = true
                    cell.containerTimePicker.centerXAnchor.constraint(equalTo: cell.containerDays.centerXAnchor).isActive = true
                    
                    
                    button.isSelected = true
                    button.tintColor = UIColor.clear
                    cell.btnFriday.layer.borderWidth = 3
                    cell.btnFriday.layer.borderColor = UIColor(hex: self.appColorNew!).cgColor
                    cell.btnFriday.setTitleColor(.white, for: .normal)
                    cell.btnFriday.backgroundColor = UIColor(hex: self.appColorNew!)
                }
                else{
                    cell.pointerFriday.isHidden = false
                    cell.pointerMonday.isHidden = true
                    cell.pointerWednesday.isHidden = true
                    cell.pointerThursday.isHidden = true
                    cell.pointerTuesday.isHidden = true
                    cell.pointerSaturday.isHidden = true
                    cell.pointerSunday.isHidden = true
                    self.selctedDays.append(self.daysArray[4].dayName)
                    print(cell.selectedDay)

                    //                    cell.selectedDay.remove(object: "Firday")
                    
//                    self.selctedDays.remove(object: "Firday")
//                    print(self.selctedDays)
                    self.checkedDay.remove(object: true)
                    print(self.checkedDay)
                    
                    //                    print(cell.selectedDay)
//                    if self.selectedTimes.count != 0 {
//                        self.selectedTimes.remove(at: 4)
//                    }
//                    if self.selectedEndTimes.count != 0 {
//                        self.selectedEndTimes.remove(at: 4)
//
//                    }
                    self.Fri = false
                    if self.selectedTimes != nil{
                        cell.lblStartTimePicker.text = self.daysArray[4].startTime
                            //objdata.startTime
                            //self.selectedTimes[optional:4]
                    }
                    if self.selectedEndTimes != nil {
                        cell.lblEndTimePicker.text = self.daysArray[4].EndTime
                            //objdata.EndTime
                            //self.selectedEndTimes[optional:4]
                        
                    }
//                    cell.lblStartTimePicker.text = ""
//                    cell.lblEndTimePicker.text = ""
                    
                    button.isSelected = false
                    cell.btnFriday.backgroundColor = .clear
                    cell.btnFriday.layer.cornerRadius = 20
                    cell.btnFriday.layer.borderWidth = 1
                    cell.btnFriday.layer.borderColor = UIColor(hex: self.appColorNew!).cgColor
                    cell.btnFriday.setTitleColor(UIColor(hex: self.appColorNew!), for: .normal)
                    
                }
                
            }
            cell.btnSaturdayAction = {()in
                
                guard  let button = cell.btnSaturday as? UIButton else{return}
                if self.selectedTimes != nil{
                    cell.lblStartTimePicker.text = self.daysArray[5].startTime
                        //objdata.startTime
                        //self.selectedTimes[optional:5]
                }
                if self.selectedEndTimes != nil {
                    cell.lblEndTimePicker.text = self.daysArray[5].EndTime
                        //objdata.EndTime
                        //self.selectedEndTimes[optional:5]
                    
                }
                if !button.isSelected{
                    cell.pointerSaturday.isHidden = false
                    cell.pointerMonday.isHidden = true
                    cell.pointerWednesday.isHidden = true
                    cell.pointerThursday.isHidden = true
                    cell.pointerFriday.isHidden = true
                    cell.pointerTuesday.isHidden = true
                    cell.pointerSunday.isHidden = true
                    cell.pointerSaturday.tintColor = UIColor(hex: self.appColorNew!)
                    
                    //                    cell.selectedDay.append("Staurday")
//                    self.selctedDays.append("Staurday")
//                    print(self.selctedDays)
//                    self.checkedDay.append("true")
//                    print(self.checkedDay)
                    self.selctedDays.append(self.daysArray[5].dayName)
                    print(self.selctedDays)
                    objdata.closedDay = true

                    self.checkedDay.append(objdata.closedDay)

                    //                    print(cell.selectedDay)
                    self.Sat = true
                    cell.containerTimePicker.isHidden = false
                    
                    cell.containerTimePicker.removeFromSuperview()
                    
                    cell.containerTimePicker.translatesAutoresizingMaskIntoConstraints = false
                    self.view.addSubview(cell.containerTimePicker)
                    cell.containerTimePicker.topAnchor.constraint(equalTo: cell.containerDays.bottomAnchor,constant: 0).isActive = true
                    cell.containerTimePicker.centerXAnchor.constraint(equalTo: cell.containerDays.centerXAnchor).isActive = true
                    
                    
                    button.isSelected = true
                    button.tintColor = UIColor.clear
                    cell.btnSaturday.layer.borderWidth = 3
                    cell.btnSaturday.layer.borderColor = UIColor(hex: self.appColorNew!).cgColor
                    cell.btnSaturday.setTitleColor(.white, for: .normal)
                    cell.btnSaturday.backgroundColor = UIColor(hex: self.appColorNew!)
                }
                else{
                    cell.pointerSaturday.isHidden = false
                    cell.pointerMonday.isHidden = true
                    cell.pointerWednesday.isHidden = true
                    cell.pointerThursday.isHidden = true
                    cell.pointerFriday.isHidden = true
                    cell.pointerTuesday.isHidden = true
                    cell.pointerSunday.isHidden = true
                    self.selctedDays.append(self.daysArray[5].dayName)
                    print(cell.selectedDay)

                    //                    cell.selectedDay.remove(object: "Staurday")
                    
//                    self.selctedDays.remove(object: "Staurday")
//                    print(self.selctedDays)
                    self.checkedDay.remove(object: true)
                    print(self.checkedDay)
//                    if self.selectedTimes.count != 0 {
//                        self.selectedTimes.remove(at: 5)
//                    }
//                    if self.selectedEndTimes.count != 0 {
//                        self.selectedEndTimes.remove(at: 5)
//
//                    }
                    self.Sat = false
                    if self.selectedTimes != nil{
                        cell.lblStartTimePicker.text = self.daysArray[5].startTime
                            //objdata.startTime
                            //self.selectedTimes[optional:5]
                    }
                    if self.selectedEndTimes != nil {
                        cell.lblEndTimePicker.text = self.daysArray[5].EndTime
                            //objdata.EndTime
                            //self.selectedEndTimes[optional:5]
                        
                    }
//                    cell.lblStartTimePicker.text = ""
//                    cell.lblEndTimePicker.text = ""
                    
                    //                    print(cell.selectedDay)
                    
                    button.isSelected = false
                    cell.btnSaturday.backgroundColor = .clear
                    cell.btnSaturday.layer.cornerRadius = 20
                    cell.btnSaturday.layer.borderWidth = 1
                    cell.btnSaturday.layer.borderColor = UIColor(hex: self.appColorNew!).cgColor
                    cell.btnSaturday.setTitleColor(UIColor(hex: self.appColorNew!), for: .normal)
                    
                }
                
            }
            
            cell.btnSundayAction = {() in
                
                guard  let button = cell.btnSunday as? UIButton else{return}
                if self.selectedTimes != nil{
                    cell.lblStartTimePicker.text = self.daysArray[6].startTime
                        //objdata.startTime
                    //self.selectedTimes[optional:6]
                }
                if self.selectedEndTimes != nil {
                    cell.lblEndTimePicker.text = self.daysArray[6].EndTime
                        //objdata.EndTime
                        //self.selectedEndTimes[optional:6]
                    
                }
                if !button.isSelected{
                    cell.pointerSunday.isHidden = false
                    cell.pointerMonday.isHidden = true
                    cell.pointerWednesday.isHidden = true
                    cell.pointerThursday.isHidden = true
                    cell.pointerFriday.isHidden = true
                    cell.pointerSaturday.isHidden = true
                    cell.pointerTuesday.isHidden = true
                    cell.pointerSunday.tintColor = UIColor(hex: self.appColorNew!)
                    
                    //                    cell.selectedDay.append("Sunday")
//                    self.selctedDays.append("Sunday")
//                    //                    print(cell.selectedDay)
//                    print(self.selctedDays)
//                    self.checkedDay.append("true")
//                    print(self.checkedDay)
                    self.selctedDays.append(self.daysArray[6].dayName)
                    print(self.selctedDays)
                    objdata.closedDay = true

                    self.checkedDay.append(objdata.closedDay)
                    self.Sun = true
                    cell.containerTimePicker.isHidden = false
                    
                    cell.containerTimePicker.removeFromSuperview()
                    cell.containerTimePicker.translatesAutoresizingMaskIntoConstraints = false
                    self.view.addSubview(cell.containerTimePicker)
                    cell.containerTimePicker.topAnchor.constraint(equalTo: cell.containerDays.bottomAnchor,constant: 0).isActive = true
                    cell.containerTimePicker.centerXAnchor.constraint(equalTo: cell.containerDays.centerXAnchor).isActive = true
                    
                    
                    button.isSelected = true
                    button.tintColor = UIColor.clear
                    cell.btnSunday.layer.borderWidth = 3
                    cell.btnSunday.layer.borderColor = UIColor(hex: self.appColorNew!).cgColor
                    cell.btnSunday.backgroundColor = UIColor(hex: self.appColorNew!)
                    cell.btnSunday.setTitleColor(.white, for: .normal)
                }
                else{
                    cell.pointerSunday.isHidden =  false
                    cell.pointerMonday.isHidden = true
                    cell.pointerWednesday.isHidden = true
                    cell.pointerThursday.isHidden = true
                    cell.pointerFriday.isHidden = true
                    cell.pointerSaturday.isHidden = true
                    cell.pointerTuesday.isHidden = true
                    self.selctedDays.append(self.daysArray[6].dayName)
                    print(cell.selectedDay)
                    self.Sun = false

                    //                    cell.selectedDay.remove(object: "Sunday")
//                    self.selctedDays.remove(object: "Sunday")
//                    print(self.selctedDays)
                    self.checkedDay.remove(object: true)
                    print(self.checkedDay)
//                    if self.selectedTimes.count != 0 {
//                        self.selectedTimes.remove(at: 6)
//                    }
//                    if self.selectedEndTimes.count != 0 {
//                        self.selectedEndTimes.remove(at: 6)
//
//                    }
                    
//                    cell.lblStartTimePicker.text = ""
//                    cell.lblEndTimePicker.text = ""
                    if self.selectedTimes != nil{
                        cell.lblStartTimePicker.text = self.daysArray[6].startTime
                            //objdata.startTime
                        //self.selectedTimes[optional:6]
                    }
                    if self.selectedEndTimes != nil {
                        cell.lblEndTimePicker.text = self.daysArray[6].EndTime
                            //objdata.EndTime
                            //self.selectedEndTimes[optional:6]
                        
                    }
                    //                    print(cell.selectedDay)
                    button.isSelected = false
                    cell.btnSunday.backgroundColor = .clear
                    cell.btnSunday.layer.cornerRadius = 20
                    cell.btnSunday.layer.borderWidth = 1
                    cell.btnSunday.layer.borderColor = UIColor(hex: self.appColorNew!).cgColor
                    cell.btnSunday.setTitleColor(UIColor(hex: self.appColorNew!), for: .normal)
                    
                }
            }
            
            cell.btnCalendarAction = { () in
                let timeSelector = TimeSelector()
                timeSelector.timeSelected = { [self]
                    (timeSelector) in
                    self.setLabelFromDate(timeSelector.date)
                    cell.lblStartTimePicker.text = self.dates
                   

//                    if selectedTimes.indices.contains(0) {
//                         //Now you can check whether element is empty or not.
//                         // Do your tuffs
//                        self.selectedTimes.insert(self.dates, at: 0)
//
//                    }else {
//                       //insert new element
//                        print("asasssas")
//                    }
//                    if selectedTimes.indices.contains(1) {
//                         //Now you can check whether element is empty or not.
//                         // Do your tuffs
//                        self.selectedTimes.insert(self.dates, at: 1)
//
//                    }else {
//                       //insert new element
//                        print("asasssas")
//                    }
//                    if selectedTimes.indices.contains(2) {
//                         //Now you can check whether element is empty or not.
//                         // Do your tuffs
//                        self.selectedTimes.insert(self.dates, at: 2)
//
//                    }else {
//                       //insert new element
//                        print("asasssas")
//                    }
//                    if selectedTimes.indices.contains(3) {
//                         //Now you can check whether element is empty or not.
//                         // Do your tuffs
//                        self.selectedTimes.insert(self.dates, at: 3)
//
//                    }else {
//                       //insert new element
//                        print("asasssas")
//                    }
//                    if selectedTimes.indices.contains(4) {
//                         //Now you can check whether element is empty or not.
//                         // Do your tuffs
//                        self.selectedTimes.insert(self.dates, at: 4)
//
//                    }else {
//                       //insert new element
//                        index = index + 1
//
//                        print("asasssas")
//                    }
//                    if selectedTimes.indices.contains(5) {
//                         //Now you can check whether element is empty or not.
//                         // Do your tuffs
//                        self.selectedTimes.insert(self.dates, at: 5)
//
//                    }else {
//                       //insert new element
//                        print("asasssas")
//                    }
//                    if selectedTimes.indices.contains(6) {
//                         //Now you can check whether element is empty or not.
//                         // Do your tuffs
//                        self.selectedTimes.insert(self.dates, at: 6)
//
//                    }else {
//                       //insert new element
//                        print("asasssas")
//                    }
//                    if self.Mon == true{
//                        self.selectedTimes.insert(self.dates, at: 0)
//
//                    }
//                    else if self.Tues == true{
//                        self.selectedTimes.insert(self.dates, at: 1)
//
//                    }
//                    else if self.Wed == true{
//                        self.selectedTimes.insert(self.dates, at: 2)
//
//                    }
//                    else if self.Thurs == true{
//                        self.selectedTimes.insert(self.dates, at: 3)
//
//                    }
//                    else if self.Fri == true{
//                        self.selectedTimes.insert(self.dates, at: 4)
//
//                    }
//                    else if self.Sat == true{
//                        self.selectedTimes.insert(self.dates, at: 5)
//
//                    }
//                    else if self.Sun == true{
//                        self.selectedTimes.insert(self.dates, at: 6)
//
//                    }
                    
                    self.selectedTimes.append(self.dates)
                    
                    
                    
                }
                timeSelector.overlayAlpha = 0.8
                timeSelector.clockTint = timeSelector_rgb(0, 230, 0)
                timeSelector.minutes = 30
                timeSelector.hours = 5
                timeSelector.isAm = false
                timeSelector.presentOnView(view: self.view)
            }
            
            
            
            cell.btnEndCalendarAction = { () in
                let timeSelector = TimeSelector()
                timeSelector.timeSelected = { [self]
                    (timeSelector) in
                    self.setLabelFromDate(timeSelector.date)
                    cell.lblEndTimePicker.text = self.dates
                    
//                    if selectedEndTimes.indices.contains(0) {
//                         //Now you can check whether element is empty or not.
//                         // Do your tuffs
//                        self.selectedEndTimes.insert(self.dates, at: 0)
//
//                    }else {
//                       //insert new element
//                        print("asasssas")
//                    }
//                    if selectedEndTimes.indices.contains(1) {
//                         //Now you can check whether element is empty or not.
//                         // Do your tuffs
//                        self.selectedEndTimes.insert(self.dates, at: 1)
//
//                    }else {
//                       //insert new element
//                        print("asasssas")
//                    }
//                    if selectedEndTimes.indices.contains(2) {
//                         //Now you can check whether element is empty or not.
//                         // Do your tuffs
//                        self.selectedEndTimes.insert(self.dates, at: 2)
//
//                    }else {
//                       //insert new element
//                        print("asasssas")
//                    }
//                    if selectedEndTimes.indices.contains(3) {
//                         //Now you can check whether element is empty or not.
//                         // Do your tuffs
//                        self.selectedEndTimes.insert(self.dates, at: 3)
//
//                    }else {
//                       //insert new element
//                        print("asasssas")
//                    }
//                    if selectedEndTimes.indices.contains(4) {
//                         //Now you can check whether element is empty or not.
//                         // Do your tuffs
//                        self.selectedEndTimes.insert(self.dates, at: 4)
//
//                    }else {
//                       //insert new element
//                        self.selectedEndTimes.insert(self.dates, at: 4)
//
//                        print("asasssas")
//                    }
//                    if selectedEndTimes.indices.contains(5) {
//                         //Now you can check whether element is empty or not.
//                         // Do your tuffs
//                        self.selectedEndTimes.insert(self.dates, at: 5)
//
//                    }else {
//                       //insert new element
//                        print("asasssas")
//                    }
//                    if selectedEndTimes.indices.contains(6) {
//                         //Now you can check whether element is empty or not.
//                         // Do your tuffs
//                        self.selectedEndTimes.insert(self.dates, at: 6)
//
//                    }else {
//                       //insert new element
//                        print("asasssas")
//                    }
                    
//                    if self.Mon == true{
//                        self.selectedEndTimes.insert(self.dates, at: 0)
//
//                    }
//                    else if self.Tues == true{
//                        self.selectedEndTimes.insert(self.dates, at: 1)
//
//                    }
//                    else if self.Wed == true{
//                        self.selectedEndTimes.insert(self.dates, at: 2)
//
//                    }
//                    else if self.Thurs == true{
//                        self.selectedEndTimes.insert(self.dates, at: 3)
//
//                    }
//                    else if self.Fri == true{
//                        self.selectedEndTimes.insert(self.dates, at: 4)
//
//                    }
//                    else if self.Sat == true{
//                        self.selectedEndTimes.insert(self.dates, at: 5)
//
//                    }
//                    else if self.Sun == true{
//                        self.selectedEndTimes.insert(self.dates, at: 6)
//
//                    }
                    self.selectedEndTimes.append(self.dates)
                    
                }
                timeSelector.overlayAlpha = 0.8
                timeSelector.clockTint = timeSelector_rgb(0, 230, 0)
                timeSelector.minutes = 30
                timeSelector.hours = 5
                timeSelector.isAm = false
                timeSelector.presentOnView(view: self.view)
                
            }
            
            return cell
            
        }
        return UITableViewCell()
        
    }
    func setLabelFromDate(_ date: Date) {
        let df = DateFormatter()
        df.dateStyle = .none
        df.timeStyle = .short
        dates = df.string(from: date)
        print(dates!)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = indexPath.section
        var height: CGFloat = 0
        
        if section == 0{
            height = UITableView.automaticDimension
        }
        return height
    }
    
    @objc func btnSubmitTapped(){
        if notAvailable == true {
            print("NotAvailable: \(self.availabilityType)")
            self.selectedTimes.removeAll()
            self.selectedEndTimes.removeAll()
            self.selctedDays.removeAll()
            self.checkedDay.removeAll()
            let finalParameter  = ["hour_type":availabilityType!,"zones":"","days":""] as [String : Any]

            let jsonData = try? JSONSerialization.data(withJSONObject: finalParameter, options: [])
            let jsonString = String(data: jsonData!, encoding: .utf8)!
            print(jsonString)
            
            
            var params = jsonToDictionary(from: jsonString) ?? [String : Any]()
             print(params)
            candidatePost(param: params as NSDictionary)
        }
        else if allTime == true {
            print("ALL TIme:\(self.availabilityType)")
            self.selectedTimes.removeAll()
            self.selectedEndTimes.removeAll()
            self.selctedDays.removeAll()
            self.checkedDay.removeAll()
            
            let finalParameter  = ["hour_type":availabilityType!,"zones":"","days":""] as [String : Any]

            let jsonData = try? JSONSerialization.data(withJSONObject: finalParameter, options: [])
            let jsonString = String(data: jsonData!, encoding: .utf8)!
            print(jsonString)
            
            
            var params = jsonToDictionary(from: jsonString) ?? [String : Any]()
             print(params)
            candidatePost(param: params as NSDictionary)
            
        }else{
            
            let str1 = selectedTimes[optional: 0]
            let str2 = selectedEndTimes[optional: 0]
            let str3 = selctedDays[optional: 0]
            let str4 = checkedDay[optionalBool: 0]
            
            let strIndex1 = selectedTimes[optional: 1]
            let strIndex2 = selectedEndTimes[optional: 1]
            let  strIndex3 = selctedDays[optional: 1]
            let strIndex4 = checkedDay[optionalBool: 1]
            
            let stIndex1 = selectedTimes[optional: 2]
            let stIndex2 = selctedDays[optional: 2]
            let stIndex3 = selectedEndTimes[optional: 2]
            let stIndex4 = checkedDay[optionalBool: 2]
            
            
            let stoIndex = selctedDays[optional: 3]
            let stoIndex1 = selectedTimes[optional: 3]
            let stoIndex2 = selectedEndTimes[optional: 3]
            let stoIndex3 = checkedDay[optionalBool: 3]
            
            
            let stpIndex = selctedDays[optional: 4]
            let stpIndex1 = selectedTimes[optional: 4]
            let stpIndex2 = selectedEndTimes[optional: 4]
            let stpIndex3 = checkedDay[optionalBool: 4]
            
            let styIndex = selectedTimes[optional: 5]
            let styIndex1 = selctedDays[optional: 5]
            let styIndex2 = selectedEndTimes[optional: 5]
            let styIndex3 = checkedDay[optionalBool: 5]
            
            let rtyIndex = selectedTimes[optional: 6]
            let rtyIndex1 = selectedEndTimes[optional: 6]
            let rtyIndex2 = selctedDays[optional: 6]
            let rtyIndex3 = checkedDay[optionalBool: 6]
            
//            availabilitiesDict["days"] = [
//                                                    ["start_time":str1,"end_time":str2,"day_name":str3,"closed":str4],
//                                                    ["start_time":strIndex1,"end_time":strIndex2,"day_name":strIndex3,"closed":strIndex4],
//                                                    ["start_time":stIndex1,"end_time":stIndex2,"day_name":stIndex3,"closed":stIndex4],
//                                                    ["start_time":stoIndex,"end_time":stoIndex1,"day_name":stoIndex2,"closed":stoIndex3],
//                                                    ["start_time":stpIndex,"end_time":stpIndex1,"day_name":stpIndex2,"closed":stpIndex3],
//                                                    ["start_time":styIndex,"end_time":styIndex1,"day_name":styIndex2,"closed":styIndex3],
//                                                    ["start_time":rtyIndex,"end_time":rtyIndex1,"day_name":rtyIndex2,"closed":rtyIndex3]]
////            candAvailDict["CanArray"]
//            
//            
//
//            var parameter: [String: Any] = [
//                "hours_type":availabilityType!,
//                "zones":selectedTimeZone!
//            
//            
//            ]
//            
//            
//
////            customDictionary["days"] = [
////                ["start_time":str1,"end_time":str2,"day_name":str3,"closed":str4],
////                ["start_time":strIndex1,"end_time":strIndex2,"day_name":strIndex3,"closed":strIndex4],
////                ["start_time":stIndex1,"end_time":stIndex2,"day_name":stIndex3,"closed":stIndex4],
////                ["start_time":stoIndex,"end_time":stoIndex1,"day_name":stoIndex2,"closed":stoIndex3],
////                ["start_time":stpIndex,"end_time":stpIndex1,"day_name":stpIndex2,"closed":stpIndex3],
////                ["start_time":styIndex,"end_time":styIndex1,"day_name":styIndex2,"closed":styIndex3],
////                ["start_time":rtyIndex,"end_time":rtyIndex1,"day_name":rtyIndex2,"closed":rtyIndex3]]
////            customDictionary.merge(with: localDictionary)
            var yourOtherArray = [
                
                ["start_time":str1,"end_time":str2,"day_name":str3,"closed":str4],
                ["start_time":strIndex1,"end_time":strIndex2,"day_name":strIndex3,"closed":strIndex4],
                ["start_time":stIndex1,"end_time":stIndex2,"day_name":stIndex3,"closed":stIndex4],
                ["start_time":stoIndex,"end_time":stoIndex1,"day_name":stoIndex2,"closed":stoIndex3],
                ["start_time":stpIndex,"end_time":stpIndex1,"day_name":stpIndex2,"closed":stpIndex3],
                ["start_time":styIndex,"end_time":styIndex1,"day_name":styIndex2,"closed":styIndex3],
                ["start_time":rtyIndex,"end_time":rtyIndex1,"day_name":rtyIndex2,"closed":rtyIndex3]
            ]
//            let custom = Constants.json(from: yourOtherArray)
//            if AddsHandler.sharedInstance.isCategoeyTempelateOn {
//            let param: [String: Any] = ["days": custom!]
//            parameter.merge(with: param)
//            }
//            parameter.merge(with: addInfoDictionary)
//            parameter.merge(with: customDictionary)
//            print(parameter)

//            var category_json = [[String:Any]]()


            let finalParameter  = ["hour_type":availabilityType!,"zones":selectedTimeZone!,"days":yourOtherArray] as [String : Any]
//            let dataFinal  = Constants.json(from: finalParameter)
//            print(dataFinal! as String)
//            category_json.append(finalParameter)
//
//            category_json.append(availabilitiesDict)
//         let finlStuff   = [category_json]
//            print(finlStuff)
            let jsonData = try? JSONSerialization.data(withJSONObject: finalParameter, options: [])
            let jsonString = String(data: jsonData!, encoding: .utf8)!
            print(jsonString)
            
            
            var params = jsonToDictionary(from: jsonString) ?? [String : Any]()

            
//            let param: [String: Any] =
//                [
//                "hours_type":availabilityType!,"zones":selectedTimeZone!,"days":yourOtherArray
//            ]
//print(param)
            candidatePost(param: params as NSDictionary)
            
            
        }
        
        
    }
    func jsonToDictionary(from text: String) -> [String: Any]? {
        guard let data = text.data(using: .utf8) else { return nil }
        let anyResult = try? JSONSerialization.jsonObject(with: data, options: [])
        return anyResult as? [String: Any]
    }

    @objc func moveToParentController() {
        self.navigationController?.popViewController(animated: true)
    }
    

    func candidatePost(param: NSDictionary){
//        self.showLoader
        print(param)
        UserHandler.nokri_postCandidateAvailableData(parameter: param) { (successResponse) in
            
            self.stopAnimating()
            if successResponse.success {
//                let alert = Constants.showBasicAlert(message: successResponse.message)
//                self.present(alert, animated: true, completion: nil)
                // Create the alert controller
                let alertController = UIAlertController(title: "Title", message: successResponse.message, preferredStyle: .alert)

                        // Create the actions
                let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                            UIAlertAction in
                    self.perform(#selector(self.moveToParentController), with: nil, afterDelay: 1)

                    
                            print("OK Pressed")
                        }
//                let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
//                            UIAlertAction in
//                            print("Cancel Pressed")
//                        }

                        // Add the actions
                        alertController.addAction(okAction)
//                        alertController.addAction(cancelAction)

                        // Present the controller
                        self.present(alertController, animated: true, completion: nil)

             
            }
        }
        failure: { (error) in
            print(error)
        }

    }
    func candidateAvailablilityData(){
        self.showLoader()
        UserHandler.nokri_candidateAvailability(success: { [self] (successResponse) in
            
            self.stopAnimating()
            if successResponse.success {
                print(successResponse.data.hoursType as Any)
                self.TimeZones = successResponse.data.zones
                print(self.TimeZones)
                self.daysArray = successResponse.data.days
                print(self.daysArray)
                for item in TimeZones{
                    if item.selcted == true {
                        print(item.value)
                        lblTimeZone.text = item.value
                        selectedTimeZone = item.value
                        break
                    }
                    else{
                        lblTimeZone.text = TimeZones[0].value
                    }
                }
//                self.selctedDays.append(self.daysArray[0].dayName)
//                self.selctedDays.append(self.daysArray[1].dayName)
//                self.selctedDays.append(self.daysArray[2].dayName)
//                self.selctedDays.append(self.daysArray[3].dayName)
//                self.selctedDays.append(self.daysArray[4].dayName)
//                self.selctedDays.append(self.daysArray[5].dayName)
//                self.selctedDays.append(self.daysArray[6].dayName)
                 heading = successResponse.data.extra.candAvailability
                print(heading!)
                lblScreenTitle.text = heading!
                headingTimeType = successResponse.data.extra.selectedHours
                print(headingTimeType!)
                headinglblHours.text = headingTimeType!
                timeZonesHeading = successResponse.data.extra.timeZone
                print(timeZonesHeading!)
                lblTZones.text = timeZonesHeading!
                btnSubmit = successResponse.data.extra.submit
                print(btnSubmit!)
                submitBtn.setTitle(btnSubmit!, for: .normal)
                to = successResponse.data.extra.to
                print(to!)
                
                openAllTime = successResponse.data.extra.open
                print(openAllTime!)
                lblAllTime.text = openAllTime!
                selectiveHours = successResponse.data.extra.selectiveHours
                print(selectiveHours!)
                lblSelctedHours.text = selectiveHours!
                notAvailableHeading = successResponse.data.extra.notAvailable
                lblNotAvailable.text = notAvailableHeading!
                print(notAvailableHeading!)
                if successResponse.data.hoursType != nil {
                    self.availabilityType = successResponse.data.hoursType
                    print(self.availabilityType!)
     
                }
                
                if  self.availabilityType == "0" {
                    lblNotAvailable.layer.borderWidth = 3
                    lblNotAvailable.backgroundColor = UIColor(hex: appColorNew!)
                    lblNotAvailable.textColor = UIColor.white
                    tableView.isHidden = true
                    notAvailable = true
                    allTime = false
                    for subview in self.tableView.subviews {
                        subview.removeFromSuperview()
                    }
                    if selctedDays != nil {
                        selctedDays.removeAll()
                    }
                    if selectedTimes != nil {
                        selectedTimes.removeAll()
                    }
                    if selectedEndTimes != nil{
                        selectedEndTimes.removeAll()
                    }
                    if selectedTimeZone != nil {
                        selectedTimeZone.removeAll()
                    }
                    //others
                    lblSelctedHours.layer.borderWidth = 1
                    lblSelctedHours.layer.borderColor = UIColor(hex: appColorNew!).cgColor
                    lblSelctedHours.backgroundColor = UIColor.clear
                    lblSelctedHours.textColor = UIColor.black
                    
                    lblAllTime.layer.borderWidth = 1
                    lblAllTime.layer.borderColor = UIColor(hex: appColorNew!).cgColor
                    lblAllTime.backgroundColor = UIColor.clear
                    lblAllTime.textColor = UIColor.black                }
                else if self.availabilityType == "1" {
                    tableView.isHidden = true
                    allTime = true
                    notAvailable = false
                    if selctedDays != nil {
                        selctedDays.removeAll()
                    }
                    if selectedTimes != nil {
                        selectedTimes.removeAll()
                    }
                    if selectedEndTimes != nil{
                        selectedEndTimes.removeAll()
                    }
                    if selectedTimeZone != nil {
                        selectedTimeZone.removeAll()
                        
                    }
                    for subview in self.tableView.subviews {
                        subview.removeFromSuperview()
                    }
                    lblAllTime.layer.borderWidth = 3
                    lblAllTime.backgroundColor = UIColor(hex: appColorNew!)
                    lblAllTime.textColor = UIColor.white
                    //others
                    lblSelctedHours.layer.borderWidth = 1
                    lblSelctedHours.layer.borderColor = UIColor(hex: appColorNew!).cgColor
                    lblSelctedHours.backgroundColor = UIColor.clear
                    lblSelctedHours.textColor = UIColor.black
                    
                    
                    lblNotAvailable.layer.borderWidth = 1
                    lblNotAvailable.layer.borderColor = UIColor(hex: appColorNew!).cgColor
                    lblNotAvailable.backgroundColor = UIColor.clear
                    lblNotAvailable.textColor = UIColor.black                }
                else if self.availabilityType ==  "2" {
                    self.notAvailable = false
                    allTime = false
                    
                    tableView.isHidden = false
                    containerTzones.isHidden = false
                    lblTZones.isHidden = false
                    tableView.reloadData()
                    //        for subview in self.tableView.subviews {
                    //               subview.addSubview(subview)
                    //        }
                    lblSelctedHours.layer.borderWidth = 3
                    lblSelctedHours.backgroundColor = UIColor(hex: appColorNew!)
                    lblSelctedHours.textColor = UIColor.white
                    //others
                    lblAllTime.layer.borderWidth = 1
                    lblAllTime.layer.borderColor = UIColor(hex: appColorNew!).cgColor
                    lblAllTime.backgroundColor = UIColor.clear
                    lblAllTime.textColor = UIColor.black
                    
                    
                    lblNotAvailable.layer.borderWidth = 1
                    lblNotAvailable.layer.borderColor = UIColor(hex: appColorNew!).cgColor
                    lblNotAvailable.backgroundColor = UIColor.clear
                    lblNotAvailable.textColor = UIColor.black
                    
                }

            }
            else {
                let alert = Constants.showBasicAlert(message: "error")
                self.present(alert, animated: true, completion: nil)
                self.showLoader()
                
                
            }
        }) { (error) in
            self.showLoader()
            
            
            let alert = Constants.showBasicAlert(message: error.message)
            self.present(alert, animated: true, completion: nil)
            self.stopAnimating()
        }
        
    }
    
    
}
extension TimeZone {
    static var random: TimeZone? {
        return TimeZone(secondsFromGMT: Int.random(in: -43200...50400))
    }
}
extension Collection {
    
    subscript(optional i: Index) -> Iterator.Element? {
        return self.indices.contains(i) ? self[i] : "" as! Self.Element
    }
    subscript(optionalBool i: Index) -> Iterator.Element? {
        return self.indices.contains(i) ? self[i] : false as! Self.Element
    }
}


extension Date {
    func localDate() -> Date {
        let nowUTC = Date()
        let timeZoneOffset = Double(TimeZone.current.secondsFromGMT(for: nowUTC))
        guard let localDate = Calendar.current.date(byAdding: .second, value: Int(timeZoneOffset), to: nowUTC) else {return Date()}
        
        return localDate
    }
}
