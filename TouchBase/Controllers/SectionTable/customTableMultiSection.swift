//
//  customTableMultiSection.swift
//  TouchBase
//
//  Created by rajendra on 26/05/17.
//  Copyright © 2017 Parag. All rights reserved.
//

import UIKit

class customTableMultiSection: UITableViewCell {

    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblHeading: UILabel!
    
    @IBOutlet weak var buttonUnderLine: UIButton!
    @IBOutlet weak var lblClubName: UILabel!
    
    @IBOutlet weak var imageUser: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
