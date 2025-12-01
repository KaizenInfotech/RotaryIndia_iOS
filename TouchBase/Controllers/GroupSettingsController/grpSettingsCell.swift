//
//  grpSettingsCell.swift
//  TouchBase
//
//  Created by Kaizan on 09/03/16.
//  Copyright © 2016 Parag. All rights reserved.
//

import UIKit
@objc protocol grpsettingDelegate
{
    @objc optional func changeSWitchVal(_ switchVal:NSString,modulId:NSString)
}

class grpSettingsCell: UITableViewCell
{
    let boundss = UIScreen.main.bounds
    @IBOutlet var ModuleNameLabel: UILabel!
    @IBOutlet var NotifyOnOffSwitch: UISwitch!
    var moduleID:NSString!
    var delegates : grpsettingDelegate?
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
    }
    @IBAction func changeNotifyswitch(_ sender: AnyObject)
    {
        if(NotifyOnOffSwitch.isOn){
            self.delegates?.changeSWitchVal!("1", modulId: moduleID)
        }else{
            self.delegates?.changeSWitchVal!("0", modulId: moduleID)
        }
        //self.delegates?.mapBtnClk!(venueLat,vnlon: venueLon,vname: EventPlaceLabel.text!)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}


