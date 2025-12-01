//
//  EmailTableViewCell.swift
//  TouchBase
//
//  Created by deepak on 30/05/17.
//  Copyright © 2017 Parag. All rights reserved.
//

import UIKit

class EmailTableViewCell: UITableViewCell {

    
    
    
    
    @IBOutlet weak var labelNameEmail: UILabel!
    
    
    @IBOutlet weak var buttonCheckBoxEmail: UIButton!
    
    
    @IBOutlet weak var buttonCheckBoxEmailMain: UIButton!
    
    
    
    @IBOutlet weak var buttonEmailEmailSend: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
