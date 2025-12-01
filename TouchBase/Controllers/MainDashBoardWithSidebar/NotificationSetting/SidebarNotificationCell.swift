//
//  SidebarNotificationCell.swift
//  TouchBase
//
//  Created by rajendra on 26/02/18.
//  Copyright © 2018 Parag. All rights reserved.
//

import UIKit

class SidebarNotificationCell: UITableViewCell {

    
    
    
    @IBOutlet weak var buttonOnOFF: UIButton!
    
    @IBOutlet weak var lableModuleName: UILabel!
    
    @IBOutlet weak var buttonSwitchOnOff: UISwitch!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
