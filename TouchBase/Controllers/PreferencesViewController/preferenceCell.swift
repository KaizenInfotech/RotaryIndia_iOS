//
//  preferenceCell.swift
//  TouchBase
//
//  Created by Kaizan on 02/05/16.
//  Copyright © 2016 Parag. All rights reserved.
//

import UIKit

class preferenceCell: UITableViewCell {
    
    @IBOutlet var PreferenceNameLabel: UILabel!
    @IBOutlet var PreferenceImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}


