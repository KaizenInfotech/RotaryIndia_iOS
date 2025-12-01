//
//  AnnouncementDetailNotiiTableViewCell.swift
//  TouchBase
//
//  Created by rajendra on 09/04/19.
//  Copyright © 2019 Parag. All rights reserved.
//

import UIKit

class AnnouncementDetailNotiiTableViewCell: UITableViewCell {

    
    //1.
    @IBOutlet weak var viewImage: UIView!
    @IBOutlet weak var imageMain: UIImageView!
    
   
    @IBOutlet weak var buttonImageFullView: UIButton!
    //2.
    @IBOutlet weak var viewTitleLinkDate: UIView!
    @IBOutlet weak var labelLink: UILabel!
    @IBOutlet weak var buttonLink: UIButton!
    @IBOutlet weak var labelTitleDate: UILabel!
    //3.

    //4.
    @IBOutlet weak var viewDescription: UIView!
    @IBOutlet weak var textviewDescription: UITextView!

    //@IBOutlet weak var footerImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

