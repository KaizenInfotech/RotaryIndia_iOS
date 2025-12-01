//
//  CustomGalleryNewCateCell.swift
//  TouchBase
//
//  Created by tt on 06/06/18.
//  Copyright © 2018 Parag. All rights reserved.
//

import UIKit

class CustomGalleryNewCateCell: UITableViewCell {

    
    
    
    @IBOutlet weak var lblCategory: UILabel!
    
    
    @IBOutlet weak var buttonCheckUncheck: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
