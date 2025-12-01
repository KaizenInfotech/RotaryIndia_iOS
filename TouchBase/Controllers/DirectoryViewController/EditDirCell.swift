//
//  EditDirCell.swift
//  TouchBase
//
//  Created by Kaizan on 09/02/16.
//  Copyright © 2016 Parag. All rights reserved.
//

import UIKit

class EditDirCell: UITableViewCell {
    
    @IBOutlet weak var imageCheckUnCheck: UIImageView!
    let boundss = UIScreen.main.bounds
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var chkBTn: UIButton!
    @IBOutlet var profilePic: UIImageView!
    @IBOutlet var mobileLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        profilePic.layer.borderWidth = 1.0
        profilePic.layer.masksToBounds = false
        profilePic.layer.borderColor = UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0).cgColor
        profilePic.layer.cornerRadius = profilePic.frame.size.width/2
        profilePic.clipsToBounds = true
        
        self.chkBTn.translatesAutoresizingMaskIntoConstraints = true
        self.chkBTn.frame=CGRect(x: ((boundss.size.width)-50), y: 5, width: 40, height: 40)
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

