//
//  BaseTableViewCell.swift
//  Opportunities
//
//  Created by Furqan Nadeem on 4/11/18.
//  Copyright © 2018 Furqan Nadeem. All rights reserved.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    
    static let identifier = "baseCell"
    
    @IBOutlet weak var imageMenuItems: UIImageView!
    @IBOutlet weak var lblMenuItems: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        nokri_setup()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        nokri_setup()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    open class func height() -> CGFloat {
        return 48
    }
    
    open func setData(_ data: Any?) {
        
        self.backgroundColor = UIColor(hex: "000000")
        self.lblMenuItems?.font = UIFont.italicSystemFont(ofSize: 12)
        self.lblMenuItems?.textColor = UIColor(hex: "FFFFFF")
        if let menuText = data as? String {
            self.lblMenuItems?.text = menuText
        }
    }
    
    override open func setHighlighted(_ highlighted: Bool, animated: Bool) {
        if highlighted {
            self.alpha = 0.4
        } else {
            self.alpha = 1.0
        }
    }
    
    open func nokri_setup() {
    }
    
}

