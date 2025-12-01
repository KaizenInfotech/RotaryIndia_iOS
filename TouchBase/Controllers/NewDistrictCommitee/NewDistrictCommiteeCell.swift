//
//  NewDistrictCommiteeCell.swift
//  TouchBase
//
//  Created by rajendra on 12/06/18.
//  Copyright © 2018 Parag. All rights reserved.
//

import UIKit

class NewDistrictCommiteeCell: UITableViewCell {
    
    
    
    @IBOutlet weak var viewOne: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var lblDesignation: UILabel!
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var viewSecond: UIView!
    
    @IBOutlet weak var lblSecond: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profileImage.contentMode = .scaleAspectFit
        profileImage.layer.borderWidth = 1
        profileImage.layer.masksToBounds = false
        profileImage.layer.borderColor = UIColor.lightGray.cgColor
        profileImage.layer.cornerRadius = profileImage.frame.height/2
        profileImage.clipsToBounds = true
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

