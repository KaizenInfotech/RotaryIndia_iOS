//
//  ClubEventsDetailsTableViewCell.swift
//  TouchBase
//
//  Created by rajendra on 01/08/17.
//  Copyright © 2017 Parag. All rights reserved.
//

import UIKit

class ClubEventsDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var buttonMain: UIButton!
    @IBOutlet weak var lblEventName: UILabel!
    
    @IBOutlet weak var lblEventDateTime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
