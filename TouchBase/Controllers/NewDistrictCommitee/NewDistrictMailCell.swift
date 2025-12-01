//
//  NewDistrictMailCell.swift
//  TouchBase
//
//  Created by tt on 15/06/18.
//  Copyright © 2018 Parag. All rights reserved.
//

import UIKit

class NewDistrictMailCell: UITableViewCell {
    
    
    @IBOutlet weak var lblKey: UILabel!
    
    
    @IBOutlet weak var lblValue: UILabel!
    
    @IBOutlet weak var buttonEmailCheckUncheckElickEvent: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

