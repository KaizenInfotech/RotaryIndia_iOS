//
//  customBodCell.swift
//  TouchBase
//
//  Created by rajendra on 19/05/17.
//  Copyright © 2017 Parag. All rights reserved.
//

import UIKit

class customBodCell: UITableViewCell {

    
    @IBOutlet weak var buttonMainImageBig: UIButton!
    @IBOutlet weak var lblDesignation: UILabel!
    @IBOutlet weak var imageBodProfilePic: UIImageView!
    
    @IBOutlet weak var lblBodMemberName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
