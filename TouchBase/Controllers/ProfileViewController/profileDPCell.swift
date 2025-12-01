//
//  profileDPCell.swift
//  TouchBase
//
//  Created by Kaizan on 17/12/15.
//  Copyright © 2015 Parag. All rights reserved.
//

import UIKit

class profileDPCell: UITableViewCell {
    
    @IBOutlet var profilePicEditButton: UIButton!
    @IBOutlet var ProfileNameLabel: UILabel!
    @IBOutlet var ProfileAddressLabel: UILabel!
    @IBOutlet var ProfilePic: UIImageView!
    @IBOutlet var profCallButton: UIButton!
    @IBOutlet var profSMSButton: UIButton!
    @IBOutlet var profMailButton: UIButton!
    @IBOutlet var indicator:UIActivityIndicatorView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        ProfilePic.layer.borderWidth = 1.0
        ProfilePic.layer.masksToBounds = false
        ProfilePic.layer.borderColor = UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0).cgColor
        ProfilePic.layer.cornerRadius = ProfilePic.frame.size.width/2
        ProfilePic.clipsToBounds = true
        
        
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}

