//
//  FooterCell.swift
//  TouchBase
//
//  Created by Kaizan on 20/01/16.
//  Copyright © 2016 Parag. All rights reserved.
//

import UIKit

class FooterCell: UITableViewCell {
    
  //  @IBOutlet var modulesLabel: UILabel!
    
    @IBOutlet var typeMemberField: UITextField!
    
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

