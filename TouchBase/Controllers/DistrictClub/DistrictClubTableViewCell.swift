//
//  DistrictClubTableViewCell.swift
//  TouchBase
//
//  Created by rajendra on 21/07/17.
//  Copyright © 2017 Parag. All rights reserved.
//

import UIKit

class DistrictClubTableViewCell: UITableViewCell {

    
    @IBOutlet weak var lblMemberName: UILabel!
    @IBOutlet weak var buttonMain: UIButton!
    @IBOutlet weak var labelDayRime: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
