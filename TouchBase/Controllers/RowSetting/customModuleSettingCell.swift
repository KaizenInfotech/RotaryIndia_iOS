//
//  customModuleSettingCell.swift
//  TouchBase
//
//  Created by rajendra on 24/05/17.
//  Copyright © 2017 Parag. All rights reserved.
//

import UIKit

class customModuleSettingCell: UITableViewCell {

    @IBOutlet weak var buttonOnOFF: UIButton!
    @IBOutlet weak var buttonSwitchOnOff: UISwitch!
    @IBOutlet weak var lableModuleName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        buttonOnOFF.isHidden = true
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
