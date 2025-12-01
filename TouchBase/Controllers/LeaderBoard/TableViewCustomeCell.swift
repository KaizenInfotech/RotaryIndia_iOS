//
//  TableViewCustomeCell.swift
//  DemoROWs
//
//  Created by tt on 24/07/18.
//  Copyright © 2018 Kaizen. All rights reserved.
//

import UIKit

class TableViewCustomeCell: UITableViewCell {
    
    
    
    @IBOutlet weak var lblValue: UILabel!
    
    @IBOutlet weak var btnSerialNumber: UIButton!
    @IBOutlet weak var btnPoint: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        btnPoint.layer.cornerRadius = 8.0
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

