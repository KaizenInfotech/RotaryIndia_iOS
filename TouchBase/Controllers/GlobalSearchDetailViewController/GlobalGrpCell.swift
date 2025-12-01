//
//  GlobalGrpCell.swift
//  TouchBase
//
//  Created by Umesh on 16/02/16.
//  Copyright © 2016 Parag. All rights reserved.
//

import UIKit

class GlobalGrpCell: UITableViewCell {
    @IBOutlet var grpNameLabel: UILabel!
    let boundss = UIScreen.main.bounds
    @IBOutlet var grpImage: UIImageView!
    @IBOutlet var ArrowImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
