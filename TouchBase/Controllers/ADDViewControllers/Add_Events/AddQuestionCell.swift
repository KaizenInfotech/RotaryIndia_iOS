//
//  AddQuestionCell.swift
//  TouchBase
//
//  Created by Kaizan on 03/05/16.
//  Copyright © 2016 Parag. All rights reserved.
//

import UIKit
@objc protocol addQueDelegate
{
    @objc optional func addQueDelegateAction(_ string:Int)
}
@objc protocol addQueDelegateNew
{
    @objc optional func addQueDelegateActionNew(_ string:Int)
}
class AddQuestionCell : UITableViewCell {
    
    @IBOutlet var questionSwitch: UISwitch!
    var delegates : addQueDelegate?
    var delegatess : addQueDelegateNew?

    @IBOutlet var questionSwitchNew: UISwitch!
    
    @IBOutlet var editQuestionButton: UIButton!
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }
    
    
    
    
    @IBAction func addQueDelegateActionNew(_ sender: AnyObject)
    {
        if (sender.isOn == true)
        {            print("on")
            
            //self.delegatess?.addQueDelegateActionNew!(0)
            self.delegates?.addQueDelegateAction!(0)
            

        }
        if (sender.isOn == false)
        {            print("off")
            
            //self.delegatess?.addQueDelegateActionNew!(0)
            self.delegates?.addQueDelegateAction!(1)
            
        }
    }
    
    
    
    @IBAction func QueSwitchAction(_ sender: UISwitch)
    {
        if (sender.isOn == true)
        {            print("on")
            
            self.delegates?.addQueDelegateAction!(5)
        }
        else
        {
            print("off")
            
            self.delegates?.addQueDelegateAction!(6)
        }
    }
    
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}


