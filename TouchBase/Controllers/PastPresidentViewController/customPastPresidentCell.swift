//
//  customPastPresidentCell.swift
//  TouchBase
//
//  Created by rajendra on 20/05/17.
//  Copyright © 2017 Parag. All rights reserved.
//

import UIKit

class customPastPresidentCell: UITableViewCell {

    
    
    
    
    
    @IBOutlet weak var lblYear: UILabel!
    @IBOutlet weak var imagePastPresidentProfilePic: UIImageView!
    
    @IBOutlet weak var lblPastPresidentMemberName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imagePastPresidentProfilePic.layer.borderWidth = 1.0
        imagePastPresidentProfilePic.layer.masksToBounds = false
        imagePastPresidentProfilePic.layer.borderColor = UIColor.lightGray.cgColor //(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0).CGColor
        
        imagePastPresidentProfilePic.layer.cornerRadius = imagePastPresidentProfilePic.frame.size.width/2
        imagePastPresidentProfilePic.clipsToBounds = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
