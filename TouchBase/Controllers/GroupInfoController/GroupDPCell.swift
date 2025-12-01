//
//  GroupDPCell.swift
//  TouchBase
//
//  Created by Kaizan on 26/02/16.
//  Copyright © 2016 Parag. All rights reserved.
//

import UIKit

class GroupDPCell: UITableViewCell {
    
    @IBOutlet var GroupNameLabel: UILabel!
    @IBOutlet var GroupAddressLabel: UILabel!
    @IBOutlet var GroupPic: UIImageView!
    @IBOutlet var indicator:UIActivityIndicatorView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}


