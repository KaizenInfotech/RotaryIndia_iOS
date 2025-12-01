//
//  DistrictCallMessageTableViewCell.swift
//  TouchBase
//
//  Created by rajendra on 24/01/18.
//  Copyright © 2018 Parag. All rights reserved.
//

import UIKit

class DistrictCallMessageTableViewCell: UITableViewCell {

    
    @IBOutlet weak var buttonCheckBoxMobileNumberMain: UIButton!
    
    @IBOutlet weak var buttonCheckBoxMobileNumber: UIButton!
    
    @IBOutlet weak var buttonMobileNumber: UIButton!
    @IBOutlet weak var labelName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
