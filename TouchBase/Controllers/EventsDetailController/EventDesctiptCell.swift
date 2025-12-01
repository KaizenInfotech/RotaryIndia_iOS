//
//  EventDesctiptCell.swift
//  TouchBase
//
//  Created by Kaizan on 21/12/15.
//  Copyright © 2015 Parag. All rights reserved.
//

import UIKit
@objc protocol eventdetcellDelegate
{
    @objc optional func mapBtnClk(_ vnlt:NSString,vnlon:NSString,addr:NSString)
}
class EventDesctiptCell: UITableViewCell {
    
    @IBOutlet weak var buttonLinkEvent: UIButton!

    
    @IBOutlet weak var labelLink: UILabel!
    
    @IBOutlet weak var img1: UIImageView!
    
    
    @IBOutlet weak var img2: UIImageView!
    
    @IBOutlet var eventGoingResponceLabel: UILabel!
    
    @IBOutlet var dotImageView: UIImageView!
    let boundss = UIScreen.main.bounds
    @IBOutlet var eventAddressLabel: UILabel!
    @IBOutlet var eventDateTimeLabel: UILabel!
    
    @IBOutlet var eventAttendingLabel: UILabel!
    @IBOutlet var eventANSLabel: UILabel!
    
    @IBOutlet var yesBtn:UIButton!
    @IBOutlet var noBtn:UIButton!
    @IBOutlet var maybeBtn:UIButton!
    
    
    @IBOutlet var NOLabel: UILabel!
    @IBOutlet var MayBELabel: UILabel!
    
    @IBOutlet var NOdotImageView: UIImageView!
    @IBOutlet var MayBEdotImageView: UIImageView!
    @IBOutlet var locImageView: UIImageView!
    var delegates : eventdetcellDelegate?
    var venueLat:NSString!
    var venueLon:NSString!
    override func awakeFromNib() {
        super.awakeFromNib()

        eventAttendingLabel.text=""
        eventANSLabel.text=""
        locImageView.image=nil
        dotImageView.image=nil
        // Initialization code
        //contentView.addSubview(imgUser)
        
        //        self.yesBtn.translatesAutoresizingMaskIntoConstraints = true
        //        self.yesBtn.frame=CGRectMake(0,yesBtn.frame.origin.y, (boundss.size.width/3), 41)
        //        self.noBtn.translatesAutoresizingMaskIntoConstraints = true
        //        self.noBtn.frame=CGRectMake((boundss.size.width/3), noBtn.frame.origin.y, (boundss.size.width/3), 41)
        //        self.maybeBtn.translatesAutoresizingMaskIntoConstraints = true
        //        self.maybeBtn.frame=CGRectMake(((boundss.size.width/3)*2), maybeBtn.frame.origin.y, (boundss.size.width/3), 41)
    }
    
    @IBAction func mapCellButtonAction(_ sender: AnyObject)
    {
        print("Click on address button...")
        self.delegates?.mapBtnClk!(venueLat,vnlon: venueLon,addr: eventAddressLabel.text! as NSString)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
