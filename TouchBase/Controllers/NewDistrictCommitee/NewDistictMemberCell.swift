
//
//  NewDistictMemberCell.swift
//  TouchBase
//
//  Created by tt on 16/06/18.
//  Copyright © 2018 Parag. All rights reserved.
//

import UIKit

class NewDistictMemberCell: UITableViewCell {
    
    @IBOutlet weak var imgProfile: UIImageView!
    
    @IBOutlet weak var lblDesignation: UILabel!
    
    
    @IBOutlet weak var lblMemberName: UILabel!
    
    
    
    @IBOutlet weak var ImgTableViewArrow: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
