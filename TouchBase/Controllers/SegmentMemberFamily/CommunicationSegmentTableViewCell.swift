//
//  CommunicationSegmentTableViewCell.swift
//  TouchBase
//
//  Created by rajendra on 17/07/17.
//  Copyright © 2017 Parag. All rights reserved.
//

import UIKit

class CommunicationSegmentTableViewCell: UITableViewCell {

    @IBOutlet weak var labelValue: UILabel!
    @IBOutlet weak var buttonNotificationCount: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        buttonNotificationCount.setTitleColor(UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0),  for: UIControl.State.normal)
        buttonNotificationCount.layer.borderWidth = 1.0
        buttonNotificationCount.layer.masksToBounds = false
        buttonNotificationCount.layer.borderColor = UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0).cgColor
        buttonNotificationCount.layer.cornerRadius = buttonNotificationCount.frame.size.width/2
        buttonNotificationCount.clipsToBounds = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
