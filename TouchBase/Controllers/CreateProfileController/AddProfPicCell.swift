//
//  AddProfPicCell.swift
//  TouchBase
//
//  Created by Kaizan on 15/12/15.
//  Copyright © 2015 Parag. All rights reserved.
//

import UIKit

class AddProfPicCell: UITableViewCell {
    
    //@IBOutlet var LanguageLabel: UILabel!
    @IBOutlet var addProfPicLabel: UILabel!
    
    @IBOutlet var editProfilePicButton: UIButton!
    @IBOutlet var addProfilePic: UIImageView!
    @IBOutlet var indicator:UIActivityIndicatorView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //contentView.addSubview(imgUser)
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

