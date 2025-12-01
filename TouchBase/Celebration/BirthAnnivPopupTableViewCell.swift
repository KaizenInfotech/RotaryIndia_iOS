//
//  BirthAnnivPopupTableViewCell.swift
//  TouchBase
//
//  Created by deepak on 21/02/18.
//  Copyright © 2018 Parag. All rights reserved.
//

import UIKit

class BirthAnnivPopupTableViewCell: UITableViewCell {

    
    
    
    @IBOutlet weak var labelEmailCallSMSPersonName: UILabel!
    @IBOutlet weak var labelEmailCallSMS: UILabel!
    
    
    @IBOutlet weak var buttonCall: UIButton!
    @IBOutlet weak var buttonSMS: UIButton!
    @IBOutlet weak var buttonEmail: UIButton!
    
    
    @IBOutlet weak var buttonCallMain: UIButton!
    @IBOutlet weak var buttonSMSMain: UIButton!
    @IBOutlet weak var buttonEmailMain: UIButton!
    
    
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
