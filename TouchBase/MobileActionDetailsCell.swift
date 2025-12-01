
//
//  MobileActionDetailsCell.swift
//  TouchBase
//
//  Created by ABC on 15/05/19.
//  Copyright © 2019 Parag. All rights reserved.
//

import UIKit

class MobileActionDetailsCell: UITableViewCell {
    
    
    
    @IBOutlet weak var lblMobileNumber: UILabel!
    @IBOutlet weak var btnAction: UIButton!
    @IBOutlet weak var btnCheckUncheck: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
