//
//  profPreferenceCell.swift
//  TouchBase
//
//  Created by Kaizan on 02/05/16.
//  Copyright © 2016 Parag. All rights reserved.
//

import UIKit

class profPreferenceCell: UITableViewCell {
    
    @IBOutlet var ProfileNameLabel: UILabel!
    @IBOutlet var ProfileMobileLabel: UILabel!
    @IBOutlet var ProfilePic: UIImageView!
    @IBOutlet var indicator:UIActivityIndicatorView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}

