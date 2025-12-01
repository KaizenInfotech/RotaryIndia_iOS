//
//  DirectoryClassifiedTableViewCell.swift
//  TouchBase
//
//  Created by rajendra on 08/06/17.
//  Copyright © 2017 Parag. All rights reserved.
//

import UIKit

class DirectoryClassifiedTableViewCell: UITableViewCell {

    @IBOutlet weak var buttonRotarian: UIButton!
    
    
    @IBOutlet weak var buttonPicBigView: UIButton!
    @IBOutlet var profilePic: UIImageView!
    @IBOutlet var groupsLabel: UILabel!
    @IBOutlet var mobileLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        profilePic.layer.borderWidth = 1.0
        profilePic.layer.masksToBounds = false
        profilePic.layer.borderColor = UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0).cgColor
        profilePic.layer.cornerRadius = profilePic.frame.size.width/2
        profilePic.clipsToBounds = true
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
