//
//  HeaderCell2.swift
//  TouchBase
//
//  Created by Kaizan on 21/01/16.
//  Copyright © 2016 Parag. All rights reserved.
//

import UIKit
@objc protocol repeatTurnOnDelegate
{
    @objc optional func repeatSwitchAction(_ string:Int)
}

class HeaderCell2 : UITableViewCell {
    
    @IBOutlet var repeateDateTImeLabel: UILabel!
    @IBOutlet var addRepeatCellButton: UIButton!
    
    @IBOutlet var repeatSwitch: UISwitch!
     var delegates : repeatTurnOnDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //contentView.addSubview(imgUser)
    }
    
    @IBAction func addCellButtonAction(_ sender: AnyObject)
    {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "notificationName"), object: nil)
    }
    
    @IBAction func repeatSwitchAction(_ sender: UISwitch)
    {
        if (sender.isOn == true)
        {
            print("on")
           
            repeateDateTImeLabel.isHidden = false
            addRepeatCellButton.isHidden = false
            
            self.delegates?.repeatSwitchAction!(1)
        }
        else
        {
            print("off")
            
            repeateDateTImeLabel.isHidden = true
            addRepeatCellButton.isHidden = true
            self.delegates?.repeatSwitchAction!(0)
        //    NSNotificationCenter.defaultCenter().postNotificationName("hideNotifyCell", object: nil)
            
            
        }

    }
   
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

