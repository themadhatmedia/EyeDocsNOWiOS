//
//  CandidateAvailableTimeTableViewCell.swift
//  Nokri
//
//  Created by Apple on 19/12/2020.
//  Copyright © 2020 Furqan Nadeem. All rights reserved.
//

import UIKit

class CandidateAvailableTimeTableViewCell: UITableViewCell {
    @IBOutlet weak var lblDaySunday: UILabel!
    @IBOutlet weak var lblSundayTimeValue: UILabel!
    @IBOutlet weak var lblDaySaturday: UILabel!
    @IBOutlet weak var lblStaurdayTimeValue: UILabel!
    @IBOutlet weak var lblFirdayTimeValue: UILabel!
    @IBOutlet weak var lblDayFriday: UILabel!
    @IBOutlet weak var lblDayThursday: UILabel!
    @IBOutlet weak var lblThursdayTimeValue: UILabel!
    @IBOutlet weak var lblWednesdayTimeValue: UILabel!
    @IBOutlet weak var lblDayWednesday: UILabel!
    @IBOutlet weak var lblTuesdayTimeValue: UILabel!
    @IBOutlet weak var lblDayTuesday: UILabel!
    @IBOutlet weak var lblMondayTimeValue: UILabel!
    @IBOutlet weak var lblDayMonday: UILabel!
    @IBOutlet weak var containerMainDaysTime: UIView!
    @IBOutlet weak var lblTimeZoneValue: UILabel!
    @IBOutlet weak var lblTimeZoneHeading: UILabel!
    @IBOutlet weak var containerTimeZone: UIView!
    @IBOutlet weak var lblOpenNow: UILabel!
    @IBOutlet weak var imgClock: UIImageView!
    @IBOutlet weak var containerClockImg: UIView!
    @IBOutlet weak var mainContainerData: UIView!
    @IBOutlet weak var mainContainer: UIView!
    
    
    
    //MARK:-Properties
    var appColorNew = UserDefaults.standard.string(forKey: "app_Color")

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        print(Date().dayOfWeek()!) // Wednesday
//        self.lblColor()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
extension Date {
    func dayOfWeek() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self).capitalized
        // or use capitalized(with: locale) if you want
    }
}
