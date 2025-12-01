//
//  AnnounceHeaderCell.swift
//  TouchBase
//
//  Created by Kaizan on 22/01/16.
//  Copyright © 2016 Parag. All rights reserved.
//

import UIKit
@objc protocol selectMultipleannDelegate
{
    @objc optional func changeValueofSelection(_ val:NSString)
}
class AnnounceHeaderCell: UITableViewCell {
    
    @IBOutlet var annTitleField: UITextField!
    
    @IBOutlet var annDescTextView: UITextView!
    
    @IBOutlet var addPeaopleCountLabel: UILabel!
    @IBOutlet var allAnnounButton: UIButton!
    @IBOutlet var comitteeAnnounButton: UIButton!
    @IBOutlet var membersAnnounButton: UIButton!
    @IBOutlet var editAnnounButton: UIButton!
      @IBOutlet var announcePic: UIButton!
     var delegates : selectMultipleannDelegate?
    override func awakeFromNib()
    {
        super.awakeFromNib()
    
        UserDefaults.standard.set("", forKey: "profID")
        print("Nothing here")
        UserDefaults.standard.set("", forKey: "groupsID")
        print("Nothing here")
        allAnnounButton.setImage(UIImage(named: "rbtn_select.png"),  for: UIControl.State.normal)
   
    annTitleField.autocorrectionType = .no
    
        annDescTextView.autocorrectionType = .no

    
    
    }
    
    @IBAction func AllRSVPAction(_ sender: AnyObject)
    {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "AllRSVPann"), object: nil)
      //  allAnnounButton.setImage(UIImage(named: "rbtn_select.png"), forState: UIControl.State.Normal)
       // comitteeAnnounButton.setImage(UIImage(named: "radio_btn.png"), forState: UIControl.State.Normal)
       // membersAnnounButton.setImage(UIImage(named: "radio_btn.png"), forState: UIControl.State.Normal)
        self.delegates?.changeValueofSelection!("0")
    }
    
    
    @IBAction func CommiteeRSVPAction(_ sender: AnyObject)
    {
       
        NotificationCenter.default.post(name: Notification.Name(rawValue: "SubGroupRSVPann"), object: nil)
        
        comitteeAnnounButton.setImage(UIImage(named: "rbtn_select.png"),  for: UIControl.State.normal)
        membersAnnounButton.setImage(UIImage(named: "radio_btn.png"),  for: UIControl.State.normal)
        allAnnounButton.setImage(UIImage(named: "radio_btn.png"),  for: UIControl.State.normal)
        self.delegates?.changeValueofSelection!("1")
    }
    
    @IBAction func MembersRSVPAction(_ sender: AnyObject)
    {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "MembersRSVPann"), object: nil)
        membersAnnounButton.setImage(UIImage(named: "rbtn_select.png"),  for: UIControl.State.normal)
        comitteeAnnounButton.setImage(UIImage(named: "radio_btn.png"),  for: UIControl.State.normal)
        allAnnounButton.setImage(UIImage(named: "radio_btn.png"),  for: UIControl.State.normal)
        self.delegates?.changeValueofSelection!("2")
    }
    
    
    @IBAction func EditEventAction(_ sender: AnyObject)
    {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "EditEventann"), object: nil)
    }
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

