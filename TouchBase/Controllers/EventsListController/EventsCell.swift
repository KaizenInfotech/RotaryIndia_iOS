//
//  EventsCell.swift
//  TouchBase
//
//  Created by Kaizan on 17/12/15.
//  Copyright © 2015 Parag. All rights reserved.
//

import UIKit
@objc protocol eventcellDelegate
{
    @objc optional func mapBtnClk(_ vnlt:NSString,vnlon:NSString,vname:NSString)
}


class EventsCell: UITableViewCell {
    
    @IBOutlet var EventNameLabel: UILabel!
    @IBOutlet var EventDateTimeLabel: UILabel!
    @IBOutlet var EventPlaceLabel: UILabel!
    
    @IBOutlet var EventLocationButton: UIButton!
    @IBOutlet var EventRemindButton: UIButton!
    
    @IBOutlet var EventPic: UIImageView!
    @IBOutlet var EventFlagImage: UIImageView!
    @IBOutlet var eventStatus: UILabel!
    var delegates : eventcellDelegate?
    var venueLat:NSString!
    var venueLon:NSString!
    @IBOutlet var datedayLabel: UILabel!
    @IBOutlet var monthLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //contentView.addSubview(imgUser)
    }
    
    @IBAction func mapCellButtonAction(_ sender: AnyObject)
    {
        self.delegates?.mapBtnClk!(venueLat,vnlon: venueLon,vname: EventPlaceLabel.text! as NSString)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}


