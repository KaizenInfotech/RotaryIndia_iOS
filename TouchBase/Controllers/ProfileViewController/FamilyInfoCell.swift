//
//  FamilyInfoCell.swift
//  TouchBase
//
//  Created by Kaizan on 17/02/16.
//  Copyright © 2016 Parag. All rights reserved.
//

import UIKit
@objc protocol familycellDelegate
{
    @objc optional func familyDeleteBtnClk(_ familymemID:NSString)
    //optional func withoutAddrsBtnClk()
}

class FamilyInfoCell: UITableViewCell {
    
    @IBOutlet var relativeName: UILabel!
    @IBOutlet var relationWithUser: UILabel!
    @IBOutlet var emailLabel: UILabel!
    @IBOutlet var birthDayLabel: UILabel!
    @IBOutlet var mobileLabel: UILabel!
    @IBOutlet var bloodGroup: UILabel!
    
    @IBOutlet var BG: UIImageView!
    var familymemID : NSString!
    
    @IBOutlet var editButton: UIButton!
    @IBOutlet var deleteButton: UIButton!
    var delegates : familycellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func familyDelete(){
        self.delegates?.familyDeleteBtnClk!(familymemID)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}

