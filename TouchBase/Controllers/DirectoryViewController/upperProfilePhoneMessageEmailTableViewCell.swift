//
//  upperProfilePhoneMessageEmailTableViewCell.swift
//  TouchBase
//
//  Created by deepak on 29/05/17.
//  Copyright © 2017 Parag. All rights reserved.
//

import UIKit

class upperProfilePhoneMessageEmailTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var buttonMobileIcon: UIButton!
    @IBOutlet weak var buttonPhoneNumberMain: UIButton!
    
    @IBOutlet weak var whatsappImgBtn: UIButton!
    
    
    @IBOutlet weak var lableKey: UILabel!
    
    @IBOutlet weak var lableName: UILabel!
    
    @IBOutlet weak var buttonCheckBox: UIButton!
    
    
    
    @IBOutlet weak var buttonCheckBoxMain: UIButton!
    
    
    
    @IBOutlet weak var buttonPhoneNumber: UIButton!
    
    @IBOutlet weak var buttonWhatsApp: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        lableName.isHidden=true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
