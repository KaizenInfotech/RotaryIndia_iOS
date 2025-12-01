//
//  SettingCell.swift
//  TouchBase
//
//  Created by Umesh on 26/03/16.
//  Copyright © 2016 Parag. All rights reserved.
//

import UIKit
@objc protocol settingDelegate
{
    @objc optional func changeSWitchVal(_ switchVal:NSString,grpId:NSString)
}

class SettingCell: UITableViewCell {

    @IBOutlet var NotifyOnOffSwitch: UISwitch!
    @IBOutlet var grpName:UILabel!
    var grpID:NSString!
    var delegates : settingDelegate?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func changeNotifyswitch(_ sender: AnyObject)
    {
        if(NotifyOnOffSwitch.isOn){
            self.delegates?.changeSWitchVal!("1", grpId: grpID)
        }else{
            self.delegates?.changeSWitchVal!("0", grpId: grpID)
        }
       //self.delegates?.mapBtnClk!(venueLat,vnlon: venueLon,vname: EventPlaceLabel.text!)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
