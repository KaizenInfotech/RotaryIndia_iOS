//
//  GroupInfoCell.swift
//  TouchBase
//
//  Created by Kaizan on 26/02/16.
//  Copyright © 2016 Parag. All rights reserved.
//

import UIKit
@objc protocol grpInfocellDelegate
{
    @objc optional func adminBtnClk(_ adminprofileID:NSString)
}

class GroupInfoCell: UITableViewCell {
    
    @IBOutlet var GroupLabel: UILabel!
    @IBOutlet var GroupDetailLabel: UILabel!
    @IBOutlet var GroupPic: UIImageView!
    @IBOutlet var grpAdminPRf:UIButton!
    var adminprofileID : NSString!
    
    var delegates : grpInfocellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func adminProfileShow(){
        self.delegates?.adminBtnClk!(adminprofileID)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}

