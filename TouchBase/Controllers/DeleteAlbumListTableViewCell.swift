//
//  DeleteAlbumListTableViewCell.swift
//  TouchBase
//
//  Created by tt on 10/10/18.
//  Copyright © 2018 Parag. All rights reserved.
//

import UIKit

class DeleteAlbumListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet var labelTitle: UILabel!
    //   @IBOutlet var viewMain: UIView!
    @IBOutlet weak var lblDetails: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

