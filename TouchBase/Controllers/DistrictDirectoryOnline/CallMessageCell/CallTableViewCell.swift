//
//  CallTableViewCell.swift
//  TouchBase
//
//  Created by rajendra on 25/01/18.
//  Copyright © 2018 Parag. All rights reserved.
//

import UIKit

class CallTableViewCell: UITableViewCell {

    
    
    
    @IBOutlet weak var buttonCallNumber: UIButton!
    
    
    @IBOutlet weak var buttonCalling: UIButton!
    @IBOutlet weak var labelName: UILabel!
    
    
    
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
