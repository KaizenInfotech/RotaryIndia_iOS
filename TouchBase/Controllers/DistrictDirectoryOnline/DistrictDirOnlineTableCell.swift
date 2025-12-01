//
//  DistrictDirOnlineTableCell.swift
//  TouchBase
//
//  Created by rajendra on 22/01/18.
//  Copyright © 2018 Parag. All rights reserved.
//

import UIKit

class DistrictDirOnlineTableCell: UITableViewCell {

    @IBOutlet weak var buttonPicBigView: UIButton!
    
    
    
    @IBOutlet weak var lblUnderLine: UILabel!
    
    @IBOutlet weak var imgNextSecond: UIImageView!
    @IBOutlet weak var imgNext: UIImageView!
    @IBOutlet weak var lblClassificationName: UILabel!
    
    @IBOutlet weak var viewClassification: UIView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgProfile: UIImageView!
    
    @IBOutlet weak var lblMobileNumber: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imgProfile.layer.borderWidth = 1.0
        imgProfile.layer.masksToBounds = false
        imgProfile.contentMode = .scaleAspectFit
        imgProfile.layer.borderColor = UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0).cgColor
        imgProfile.layer.cornerRadius = imgProfile.frame.size.width/2
        imgProfile.clipsToBounds = true
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
