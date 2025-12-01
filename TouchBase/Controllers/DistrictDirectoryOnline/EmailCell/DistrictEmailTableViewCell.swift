//
//  DistrictEmailTableViewCell.swift
//  TouchBase
//
//  Created by rajendra on 24/01/18.
//  Copyright © 2018 Parag. All rights reserved.
//

import UIKit

class DistrictEmailTableViewCell: UITableViewCell {

    @IBOutlet weak var labelNameEmail: UILabel!
    @IBOutlet weak var buttonCheckboxEmail: UIButton!
    @IBOutlet weak var buttonCheckBoxEmailMain: UIButton!
    @IBOutlet weak var buttonEmailEmailSend: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
