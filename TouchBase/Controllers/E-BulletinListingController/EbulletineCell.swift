//
//  EbulletineCell.swift
//  TouchBase
//
//  Created by Kaizan on 21/12/15.
//  Copyright © 2015 Parag. All rights reserved.
//

import UIKit

class EbulletineCell: UITableViewCell {
    
    
    
     @IBOutlet var buttonmDeleteClickEvent: UIButton!
    
    
    
    @IBOutlet var bulletineNameLabel: UILabel!
    @IBOutlet var bulletinDateTimeLabel: UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //contentView.addSubview(imgUser)
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}


