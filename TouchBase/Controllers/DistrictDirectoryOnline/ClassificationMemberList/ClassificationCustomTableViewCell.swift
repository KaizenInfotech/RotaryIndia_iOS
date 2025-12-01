//
//  ClassificationCustomTableViewCell.swift
//  TouchBase
//
//  Created by rajendra on 25/01/18.
//  Copyright © 2018 Parag. All rights reserved.
//

import UIKit

class ClassificationCustomTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var buttonPicBigView: UIButton!
    
    
    
    
    @IBOutlet weak var imgProfile: UIImageView!
    
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var userMobileNumber: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        imgProfile.layer.borderWidth = 1.0
        imgProfile.layer.masksToBounds = false
        imgProfile.contentMode = .scaleAspectFit
        imgProfile.layer.borderColor = UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0).cgColor
        imgProfile.layer.cornerRadius = imgProfile.frame.size.width/2
        imgProfile.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
