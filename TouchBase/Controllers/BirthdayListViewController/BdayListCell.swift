//
//  BdayListCell.swift
//  TouchBaseGit
//
//  Created by Umesh on 05/06/15.
//  Copyright (c) 2015 Parag. All rights reserved.
//

import UIKit

class BdayListCell: UITableViewCell {
    @IBOutlet weak var imgUser: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imgUser.layer.cornerRadius = 6.0
        imgUser.clipsToBounds = true
        imgUser.layer.borderWidth=2.0
        imgUser.layer.borderColor=UIColor.white.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        
    }

}
