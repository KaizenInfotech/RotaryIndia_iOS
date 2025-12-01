//
//  DistrictDirDetailsTableCell.swift
//  TouchBase
//
//  Created by rajendra on 22/01/18.
//  Copyright © 2018 Parag. All rights reserved.
//

import UIKit

class DistrictDirDetailsTableCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblValue: UILabel!
    @IBOutlet weak var lblKey: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        imgView.layer.cornerRadius = imgView.frame.width / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
