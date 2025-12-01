//
//  ClubGalleryListViewTableCell.swift
//  TouchBase
//
//  Created by rajendra on 01/08/17.
//  Copyright © 2017 Parag. All rights reserved.
//

import UIKit

class ClubGalleryListViewTableCell: UITableViewCell {

    
    @IBOutlet var imageAlbum: UIImageView!
    @IBOutlet var labelTitle: UILabel!
    @IBOutlet var viewMain: UIView!
    @IBOutlet var buttonDelete: UIButton!
    @IBOutlet weak var labelDate: UILabel!
    
    //  @IBOutlet var labelDescription: UILabel!
    
    @IBOutlet var textviewDescription: UITextView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
