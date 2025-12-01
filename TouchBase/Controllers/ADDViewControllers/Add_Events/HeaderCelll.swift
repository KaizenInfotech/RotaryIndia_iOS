//
//  HeaderCelll.swift
//  TouchBase
//
//  Created by Kaizan on 21/01/16.
//  Copyright © 2016 Parag. All rights reserved.
//

import UIKit
@objc protocol selectMultipleDelegate
{
    @objc optional func changeValueofSelection(_ val:NSString)
}
class HeaderCelll: UITableViewCell {
    
    
    
    @IBOutlet weak var textfieldTitleLater: UITextField!
    
    @IBOutlet weak var lblDescCount: UILabel!
    
    @IBOutlet var EventProfilePic: UIImageView!
    
    @IBOutlet var eventTitleField: UITextField!
    
    @IBOutlet var eventDescTextView: UITextView!
    
    @IBOutlet var eventVenueTextView: UITextView!
    
    @IBOutlet var addPeaopleCountLabel: UILabel!
    @IBOutlet var allEventsButton: UIButton!
    @IBOutlet var subGroupEventButton: UIButton!
    @IBOutlet var membersEventsButton: UIButton!
    @IBOutlet var editEventButton: UIButton!
     var delegates : selectMultipleDelegate?
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
        allEventsButton.setImage(UIImage(named: "radio_btn_Check"),  for: UIControl.State.normal)
        
        
        eventTitleField.autocorrectionType = .no
        eventDescTextView.autocorrectionType = .no

        eventVenueTextView.autocorrectionType = .no

        
      //  eventDescTextView.enablesReturnKeyAutomatically = true;
       // eventVenueTextView.enablesReturnKeyAutomatically = true;

        
    }
    
 
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        print("Generic Cell Initialization Done")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @IBAction func AllRSVPAction(_ sender: AnyObject)
    {
        //NSNotificationCenter.defaultCenter().postNotificationName("AllRSVP", object: nil)
        
        allEventsButton.setImage(UIImage(named: "radio_btn_Check"),  for: UIControl.State.normal)
        subGroupEventButton.setImage(UIImage(named: "radio_btn_Uncheck"),  for: UIControl.State.normal)
        membersEventsButton.setImage(UIImage(named: "radio_btn_Uncheck"),  for: UIControl.State.normal)
        
        
        addPeaopleCountLabel.isHidden = true
        editEventButton.isHidden = true
        self.delegates?.changeValueofSelection!("0")
        
    }
    
    
    @IBAction func SubGroupsRSVPAction(_ sender: AnyObject)
    {
        subGroupEventButton.setImage(UIImage(named: "radio_btn_Check"),  for: UIControl.State.normal)
        membersEventsButton.setImage(UIImage(named: "radio_btn_Uncheck"),  for: UIControl.State.normal)
        allEventsButton.setImage(UIImage(named: "radio_btn_Uncheck"),  for: UIControl.State.normal)
        
        addPeaopleCountLabel.isHidden = true
        editEventButton.isHidden = true
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: "SubGroupRSVP"), object: nil)
         self.delegates?.changeValueofSelection!("1")
    }
    
    @IBAction func MembersRSVPAction(_ sender: AnyObject)
    {
        membersEventsButton.setImage(UIImage(named: "radio_btn_Check"),  for: UIControl.State.normal)
        subGroupEventButton.setImage(UIImage(named: "radio_btn_Uncheck"),  for: UIControl.State.normal)
        allEventsButton.setImage(UIImage(named: "radio_btn_Uncheck"),  for: UIControl.State.normal)

        addPeaopleCountLabel.isHidden = true
        editEventButton.isHidden = true
         self.delegates?.changeValueofSelection!("2")
        NotificationCenter.default.post(name: Notification.Name(rawValue: "MembersRSVP"), object: nil)
    }
    
    
    @IBAction func EditEventAction(_ sender: AnyObject)
    {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "EditEvent"), object: nil)
    }
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}


