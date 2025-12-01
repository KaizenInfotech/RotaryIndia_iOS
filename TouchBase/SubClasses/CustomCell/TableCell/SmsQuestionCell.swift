//
//  SmsQuestionCell.swift
//  TouchBase
//
//  Created by Umesh on 23/04/16.
//  Copyright © 2016 Parag. All rights reserved.
//

import UIKit
@objc protocol smsQuesDelegate
{
    @objc optional func changeValueofSelectionAll(_ val:NSString)
    @objc optional func changeValueofSelectionnonSmartSMSButton(_ val:NSString)
}

class SmsQuestionCell: UITableViewCell {
    
    
    @IBOutlet var whatsappRadioBtn: UISwitch!
    @IBOutlet weak var btnDisplayOnBanner: UIButton!
    @IBOutlet var allMemSMSButton: UIButton!
    @IBOutlet var nonSmartSMSButton: UIButton!
    var delegates : smsQuesDelegate?
    
    @IBOutlet weak var lblNoMSGUser: UILabel!
    @IBOutlet var SMSCountLabel: UILabel!
    @IBOutlet var questionSwitch: UISwitch!
    var SelVal:NSString!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func DisplayOnBannerClick(_ sender: AnyObject)
    {
        if btnDisplayOnBanner.currentImage!.isEqual(UIImage(named: "switchOn"))  {
            btnDisplayOnBanner.setImage(UIImage(named:"switchOff"),  for: UIControl.State.normal)
            self.delegates?.changeValueofSelectionAll!("0")
        }else {
            btnDisplayOnBanner.setImage( UIImage(named:"switchOn"),  for: UIControl.State.normal)
            self.delegates?.changeValueofSelectionAll!("1")
        }
    }

    @IBAction func whatsappRadioValueChenged(_ sender: UISwitch) {
        if (sender.isOn == true)
        {
//            @IBAction func repeatSwitchAction(_ sender: UISwitch)
            print("on")
           
//            repeateDateTImeLabel.isHidden = false
//            addRepeatCellButton.isHidden = false
//
//            self.delegates?.repeatSwitchAction!(1)
//
            
//            {
//                nonSmartSMSButton.setImage( UIImage(named:"CHECK_BLUE_ROW"), forState: .Normal)
                allMemSMSButton.setImage(UIImage(named:"switchOff"),  for: UIControl.State.normal)
            whatsappRadioBtn.isOn = false
                self.delegates?.changeValueofSelectionAll!("0")
//            }
        }
        else
        {
            print("off")
            
            whatsappRadioBtn.isOn = true
//            nonSmartSMSButton.setImage(UIImage(named:"switchOff"),  for: UIControl.State.normal)
            allMemSMSButton.setImage( UIImage(named:"switchOn"),  for: UIControl.State.normal)
            self.delegates?.changeValueofSelectionAll!("1")
//            repeateDateTImeLabel.isHidden = true
//            addRepeatCellButton.isHidden = true
//            self.delegates?.repeatSwitchAction!(0)
        //    NSNotificationCenter.defaultCenter().postNotificationName("hideNotifyCell", object: nil)
            
            
        }
    }
    @IBAction func allMemBtnClick(_ sender : UIButton){
        //cell.allMemSMSButton.setImage(UIImage(named: "CHECK_BLUE_ROW"), forState: UIControl.State.Normal)
        // cell.nonSmartSMSButton.setImage(UIImage(named: "UN_CHECK_BLUE_ROW"), forState: UIControl.State.Normal)
        if allMemSMSButton.currentImage!.isEqual(UIImage(named: "switchOn"))  {
            //nonSmartSMSButton.setImage( UIImage(named:"CHECK_BLUE_ROW"), forState: .Normal)
            allMemSMSButton.setImage(UIImage(named:"switchOff"),  for: UIControl.State.normal)
            self.delegates?.changeValueofSelectionAll!("0")
        }else {
            nonSmartSMSButton.setImage(UIImage(named:"switchOff"),  for: UIControl.State.normal)
            allMemSMSButton.setImage( UIImage(named:"switchOn"),  for: UIControl.State.normal)
            self.delegates?.changeValueofSelectionAll!("1")
        }
    }
    
    @IBAction func noSmartMemBtnClick(_ sender : UIButton){
        if nonSmartSMSButton.currentImage!.isEqual(UIImage(named: "switchOn")) {
            nonSmartSMSButton.setImage(UIImage(named:"switchOff"),  for: UIControl.State.normal)
            //allMemSMSButton.setImage( UIImage(named:"CHECK_BLUE_ROW"), forState: .Normal)
            self.delegates?.changeValueofSelectionnonSmartSMSButton!("0")
        }else  {
            nonSmartSMSButton.setImage( UIImage(named:"switchOn"),  for: UIControl.State.normal)
            allMemSMSButton.setImage(UIImage(named:"switchOff"),  for: UIControl.State.normal)
            self.delegates?.changeValueofSelectionnonSmartSMSButton!("1")
        }
    }
}
