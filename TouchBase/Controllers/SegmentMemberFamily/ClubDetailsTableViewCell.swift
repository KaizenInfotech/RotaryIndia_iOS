//
//  ClubDetailsTableViewCell.swift
//  TouchBase
//
//  Created by rajendra on 20/06/17.
//  Copyright © 2017 Parag. All rights reserved.
//

import UIKit

class ClubDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var lblHeading: UILabel!
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var buttonMail: UIButton!
    @IBOutlet weak var buttonCall: UIButton!
    
    @IBOutlet weak var buttonMessage: UIButton!
    
    
    @IBOutlet weak var buttonWhatsApp: UIButton!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
