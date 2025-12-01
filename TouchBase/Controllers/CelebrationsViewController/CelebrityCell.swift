//
//  CelebrityCell.swift
//  TouchBase
//
//  Created by Kaizan on 23/12/15.
//  Copyright © 2015 Parag. All rights reserved.
//

import UIKit

class CelebrityCell: UITableViewCell {
    
    //@IBOutlet var LanguageLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    
    @IBOutlet var profilePic: UIImageView!
    @IBOutlet var birthDateLabel: UILabel!
    @IBOutlet var eventLabel: UILabel!
    
    @IBOutlet var callButton: UIButton!
    @IBOutlet var notifyButton: UIButton!
    @IBOutlet var messageButton: UIButton!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}


