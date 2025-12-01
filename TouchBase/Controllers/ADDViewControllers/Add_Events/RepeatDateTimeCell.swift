//
//  RepeatDateTimeCell.swift
//  TouchBase
//
//  Created by Kaizan on 21/01/16.
//  Copyright © 2016 Parag. All rights reserved.
//

import UIKit
@objc protocol repeatnotyDelegate
{
    @objc optional func myDelegateFunctionIshere(_ string:Int,myCell:RepeatDateTimeCell)
     @objc optional func myDelegateFunctionSelectDate(_ myCell:RepeatDateTimeCell)
    
}
class RepeatDateTimeCell: UITableViewCell {
    
    
    @IBOutlet var deleteCellButton: UIButton!
    @IBOutlet var repeatDateButton: UIButton!
    @IBOutlet var repeatTimeButton: UIButton!
    var delegates : repeatnotyDelegate?
     var objectVal : Int?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //contentView.addSubview(imgUser)
    }
    
    @IBAction func DelateCellButtonAction(_ sender: AnyObject)
    {
       // NSNotificationCenter.defaultCenter().postNotificationName("DeleteNotification", object: nil)
        print("Button row \(sender.row)")
        delegates?.myDelegateFunctionIshere!(repeatDateButton.tag,myCell: self)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    @IBAction func repeatDateClickEvent(_ sender: Any) {
        delegates?.myDelegateFunctionSelectDate!(self)
    }
    
    @IBAction func repeatTimeClickEvent(_ sender: Any) {
        delegates?.myDelegateFunctionSelectDate!(self)
    }
    
}

