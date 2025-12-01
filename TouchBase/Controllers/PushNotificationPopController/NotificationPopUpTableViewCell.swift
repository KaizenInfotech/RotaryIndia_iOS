//
//  NotificationPopUpTableViewCell.swift
//  TouchBase
//
//  Created by rajendra on 17/07/17.
//  Copyright © 2017 Parag. All rights reserved.
//

import UIKit

class NotificationPopUpTableViewCell: UITableViewCell {

    
    @IBOutlet weak var buttonAnniVersaryCount: UIButton!
    @IBOutlet weak var buttonCount: UIButton!
    @IBOutlet weak var labelNotificationAnniversaryCount: UILabel!
    @IBOutlet weak var labelNotificationBdayCount: UILabel!
    @IBOutlet weak var labelNotificationCount: UILabel!
    @IBOutlet weak var buttonMessage: UIButton!
    @IBOutlet weak var buttonCall: UIButton!
    @IBOutlet weak var labelKey: UILabel!
    @IBOutlet weak var labelValue: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        buttonCall.isHidden=true
        buttonMessage.isHidden=true
        
//        labelValue.layer.cornerRadius = 1.0
//        labelValue.layer.borderColor = UIColor.lightGrayColor().CGColor
//        labelValue.layer.borderWidth = 1.0
        
        
//                buttonCount.layer.borderWidth = 1.0
//                buttonCount.layer.masksToBounds = false
//                buttonCount.layer.borderColor = UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0).CGColor
//                buttonCount.layer.cornerRadius = buttonCount.frame.size.width/2
//                buttonCount.clipsToBounds = true
//        buttonAnniVersaryCount.layer.borderWidth = 1.0
//        buttonAnniVersaryCount.layer.masksToBounds = false
//        buttonAnniVersaryCount.layer.borderColor = UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0).CGColor
//        buttonAnniVersaryCount.layer.cornerRadius = buttonAnniVersaryCount.frame.size.width/2
//        buttonAnniVersaryCount.clipsToBounds = true
//        
//        
       
//
//        labelNotificationAnniversaryCount.layer.borderWidth = 1.0
//        labelNotificationAnniversaryCount.layer.masksToBounds = false
//        labelNotificationAnniversaryCount.layer.borderColor = UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0).CGColor
//        labelNotificationAnniversaryCount.layer.cornerRadius = labelNotificationAnniversaryCount.frame.size.width/2
//        labelNotificationAnniversaryCount.clipsToBounds = true
//        
//        
//        
//        
//        labelNotificationBdayCount.layer.borderWidth = 1.0
//        labelNotificationBdayCount.layer.masksToBounds = false
//        labelNotificationBdayCount.layer.borderColor = UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0).CGColor
//        labelNotificationBdayCount.layer.cornerRadius = labelNotificationBdayCount.frame.size.width/2
//        labelNotificationBdayCount.clipsToBounds = true
//        
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
