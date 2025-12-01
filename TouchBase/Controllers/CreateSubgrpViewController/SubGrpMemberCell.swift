//
//  SubGrpMemberCell.swift
//  TouchBase
//
//  Created by Umesh on 09/02/16.
//  Copyright © 2016 Parag. All rights reserved.
//

import UIKit

class SubGrpMemberCell: UITableViewCell {
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var mobileLabel: UILabel!
    
     @IBOutlet var chkBTn:UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
