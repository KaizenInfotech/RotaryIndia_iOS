//
//  ShowCaseAlbumListTableViewCell.swift
//  TouchBase
//
//  Created by tt on 07/06/18.
//  Copyright © 2018 Parag. All rights reserved.
//

import UIKit

class ShowCaseAlbumListTableViewCell: UITableViewCell {
    
    
    @IBOutlet var imageAlbum: UIImageView!
    @IBOutlet var labelTitle: UILabel!
    @IBOutlet var viewMain: UIView!
    @IBOutlet var buttonDelete: UIButton!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet var textviewDescription: UITextView!
    override func awakeFromNib()
    {
        super.awakeFromNib()
        textviewDescription.isScrollEnabled=false
        textviewDescription.isUserInteractionEnabled=false
        textviewDescription.isEditable=false
        textviewDescription.contentInset = UIEdgeInsets(top: -7.0,left: -5.0,bottom: 0,right: 0.0);
        
        imageAlbum.contentMode = .scaleAspectFit
        
        
    }
    
    
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

