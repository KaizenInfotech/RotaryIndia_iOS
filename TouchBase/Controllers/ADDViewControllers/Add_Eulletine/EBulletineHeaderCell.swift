//
//  EBulletineHeaderCell.swift
//  TouchBase
//
//  Created by Kaizan on 22/01/16.
//  Copyright © 2016 Parag. All rights reserved.
//

import UIKit

class EBulletineHeaderCell: UITableViewCell {
    
    @IBOutlet var bullTitleField: UITextField!
    
    @IBOutlet var bullRedirectLinkField: UITextField!
    
    @IBOutlet var addPeaopleCountLabel: UILabel!
    @IBOutlet var allEbullButton: UIButton!
    @IBOutlet var subGroupBullButton: UIButton!
    @IBOutlet var membersBullButton: UIButton!
    @IBOutlet var editBullButton: UIButton!

    
    @IBOutlet var uploadPDFButton: UIButton!
    @IBOutlet var uploadPDFicon: UIImageView!
    @IBOutlet var uploadPDFnam: UILabel!
    @IBOutlet var deletePDFButton: UIButton!
    
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
        uploadPDFnam.isHidden=true
        
        allEbullButton.setImage(UIImage(named: "radio_btn_Check"),  for: UIControl.State.normal)
        
        UserDefaults.standard.set("", forKey: "profID")
        print("Nothing here")
        UserDefaults.standard.set("", forKey: "groupsID")
        print("Nothing here")
        
    }
    
    @IBAction func AllRSVPAction(_ sender: AnyObject)
    {
//        allEbullButton.setImage(UIImage(named: "rbtn_select.png"), forState: UIControl.State.Normal)
//        subGroupBullButton.setImage(UIImage(named: "radio_btn.png"), forState: UIControl.State.Normal)
//        membersBullButton.setImage(UIImage(named: "radio_btn.png"), forState: UIControl.State.Normal)
        NotificationCenter.default.post(name: Notification.Name(rawValue: "AllRSVPbull"), object: nil)
    }
    
    @IBAction func subGroupRSVPAction(_ sender: AnyObject)
    {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "subGroupRSVPbull"), object: nil)
        
        subGroupBullButton.setImage(UIImage(named: "radio_btn_Check"),  for: UIControl.State.normal)
        membersBullButton.setImage(UIImage(named: "radio_btn_Uncheck"),  for: UIControl.State.normal)
        allEbullButton.setImage(UIImage(named: "radio_btn_Uncheck"),  for: UIControl.State.normal)
    }
    
    @IBAction func MembersRSVPAction(_ sender: AnyObject)
    {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "MembersRSVPbull"), object: nil)
        
        membersBullButton.setImage(UIImage(named: "radio_btn_Check"),  for: UIControl.State.normal)
        subGroupBullButton.setImage(UIImage(named: "radio_btn_Uncheck"),  for: UIControl.State.normal)
        allEbullButton.setImage(UIImage(named: "radio_btn_Uncheck"),  for: UIControl.State.normal)
    }
    
    @IBAction func EditEventAction(_ sender: AnyObject)
    {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "EditEventbull"), object: nil)
    }
    
    
    @IBAction func UploadPDFAction(_ sender: AnyObject)
    {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "UploadPDF"), object: nil)
    }
    
    
    @IBAction func DeletePDFAction(_ sender: AnyObject)
    {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "DeletePDF"), object: nil)
    }
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

