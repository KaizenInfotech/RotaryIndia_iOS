//
//  RotarianDetailsTableViewCell.swift
//  TouchBase
//
//  Created by rajendra on 23/06/17.
//  Copyright © 2017 Parag. All rights reserved.
//

import UIKit

class RotarianDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var lblHeading: UILabel!
    @IBOutlet weak var lblKeyValue: UILabel!
    
    @IBOutlet weak var btnTag: UIButton!
    @IBOutlet weak var tagBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
