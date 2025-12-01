//
//  DistrictCommiteTableViewCell.swift
//  TouchBase
//
//  Created by rajendra on 21/07/17.
//  Copyright © 2017 Parag. All rights reserved.
//

import UIKit

class DistrictCommiteTableViewCell: UITableViewCell {

    
    @IBOutlet weak var buttonPicBigView: UIButton!
    @IBOutlet weak var lblDesignation: UILabel!
    @IBOutlet weak var imageBodProfilePic: UIImageView!
    
    @IBOutlet weak var lblBodMemberName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageBodProfilePic.contentMode = .scaleAspectFit
        imageBodProfilePic.layer.borderWidth = 1.0
        imageBodProfilePic.layer.masksToBounds = false
        imageBodProfilePic.layer.borderColor = UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0).cgColor
        imageBodProfilePic.layer.cornerRadius = imageBodProfilePic.frame.size.width/2
        imageBodProfilePic.clipsToBounds = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
