//
//  ProfileFieldsCell.swift
//  TouchBase
//
//  Created by Kaizan on 16/12/15.
//  Copyright © 2015 Parag. All rights reserved.
//

import UIKit

class ProfileFieldsCell: UITableViewCell {
    
    //@IBOutlet var LanguageLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var textsField: UITextField!
    
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

