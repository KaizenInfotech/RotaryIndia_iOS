//
//  EventDetailCell.swift
//  TouchBase
//
//  Created by Kaizan on 21/12/15.
//  Copyright © 2015 Parag. All rights reserved.
//

import UIKit
@objc protocol eventImgDelegate
{
    @objc optional func EventImgBtnClk(_ imgUrl:NSString)
}

class EventDetailCell: UITableViewCell {
    
    @IBOutlet var eventNameLabel: UILabel!
    @IBOutlet var eventDetailLabel: UILabel!
    @IBOutlet var EventPic: UIImageView!
    var imgUrl:NSString!
    var delegates : eventImgDelegate?
    @IBOutlet var indicator:UIActivityIndicatorView!
    @IBOutlet var imgClkBtn : UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    @IBAction func imgClicked(){
        self.delegates?.EventImgBtnClk!(imgUrl)
        
        
        
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

