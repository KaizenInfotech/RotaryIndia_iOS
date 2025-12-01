//
//  AnnouncementCell.swift
//  TouchBase
//
//  Created by Kaizan on 21/12/15.
//  Copyright © 2015 Parag. All rights reserved.
//

import UIKit

class AnnouncementCell: UITableViewCell {
    
    @IBOutlet var announceNameLabel: UILabel!
    @IBOutlet var announceDateTimeLabel: UILabel!
    @IBOutlet var announceStatus: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //contentView.addSubview(imgUser)
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

